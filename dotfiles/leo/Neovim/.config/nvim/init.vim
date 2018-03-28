"autocmd VimEnter * !tmux rename-window vim
set tabstop=4
set shiftwidth=4

" set sidebar
"set number
set foldcolumn=1
highlight LineNr ctermbg=0
highlight FoldColumn ctermbg=0
"highlight VertSplit ctermbg=7 ctermfg=16
"highlight EndOfBuffer ctermfg=16

" Use alt-[hjkl] to select the active split!
nmap <silent> <m-k> :wincmd k<CR>
nmap <silent> <m-j> :wincmd j<CR>
nmap <silent> <m-h> :wincmd h<CR>
nmap <silent> <m-l> :wincmd l<CR>

" table mode
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='-'
command TableModeFull let g:table_mode_corner_corner="|" | let g:table_mode_header_fillchar="-"
command TableModeGrid let g:table_mode_corner_corner="+" | let g:table_mode_header_fillchar="="

" rmarkdown
"autocmd FileType rmarkdown let b:pandoc_command_autoexec_command = "silent RMarkdown html"
command RMarkrender silent ! (exec ~/Scripts/rmarkdown-vivaldi %:t ) &> /dev/null
command RMarkrenderv ! (exec ~/Scripts/rmarkdown-vivaldi %:t )

" vim-pandoc
let g:pandoc#command#latex_engine = ""
let g:pandoc#modules#disabled = [ 'folding', 'spell' ]

let g:pandoc#syntax#conceal#blacklist = [ 'titleblock', 'image', 'block', 'subscript', 'superscript', 'strikeout', 'atx', 'codeblock_start', 'codeblock_delim', 'footnote', 'definition', 'list', 'newline', 'dashes', 'ellipses', 'quotes', 'inlinecode' ]

"let pandoc#command#autoexec_on_writes =	1
"let b:pandoc_command_autoexec_command = "silent Pandoc! html"

let g:pandoc#after#modules#enabled = ["tablemode"]

" vim-instant-markdown
let g:instant_markdown_autostart = 0

" startify
let g:startify_files_number           = 8
let g:startify_relative_path          = 0
let g:startify_change_to_dir          = 1
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1 
let g:startify_session_persistence    = 1

let g:startify_list_order = ['files', 'bookmarks', 'sessions', 'commands']

let g:startify_skiplist = [
    \ 'COMMIT_EDITMSG',
    \ 'bundle/.*/doc',
    \ '/data/repo/neovim/runtime/doc',
    \ '/Users/mhi/local/vim/share/vim/vim74/doc',
	\ '/nix/store/*',
    \ ]

let g:startify_bookmarks = [
        \ { 'v': '~/.config/nvim/init.vim' },
		\ { 'c': '~/nixos-config' },
        \ { 's': '~/nixos-config/systems/home.nix' },
        \ { 'u': '~/nixos-config/users/leo.nix' } ]

let g:startify_custom_header =
        \ map(split(system('figlet -S neovim'), '\n'), '"   ". v:val')

"let g:startify_custom_header =
"        \ map(split(system('figlet -S xXneovimXx'), '\n'), '"   ". v:val')


"let g:startify_custom_footer =
"        \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val')

"hi StartifyBracket ctermfg=0
"hi StartifyFile    ctermfg=4
"hi StartifyFooter  ctermfg=0
hi StartifyHeader  ctermfg=1
"hi StartifySection ctermfg=1
"hi StartifyNumber  ctermfg=0
"hi StartifyPath    ctermfg=0
"hi StartifySlash   ctermfg=1
"hi StartifySpecial ctermfg=0

let normalBg = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'cterm')
if (normalBg ==# '')
	let normalBg = '16'
endif

execute 'highlight EndOfBuffer ctermfg='.normalBg

" Fix broken colors
hi Statement ctermfg=3
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
