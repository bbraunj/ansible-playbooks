if [[ $(which alacritty) != *"bin/alacritty" ]]; then
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	source "{{ user }}/.cargo/env"
	cargo build --release

	# Post-install
	tic -xe alacritty,alacritty-direct extra/alacritty.info

	# - Desktop Entry
	cp target/release/alacritty /usr/local/bin/
	cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	desktop-file-install extra/linux/Alacritty.desktop
	update-desktop-database

	# - Manual Page
	mkdir -p /usr/local/share/man/man1
	gzip -c extra/alacritty.man | tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
	gzip -c extra/alacritty-msg.man | tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

	# - Zsh completions
	mkdir -p ${ZDOTDIR:-~}/.zsh_functions
	echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
	cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty
else
	echo "Alacritty already installed!"
fi
