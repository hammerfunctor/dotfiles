#!/usr/bin/env lua

test = false

basedir = os.getenv('PWD') ..'/'.. debug.getinfo(1).source:match("@?(.*/)")
dofile(basedir .. 'config.lua') -- global variables: links, scripts, copies

function run_scripts()
  -- run scripts
  for i = 1,#scripts do
    local script = basedir .. scripts[i]
    if is_file(script) then
      os.execute(script)
    else
      print('Script: `' .. script.. '` not exists')
    end
  end
end

function run_links(forced)
  for i = 1,#links do
    links[i].src = basedir .. links[i].src

    if test then
      links[i].dst = basedir .. links[i].dst
    end
  end
  link(links,forced)
end

function run_copies()
  for i = 1,#copies do
    copies[i].src = basedir .. copies[i].src

    if test then
      copies[i].dst = basedir .. copies[i].dst
    end
  end
  copy(copies)
end

function dirname(s)
  return is_dir(s) and (s:match("(.*)/") or s) or (s:match("(.*)/.*") or '.')
end

function link_sf(src, dst); os.execute('ln -sf ' .. src .. ' ' .. dst); end
function cp_r(src, dst); os.execute('cp -r ' .. src .. ' ' .. dst); end
function exists(name); return os.execute('[ -e ' ..name.. ' ]'); end
function is_file(name); return os.execute('[ -f ' ..name.. ' ]'); end
function is_link(name); return os.execute('[ -L ' ..name.. ' ]'); end
function is_dir(name); return os.execute('[ -d ' ..name.. ' ]'); end
function is_link_or_not_exists_but_parent_exists(name); return ( (not exists(name) and exists(dirname(name))) or is_link(name) ); end
function mkdir(name); os.execute('mkdir -p ' .. name); end
function rm(name); os.execute('rm -rf ' .. name); end

function childjobs(s, d)
  if not is_dir(d) or not is_dir(s) then
    print(d..' or '..s.. ' is not a directory.')
    return
  end

  local src, dst = s..'/', d..'/'
  local i, children, popen = 0, {}, io.popen
  local pfile = popen('ls ' ..src)
  for filename in pfile:lines() do
    i = i + 1
    local filefullname = src..filename

    if is_file(filefullname) then
      children[i] = {src=src..filename, dst=dst..filename}
    elseif is_dir(filefullname) then
      children[i] = {src=src..filename, dst=dst..filename, mode='children'}
    else
      print('? => s='..src..filename..', d='..dst..filename)
    end
  end
  
  return children
end

function copy(jobs)
  for i = 1, #jobs do
    local item = jobs[i]
    local src, dst = item.src, item.dst
    if item.mode == 'overwrite' then
      if exists(dst) then
        rm(dst)
      end
      cp_r(src, dst)
    end
  end
end

function link(jobs, forced)

  for i = 1, #jobs do
    local item = jobs[i]
    local src, dst = item.src, item.dst

    if is_file(src) then
      print('link ' .. src .. ' <- ' .. dst)
      if is_link_or_not_exists_but_parent_exists(dst) then
        -- a link, or not exists but dir exists
        rm(dst)
        link_sf(src, dst)
      elseif not exists(dirname(dst)) then
        -- parent dir not exists
        print('Parent dir: `' ..dirname(dst).. '` not exists')
      else
        -- file exists, not a link
        if forced then
          link_sf(src, dst)
        else
          print('File: `' ..dst.. '` exists. Use `-f` to override it.')
        end
      end

    elseif is_dir(src) then
      if item.mode == 'children' then
        if is_link(dst) then
          os.execute('rm ' .. dst)
        end
        if not exists(dst) then
          print('Dir: `' ..dst.. '` not exists, with mode `children`.')
        else
          children = childjobs(src, dst)
          link(children, forced)
        end
      elseif item.mode == 'sub' then
        if is_link_or_not_exists_but_parent_exists(dst) then
          -- a link, or not exists but dir exists
          rm(dst)
          link_sf(src,dst)
        elseif not exists(dirname(dst)) then
          -- parent dir not exists
          print('Parent dir: `' ..dirname(dst).. '` not exists')
        else
          -- dir exists, not a link
          if forced then
            rm(dst)
            link_sf(src,dst)
          else
            print('Dir: `'..dst..'` exists. Use `-f` to override it.')
          end
        end
      else
        print('Mode of dir: ' ..dst.. ' unrecognized.')
      end

    else
      print('Source: ' ..src.. ' not found.')
    end
    
  end
end

function has(l, el)
  for i = 0,#l do
    if el == l[i] then
      return true
    end
  end
  return false
end
function arghas(el); return has(arg,el); end

function main()
  local forced = arghas('-f')
  print('force mode: ' .. tostring(forced))

  if arghas('all') then
    run_links(forced)
    run_scripts()
    run_copies()
  elseif arghas('links') and not arghas('scripts') then
    run_links(forced)
  elseif arghas('scripts') and not arghas('links') then
    run_scripts()
  else
    print('Nothing Executed, check your params: `all` | `links` | `scripts`')
  end

end

main()
