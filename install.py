#!/usr/bin/python3
import filecmp
import os.path
import shutil
import requests

HOME_DIR = os.path.expanduser('~')
HOME_FILES = ('.tmux.conf', '.bashrc', '.vimrc')
CONFIG_FILES = {
    HOME_DIR: HOME_FILES,
    os.path.join(HOME_DIR, '.config', 'nvim'): ('init.vim',),
}
BASH_GIT_URL = \
    'https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh'
BASH_GIT_PATH = os.path.join(HOME_DIR, '.bash_git')


def ask(string):
    while True:
        answer = input(string)
        if answer == "y":
            return True
        elif answer == "n":
            return False


def update_config_files():
    for config_path, configs in CONFIG_FILES.items():
        for config in configs:
            if not os.path.exists(config_path):
                os.makedirs(config_path)
            old_path = os.path.join(config_path, config)
            if not os.path.isfile(old_path):
                print("{} not found, creating".format(config))
                shutil.copyfile(config, old_path)
            elif not filecmp.cmp(config, old_path):
                question = "".join(("Found changes in ", config, "\n",
                                    "Do you want to replace it?(y/n)\n"))
                if ask(question):
                    shutil.copyfile(config, old_path)


def install_bash_git():
    if not os.path.isfile(BASH_GIT_PATH):
        r = requests.get(BASH_GIT_URL)
        if r.status_code != 200:
            raise RuntimeError("Unable to download .bash_git")
        with open(BASH_GIT_PATH, 'a') as bashgit:
            bashgit.write(r.text)


if __name__ == '__main__':
    install_bash_git()
    update_config_files()
