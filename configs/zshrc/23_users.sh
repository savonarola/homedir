alias f="sudo -u fbdeploy"
alias fs="f sudo -u service"
alias fsh="sudo -E -u fbdeploy zsh"
alias fssh="sudo -E -u fbdeploy sudo -E -u service"

alias fp="f env RAILS_ENV=production"
alias fsp="fs env RAILS_ENV=production"

alias fpb="fp bundle exec"
alias fspb="fsp bundle exec"

