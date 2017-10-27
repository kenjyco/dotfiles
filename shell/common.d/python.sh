# Deactivate Python virtual environment (including an internal Node environment)
alias Deactivate="deactivate_node 2>/dev/null; deactivate 2>/dev/null"

# Activate Python virtual environment (as well as an optional Node environment).
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NODE_VIRTUAL_ENV_DISABLE_PROMPT=1
activate() {
    envpy="$1"
    envjs="$2"
    if [[ "$envpy" == "$envjs" && -n "$envjs" ]]; then
        echo "Abort: node env cannot be the same as python env!"
        return 1
    fi

    if [[ -z "$envpy" ]]; then
        # Check to see if envpy should be 'env', 'venv', or '.'
        [[ -f "env/bin/activate" ]] && envpy="env"
        [[ -f "venv/bin/activate" ]] && envpy="venv"
        [[ -f "./bin/activate" ]] && envpy="."

        if [[ -z "$envpy" ]]; then
            echo "Abort: Could not determine environment to activate!"
            return 1
        fi
    fi

    if [[ ! -f "${envpy}/bin/activate" ]]; then
        echo "Abort: No activation script at ${envpy}/bin/activate"
        return 1
    fi

    # Activate python environment.
    source "${envpy}/bin/activate"

    # Activate node environment, if specified.
    if [[ -n "$envjs" ]]; then
        if [[ ! -f "${envjs}/bin/activate" ]]; then
            Deactivate
            echo "Abort: No activation script at ${envjs}/bin/activate"
            return 1
        else
            source "${envjs}/bin/activate"
        fi
    fi
    which python3
    which pip3
}

install-home-venv-requirements() {
    if [[ -f /usr/bin/apt-get && -n "$(groups | grep sudo)" ]]; then
        sudo apt-get update || return 1
        sudo apt-get install -y binutils-multiarch gcc g++ python3-dev python3-venv python3-pip python3-setuptools
        sudo apt-get install -y redis-server moc vlc libav-tools sox rtmpdump imagemagick wmctrl
        # Requirements for dbus-python
        sudo apt-get install -y pkg-config libdbus-1-dev libdbus-glib-1-dev
        # Requirements for lxml
        sudo apt-get install -y libxml2 libxslt1.1 libxml2-dev libxslt1-dev zlib1g-dev
        # Requirements for bcrypt
        sudo apt-get install -y libffi-dev
        # Requirements for dryscrape
        sudo apt-get install -y qt5-default libqt5webkit5-dev xvfb build-essential
    elif [[ -f /usr/local/bin/brew ]]; then
        brew update || return 1
        brew install dbus dbus-glib moc libav sox rtmpdump
        brew tap homebrew/versions
        brew install redis@3.2
        if [[ -z $(brew services list | grep "redis@3.2.*started") ]]; then
            brew services start redis@3.2
        fi
        if [[ -z $(brew services list | grep "dbus.*started") ]]; then
            brew services start dbus
        fi
        if [[ -z $(brew services list | grep "jack.*started") ]]; then
            brew services start jack
        fi
        # Requirements for lxml
        brew install libxml2
        # Requirements for bcrypt
        brew install libffi
        # Requirements for dryscrape
        brew install qt
    fi
}

make-home-venv() {
    if [[ ! -d "$HOME/venv" ]]; then
        install-home-venv-requirements
        cd
        python3 -m venv venv && venv/bin/pip3 install --upgrade pip wheel
        if [[ $(uname) == 'Darwin' ]]; then
            venv/bin/pip3 install ipython flake8 grip jupyter awscli httpie beu
        else
            venv/bin/pip3 install ipython flake8 grip jupyter awscli httpie beu vlc-helper
        fi
    fi
}

update-home-venv() {
    [[ ! -d "$HOME/venv" ]] && echo "$HOME/venv does not exist" && return 1
    cd
    if [[ $(uname) == 'Darwin' ]]; then
        venv/bin/pip3 install --upgrade ipython flake8 grip jupyter awscli httpie beu
    else
        venv/bin/pip3 install --upgrade ipython flake8 grip jupyter awscli httpie beu vlc-helper
    fi
}

home-ipython() {
    PYTHONPATH=$HOME $HOME/venv/bin/ipython $@
}

home-site-packages() {
    if [[ -d "$HOME/venv/lib/python3.5/site-packages" ]]; then
        cd "$HOME/venv/lib/python3.5/site-packages"
    elif [[ -d "$HOME/venv/lib/python3.6/site-packages" ]]; then
        cd "$HOME/venv/lib/python3.6/site-packages"
    fi

}

venv-site-packages() {
    env_name=$1
    [[ -z "$env_name" ]] && env_name="venv"
    [[ ! -d $env_name ]] && echo "Can't find '$env_name'" && return 1
    if [[ -d "$env_name/lib/python3.5/site-packages" ]]; then
        cd "$env_name/lib/python3.5/site-packages"
    elif [[ -d "$env_name/lib/python3.6/site-packages" ]]; then
        cd "$env_name/lib/python3.6/site-packages"
    fi

}

update-home-config() {
    dotfiles && repo-update
	if [[ -n "$BASH_VERSION" ]]; then
        source ~/.bashrc
	elif [[ -n "$ZSH_VERSION" ]]; then
        source ~/.zshrc
	fi
    update-home-venv
}

test-install-in-tmp() {
    oldpwd=$(pwd)
    project_name=$(basename $oldpwd)
    version=$(grep download_url setup.py 2>/dev/null | perl -pe 's/^.*v([\d\.]+).*/$1/')
    if [[ -z "$version" ]]; then
        echo "Could not determine version from 'download_url' in 'setup.py'"
        return 1
    fi
    tmp_dir=/tmp/$project_name--$version

    mkdir -pv $tmp_dir
    clean-py >/dev/null
    venv/bin/python3 setup.py bdist_wheel || return 1
    cp -av dist/* $tmp_dir || return 1
    cd $tmp_dir || return 1
    rm -rf venv
    python3 -m venv venv && venv/bin/pip3 install --upgrade pip wheel
    venv/bin/pip3 install *.whl ipython pdbpp
    echo -e "\n$(pwd)\n"
    PYTHONPATH="$tmp_dir" venv/bin/ipython
    cd "$oldpwd"
}

grip() {
    PYTHONPATH=$HOME $HOME/venv/bin/grip $@
}

flake8() {
    PYTHONPATH=$HOME $HOME/venv/bin/flake8 $@
}

flakeit() {
    flake8 --exclude='venv/*' . |
    egrep -v '(line too long|import not at top of file|imported but unused|do not assign a lambda)'
}

jupyter() {
    PYTHONPATH=$HOME $HOME/venv/bin/jupyter $@
}

aws() {
    PYTHONPATH=$HOME $HOME/venv/bin/aws $@
}

http() {
    PYTHONPATH=$HOME $HOME/venv/bin/http $@
}

rh-download-examples() {
    PYTHONPATH=$HOME $HOME/venv/bin/rh-download-examples $@
}

rh-download-scripts() {
    PYTHONPATH=$HOME $HOME/venv/bin/rh-download-scripts $@
}

rh-notes() {
    PYTHONPATH=$HOME $HOME/venv/bin/rh-notes $@
}

rh-shell() {
    PYTHONPATH=$HOME $HOME/venv/bin/rh-shell $@
}

yt-download() {
    PYTHONPATH=$HOME $HOME/venv/bin/yt-download $@
}

yt-search() {
    PYTHONPATH=$HOME $HOME/venv/bin/yt-search $@
}

ph-goo() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-goo $@
}

ph-you() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-you $@
}

ph-ddg() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-ddg $@
}

ph-download-files() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-download-files $@
}

ph-download-file-as() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-download-file-as $@
}

ph-soup-explore() {
    PYTHONPATH=$HOME $HOME/venv/bin/ph-soup-explore $@
}

vlc-repl() {
    PYTHONPATH=$HOME $HOME/venv/bin/vlc-repl $@
}

myvlc() {
    PYTHONPATH=$HOME $HOME/venv/bin/myvlc $@
}

mocplayer() {
    PYTHONPATH=$HOME $HOME/venv/bin/mocplayer $@
}

beu-ipython() {
    PYTHONPATH=$HOME $HOME/venv/bin/beu-ipython $@
}

beu-trending() {
    PYTHONPATH=$HOME $HOME/venv/bin/beu-trending $@
}

beu-related-to() {
    PYTHONPATH=$HOME $HOME/venv/bin/beu-related-to $@
}

alias m=mocplayer
alias b=beu-ipython
alias v='yt-search'
alias a='yt-search --audio-only'
alias trending=beu-trending
alias related=beu-related-to
alias pdfsearch='ph-goo --filetype pdf'

# Create a Python virtual environment and an optional Node virtual environment.
makeenv() {
    envpy="$1"
    envjs="$2"
    if [[ "$envpy" == "$envjs" && -n "$envjs" ]]; then
        echo "Abort: node env cannot be the same as python env!"
        return 1
    fi
    if [[ -z "$envpy" ]]; then
        envpy="env"
    fi

    # Create python environment and install requirements.txt (as well as
    # ipython and ipdb).
    virtualenv --no-site-packages ${envpy}
    if [[ $? -ne 0 ]]; then
        echo "Abort: Something went wrong creating python env!"
        rm -rf $envpy 2>/dev/null
        return 1
    fi
    ${envpy}/bin/pip install ipython ipdb pytest git+git://github.com/mverteuil/pytest-ipdb.git
    [[ -f requirements.txt ]] && ${envpy}/bin/pip install -r requirements.txt

    # Create node environment (if specified) and activate environment(s).
    if [[ -n "$envjs" ]]; then
        # Install nodeenv to the python virtual environment.
        ${envpy}/bin/pip install nodeenv

        # Create node environment and install whatever is in package.json
        # (if it exists).
        if [[ 0 -eq $? ]]; then
            echo "Creating node.js environment. This will take a while."
            ${envpy}/bin/nodeenv $envjs
            [[ -f package.json ]] && ${envjs}/bin/npm install
        else
            echo "Abort: Something went wrong installing nodeenv package!"
            rm -rf $envpy $envjs 2>/dev/null
            return 1
        fi
        activate $envpy $envjs
    else
        activate $envpy
    fi
}

alias aipy='activate && ipython'

try-it() {
    script=
    if [ -f "$1" ]; then
        script=$(basename "$1")
        dname=$(dirname "$1")
        cd "$dname"
        shift
    elif [ -d "$1" ]; then
        cd "$1"
        shift
    fi

    # If this is not an autoenv directory that automatically starts the python
    # virtualenv when we cd to it, manually activate the virtualenv.
    if [ ! -s ".env" ]; then
        # Activate the python environment (or create it if it doesn't exist).
        activate >/dev/null 2>&1 || makeenv
    else
        echo -e "\nNeed to confirm that autoenv worked...\n"
        sleep 2
    fi

    # If a script name was passed in, or if there is only one .py file in the
    # directory, run it and deactivate the virtual environment.
    if [ -n "$script" ]; then
        python "$script" $@
        Deactivate
        cd $OLDPWD
    elif [ $(ls -1 *.py | wc -l) -eq 1 ]; then
        # If there is exactly 1 python script in this directory, run it
        python *.py $@
        Deactivate
        cd $OLDPWD
    else
        echo -e "\nBe sure to issue the 'Deactivate' command when finished.\n"
    fi
}
