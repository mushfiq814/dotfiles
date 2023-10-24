# showFuzzyDirContents {{{
function showFuzzyDirContents() {
  DIR="$1"
  SELECTION=$('ls' "$DIR" | fzf --height=20)
  if [[ $SELECTION && $? -eq 0 ]]; then
    cd "$DIR"/"$SELECTION"
  fi
}
# }}}


# launcher {{{
function launcher() {
  case $(print "dotfiles\nprojects\nconfig\ndownloads" | fzf) in
    "dotfiles")
      cd "$HOME/dotfiles" ;;
    "projects")
      showFuzzyDirContents "$HOME/projects" ;;
    "config")
      showFuzzyDirContents "$HOME/.config" ;;
    "downloads")
      cd "$HOME/downloads" ;;
    *)
      cd "$HOME" ;;
  esac
}
# }}}

# prettyGitLog {{{
function prettyGitLog() {
  # format strings; check man git log for more `placeholders`
  local authorDate='%aI'            # author date
  local authorDateRelative='%ar'    # author date relative
  # local commitDate='%cI'            # commit date relative
  # local commitDateRelative='%cr'    # commit date relative
  local authorName='%an'            # author name
  local shortCommitHash='%h'        # abbreviated commit hash
  # local longCommitHash='%H'         # commit hash
  local subject='%s'                # subject
  # local REFP='%d'   # reference pointer(branch, tag) names

  local format=""
  format+="%C(Magenta)$shortCommitHash  %C(reset)"
  format+="%C(Yellow)$authorDate %C(reset)"
  format+="(%C(Green)$authorDateRelative%C(reset))"
  format+="    %x09" # tab character
  format+="%C(Cyan)$authorName: %C(reset)"
  format+="$subject"

  # call git log with custom format and append any flags passed in
  git log --pretty="$format" $@
}
# }}}

# fzf git checkout {{{
# RESOURCE: https://koenwoortman.com/git-faster-branch-checkouts-with-fzf/
# RESOURCE: http://ses4j.github.io/2020/04/01/git-alias-recent-branches/
function fuzzyGitCheckout() {
  if [ $# -eq 0 ]; then
    # local BRANCH_LIST=$(git for-each-ref refs/heads/ --format='%(refname:short)')
    local BRANCH_LIST=$(
      git reflog show --pretty=format:'%gs ~ %gd' --date=relative \
      | grep 'checkout:' \
      | grep -oE '[^ ]+ ~ .*' \
      | awk -F~ '!seen[$1]++' \
      | awk -F' ~ HEAD@{' '{print($1)}'
    )
    local BRANCH=$(echo $BRANCH_LIST | fzf --height=~50)
    if [[ $? -eq 0 && "$BRANCH" != "" ]]; then
      echo "checking out $BRANCH..."
      git checkout "$BRANCH"
    fi
  else
    if [ $1 = "-b" ]; then
      echo "creating new branch...$2"
      git checkout -b $2
    else
      echo "searching locally for branch"

      BRANCH=$(git for-each-ref refs/heads/ --format='%(refname:short)' | grep "^$1$")
      if [ $? = 0 ]; then
        echo "$BRANCH found locally. switching..."
        git checkout "$BRANCH"
      else
        echo "branch not found. fetching $1 from remote..."
        # TODO: make remote name (here as `origin`) dynamic
        git fetch origin "$1"
        if [ $? -eq 0 ]; then
          git checkout "$1"
        fi
      fi
    fi
  fi
}
# }}}

# fzf git diff {{{
fuzzyGitDiff () {
  preview="git diff $@ --color=always -- {-1}"
  git diff $(git diff $@ --name-only | fzf --height=50 -m --ansi --preview $preview)
}
# }}}

# fzf git stash {{{
fuzzyGitStash () {
  preview="git stash $@ show -p --color \$(echo {1} | cut -d: -f1)"
  stashItem=$(
    git stash list | fzf \
      -m --ansi \
      --preview $preview --preview-window 'right,<80(down,wrap)' \
      --margin 1,5% \
      --border top --border-label " git stash " \
      --color 'marker:yellow,pointer:yellow,border:cyan,gutter:-1'
  )
  echo $stashItem
  # git stash apply "$(echo $stashItem | cut -d: -f1)"
}
# }}}

# texclean {{{
function texclean() {
  rm -i *.log *.aux
}
# }}}

# convertWinPath {{{
function convertWinPath() {
  echo "'$1'"
  echo "'$1'" | sed 's/\\/\//g'
  echo "'$1'" | sed 's/\\/\//g' | sed 's/C:/\/mnt\/c/g'
}
# }}}

# vlcplay {{{
function vlcplay() {
  vlc="C:\Program Files (x86)\VideoLan\VLC\\\vlc.exe"
  pth="$(echo $1 | sed 's/\/home\/mushfiq\/windows/C:/g; s/\//\\/g')"
  powershell.exe $vlc $pth
}
# }}}

# md2html: Convert from markdown to html {{{
function md2html() {
  css="~/dotfiles/pandoc/mvp.css"
  html="$HOME/dotfiles/pandoc/template.html"
  out="$(basename $1 .md).html"

  pandoc $1                       \
         --to html                \
         --standalone             \
         --css $css               \
         --template $html         \
         --output $out            \
         --mathjax                \
         --highlight-style tango

  # open in browser
  # powershell.exe Invoke-Item $out
}
# }}}

# changeBG {{{
function changeBG() {
  pre="C:\/Users\/mushf\/Downloads\/screenshots"
  img="$pre\/$1.png"
  term1="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
  term2="/mnt/c/Users/mushf/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
  sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term1
  sed -i "0,/\"backgroundImage\"/s/\(\"backgroundImage\"\s*:\s*\"\).*\(\",\s*\)/\1$img\2/" $term2
}
# }}}
