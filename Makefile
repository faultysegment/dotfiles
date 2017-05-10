homefiles = .tmux.conf .bashrc 
all_files = $(homefiles) init.vim

all : $(all_files) 

$(homefiles): FORCE
		cp --remove-destination $@ ~/
		touch ~/$@local

init.vim: FORCE
		mkdir -p ~/.config/nvim/
		cp --remove-destination $@ ~/.config/nvim/
		touch ~/.config/nvim/$@.local
		go get github.com/sourcegraph/go-langserver
		git clone git@github.com:palantir/python-language-server.git
		cd python-language-server && pip install --process-dependency-links .
		rm -rf python-language-server
FORCE:
