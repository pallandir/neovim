## My neovim keymaps

> [!important] 
> In my config `<leader> = space`


<div style="display: flex; gap: 20px;">

<div style="flex: 1;">

### General

| Command      | Description                                        |
| ------------ | -------------------------------------------------- |
| `jk`         | Exit insert mode by pressing jk                    |
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


</div>

<div style="flex: 1;">

### Working session
| Command      | Description                            |
| ------------ | -------------------------------------- |
| `<leader>ws` | Save session for auto session root dir |
| `<leader>wr` | Restore session for cwd                |

</div>

</div>

---

<div style="display: flex; gap: 20px;">

<div style="flex: 1;">

### File explorer
| Command      | Description                          |
| ------------ | ------------------------------------ |
| `<leader>nn` | Toggle file explorer                 |
| `<leader>nf` | Toggle file explorer on current file |
| `<leader>nc` | Collapse file explorer               |
| `<leader>nr` | Refresh file explorer                |

</div>

<div style="flex: 1;">

### Find files and grep (telescope)
| Command      | Description                                           |
| ------------ | ----------------------------------------------------- |
| `<leader>ff` | Fuzzy find files in current working directory         |
| `<leader>fr` | Fuzzy find recent files                               |
| `<leader>fs` | Find string in current working directory              |
| `<leader>fc` | Find string under cursor in current working directory |
| `<leader>ft` | Find todos comments                                   |

</div>

</div>

---


<div style="display: flex; gap: 20px;">

<div style="flex: 1;">

### Visual Mode
| Command      | Description                        |
| ------------ | ---------------------------------- |
| `<leader>xw` | Open trouble workspace diagnostics |
| `<leader>xd` | Open trouble document diagnostics  |
| `<leader>xq` | Open trouble quickfix list         |
| `<leader>xl` | Open trouble location list         |
| `<leader>xt` | Open todos in trouble              |

</div>

<div style="flex: 1;">

### Buffers & Windows
| Command          | Description               |
| ---------------- | ------------------------- |
| `:ls`            | List buffers              |
| `:b#`            | Switch to previous buffer |
| `:bn`            | Next buffer               |
| `:bp`            | Previous buffer           |
| `Ctrl+w h/j/k/l` | Navigate windows          |

</div>

</div>