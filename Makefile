homefiles = .tmux.conf .bashrc .vimrc 
all_files = $(homefiles) init.vim

all : $(all_files) 

$(homefiles): FORCE
		cp --remove-destination $@ ~/
		touch ~/$@local

init.vim: FORCE
		mkdir -p ~/.config/nvim/
		cp --remove-destination $@ ~/.config/nvim/
		cat ~/.config/nvim/$@.local >> ~/.config/nvim/init.vim
FORCE:
