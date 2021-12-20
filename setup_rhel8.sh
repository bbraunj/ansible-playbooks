#!/bin/bash

echo "Ensuring RHEL 8 Repo Subscriptions Exist"
sudo subscription-manager register
sudo subscription-manager refresh
sudo subscription-manager attach --auto

echo
echo "Adding EPEL8 repo"
sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

echo
echo "Installing ansible"
sudo yum install -y ansible

echo
echo "Installing required ansible-galaxy collections"
ansible-galaxy collection install -r roles/base/requirements.yml
