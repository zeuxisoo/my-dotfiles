### Install

Checkout `dotfiles` to `~/.dotfiles` path

	git clone git@github.com:zeuxisoo/my-dotfiles.git .dotfiles

Enter to `dotfiles` directory

	cd ~/.dotfiles

Link all `dotfiles` to `$HOME`

	bash install.sh link

Install vim plugin

	vim
	:PluginInstall

### Uninstall

Enter to `dotfiles` directory

	cd ~/.dotfiles

Unlink all `dotfiles` from `$HOME`

	bash install.sh unlink

Remove the `dotfiles` directory

	rm -rf ~/.dotfiles
