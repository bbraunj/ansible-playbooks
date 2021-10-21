#!/usr/bin/env python3

from datetime import datetime
from pathlib import Path
import re
import shutil
import socket
import subprocess


preferences = {
    "Alfred": {
        "ansible_path": Path.cwd()/("roles/workstation/tasks/app_preferences/"
                                    "Alfred.alfredpreferences/"),
        "system_path": Path("~/Library/Application Support/"
                            "Alfred/Alfred.alfredpreferences/").expanduser()
    },
    "tmux": {
        "ansible_path": Path.cwd()/("roles/base/tasks/dotfiles/.tmux.conf"),
        "system_path": Path("~/.tmux.conf").expanduser()
    },
    "vimrc": {
        "ansible_path": Path.cwd()/("roles/base/tasks/dotfiles/.vimrc"),
        "system_path": Path("~/.vimrc").expanduser()
    },
    "vim/colors": {
        "ansible_path": Path.cwd()/("roles/base/tasks/dotfiles/.vim/colors"),
        "system_path": Path("~/.vim/colors").expanduser()
    },
    "git": {
        "ansible_path": Path.cwd()/("roles/base/tasks/dotfiles/.gitconfig"),
        "system_path": Path("~/.gitconfig").expanduser()
    },
    "zshrc": {
        "ansible_path": Path.cwd()/("roles/base/tasks/dotfiles/.zshrc"),
        "system_path": Path("~/.zshrc").expanduser()
    },
    "skhdrc": {
        "ansible_path": Path.cwd()/("roles/workstation/tasks/dotfiles/.skhdrc"),
        "system_path": Path("~/.skhdrc").expanduser()
    },
    "yabairc": {
        "ansible_path": Path.cwd()/("roles/workstation/tasks/dotfiles/.yabairc"),
        "system_path": Path("~/.yabairc").expanduser()
    },
}

no_diffs_occurred = True
apps_to_update = []
for app_name, pref_paths in preferences.items():
    if (not pref_paths["ansible_path"].exists() or
        not pref_paths["system_path"].exists()):
        continue

    rc = subprocess.run(["diff", "-r", pref_paths["ansible_path"],
                         pref_paths["system_path"]]).returncode

    if rc != 0:
        no_diffs_occurred = False

        print("\n- Do you wish to update the Ansible repository with current "
              f"system preferences for {app_name}? ", end="")
        response = input("[y/n] ")

        while len(re.findall("[YyNn]", response)) != 1:
            response = input("--> Unrecognized response. Please enter [y/n]: ")

        if len(re.findall("[Yy]", response)) == 1:
            apps_to_update.append(app_name)
        else:
            print("--> Alright, skipping...")

if no_diffs_occurred:
    print("\n--> Nothing to do! Your system preferences match Ansible "
          "preferences for the following applications:")
    for app_name in preferences.keys():
        print(f"    - {app_name}")
elif len(apps_to_update) > 0:
    time = datetime.now().strftime("%Y%m%d%H%M%S")
    hostname = socket.gethostname()
    branch_name = f"{hostname}_{time}"

    subprocess.run(["git", "branch", branch_name])
    subprocess.run(["git", "checkout", branch_name])

    for app in apps_to_update:
        if preferences[app]["system_path"].is_dir():
            shutil.copytree(preferences[app]["system_path"],
                            preferences[app]["ansible_path"],
                            dirs_exist_ok=True)
        else:
            shutil.copy(preferences[app]["system_path"],
                        preferences[app]["ansible_path"])

        # rc = subprocess.run(["diff", "-r", preferences[app]["ansible_path"],
        #                      preferences[app]["system_path"]]).returncode
        # assert rc == 0

        subprocess.run(["git", "add", preferences[app]["ansible_path"]])

    print("--> Changes for the following apps have been added to "
          f"the branch {branch_name}:")
    for app in apps_to_update:
        print(f"    - {app}")
