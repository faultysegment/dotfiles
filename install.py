#!/usr/bin/python3
import filecmp
import os.path
import shutil

HOME_DIR = os.path.expanduser('~')
HOME_FILES = ('.tmux.conf', '.bashrc', '.vimrc')
CONFIG_FILES = {
    HOME_DIR: HOME_FILES,
    os.path.join(HOME_DIR, '.config', 'nvim'): ('init.vim',),
}


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
            old_path = os.path.join(config_path, config)
            if not os.path.isfile(old_path):
                print("{} not found, creating".format(config))
                shutil.copyfile(config, old_path)
            elif not filecmp.cmp(config, old_path):
                question = "".join(("Found changes in ", config, "\n",
                                    "Do you want to replace it?(y/n)\n"))
                if ask(question):
                    shutil.copyfile(config, old_path)


if __name__ == "__main__":
    update_config_files()
