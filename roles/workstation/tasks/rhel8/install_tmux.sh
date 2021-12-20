if [[ $(tmux -V) != *"3.2a"* ]]; then
	wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz
	tar -xf tmux-3.2a.tar.gz
	cd tmux-3.2a
	./configure
	make
	make install

	# Cleanup
	cd ..
	rm -rf tmux-3.2a*
else
	echo "Tmux 3.2a already installed"
fi
