# My dotfiles

Set up Ubuntu/WSL:
1. Install neovim from source
2. Install zsh
- `sudo apt install zsh -y`
3. Configure zsh by typing `zsh` into the CLI

Set up GitHub in WSL:
1. Set up credentials
2. Create key and copy key with `ssh-keygen -t rsa -b 4096 -C "email@gmail.com"
3. cat ~/.ssh/id_rsa.pub
4. Paste key in GitHub (Settings > SSH and GPG Keys > New SSH key)
5. Done

Creating a repo to contain all the dotfiles I'll be using for nvim and more.

Some configurations:
1. go to `.bashrc` and modify alias so `vim=nvim`
