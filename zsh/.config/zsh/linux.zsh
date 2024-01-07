# aliases
alias open='xdg-open'

# texlive
if [ -d "$HOME/.texlive/bin/x86_64-linux" ]; then
  PATH="$PATH:$HOME/.texlive/bin/x86_64-linux";
fi

if [ -d "$HOME/.texlive/texmf-dist/doc" ]; then
  MANPATH="$MANPATH:$HOME/.texlive/texmf-dist/doc/man"
  INFOPATH="$INFOPATH:$HOME/.texlive/texmf-dist/doc/info"
fi
