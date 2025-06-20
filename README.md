<a name="readme-top"></a>

<br />
<div align="center">
  <a href="#">
    <img src="./public_assets/neovim.svg" alt="Logo" width="80" height="80">
  </a>
  <h3 align="center">Neovim IDE setup</h3>

  <p align="center">
    Custom setup of Neovim IDE from scratch.
    <br />
    <br />
    <a href="https://github.com/pallandir/neovim/issues">Report Bug</a>
    ·
    <a href="https://github.com/pallandir/neovim/issues">Request Feature</a>
  </p>
</div>
<br>
<br>
<img align="center" src="./public_assets/preview.png" alt="preview">


## About this project

After six years of using `VSCode`, I decided to switch to `Neovim`. I found traditional IDEs to be overly bloated, packed with every possible tool, often sluggish, and with a minimal learning curve that didn’t challenge or engage me.

In contrast, learning and configuring Vim felt rewarding. It offers a streamlined and efficient development experience that’s both powerful and enjoyable. I initially experimented with `NVChad`, but eventually moved away from it to build my own setup from scratch. This hands-on approach helped me deeply understand how `Neovim` works under the hood.

This project is the result: a fully customized, lightweight IDE tailored to my workflow, with only the essential plugins. It supports Vue.js, Python, Go, Rust, and OpenTofu for a fast and focused development environment.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Getting Started

Getting up and running with this custom Neovim setup is simple. Just clone the repository into your Neovim config directory:

```sh
git clone git@github.com:pallandir/neovim.git ~/.config/nvim
```

If you plan to make changes and use your own version, you can either update the remote to point to your repository or remove the .git directory entirely to start fresh:

```sh
git remote set-url origin <your-remote-url>
# or
rm -rf ~/.config/nvim/.git
```

> [!tip]
>Package manager: `Lazy.nvim`
>    - `:Lazy` (to open the Lazy interface)
>
>LSP manager: `Mason.nvim`
>    - `:Mason` (to open Mason imterface)
>    - `:MasonInstall` \<lsp> to install a specific lsp


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Custom keymap

> [!important] 
> In this config `<leader> = space`

### General keys

| Command      | Description                                        |
| ------------ | -------------------------------------------------- |
| `jk`         | Exit insert mode                                   |
| `<leader>nh` | Clear search highligh (:nohl)                      |
| `<leader>+`  | Increment selected number                          |
| `<leader>-`  | Decrement selected number                          |
| `<leader>sv` | Split window vertically                            |
| `<leader>sh` | Split window horizontally                          |
| `<leader>se` | Split window equally when they are inequally sized |
| `<leader>sx` | Close current split                                |
| `<leader>to` | Open new tab                                       |
| `<leader>tx` | Close new tab                                      |
| `<leader>tn` | Go to next tab                                     |
| `<leader>tp` | Go to previous tab                                 |
| `<leader>tf` | Open current buffer in a new tab                   |


### File explorer ([nvim-tree](https://github.com/nvim-tree/nvim-tree.lua))
| Command      | Description                          |
| ------------ | ------------------------------------ |
| `<leader>nn` | Toggle file explorer                 |
| `<leader>nf` | Toggle file explorer on current file |
| `<leader>nc` | Collapse file explorer               |
| `<leader>nr` | Refresh file explorer                |


### Session management ([auto-session.nvim](https://github.com/rmagatti/auto-session))
| Command      | Description                            |
| ------------ | -------------------------------------- |
| `<leader>ws` | Save session for auto session root dir |
| `<leader>wr` | Restore session for cwd                |


### Find files and grep ([telescope.nvim](https://github.com/nvim-telescope/telescope.nvim))
| Command      | Description                                           |
| ------------ | ----------------------------------------------------- |
| `<leader>ff` | Fuzzy find files in current working directory         |
| `<leader>fr` | Fuzzy find recent files                               |
| `<leader>fs` | Find string in current working directory              |
| `<leader>fc` | Find string under cursor in current working directory |
| `<leader>ft` | Find todos comments                                   |


### Errors management ([trouble.nvim](https://github.com/folke/trouble.nvim))
| Command      | Description                        |
| ------------ | ---------------------------------- |
| `<leader>xw` | Open trouble workspace diagnostics |
| `<leader>xd` | Open trouble document diagnostics  |
| `<leader>xq` | Open trouble quickfix list         |
| `<leader>xl` | Open trouble location list         |
| `<leader>xt` | Open todos in trouble              |


### Buffers & Windows
| Command          | Description               |
| ---------------- | ------------------------- |
| `:ls`            | List buffers              |
| `:b#`            | Switch to previous buffer |
| `:bn`            | Next buffer               |
| `:bp`            | Previous buffer           |
| `Ctrl+w h/j/k/l` | Navigate windows          |


## License

This repository and all its content is under `GNU General Public License v3.0`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
