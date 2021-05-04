""""""""""""""""""""""""""""""""""""""""""
" 全局配置
""""""""""""""""""""""""""""""""""""""""""
" 不与vi兼容
set nocompatible
" 外部修改文件并在vim内重载自动重新读取
set autoread
" 去除欢迎界面
set shortmess=atI
" 改变搜索模式使用的特殊字符
set magic
" 窗口标题显示位置
set title
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
" 显示可视响铃
set t_vb=
" 映射的键序列完成的时间
set timeoutlen=500
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
" 代码补全模式preview
set completeopt=preview,menu
" 共享剪贴板
set clipboard=unnamed
" 处理未保存或只读文件弹出确认
set confirm
" 保存全局变量
set viminfo+=!
" 增强模式中命令行自动完成操作
set wildmenu
" 退格键正常处理indent, eol,start
set backspace=2
" 允许退格键和光标跨越行边界
"set whichwrap+=<,>,h,l

""""""""""""""""""""""""""""""""""""""""
" 编码设置
""""""""""""""""""""""""""""""""""""""""
set fileencoding=chinese
set fileencodings=ucs-bom,utf-8,gb18030,gb2312,cp936,gbk,big5,latin-1
" 缓冲区、寄存器、表达式所用的字符
set encoding=utf-8
" 自动检测文件编码时的备选字符编码列表
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 以unix格式保存文件
set fileformat=unix
" 用于设置参与自动检测换行符 () 格式类型的备选列表
set fileformats=unix,dos,mac
" 终端使用的编码
set termencoding=utf-8
" 自动排版
set formatoptions+=m
set formatoptions+=B

""""""""""""""""""""""""""""""""""""""""
" 界面显示
""""""""""""""""""""""""""""""""""""""""
" 主题
color desert
set t_Co=256
" 背景色
set background=dark
" 隐藏滚动条
set guioptions-=r
set guioptions-=L
set guioptions-=b
" 隐藏顶部标签栏
set showtabline=0
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
" 举例顶部和底部几行
set scrolloff=3
" 自定义状态行
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
" 带有如下符号的单词不被换行符分割
set iskeyword+=_,$,@,%,#,-
" 分隔的窗口间保留空白
set fillchars=vert:\ ,stl:\ ,stlnc:\

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
"""""""""""""""""""""""""""""""""""""""""""
" 制表符
"""""""""""""""""""""""""""""""""""""""""""
" tab键输出空格
set expandtab
" 插入tab时使用shiftwidth位移
set smarttab
" 缩进列数对齐到 shiftwidth 值的整数倍
set shiftround
"""""""""""""""""""""""""""""""""""""""""""
" 缩进配置
"""""""""""""""""""""""""""""""""""""""""""
" 与前一行缩进保持相同,智能缩进
set autoindent smartindent shiftround
" 普通模式下>>缩进长度
set shiftwidth=4
" 插入模式table长度
set tabstop=4
" 插入模式tab和退格走4格
set softtabstop=4
" C样式的缩进格式
set cindent
" 自动缩进
set ai
"""""""""""""""""""""""""""""""""""""""""""
" 文件类型
"""""""""""""""""""""""""""""""""""""""""""
" 文件类型检测功能
filetype on
"加载文件类型插件功能
filetype plugin on
" 为不同类型的文件定义不同的缩进格式
filetype indent on
autocmd FileType yaml setlocal sw=2 ts=2 et ai

"""""""""""""""""""""""""""""""""""""""""""""
" 按键映射
"""""""""""""""""""""""""""""""""""""""""""""
" F5执行当前代码并保存
" cwd非零时跳到文件所在目录,运行后又跳回来,needsave非零时执行前先保存
map <F5> :call VimExecute()<CR>
let cwd = 1
let needsave = 0
function! VimExecute(cwd, needsave)
    let savecwd = getcwd()
    let cd = haslocaldir()? 'lcd ' : 'cd '
    let ext = tolower(expand("%:e"))
    if bufname('%') == '' 
        return 
    endif
    if a:needsave != 0
        silent! update 
    endif
    if a:cwd != 0
        let dest = expand('%:p:h')
        silent! exec cd . fnameescape(dest)
    endif
    if has('gui_running') && (has('win32') || has('win64') || has('win10'))
        let fname = shellescape(expand("%"))
        if index(['c', 'cpp'], &filetype) >= 0
            exec '!start cmd /C '. shellescape(expand("%<")) . ' & pause'
        elseif index(['py', 'pyw', 'pyc', 'pyo'], ext) >= 0
            silent exec '!start cmd /C python3 ' . fname . ' & pause'
        elseif index(['html', 'htm'], ext) >= 0
            exec '!start ' . fname
        elseif ext  == "js"
            silent exec '!start cmd /C node ' . fname . ' & pause'
        elseif ext == 'sh'
            silent exec '!start cmd /C sh ' . fname . ' & pause'
        elseif ext == 'lua'
            silent exec '!start cmd /C lua ' . fname . ' & pause'
        elseif ext == 'pl'
            silent exec '!start cmd /C perl ' . fname . ' & pause'
        elseif ext == 'rb'
            silent exec '!start cmd /C ruby ' . fname . ' & pause'
        elseif ext == 'php'
            silent exec '!start cmd /C php ' . fname . ' & pause'
        elseif ext == 'ps1'
            silent exec '!start cmd /C powershell '. fname. ' & pause'
        endif
    else
        if index(['c', 'cpp'], &filetype) >= 0
            exec '!'. shellescape(expand("%<"))
        elseif index(['py', 'pyw', 'pyc', 'pyo'], ext) >= 0
            exec '!python3 ' . shellescape(expand("%"))
        elseif index(['html', 'htm'], ext) >= 0
            exec '!start ' . shellescape(expand("%"))
        elseif ext  == "js"
            exec '!node ' . shellescape(expand("%"))
        elseif ext == 'sh'
            exec '!sh ' . shellescape(expand("%"))
        elseif ext == 'lua'
            exec '!lua ' . shellescape(expand("%"))
        elseif ext == 'pl'
            exec '!perl ' . shellescape(expand("%"))
        elseif ext == 'rb'
            exec '!ruby ' . shellescape(expand("%"))
        elseif ext == 'php'
            exec '!php ' . shellescape(expand("%"))
        elseif index(['osa', 'scpt', 'applescript'], ext) >= 0
            exec '!osascript '. shellescape(expand('%'))
        elseif ext == 'ps1'
            exec 'powershell '. shellescape(expand('%'))
        endif
    endif
    if a:cwd != 0
        silent! exec cd . fnameescape(savecwd)
    endif
endfunc

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

""""""""""""""""""""""""""""""""""""""""""""
" 插件
""""""""""""""""""""""""""""""""""""""""""""
" 需事先下载https://gitee.com/bigCake/vim-plug.git
" 将plug.vim放到vim程序文件夹中的autoload目录中
" vim-plug插件管理列表
call plug#begin('D:\ruanjian\Neovim\share\nvim\runtime\plugged')
" 目錄樹
Plug 'https://gitee.com/tay3223/nerdtree.git'
" markdown编辑
Plug 'https://gitee.com/uxvim/vim-markdown.git'
" python代码自动补全默认,依赖jedi库:C-space或.
Plug 'https://gitee.com/edenglei/jedi-vim.git'
" 自动生成tags
Plug 'https://gitee.com/dglxlcl/vim-gutentags.git'
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
" 高效注释[count]<leader>cc注释,[count]<leader>cu取消注释,[count]<leader>ci切换注释状态,[count]<leader>c$注释到行尾,[count]<leader>cA行尾插入注释
Plug 'https://gitee.com/yaozhijin/nerdcommenter.git'
" html插件
Plug 'https://gitee.com/zque/emmet-vim.git'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
""""""""""""""""""""""""""""""""""""""""""""""
" jedi-vim
let g:jedi#completions_command = "<C-N>"
" indentLine
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
" autoformat
nnoremap <F6> :Autoformat<CR>
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
""""""""""""""""""""""""""""
"ctags
""""""""""""""""""""""""""""
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
