{
    configs => [
        {
            config => '.zshrc',
            external => [ 
                'zshrc/externals/*.sh', 
                { 
                    files => 'zshrc/externals/*.sh', 
                    flags => 'Linux'
                }
            ],
            snippet => [ 
                'zshrc/snippets/*.sh',
            ]
        },
    ],

    files => {



    }
}

