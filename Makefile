# Kickstarter to everything.

nothing:
	@echo Dry run.

clean:
	[ -f ~/.zshrc ] && unlink ~/.zshrc
	[ -f ~/.bashrc ] && unlink ~/.bashrc
	[ -f ~/.aliases ] && unlink ~/.aliases
	[ -f ~/.gitconfig ] && unlink ~/.gitconfig
	[ -f ~/.inputrc ] && unlink ~/.inputrc
	[ -f ~/.tmux.conf ] && unlink ~/.tmux.conf
	[ -f ~/.vim ] && unlink ~/.vim

install:
	ln -sf ~/.dotfiles/.zshrc ~/.zshrc
	ln -sf ~/.dotfiles/.bashrc ~/.bashrc
	ln -sf ~/.dotfiles/.aliases ~/.aliases
	ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
	ln -sf ~/.dotfiles/.inputrc ~/.inputrc
	ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
#	git clone https://github.com/santosh/.vim.git ~/.vim
#	cd ~/.vim && make install
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
	cd zsh-autocomplete source 
	zsh-autocomplete.plugin.zsh

	cd

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
	source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use

	echo "Done installing dotfiles."

bootstrap_fedora:
	sudo bash bootstrap/fedora.sh
