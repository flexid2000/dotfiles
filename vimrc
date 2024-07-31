"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           General Options                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $VIMRUNTIME/defaults.vim

" Compatibility and Interface
set nocompatible
set mouse=a
set ttymouse=sgr
if has("gui_running")
   set guifont=Cousine\ 11
endif

" Text Display and Wrapping
set wrap
set linebreak
set textwidth=0
set columns=80
set wrapmargin=0
set number
set numberwidth=5

" Tabs and Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Clipboard
set clipboard=unnamedplus

" Syntax and Filetype
syntax enable
filetype plugin on

" Listchars
set list
set listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣

" Autocommands for Filetypes
augroup filetype_settings
  autocmd!
  autocmd FileType markdown setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
  autocmd FileType text setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
  autocmd FileType mail setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Functions                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function to toggle between light and dark themes
function! ToggleTheme()
  " Check the current theme and toggle
  if exists("g:current_theme") && g:current_theme == 'dark'
    " Switch to light
    call system('alacritty msg config "$(cat /usr/lib/node_modules/alacritty-themes/themes/rose-pine-dawn.toml)"')
    let g:current_theme = 'light'
  else
    " Switch to dark
    call system('alacritty msg config "$(cat /usr/lib/node_modules/alacritty-themes/themes/Catppuccin-Mocha.toml)"')
    let g:current_theme = 'dark'
  endif
endfunction

" Set the default theme when starting Vim
let g:current_theme = 'dark'  " Or 'light', depending on which theme you want as default

function! SetColumnsAndVsplit()
  set columns=210
  vsplit
endfunction

" Erstelle einen neuen Befehl, der die Funktion verwendet
command! Vsp call SetColumnsAndVsplit()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Plugin Management                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Markdown and Writing Plugins
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'preservim/vim-pencil'

" Text Editing Plugins
Plug 'tpope/vim-surround'
Plug 'preservim/vim-textobj-quote'
Plug 'kana/vim-textobj-user'
Plug 'dhruvasagar/vim-table-mode'

" File Navigation Plugins
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Plugin Settings                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-markdown Settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'vim']
let g:vim_markdown_emphasis_multiline = 1

" vim-textobj-user Settings
augroup textobj_quote
  autocmd!
  autocmd FileType markdown call textobj#quote#init()
  autocmd FileType textile call textobj#quote#init()
  autocmd FileType text call textobj#quote#init({'educate': 0})
  autocmd FileType mail call textobj#quote#init()
augroup END
let g:textobj#quote#doubleDefault = '„“'
let g:textobj#quote#singleDefault = '‚‘'

" markdown-preview.nvim Settings
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

" Goyo Settings
autocmd! User GoyoEnter
autocmd! User GoyoLeave
let g:goyo_height = '100%'

" Limelight Settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1

" vim-pencil Settings
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,mail call pencil#init()
  autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

" vim-autoformat Settings
let g:autoformat_autoindent = 0
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_format_on_save = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Key Mappings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader Key
let mapleader = ","

" Ranger Plugin
let g:ranger_map_keys = 0
map <leader>r :Ranger<CR>

" Autoformat Mapping
noremap <F3> :Autoformat<CR>

" Toggle Theme Mapping
nnoremap <F4> :call ToggleTheme()<CR>

" Surround Plugin
let g:surround_42 = "**\r**"

" Mouse Scroll for Tab Switching
nnoremap <ScrollWheelUp> :tabprevious<CR>
nnoremap <ScrollWheelDown> :tabnext<CR>

" Fügt ein non-breaking space ein
inoremap <C-N> <C-Q>u00A0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Autocommands                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set list and listchars for markdown, text, and mail files
augroup filetype_settings
  autocmd!
  autocmd FileType markdown setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
  autocmd FileType text setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
  autocmd FileType mail setlocal nonumber norelativenumber list listchars=space:·,tab:▸\·,trail:·,extends:>,precedes:<,eol:¶,nbsp:␣
augroup END

