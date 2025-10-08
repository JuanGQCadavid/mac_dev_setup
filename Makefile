setup:
	mkdir -p ~/.config/nvim  
	cp -r * ~/.config/nvim
	
install:
	brew install ripgrep
	brew install fzf
	brew install fd
	brew install neovim
	echo 'Run: DOLLAR SIGN (brew --prefix)/opt/fzf/install'
