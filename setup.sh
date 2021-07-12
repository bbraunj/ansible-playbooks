#!/bin/bash

echo
echo "*** Installing Xcode Command Line Tools ***"
echo

xcode-select --install

echo
echo "* Done"
echo

echo
echo "*** Installing Homebrew ***"
echo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo
echo "* Done"
echo

echo
echo "*** Installing Ansible ***"
echo

brew install ansible

echo
echo "* Ansible installed. To run the playbook, type:"
echo
echo "    \$ ansible-playbook local.yml"
echo

