" ╭───────────────────────────────────────────╮
" │                  Basic                    │
" ╰───────────────────────────────────────────╯

" 禁用 vi 兼容模式
set nocompatible

" 自动缩进
set autoindent

" 设置 Backspace 键模式
set bs=eol,start,indent

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" ╭───────────────────────────────────────────╮
" │                  Search                   │
" ╰───────────────────────────────────────────╯

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch


" ╭───────────────────────────────────────────╮
" │                  Display                  │
" ╰───────────────────────────────────────────╯

" 总是显示状态栏
set laststatus=2

" 总是显示行号
set number

" 总是显示标签栏
" set showtabline=2

" 设置显示制表符等隐藏字符
set list


" ╭───────────────────────────────────────────╮
" │                  Tabsize                  │
" ╰───────────────────────────────────────────╯

" 设置缩进宽度
set shiftwidth=4

" 设置 TAB 宽度
set tabstop=4

" 展开 tab
set expandtab

" 如果后面设置了 expandtab 那么展开 tab 为多少字符
set softtabstop=4


" ╭───────────────────────────────────────────╮
" │                  Keymaps                  │
" ╰───────────────────────────────────────────╯

" Move cursor
nnoremap <S-j> 5j
vnoremap <S-j> 5j
onoremap <S-j> 5j
nnoremap <S-k> 5k
vnoremap <S-k> 5k
onoremap <S-k> 5k
nnoremap <S-h> ^
vnoremap <S-h> ^
onoremap <S-h> ^
nnoremap <S-l> $
vnoremap <S-l> $
onoremap <S-l> $

" Move line
nnoremap <C-j> :m+1<CR>V=
vnoremap <C-j> :m'>+1<CR>gv=gv
inoremap <C-j> <ESC>:m+1<CR>V=gi
nnoremap <C-k> :m-2<CR>V=
vnoremap <C-k> :m'<-2<CR>gv=gv
inoremap <C-k> <ESC>:m-2<CR>V=gi

" highlight
nnoremap <Esc><Esc> :nohlsearch<CR>
