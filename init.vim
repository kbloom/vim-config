filetype on
syntax on
if filereadable("/usr/share/vim/google/google.vim")
  source /usr/share/vim/google/google.vim
  Glug relatedfiles
  Glug outline-window
  Glug google-csimporter
endif

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'https://tpope.io/vim/sleuth.git'
Plug 'endel/vim-github-colorscheme'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'nvim-lua/plenary.nvim'
if filereadable("/usr/share/vim/google/google.vim")
  Plug 'sso://googler@user/piloto/cmp-nvim-ciderlsp'
  Plug 'sso://user/vicentecaycedo/cmp-buganizer'
endif

call plug#end()

silent! packadd! taglist
set ignorecase
set encoding=utf-8
set number
set noincsearch
set autochdir
set modeline modelines=5
set tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
set showmatch " shows matching parenthes (good for lisp)
let g:tex_flavor = "latex"
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_stop_completion = ['<TAB>', '<Enter>']
augroup filetype
  au BufRead,BufNewFile *.flex,*.jflex    set filetype=jflex
augroup END
au Syntax jflex    so ~/.vim/syntax/jflex.vim


noremap q <Nop>
noremap Q q

set rtp+=/usr/lib/google-golang/misc/vim

nmap <F4> :call OpenFileFromClipboard()
imap <F4> :call OpenFileFromClipboard()
filetype on
filetype plugin on
filetype indent on

if has('nvim')
  set mouse=a
  "Fix select-to-copy in neovim-qt, and also in neovim from the command-line.
  vmap <LeftRelease> "*ygv
  nmap <2-LeftMouse> <2-LeftMouse>"*ygv
  vmap <2-LeftMouse> <2-LeftMouse>"*ygv
  imap <2-LeftMouse> <2-LeftMouse><Cmd>:normal "*ygvi<CR>
  vmap <3-LeftMouse> <3-LeftMouse>"*ygv

  au FocusGained,BufEnter * :checktime
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "java", "go", "proto", "bash", "python"},
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
}
EOF
set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
  -- CiderLSP
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  require("lsp")
EOF

if exists(":Guifont")
  Guifont Monospace:h9
endif
