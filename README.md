# README

Some dot files for some tools I use. All of them belong into `~/.config/` folder.

> [!IMPORTANT]
> I created this readme at some point in time with no intentions of keeping it up to date at all times. But below is some stuff which you might want to consider before using these dotfiles.

## Settings

Some of the settings might not work on your system because some additional steps are required. Some of the examples I can think of at the moment are explained below, although it is likely that this list is not exhaustive. But in the end they are my dotfiles -> it works on my machine ¯\\\_(ツ)\_/¯.

### Neovim

In my neovim settings different LSP's are listed which neovim will try to install on the first startup. However you might not have installed the necessary tools for the language the LSP belongs to. For example if you haven't installed `solargraph` the Ruby LSP will not work and therefore throw an error on startup.

You can either:
- Install the necessary tools
- Disable the automatic install

If you want to disable the automatic install you can edit the file `nvim/lua/plugins/lspconfig.lua`, specifically the lines in this codeblock:

```lua
require('mason-lspconfig').setup({
	ensure_installed = {
		'<lsp_name>',
	},
```

Just comment out whatever languages you don't want.


### ZSH

For zsh you need to link the .zshrc into the home directory
```bash
ln -s ~/.config/.zshrc ~/
```

There are also some non-standard tools used either in aliases or just for some extra functionality somewhere in the `.zshrc` config file (list may be incomplete). Therefore you might have to install these tools or remove them from the `.zshrc` file:

- Aliases of standard commands:
  - `rm` -> `trash`
  - `cat` -> `bat`
- Extra tools
  - `zoxide`
  - `fzf`
  - `asdf`
  - `fastfetch`
- Plugins
  - zinit
  - zsh-plugins:
    - zsh-autosuggestions
    - zsh-syntax-highlighting

> [!IMPORTANT]
> On Ubuntu/Debian `bat` needs to be changed to `batcat`


## Note

> [!NOTE]
> Create an issue if you still encounter problems
