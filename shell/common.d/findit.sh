findit-swp() {
    findit "$@" --pattern ".*sw[po]"
}

swps() {
    findit-swp "$@" --stamp 2>/dev/null | sort
}

findit-py() {
    findit "$@" --exclude_dirs "venv, env, node_modules, dist, build, .cache, .eggs, *.egg-info" --ipattern "*.py"
}

findit-py-no-tests() {
    findit "$@" --exclude_dirs "venv, env, node_modules, dist, build, .cache, .eggs, *.egg-info, test*" --ipattern "*.py"
}

findit-test-dirs() {
    findit "$@" --type d --exclude_dirs "venv, node_modules, build" --ipattern "*test*" | egrep -v '(pytest_cache|.egg$)'  | sort
}

pys() {
    findit-py "$@" --depth 1 --stamp | sort
}

pys-all() {
    findit-py "$@" --stamp | sort
}

findit-node-modules() {
    findit "$@" --pattern "node_modules" --type d
}

findit-js-backend() {
    findit "$@" --exclude_dirs "node_modules, lib, static, ui, deploy, test, unitTests, apidoc" --ipattern "*.js"
}

jss() {
    findit-js-backend "$@" --depth 1 --stamp | sort
}

jss-all() {
    findit-js-backend "$@" --stamp | sort
}

findit-tf() {
    findit --exts "tf, tfstate, tfvars" "$@"
}

findit-autoday() {
    findit ~/autoday "$@"
}

findit-pics() {
    findit "$@" --exclude_dirs ".cache, .config, .thumbnails, .cinnamon, .Trash, Library, venv, env, nvm, node_modules" --exts "png, jpg, jpeg, gif"
}

pics() {
    findit-pics "$@" --depth 1 --stamp | sort
}

pics-all() {
    findit-pics "$@" --stamp | sort
}

pics-view() {
    findit-pics "$@" --depth 1 --pipesort "feh -Fd" &
}

pics-all-view() {
    findit-pics "$@" --pipesort "feh -Fd" &
}

recent-mac-screenshots() {
    hours=$1
    [[ -z "$hours" ]] && hours=4
    findit-pics ~/Desktop --hours $hours --pipesort "open"
}

findit-vids() {
    findit --exclude_dirs ".Trash" --exts "mp4, flv, mkv, ogv, mov, webm, avi"
}

vids() {
    findit-vids "$@" --depth 1 --stamp | sort
}

vids-all() {
    findit-vids "$@" --stamp | sort
}

vids-play() {
    _vlc="vlc"
    [[ $(uname) == 'Darwin' ]] && _vlc="/Applications/VLC.app/Contents/MacOS/VLC"
    findit-vids "$@" --depth 1 --pipesort "$_vlc --fullscreen"
}

vids-all-play() {
    _vlc="vlc"
    [[ $(uname) == 'Darwin' ]] && _vlc="/Applications/VLC.app/Contents/MacOS/VLC"
    findit-vids "$@" --pipesort "$_vlc --fullscreen" &>/dev/null &
}

findit-audio() {
    findit --exclude_dirs "venv, env, node_modules, Library" --exts "mp3, flac, ogg, m4a, wav"
}

audio() {
    findit-audio "$@" --depth 1 --stamp | sort
}

audio-all() {
    findit-audio "$@" --stamp | sort
}

audio-play() {
    mocp -S &>/dev/null
    mocp -c && findit-audio "$@" --depth 1 --pipesort "mocp -a" && mocp -p
}

audio-all-play() {
    mocp -S &>/dev/null
    mocp -c && findit-audio "$@" --pipesort "mocp -a" && mocp -p
}

findit-webm() {
    findit "$@" --ipattern "*.webm"
}

findit-logs() {
    findit "$@" --complex "-iname '*.log' -type f ! -size 0"
}

logs-empty() {
    findit "$@" --complex "-iname '*.log' -type f -empty"
}

logs-empty-delete() {
    findit "$@" --complex "-iname '*.log' -type f -empty -delete"
}

logs() {
    findit-logs "$@" --depth 1 --stamp | sort
}

logs-wcl() {
    findit-logs "$@" --depth 1 --pipesort 'wc -l'
}

logs-info() {
    findit-logs "$@" --depth 1 --pipesort 'grep -Hn --color INFO'
}

logs-error() {
    findit-logs "$@" --depth 1 --pipesort 'grep -Hn --color ERROR'
}

logs-debug() {
    findit-logs "$@" --depth 1 --pipesort 'grep -Hn --color DEBUG'
}

logs-all() {
    findit-logs "$@" --stamp | sort
}

logs-all-wcl() {
    findit-logs "$@" --pipesort 'wc -l'
}

logs-all-info() {
    findit-logs "$@" --pipesort 'grep -Hn --color INFO'
}

logs-all-error() {
    findit-logs "$@" --pipesort 'grep -Hn --color ERROR'
}

logs-all-debug() {
    findit-logs "$@" --pipesort 'grep -Hn --color DEBUG'
}

findit-docs() {
    findit "$@" --exclude_dirs "venv, env, node_modules" --exts "pdf, doc, odt, md, txt, idea"
}

docs() {
    findit-docs "$@" --depth 1 --stamp | sort
}

docs-by-length() {
    findit-docs --depth 1 --pipe "wc -l" | sort -n
}

docs-all() {
    findit-docs "$@" --stamp | sort
}

docs-all-by-length() {
    findit-docs  --pipe "wc -l" | sort -n
}

annotated() {
    findit "$@" --pattern 'annotated*pdf' --stamp | sort
}

show-mac-garbage() {
    findit --pattern '._*, .Trashes, .Trash, .Spotlight-V100, __MACOSX, .TemporaryItems, .fseventsd, .DS_Store' "$@"
}

delete-mac-garbage() {
    show-mac-garbage -print0 | xargs -0 rm -rfv
}
