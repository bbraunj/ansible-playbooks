" This file moved here by Ansible ;)

set nocompatible              " be iMproved, required
filetype off                  " required

" ########################################################################
" ############################  Vim Settings #############################
" ########################################################################

" --------- Indentation ---------
set tabstop=4
set softtabstop=4
set shiftwidth=4

" PEP Indentation
au BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.java
    \ set expandtab |
    \ set autoindent

au BufNewFile,BufRead *.tex
    \ set textwidth=79

" ----------- Colors ------------
let python_highlight_all=1
syntax on
colorscheme zenburn
" colorscheme	solarized

" ------- Other Settings --------
" Backspace adjustments
set backspace=indent,eol,start

" Better pasting from system clipboard
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"

" Enable folding with spacebar
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

set encoding=utf-8
set number

" Native fuzzy finding
set path+=**
set wildmenu

" v| to generate new vertical split
nnoremap <silent> v\| <C-w>v

" v- to generate new horizontal split
nnoremap <silent> v- :split<CR>

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Insert PUDB Breakpoint
nnoremap <Leader>q o <BS>import pudb; pudb.set_trace()<ESC>

" Run Current File with Python Interpreter
nnoremap <Leader>e :! python3 % \| less <CR>

" Highlight current line
set cursorline

" Persistent Undo
if has('persistent_undo')       "check if your vim version supports it
    set undofile                 "turn on the feature  
    set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif 

" Mouse mode
set mouse=a

" Yank to system clipboard with gy. Put wiht gp.
nnoremap gy "+y
vnoremap gy "+y
nnoremap gP "+P
vnoremap gP "+P
nnoremap gp "+p
vnoremap gp "+p

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ########################################################################
" #####################   Vim-Plug Plugin Settings #######################
" ########################################################################

" Vim-Plug
call plug#begin('~/.vim/plugged')

" ------------------------------------------------
" ------------------ Utility ---------------------
" ------------------------------------------------

" ----- Commentary -----
Plug 'tpope/vim-commentary'

" ----- NERDTree -----
Plug 'scrooloose/nerdtree'
map <C-y> :NERDTreeToggle<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1

Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" Show marks in number bar
Plug 'kshenoy/vim-signature'

" ------------ Git ------------
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'

" ------- Quick Finding -------
Plug 'junegunn/fzf'
nnoremap <C-P> :FZF<CR>

Plug 'wsdjeg/FlyGrep.vim'
nnoremap <Leader>s :FlyGrep<cr>

" ------- Other Plugins -------
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Swap windows (<Leader>ww in 1st window then same in next)
Plug 'wesQ3/vim-windowswap'

" Show items in buffer (<Leader>b)
Plug 'jeetsukumaran/vim-buffergator'

" Random other useful plugins
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'terryma/vim-multiple-cursors'

Plug 'majutsushi/tagbar'

Plug 'darfink/vim-plist'

Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'skim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
nmap <leader>md <Plug>MarkdownPreviewToggle

" ------------------------------------------------
" ------------------- Visual ---------------------
" ------------------------------------------------

" Info bar at bottom & top of Vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='zenburn'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Show icons for files in NERDTree
Plug 'ryanoasis/vim-devicons'

" Better syntax highlighting for C++
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'ap/vim-css-color'

" ------------------------------------------------
" --------------- Python Plugins -----------------
" ------------------------------------------------
Plug 'vim-scripts/indentpython.vim'
Plug 'SkyLeach/pudb.vim'

" -------------------------------------------------
" --------------- Vim/Tmux Plugins ----------------
" -------------------------------------------------
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

Plug 'wellle/tmux-complete.vim'

Plug 'benmills/vimux'
Plug 'janko/vim-test'
let test#strategy = "vimux"
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tv :TestVisit<CR>

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" Ultisnips completion
" --------------------
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<nop>"
let g:UltiSnipsJumpForwardTrigger = "<C-i>"
let g:UltiSnipsJumpBackwardTrigger = "<C-o>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"

call plug#end()

" Python completion using built-in neovim-lsp
" -------------------------------------------
lua << EOF
-- Neovim-LSP
require('lspconfig').pyright.setup{}
require('lspconfig').texlab.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable signs
    signs = true,
  }
)

-- Mappings
local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local opts = {noremap = true, silent = true}
buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

-- Compe
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    ultisnips = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  else
    return t "<Tab>"
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF


" Lastly, source any system-specific settings you may have.
source ~/.config/system_specific/.vimrc
