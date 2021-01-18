# Dotfiles
My configuration files for different programs that I use. This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to automatically create symlinks to the relevant directories and files from the user home directory `~`.

# Setup
Make sure `stow` is installed

```sh
$ sudo apt install stow
```

Use stow to create or remove symbolic links for different programs

## Link config files
```sh
# for testing out use -n
$ stow -nSvt ~ <program_dir_name>
# for actually creating the link
$ stow -Svt ~ <program_dir_name>
```
For `<program_dir_name>`, use the top level directory name that is in the repo, e.g. `neovim`, `zsh`, `bash`

## Unlink config files
```sh
# for testing out use -n
$ stow -nDvt ~ <program_dir_name>
# for actually creating the link
$ stow -Dvt ~ <program_dir_name>
```

