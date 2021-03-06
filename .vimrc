"""" Basic behaviour
set nocompatible
set mouse=a                     " enable mouse for all modes
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast
set ffs=unix,dos,mac            " set file encoding priority order

set tabstop=4                   " set width of a hard TAB
set shiftwidth=4                " set width of an indent (indent = m x TABs + n x spaces)
set softtabstop=4               " set columns for a tab
set expandtab                   " expand TABs to spaces
set autoindent                  " copy indent from current line when starting a new line
set smarttab                    " insert blanks on tab according to sw (otherwise uses ts, sts)

set backspace=indent,eol,start  " backspace over indentation, eol, beginning of insert mode
set wrap                        " wrap lines

set number relativenumber       " show line numbers relative to the current line
set ruler                       " show line and column number on right side of statusline

set cmdheight=2                 " set command window height to 2 lines
set showcmd                     " show partial commands in the last line of the screen
set foldenable                  " enable code folding
set showmatch                   " highlight matching parentheses
set wildmenu                    " better command-line completion
" set visualbell                  " use visual bell instead of beeping when doing something wrong
set confirm                     " raise dialog instead of failing a command due to unsaved changes

set splitbelow                  " open new split pane to the bottom
set splitright                  " open new split pane to the right

set hidden                      " enable hidden buffers
set lazyredraw                  " disable redraw while executing macros for better performance

set nrformats-=octal            " disable octal +/- due to conflict with leading zeros
set nrformats+=hex,alpha        " enable +/- for hex and alphabets

"" Include plugins for vim-plug
if filereadable(expand("~/.vim/vimplugins"))
  source ~/.vim/vimplugins
endif

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif



"""" Appearance

set mousemodel=popup
" set t_Co=256
set guioptions=egmrti

syntax enable                   " enable syntax highlighting
filetype plugin indent on       " use filetype-based highlighting
set laststatus=2                " always display status line, even on single window

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  let g:indentLine_faster = 1


  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
    if has('termguicolors')
      set termguicolors
    endif
  endif

endif

"" Set colorscheme
set background=dark
colorscheme gruvbox8


if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif



"""" Search
set incsearch                   " search incrementally as characters are entered
set hlsearch                    " highlight matches
set ignorecase                  " use case-insensitive search
set smartcase                   " use case-insensitive search except when using capital letters
set infercase                   " use case inference for smarter autocompletion
set path+=**                    " recursive file searching from current directory

"" Center line on search item occurence
nnoremap n nzzzv
nnoremap N Nzzzv

"" Search current selection in visual mode
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Rg '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""" Cleaner backup, swap and undo files
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "", 0700)
endif
set backupdir=~/.vim/backup//
if !isdirectory($HOME."/.vim/swp")
    call mkdir($HOME."/.vim/swp", "", 0700)
endif
set directory=~/.vim/swp//
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif
set undodir=~/.vim/undo//
set undofile



"""" Key Bindings

"" Map leader to ,
let mapleader=','

nnoremap <leader>jk :nohlsearch<CR>         " turn off highlights after search
map Y y$

" Press enter for newline without insert
nnoremap <cr> O<esc>
" but don't effect command line mode
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd CmdwinLeave * nnoremap <cr> o<esc>

""Press jk to quit Input Mode
inoremap jk <esc>
xnoremap jk <esc>

"" Code folding
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Split navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

"" Split resize
nnoremap <C-S-j> :resize -2<CR>
nnoremap <C-S-k> :resize +2<CR>
nnoremap <C-S-l> :vertical resize +2<CR>
nnoremap <C-S-h> :vertical resize -2<CR>

"" Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tj :tabnext
nnoremap <leader>tk :tabprevious
noremap <Leader><Left>  :tabmove -1<CR>     " shift tab to the left
noremap <Leader><Right> :tabmove +1<CR>     " shift tab to the right

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


"" Error window navigation
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>x :cclose<CR>


"" Buffer navigation
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>


"" Indent code blocks
vnoremap < <gv
vnoremap > >gv


"" Move code blocks
nnoremap <S-Down> :m .+1<CR>==
nnoremap <S-Up> :m .-2<CR>==
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv


"" Use urlview to choose and open a url:
:noremap <leader>u :w<Home>silent <End> !urlview<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>



"""" Miscellaneous shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall



"""" Auto-commands

" Automatic reloading of .vimrc on save
    autocmd BufWritePost ~/.vimrc source %

" Automatically deletes all trailing whitespace on save.
    function! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun

    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Automatically save and reload folds
augroup folding
    " au BufWinLeave * mkview
    " au BufWinEnter * silent loadview
augroup END

" Periodically check for file changes
augroup file-refresh
    autocmd!
    autocmd CursorHold * silent! checktime
augroup END

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %



"""" Language specific configs

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" css
au! FileType css,scss setl iskeyword+=-


" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END


" LaTeX
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal="abdmg"

let g:auto_save_events = ["InsertLeave"]
let g:auto_save_in_insert_mode = 0
autocmd FileType tex let g:auto_save=1
autocmd FileType tex let g:auto_save_silent=1


" go
" vim-go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_addtags_transform = "snakecase"

augroup vimrc-go
  autocmd!
  autocmd Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
  autocmd Filetype go nmap <leader>gah <Plug>(go-alternate-split)
  autocmd Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
  autocmd FileType go nmap <F10> :GoTest -short<cr>
  autocmd FileType go nmap <F11> :GoCoverageToggle -short<cr>
  autocmd FileType go nmap <F12> <Plug>(go-def)
augroup end

" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
" let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" syntastic
let g:syntastic_python_checkers=['python', 'flake8']

" Syntax highlight
" Default highlight is better than polyglot
" Disable latex in polyglot to use vimtex
let g:polyglot_disabled = ['latex', 'python']
let python_highlight_all = 1


" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" augroup tfvars
"   autocmd!
"   autocmd BufNewFile,BufRead *.tfvars set filetype=tfvars
" augroup END



"""" Plugin-specific configs and bindings

"" Vim Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts=1
if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
let g:airline_theme = 'gruvbox'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#virtualenv#enabled = 1



"" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>



"" vim-session
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>



"" vim-fugitive
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gps :Gpush<CR>
noremap <Leader>gpl :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
noremap <Leader>gh :diffget //2<CR>
noremap <Leader>gl :diffget //3<CR>



"" fzf.vim
set rtp+=~/.fzf
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!{.git, node_modules}"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!{.git, node_modules}" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles --exclude-standard --other
  endif
endfun

nnoremap <silent> <leader>;         :BLines<CR>                 " lines in current buffer
nnoremap <silent> <leader>o         :BTags<CR>                  " tags in current buffer
nnoremap <silent> <leader><enter>   :Buffers<CR>                " open buffers
nnoremap <silent> <C-p>             :call FzfOmniFiles()<CR>
nnoremap <silent> <leader><space>   :Files<CR>                  " open files
nnoremap <silent> <leader>ft        :Filetypes<CR>              " change filetype
nnoremap <silent> <leader>?         :History<CR>                " file history
nnoremap <silent> <leader>:         :History:<CR>               " command history
nnoremap <silent> <leader>/         :History/<CR>               " search history
nnoremap <silent> <leader>`         :Marks<CR>                  " all marks
nnoremap <silent> <leader>s         :Snippets<CR>               " ultisnips snippets
nnoremap <silent> <leader>A         :Windows<CR>                " open windows
nnoremap <silent> <leader>O         :Tags<CR>                   " all tags



"" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier','eslint'],
\}
let g:ale_fix_on_save = 1
nmap <Leader>ad :ALEGoToDefinition<CR>
nmap <Leader>ah :ALEHover<CR>
nmap <Leader>ar :ALEFindReferences<CR>
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'



"" Ultisnips
let g:UltisnipsEditSplit='vertical'
let g:UltisnipsListSnippets='<C-S-s>'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'



"" coc.nvim
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
set completeopt=longest,menuone

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Add Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" Disable vim-go definition mapping
let g:go_def_mapping_enabled = 0



""vim-slime
let g:slime_target = "kitty"
