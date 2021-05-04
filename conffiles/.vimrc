""""""""""""""""""""""""""""""""""""""""""
" 全局配置
""""""""""""""""""""""""""""""""""""""""""
" 不与vi兼容
set nocompatible
" runtime path
set rtp+=~/.vim/plugged/
" 外部修改文件并在vim内重载自动重新读取
set autoread
" 去除欢迎界面
set shortmess=atI
" 改变搜索模式使用的特殊字符
set magic
" 不创建交换文件
set noswapfile
" 不备份
set nobackup
" 自动保存
set autowrite
" 有错误信息时不响铃
set noerrorbells
" 既不想要响铃也不想要闪烁
set visualbell t_vb=
" 保留撤销历史
set undofile
" 记录历史的数目
set history=1000
"自动切换到目录
set autochdir
" 鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 保存全局变量
set viminfo+=!
" 增强模式中命令行自动完成操作
"set wildmenu
" doc文档设置
" let helptags=$VIMFILES.'/doc'
set helplang=cn

"""""""""""""""""""""""""""""""""""
" 编辑
"""""""""""""""""""""""""""""""""""
" 退格键正常处理indent, eol,start
set backspace=2
" 共享剪贴板
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""
" 编码设置
""""""""""""""""""""""""""""""""""""""""
" 缓冲区、寄存器、表达式所用的字符
set encoding=utf-8
" 自动检测文件编码时的备选字符编码列表
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 终端使用的编码
set termencoding=utf-8
" 以unix格式保存文件
set fileformat=unix
" 用于设置参与自动检测换行符 () 格式类型的备选列表
set fileformats=unix,dos,mac
" 自动排版
set formatoptions+=m
set formatoptions+=B

""""""""""""""""""""""""""""""""""""""""
" 界面显示
""""""""""""""""""""""""""""""""""""""""
" Gvim去掉工具栏,菜单栏滑块
set guioptions-=T
set guioptions-=m
set guioptions-=r
" 主题
color gruvbox
set t_Co=256
set background=dark
" 显示标尺
set ruler
" 显示行号
set number
" 不折行
set nowrap
" 屏幕最后一行显示 (部分的) 命令
set showcmd
" 末行模式高度
set laststatus=2
set cmdheight=2
" 插入、替换和可视模式切换提醒
set showmode
" 显示配对的括号
set showmatch
" 显示配对括号的时间
set matchtime=1
" 语法高亮
syntax on
" 距离顶部和底部几行
set scrolloff=3
" 自定义状态行
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %l:%c[%p%%]/%L%)\
" 带有如下符号的单词不被换行符分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 分隔的窗口间保留空白
"set fillchars=vert:\ ,stl:\ ,stlnc:\
" 启用缩进折叠
set nofoldenable
set foldmethod=indent
set foldcolumn=0
setlocal foldlevel=1

""""""""""""""""""""""""""""""""""""""""""
" 查找配置
""""""""""""""""""""""""""""""""""""""""""
" 搜索结果高亮显示
set hlsearch
" 即时更新预览内容
set incsearch
" 含大写时区分大小写,不含大写时不区分大小写
set ignorecase
set smartcase
" 搜索不循环
set nowrapscan

"""""""""""""""""""""""""""""""""""""""""""
" 缩进配置
"""""""""""""""""""""""""""""""""""""""""""
" 缩进列数对齐到 shiftwidth 值的整数倍
set shiftround
" 与前一行缩进保持相同,智能缩进
set smartindent
" 普通模式下>>缩进长度
set shiftwidth=4
" 插入模式table长度
set tabstop=4
" 插入模式tab和退格走4格
set softtabstop=4
" tab键输出空格
set expandtab
" 插入tab时使用shiftwidth位移
set smarttab

"""""""""""""""""""""""""""""""""""""""""""
" 文件类型
"""""""""""""""""""""""""""""""""""""""""""
" 文件类型检测功能
filetype on
"加载插件功能
filetype plugin on
" 为不同类型的文件定义不同的缩进格式
filetype indent on
autocmd FileType yaml setlocal sw=2 ts=2 et ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown set filetype=markdown.mkd

"""""""""""""""""""""""""""""""""""""""""""""
" 按键映射
"""""""""""""""""""""""""""""""""""""""""""""
" 一键执行代码
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
"                exec "!clear"
                exec "!python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

set pastetoggle=<F12>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-F> <Right>
inoremap <C-B> <Left>

nnoremap <space> @=((foldclosed(line('.')) < 0)? 'zc' : 'zo')<CR>

""""""""""""""""""""""""""""""""""""""""""""
" 插件
""""""""""""""""""""""""""""""""""""""""""""
" 需事先下载https://gitee.com/bigCake/vim-plug.git
" 将plug.vim放到~/.vim程序文件夹中的autoload目录中

" vim-plug插件管理列表
call plug#begin('~/.vim/plugged')

" 主题
Plug 'https://gitee.com/yaozhijin/gruvbox.git'
Plug 'https://gitee.com/leeonky/vim-airline.git'
" 输入法支持插件
"Plug 'https://gitee.com/guanyusheng/vim-fcitx.git'
Plug 'https://gitee.com/guanyusheng/vim-ibus.git'

" 目錄樹
Plug 'https://gitee.com/tay3223/nerdtree.git'

" markdown编辑
Plug 'https://gitee.com/uxvim/vim-markdown.git'

" shell命令补全
Plug 'https://github.com/Shougo/vimshell.vim.git'

""" YouCompleteMe万能代码补全插件
""" 依赖gcc,make,cmake,python-devel,python3-devel,clang
""" 执行PlugInstall后还需要到YCM源码目录中执行git submodule update --init --recursive获取相关依赖
""" 在源码目录中执行./install.py --clang-completer编译c族语言补全功能
""" 如果源里有YCM就安装源里的,github太慢
Plug 'https://gitee.com/Random_Coder/YouCompleteMe.git'

" python代码自动补全默认,依赖jedi库:C-space或.
" 这个不像YCM那么智能,要结合supertab使用效果才好
"Plug 'https://gitee.com/btshub/supertab.git'
Plug 'https://gitee.com/edenglei/jedi-vim.git'

" 自动生成tags
"Plug 'https://gitee.com/dglxlcl/vim-gutentags.git'

" 模糊搜索C-k打开搜索框,:CtrlP 路径查找文件,CtrlPBuffer查缓冲区
Plug 'https://gitee.com/leeonky/ctrlp.vim.git'

" python代码缩进指示 
Plug 'https://gitee.com/tay3223/indentLine.git'

" python语法检查,依赖flake8库
Plug 'https://gitee.com/dglxlcl/ale.git'

" 引号括号自动补齐
Plug 'https://gitee.com/githubClone/auto-pairs.git'

" 多色彩括号显示
Plug 'https://gitee.com/eagle_ice/rainbow_parentheses.vim.git'

" python代码自动格式化,默认执行:Autopep8格式化代码,依赖autopep8库
Plug 'https://gitee.com/yaozhijin/vim-autoformat.git'
" 模块导入格式化
Plug 'https://gitee.com/guanyusheng/vim-isort.git'

" 高效注释[count]<leader>cc注释,[count]<leader>cu取消注释,[count]<leader>ci切换注释状态,[count]<leader>c$注释到行尾,[count]<leader>cA行尾插入注释
Plug 'https://gitee.com/yaozhijin/nerdcommenter.git'

" html格式化插件
Plug 'https://gitee.com/zque/emmet-vim.git'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
""""""""""""""""""""""""""""""""""""""""""""""
" 如果用jedi和supertab那么启用下面的配置
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" vim-ibus
let g:ibus#layout = 'xkb:us::eng'
let g:ibus#engine = 'rime'

" indentLine
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" autoformat
nnoremap <F6> :Autoformat<CR>:Isort<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" nerdtree
nnoremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
" let g:ale_fixers = {
"             \ 'python': ['yapf', 'isort'],
"             \}
" nnoremap <F6> :ALEFix<CR>

" auto-pairs
"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"let g:AutoPairs['<']='>'
let g:AutoPairsMapCR = 1
let g:AutoPairsMapSpace = 1

""""""""""""""""""""""""""""
"ctags
""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
" 
" " 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = '.tags'
" 
" " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" " 检测 ~/.cache/tags 不存在就新建 "
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif
" 
" " 配置 ctags 的参数 "
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

""""""""""""""""""""""""""""""""""""""""""""""
" 小小輸入法
""""""""""""""""""""""""""""""""""""""""""""""
" let g:input_toggle = 0
" 
" function! Yong2en()
" let g:input_toggle = system("yong-vim 1 -w")
" endfunction
" 
" function! Yong2zh()
" if g:input_toggle != 0
" let g:input_toggle = system("yong-vim 0")
" let g:input_toggle = 0
" endif
" endfunction
" 
" autocmd InsertLeave * call Yong2en()
" autocmd InsertEnter * call Yong2zh()
"""""""""""""""""""""""""""""""""""""""""""
" YCM
"""""""""""""""""""""""""""""""""""""""""""
" 去掉preview
set completeopt=menu
" 快捷键
"let g:ycm_key_list_select_completion=['<C-N>']
"let g:ycm_key_list_previous_completion=['<C-P>']
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_max_num_identifier_candidates = 50
let g:ycm_auto_trigger = 1
