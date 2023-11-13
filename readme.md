# Dotfiles

My configuration files for different programs that I use. This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to automatically create symlinks to the relevant directories and files from the user home directory `~`.

## My setup

| Part               | Details                                                                                |
|--------------------|----------------------------------------------------------------------------------------|
| Device             | Razer Blade Stealth/Dell XPS 13/Macbook Pro M1/Samsung S23                             |
| OS                 | Arch Linux/MacOS/Android                                                               |
| Shell              | zsh                                                                                    |
| Terminal Emulator  | Kitty/Termux                                                                           |
| Window Manager     | i3-gaps/yabai                                                                          |
| Editor             | NeoVim                                                                                 |
| Browser/PDF Reader | QuteBrowser                                                                            |
| Font               | [LigaSauceCodePro Nerd Font](https://github.com/Bo-Fone/Liga-Sauce-Code-Pro-Nerd-Font) |
| Colorscheme        | Various (see `scripts/colorscheme/colors/*.json`)                                    |

## How it Looks

### Linux Systems

#### polybar, neovim & qutebrowser with catppuccin theme

![polybar, neovim & qutebrowser with catppuccin theme](https://user-images.githubusercontent.com/32845348/197903873-c6850947-7d03-4189-bc48-0392af9a53ea.png)

#### polybar, neovim & qutebrowser with ayu-light theme

![polybar, neovim & qutebrowser with ayu-light theme](https://user-images.githubusercontent.com/32845348/197916219-6fb2fc55-4780-4f59-a350-188dacf30346.png)

#### rofi launcher with ayu-light theme

![rofi launcher with ayu-light theme](https://user-images.githubusercontent.com/32845348/197916240-ff5a6929-a3d3-49a6-b3ac-9b7267c22997.png)

### MacOS System

![sketchybar & neovim with starfield-light theme](https://github.com/mushfiq814/dotfiles/assets/32845348/7d408284-b66b-4931-a626-91d5bbbd3e26)

### Android + Termux + Samsung Dex

![Samsung Dex with Termux and a browser](https://github.com/mushfiq814/dotfiles/assets/32845348/72f4e410-a5c8-4f50-bba5-e7356452f136)

## Setup!

Make sure `stow` is installed

```sh
$ sudo apt install stow
```

Use stow to create or remove symbolic links for different programs

For understanding stow terminology, see [Stow Terminology](#Stow Terminology)

## Clone repository (with submodules)

This repo contains git submodules. Some are private repos that only I should have access to.

```bash
$ git clone --recurse-submodules <repo_url>

# or if forgotten to do it at clone
$ git submodule update --remote --merge
```

## Link config files

* Create directory with name of program for which the config files will be linked e.g. `zsh`.
* Recreate config directory structure in this directory. For instance, `neovim` would have the following directory structure:

  ```sh
  neovim
  └── .config
      └── nvim
          └── init.vim
  ```

Then run one of the following. Note: `<program_dir_name>` refers to the name created in the first step.

```sh
# for testing out use -n
$ stow -nSvt ~ <program_dir_name>
$ stow --simulate --stow --verbose --target=$HOME <program_dir_name>

# for actually creating the link
$ stow -Svt ~ <program_dir_name>
$ stow --stow --verbose --target=$HOME <program_dir_name>

# in case config already exists, use --adopt to force stow to link
$ stow --adopt -Svt ~ <program_dir_name>
$ stow --adopt --stow --verbose --target=$HOME <program_dir_name>
```

For `<program_dir_name>`, use the top level directory name that is in the repo, e.g. `neovim`, `zsh`, `bash`

## Unlink config files

```sh
# for testing out use -n
$ stow -nDvt ~ <program_dir_name>
$ stow --simulate --delete --verbose --target=$HOME <program_dir_name>

# for actually creating the link
$ stow -Dvt ~ <program_dir_name>
$ stow --delete --verbose --target=$HOME <program_dir_name>

# in case config already exists, use --adopt to force stow to link
$ stow --adopt -Dvt ~ <program_dir_name>
$ stow --adopt --delete --verbose --target=$HOME <program_dir_name>
```

## Stow Terminology

* __target dir__: the directory where the linked files will be created.
  * this is the directory the files/dir would ideally be at without gnu stow
  * example: for neovim, this would be `~/.config/nvim`
* __source dir__: the directory where the linked files will be sourced from.
  * this is the directory the files/dir would actually be at
  * example: for neovim, this would be `~/dotfiles/neovim/.config/nvim`

### No Target Directory

If the target directory is empty and source directory is __NOT__ empty, i.e.

```bash
$ tree ~/.config/test
# /home/mushfiq/.config/test  [error opening dir]
#
# 0 directories, 0 files
$ tree -a ~/dotfiles/test
# /home/mushfiq/dotfiles/test
# └── .config
#     └── test
#         └── test.rc
#
# 2 directories, 1 file
$ cat ~/dotfiles/test/.config/test/test.rc
# from dotfiles
```

Then the target directory contents will be linked to the source directory contents. This also works if there are other files that are in the target directory that are also not in the source directory. e.g., if there was a second file in `~/.config/test/another.rc` and `stow` was called, that file will remain unchanged.

```bash
$ stow --adopt --verbose --target=$HOME --no-folding --stow test
$ tree ~/.config/test
# /home/mushfiq/.config/test
# └── test.rc -> ../../dotfiles/test/.config/test/test.rc
#
# 0 directories, 1 file
$ cat ~/.config/test/test.rc
# from dotfiles
$ cat ~/dotfiles/test/.config/test/test.rc
# from dotfiles
```

### Target Directory with contents

If both the source directory and the target directory is __NOT__ empty, the files in the source directory will get overwritten by the target. i.e.

```bash
$ tree -a ~/.config/test/
# /home/mushfiq/.config/test/
# ├── another.rc
# └── test.rc
#
# 0 directories, 2 files
$ cat ~/.config/test/test.rc
# from config dir
$ cat ~/dotfiles/test/.config/test/test.rc
# from dotfiles
$ stow --adopt --verbose --target=$HOME --no-folding --stow test
$ cat ~/.config/test/test.rc
# from config dir
$ cat ~/dotfiles/test/.config/test/test.rc
# from config dir
$ tree -a ~/dotfiles/test/.config/test
# /home/mushfiq/dotfiles/test/.config/test
# └── test.rc
#
# 0 directories, 1 file
```
