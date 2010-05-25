{
    configs => [
        {
            config => '.zshrc',
            external => [ 
                'configs/zshrc/externals/*.sh', 
                { 
                    files => 'configs/zshrc/externals/*.sh', 
                    flags => 'Linux'
                }
            ],
            snippet => [ 
                'configs/zshrc/snippets/*.sh',
            ]
        },
    ],

    files => {

        '~/' => 'files/.about'


    }
}

