{
    configs => [
        {
            config => '.vimrc',
            vim_external => [ 
                'configs/vimrc/??_*.vim', 
                { files => 'configs/vimrc/local_??_*.vim', flags => 'local' },
                { files => 'configs/vimrc/utf_??_*.vim', flags => 'utf fbprod' },

            ],
        },
        {
            config => '.zshrc',
            external => [ 
                'configs/zshrc/??_*.sh',
                'configs/sh-common/*.sh',
                { files => 'configs/zshrc/utf.sh', flags => 'utf fbprod' },
                { files => 'configs/zshrc/cp1251.sh', flags => 'cp1251' },
                { files => 'configs/zshrc/umask.sh', flags => 'fbprod' },
                { files => 'configs/zshrc/linux/*', flags => 'linux' },
                { files => 'configs/zshrc/bsd/*', flags => 'freebsd openbsd' },
            ],
        },
        {
            config => '.bashrc',
            external => [ 
                'configs/bashrc/??_*.sh',
                'configs/sh-common/*.sh',
                { files => 'configs/bashrc/utf.sh', flags => 'utf fbprod' },
                { files => 'configs/bashrc/cp1251.sh', flags => 'cp1251' },
                { files => 'configs/bashrc/linux/*', flags => 'linux' },
                { files => 'configs/bashrc/bsd/*', flags => 'freebsd openbsd' },
                { files => 'configs/zshrc/umask.sh', flags => 'fbprod' },
            ],
        },
    ],

    files => {
        '~/.vim/' => 'files/vim/*',
        '~/' =>  [ 
            'configs/screenrc/.screenrc',
            'configs/tmux/.tmux.conf',
            'configs/gitconfig/.gitconfig',
            'configs/bashrc/.bash_profile',
        ],
        '~/.tools/' => 'files/tools/*',
    }
}

