{
    configs => [
        {
            config => '.vimrc',
            vim_external => [ 
                'configs/vimrc/??_*.vim', 
                { files => 'configs/vimrc/local_??_*.vim', flags => 'local' },
                { files => 'configs/vimrc/utf_??_*.vim', flags => 'linux utf' },

            ],
        },
        {
            config => '.zshrc',
            external => [ 
                'configs/zshrc/??_*.sh',
                { files => 'configs/zshrc/utf.sh', flags => 'utf' },
                { files => 'configs/zshrc/cp1251.sh', flags => 'cp1251' },
                { files => 'configs/zshrc/linux/*', flags => 'linux' },
                { files => 'configs/zshrc/bsd/*', flags => 'freebsd openbsd' },
            ],
        },
    ],

    files => {
        '~/.vim/' => 'files/vim/*',
        '~/' =>  [ 'configs/screenrc/.screenrc' ],
    }
}

