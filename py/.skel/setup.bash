#!/usr/bin/env bash

# Get the directory where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -f /usr/bin/apt-get ]]; then
    # Update the system package lists
    # sudo apt-get update

    # Install the system requirements for __________
    # sudo apt-get install -y __________

    # Make sure pip is installed
    which pip &>/dev/null
    [[ $? -ne 0 ]] && sudo apt-get install -y pip
fi

# Update pip to latest version and install virtualenv if not installed
which virtualenv &>/dev/null
if [[ $? -ne 0 ]]; then
    sudo pip install --upgrade pip
    sudo pip install virtualenv
fi

# Create the virtual environment
virtualenv --no-site-packages "$DIR/env" || exit 1

# Install packages in `requirements.txt` to the virtual environment
env/bin/pip install -r requirements.txt

# Fetch the submodules (only if git submodules are added)
git submodule init && git submodule update

# Manually setup code in any submodules
# source env/bin/activate
# oldpwd=$(pwd)
# cd "$DIR/env/repos/some_submodule"
# python setup.py install

# All finished
# deactivate
# cd "$oldpwd"
