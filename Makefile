setup:
	mkdir -p ~/.config/nvim  
	cp -r * ~/.config/nvim

profile:
	echo "alias cdf='cd $(fd --type d | fzf)'" > .zrs.sdfsa
	
install:
	brew install derailed/k9s/k9s
	brew install yaml-language-server
	brew install terraform-ls
	brew install helm-ls
	brew install ripgrep
	brew install fzf
	brew install fd
	brew install neovim
	echo 'Run: DOLLAR SIGN (brew --prefix)/opt/fzf/install'
