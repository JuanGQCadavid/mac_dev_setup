setup:
	mkdir -p ~/.config/nvim  
	cp -r * ~/.config/nvim
	
install:
	brew install yaml-language-server
	brew install helm-ls
	brew install ripgrep
	brew install fzf
	brew install fd
	brew install neovim
	echo 'Run: DOLLAR SIGN (brew --prefix)/opt/fzf/install'
