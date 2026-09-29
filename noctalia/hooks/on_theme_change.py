#!/usr/bin/python
from subprocess import run
from pathlib import Path
import os, json


def set_nvim_theme_rpc(bg, colorscheme):
    nvim_cmd = f'<Cmd>set background={bg} | colorscheme {colorscheme}<CR>'
    uid = os.getuid()
    runtime_dir = os.environ.get('XDG_RUNTIME_DIR', f'/run/user/{uid}')
    for socket_path in Path(runtime_dir).glob('nvim*'):
        if socket_path.is_socket(): 
            run(f"nvim --server {str(socket_path)} --remote-send '{nvim_cmd}'", shell=True)


def set_nvim_theme_config(bg, colorscheme):
    nvim_config = Path.home() / '.config/nvim/lua/noctalia_sync.lua'
    nvim_config.write_text(f"vim.cmd.colorscheme '{colorscheme}'\nvim.o.background='{bg}'")


def set_ps1_color(bg, colorscheme):
    with open(Path.home() / f'.config/noctalia/palettes/{colorscheme}.json') as f:
        hex = json.load(f)[bg]['mPrimary'][1:]

    r = int(f'0x{hex[:2]}', 16)
    g = int(f'0x{hex[2:4]}', 16)
    b = int(f'0x{hex[-2:]}', 16)

    color_file = Path.home() / '.cache/ps1_color.sh'
    color_file.write_text(f'color="\e[38;2;{r};{g};{b}m"')


if __name__ == '__main__':
    args = dict(shell=True, capture_output=True, text=True)

    bg = run('noctalia msg theme-mode-get', **args).stdout.strip().lower()
    colorscheme = run('noctalia msg color-scheme-get', **args).stdout.strip().split(' ')[-1].lower()

    set_nvim_theme_rpc(bg, colorscheme)
    set_nvim_theme_config(bg, colorscheme)
    set_ps1_color(bg, colorscheme)

