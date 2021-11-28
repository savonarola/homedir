#!/bin/bash

set -xe

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
