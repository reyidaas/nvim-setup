# Nvim setup

1. Install dependencies
```
// General dependencies
brew update
brew install --HEAD luajit tree-sitter tree-sitter-cli neovim
brew install grep ripgrep tmux marksman pnpm fzf lazygit lua-language-server

npm i -g typescript typescript-language-server pyright vscode-langservers-extracted prettier @prisma/language-server @tailwindcss/language-server graphql-language-service-cli corepack

brew install rust-analyzer

// rust dependencies
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src
```

- Install one of [nerd-fonts](https://www.nerdfonts.com/) and enable it in iTerm2 - *Source Code Pro* (using Ghostty now)
- Install vim-plug `sh -c 'curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`
- Place _.config_ folder in home folder
- Place _.tmux.conf_ in home folder
- Install [tpm](https://github.com/tmux-plugins/tpm)
- Install [yabai](https://github.com/koekeishiya/yabai)
- Install [skhd](https://github.com/koekeishiya/skhd)
- Install [borders](https://github.com/FelixKratz/JankyBorders)
- Install [ghostty](https://ghostty.org/docs/install/binary#macos)
- Go to _.config/nvim_
- `nvim plug.vim`
- `:PlugInstall`
