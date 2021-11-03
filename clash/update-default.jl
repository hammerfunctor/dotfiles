#!/usr/bin/julia

import YAML, HTTP, JSON3
import Base64: base64decode

const config_template_path = joinpath(dirname((@__FILE__)), "config.template.yaml")

function update_clash(template::Dict, extras::Union{Dict,Nothing})
    # constants
    config_clash_path = joinpath(ENV["HOME"], ".config/clash/config.clash.yaml")
    update_keys = ["port", "socks-port", "allow-lan", "bind-address", "log-level", "external-controller"]
    url_clash = joinpath(dirname(@__FILE__),"ghelper-clash.txt") |> read |> String |> strip
    # constants end

    response = HTTP.get(url_clash)
    response.status == 200 || error("Error fetching proxies config from clash distribution.")
    config = response.body |> String |> YAML.load

    for k in update_keys
        config[k] = template[k]
    end

    if ! isnothing(extras)
        append!(config["proxies"], extras)
    end

    YAML.write_file(config_clash_path, config)
end

function update_default!(template::Dict, extras::Union{Dict,Nothing})
    # constants
    config_path = joinpath(ENV["HOME"], ".config/clash/config.yaml")
    update_keys = ["port", "socks-port", "allow-lan", "bind-address", "log-level", "external-controller"]
    url = joinpath(dirname(@__FILE__),"ghelper-default.txt") |> read |> String |> strip
    # constants end

    proxies::Vector{Dict} = fetch(url)
    if ! isnothing(extras)
        append!(proxies, extras["proxies"])
    end

    proxynames = [x["name"] for x in proxies]

    for x in template["proxy-groups"]
        x["proxies"] = proxynames
    end
    template["proxies"] = proxies
    
    YAML.write_file(config_path, template)
end

function fetch(url::AbstractString)::Vector{Dict}
    response = HTTP.get(url)
    response.status == 200 || error("Error fetching proxies config")

    items = base64decode(String(response.body)) |> String |> (x->split(x,'\n'))
    proxies = Dict[]

    for item in items
        if startswith(item, "vmess")
            jsobj = base64decode(replace(item, "vmess://"=>"")) |> String |> JSON3.read
            push!(proxies, vmess(jsobj))
        elseif startswith(item, "https")
            s = base64decode(replace(item, "https://"=>"")) |> String
            push!(proxies, https(s))
        else
            error("Proxy item neither vmess nor https")
        end
    end

    proxies
end


function vmess(jsobj::JSON3.Object)::Dict
    namesuffix = string("-", string(time_ns())[end-3:end]) # in case names duplicate
    d = Dict(
             "name" => string(jsobj.ps, namesuffix),
             "alterId" => jsobj.aid,
             "cipher" => "auto",
             "network" => !isnothing(jsobj.net) && jsobj.net != "tcp" ? jsobj.net : nothing,
            #  "network" => println(jsobj.net, " => ", !isnothing(jsobj.net) && jsobj.net!="tcp"),
             "type" => "vmess",
             "port" => jsobj.port,
             "server" => jsobj.add,
             "tls" => jsobj.tls == "tls" ? true : nothing,
             "uuid" => jsobj.id,
             "ws-path" => something(jsobj.path)
    )

    if :host in keys(jsobj)
        push!(d, "ws-header"=>Dict("Host"=>jsobj.host))
    end

    d
end

function https(s::String)::Dict
    namesuffix = string("-", string(time_ns())[end-3:end]) # in case names duplicate

    # e.g. "topo20@protonmail.com:109a2ffc5dd55e8b0f3b9b868be1a3a9@pccw.stunnel.vip:4700/#香港HKT"
    # 1 = username
    # 2 = password
    # 3 = server
    # 4 = port
    # 5 = name

    #m = match(r"^(.*)@(.*):(.*)@(.*):(.*)/#(.*)$", s)
    m = match(r"^(.*):(.*)@(.*):(.*)/#(.*)$", s) # email is displayed explicitly, fix it later

    Dict(
         "name" => m[5],
         "username" => m[1],
         "password" => m[2],
         "server" => m[3],
         "port" => m[4],

         "type" => "http",
         "tls" => true
    )
end

function main()
    extras = isdefined(@__MODULE__, :config_extra_path) ? YAML.load_file(config_extra_path) : nothing
    template = YAML.load_file(config_template_path)

    update_clash(template, extras)
    update_default!(template, extras)
end

main()
