localfiles = .tmux.conflocal .vimrclocal .bashrclocal
files = .tmux.conf .vimrc .bashrc 
all_files = $(files) $(localfiles) init.vim

all : $(all_files) 

$(localfiles): FORCE
		touch ~/$@

$(files): FORCE
		cp --remove-destination $@ ~/

init.vim: FORCE
		mkdir -p ~/.config/nvim/
		cp --remove-destination $@ ~/.config/nvim/
FORCE:
