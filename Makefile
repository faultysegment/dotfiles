localfiles = .tmux.conflocal .vimrclocal .bashrclocal
files = .tmux.conf .vimrc .bashrc

all: $(files)
$(localfiles): % :
	touch ~/$@
$(files): % : %local
	cp --remove-destination $@ ~/
