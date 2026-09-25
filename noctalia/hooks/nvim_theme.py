#!/usr/bin/python

from subprocess import run
from pathlib import Path
import os

args = dict(shell=True, capture_output=True, text=True)
bg = run('noctalia msg theme-mode-get', **args).stdout.strip().lower()
colorscheme = run('noctalia msg color-scheme-get', **args).stdout.strip().split(' ')[-1].lower()
nvim_cmd = f'<Cmd>set background={bg} | colorscheme {colorscheme}<CR>'

uid = os.getuid()
runtime_dir = os.environ.get('XDG_RUNTIME_DIR', f'/run/user/{uid}')

for socket_path in Path(runtime_dir).glob('nvim*'):
    if socket_path.is_socket(): 
        run(f"nvim --server {str(socket_path)} --remote-send '{nvim_cmd}'", shell=True)

nvim_config = Path.home() / '.config/nvim/lua/noctalia_sync.lua'
nvim_config.write_text(f"vim.cmd.colorscheme '{colorscheme}'\nvim.o.background='{bg}'")
