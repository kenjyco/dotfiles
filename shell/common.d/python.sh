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
        echo -e "\nUpdating apt-get package listing"
        sudo apt-get update || return 1
        sudo apt-get install -y binutils-multiarch gcc g++ python3-dev python3-venv python3-pip python3-setuptools
    elif [[ -f /usr/local/bin/brew ]]; then
        echo -e "\nUpdating homebrew package listing"
        brew update || return 1
        brew install python3
    fi
}

make-home-venv() {
    if [[ ! -d "$HOME/venv" ]]; then
        install-home-venv-requirements
        cd
        python3 -m venv venv && venv/bin/pip3 install --upgrade pip wheel
        if [[ $(uname) == 'Darwin' ]]; then
            venv/bin/pip3 install flake8 grip jupyter awscli httpie
        else
            venv/bin/pip3 install flake8 grip jupyter awscli httpie
        fi
    fi
}

update-home-venv() {
    [[ ! -d "$HOME/venv" ]] && echo "$HOME/venv does not exist" && return 1
    cd
    if [[ $(uname) == 'Darwin' ]]; then
        venv/bin/pip3 install --upgrade ipython flake8 grip jupyter awscli httpie
    else
        venv/bin/pip3 install --upgrade ipython flake8 grip jupyter awscli httpie
    fi
}

home-ipython() {
    PYTHONPATH=$HOME $HOME/venv/bin/ipython "$@"
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
    if [[ ! -d "$HOME/.beu" ]]; then
        curl -o- https://raw.githubusercontent.com/kenjyco/beu/master/install.sh | bash
    else
        beu-update
    fi
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
    PYTHONPATH=$HOME $HOME/venv/bin/grip "$@"
}

flake8() {
    PYTHONPATH=$HOME $HOME/venv/bin/flake8 "$@"
}

flakeit() {
    flake8 --exclude='venv/*' . |
    egrep -v '(line too long|import not at top of file|imported but unused|do not assign a lambda)'
}

jupyter() {
    PYTHONPATH=$HOME $HOME/venv/bin/jupyter "$@"
}

aws() {
    PYTHONPATH=$HOME $HOME/venv/bin/aws "$@"
}

http() {
    PYTHONPATH=$HOME $HOME/venv/bin/http "$@"
}

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
