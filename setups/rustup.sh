#!/usr/bin/env bash

[ ! -z `command -v rustup` ] && echo "rustup found." && exit 0
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
