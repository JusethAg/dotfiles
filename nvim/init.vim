" Install Plug (vim-plug) manager if It doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" ============================================================
"           Section for installing plugins
" ============================================================
call plug#begin("~/.config/nvim/plugged")
    
    " Vim theme
    " GitHub: https://github.com/dracula/vim
    Plug 'dracula/vim', { 'as': 'dracula' } 

    " File system explorer
    " GitHub: https://github.com/preservim/nerdtree
    Plug 'preservim/nerdtree'

    " NeedTree plugin for showing Git status flag on folders and files
    " GitHub: https://github.com/Xuyuanp/nerdtree-git-plugin
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " NeedTree plugin for adding icons to folders and files
    " GitHub: https://github.com/ryanoasis/vim-devicons
    Plug 'ryanoasis/vim-devicons'

    " NeedTree plugin for highlighting NERDTree based on filetype
    " GitHub: https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " Statusline/tabline plugin
    " GitHub: https://github.com/itchyny/lightline.vim
    Plug 'itchyny/lightline.vim'

    " NodeJS extension host
    " GitHub: https://github.com/neoclide/coc.nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Plugin providing linting
    " GitHub: https://github.com/dense-analysis/ale
    Plug 'dense-analysis/ale'

    " Language pack
    " GitHub: https://github.com/sheerun/vim-polyglot
    Plug 'sheerun/vim-polyglot'

call plug#end()

" ============================================================
"           Section for adding additional configs
" ============================================================

" Set theme
colorscheme dracula

" ========== Configs for nerdtree ==========
" Start NERDTree with cursor on it
autocmd VimEnter * NERDTree

" ========== Configs for nerdtree-git-plugin ==========
" Change symbols
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

" ========== Configs for lightline.vim ==========
" Set colorscheme
let g:lightline = {
    \ 'colorscheme': 'darcula',
\ }

" ========== Configs for CoC ==========
" For adding and installing CoC extensions. 
" Available list: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [
    \ 'coc-java',
    \ 'coc-go',
    \ 'coc-clangd',
    \ 'coc-rls',
    'coc-tsserver'
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-xml',
    \ 'coc-cfn-lint',
    \ 'coc-git',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-graphql',
\ ]

" For avoiding issues with backups (some servers fail)
set nobackup
set nowritebackup

" For reducing delays
set updatetime=300

" For always show the signcolumn, otherwise it would shift the 
" text each time diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" For triggering completition with <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" For triggering completition with <c-space>
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" For making <CR> auto-select the first completion item and notify 
" coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" For using K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" To highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" For formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" For applying codeAction to the selected region.
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" For remapping keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" For applying autoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" To add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" To add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" To add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" For adding (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ========== Configs for Ale ==========
" For fixing files with ALEXFix command
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint'],
\}

" To fix file when saving it
let g:ale_fix_on_save = 1