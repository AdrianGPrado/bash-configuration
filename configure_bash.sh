#~/bin/bash



bashrc_path=$(pwd)/bashrc
bash_profile_path=$(pwd)/bash_profile

# Create symlinks
ln -sf $bash_profile_path $HOME/.bash_profile
ln -sf $bashrc_path       $HOME/.bashrc

