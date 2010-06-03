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
    ],

    files => {
        '~/.vim/' => 'files/vim/*',
    }
}

