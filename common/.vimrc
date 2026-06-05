" ============================================================================
"  .vimrc — Personal Vim Configuration
"  Struktur: Basis → Plugin-Block (inkl. Plugin-Optionen) →
"            Allgemeine Optionen → Mappings → Autocommands → Funktionen
" ============================================================================


" ============================================================================
"  1. Basis-Einstellungen (vor Plugins)
" ============================================================================

set nocompatible
set encoding=UTF-8
syntax on
filetype plugin on

" Terminal colors
if !has('gui_running')
  set t_Co=256
endif
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" PATH
let $PATH = $HOME . '/.local/share/mise/shims:' . $PATH


" ============================================================================
"  1b. Funktionen (für Startify) — vor Plugin-Block, da in g:startify_lists referenziert
" ============================================================================

" Returns all modified files of the current git repo.
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty.
function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" Same as above, but show untracked files, honouring .gitignore.
function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" ============================================================================
"  1c. llama.vim — Konfiguration (vor Plugin-Block, damit beim Laden sichtbar)
" ============================================================================

" Server läuft bereits auf Port 8012 (Default-Endpoint localhost:8012 wird verwendet)
" Nur Fill-in-the-Middle, kein Instruction-Mode
 "let g:llama_config = {
     "\ 'show_info':               0,
     "\ 'auto_fim':                v:true,
     "\ 'keymap_fim_accept_full':  '<C-Tab>',
     "\ 'keymap_fim_accept_line':  '<S-Tab>',
     "\ 'keymap_fim_accept_word':  '<Tab>',
     "\ 'endpoint_inst':           '',
     "\ }

" ============================================================================
"  2. Plugin-Manager + Plugin-Deklarationen + Plugin-Optionen
" ============================================================================

call plug#begin('~/.vim/plugged')

" --- Navigation / Dateien ------------------------------------------------

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

Plug 'preservim/nerdtree' |
      \ Plug 'Xuyuanp/nerdtree-git-plugin' |
      \ Plug 'ryanoasis/vim-devicons' |
      \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeNaturalSort = 1
let g:NERDTreeNodeDelimiter="	"
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeMinimalUI = 1

" nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'✹',
      \ 'Staged'    :'✚',
      \ 'Untracked' :'✭',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'═',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'☒',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }
let g:NERDTreeGitStatusUseNerdFonts = 1

" vim-devicons
let g:webdevicons_enable_startify = 1
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['gguf'] = ''

Plug 'yukimura1227/vim-yazi'
let g:yazi_executable = 'yazi'
let g:yazi_open_multiple = 0
let g:yazi_replace_netrw = 1
let g:yazi_no_mappings = 1

" --- Git ------------------------------------------------------------------

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
let g:flog_default_opts = { 'max_count': 2000 }
let g:flog_permanent_default_opts = { 'date': 'short' }

" --- Editor-Verbesserungen -----------------------------------------------

Plug 'justinmk/vim-sneak'
let g:sneak#label = 1

Plug 'joeytwiddle/sexy_scroller.vim'
let g:SexyScroller_MinLines   = 50
let g:SexyScroller_MinColumns = 200

Plug 'makerj/vim-pdf'

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = [ 'foregroundfull' ]
let g:Hexokinase_optInPatterns = [
      \ 'full_hex',
      \ 'triple_hex',
      \ 'rgb',
      \ 'rgba',
      \ 'hsl',
      \ 'hsla',
      \ 'colour_names'
      \ ]
let g:Hexokinase_ftOptInPatterns = {
      \ 'css': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
      \ 'html': 'full_hex,rgb,rgba,hsl,hsla,colour_names'
      \ }

Plug 'sheerun/vim-polyglot'
let g:vim_svelte_plugin_load_full_syntax = 1

Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'cpp': ['clang'],
      \ 'sh': ['shellcheck'],
      \}

Plug 'ggml-org/llama.vim'

" --- Kommentare ----------------------------------------------------------

Plug 'preservim/nerdcommenter'

" --- UI / Look & Feel ----------------------------------------------------

Plug 'mhinz/vim-startify'
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
      \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='atomic'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

Plug 'nordtheme/vim'

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

call plug#end()

" Farbthema (nach plug#end(), damit Plugin geladen ist)
colorscheme nord


" ============================================================================
"  3. Allgemeine Vim-Optionen
" ============================================================================

set number
set mouse=a
set autoindent
set shiftwidth=2
set expandtab
set softtabstop=2
set tabstop=2
set laststatus=2
set showtabline=2
set noshowmode

" Suche
set hlsearch
highlight Search cterm=NONE ctermbg=yellow ctermfg=black

" Session
set sessionoptions-=blank


" ============================================================================
"  4. Key Mappings
" ============================================================================

" --- Leader ---------------------------------------------------------------

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" --- Schnellbefehle -------------------------------------------------------

nnoremap <leader>tr :terminal<CR>
nnoremap qq :q<CR>              " qq = quit
nnoremap ww :w<CR>              " ww = write
nnoremap wq :wq<CR>             " wq = write & quit
nnoremap Q :qall<CR>            " Q = quit all

" --- NERDTree -------------------------------------------------------------

nmap <C-f> :NERDTreeToggle<CR>
imap <C-f> <ESC>:NERDTreeToggle<CR>

" --- Which-Key ------------------------------------------------------------

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-right']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
let g:which_key_map.t = {
      \ 'name' : '+TOrminal' ,
      \ 'r' : ['<leader>tr', 'Open terminal'] ,
      \ }


" ============================================================================
"  5. Autocommands
" ============================================================================

" Startify + NERDTree beim Vim-Start (nur wenn keine Dateien übergeben)
autocmd VimEnter *
      \   if !argc()
autocmd VimEnter * if !argc() | Startify | endif
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if !argc() | wincmd w | endif

" Exit Vim wenn NERDTree das einzige Fenster ist
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" NERDTree in jedem neuen Tab spiegeln
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif

