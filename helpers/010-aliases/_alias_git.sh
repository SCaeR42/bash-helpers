#!/bin/bash
#git
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"

alias gs='git status'
alias ga='git add'
alias gac='git add .;git commit -a'
alias gacm='git add .;git commit -a -m'
alias gcm='git commit --amend'
alias gu='git config user.name; git config user.email'
alias gl='git log'
alias gpush='git push'
alias gpull='git pull'
alias gr='git remote'
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative -30"

alias gi='echo "
gb		-	git branch
gc		-	git commit
gd		-	git diff
gco		-	git checkout
gs		-	git status
ga		-	git add .
gac		-	git add .;git commit -a
gacm		-	git add .;git commit -a -m
gcm		-	git commit --amend
gu		-	git config user.name; git config user.email
gl		-	git log
gpush		-	git push
gpushnew		-	git push --set-upstream origin
gpull		-	git pull
gr		-	git remote"
gll		-	git log graph + colored last 30"
'

# Получение новой удалённой ветки с доп. действиями
function gpullB {
    if [ $# -eq 0 ] || [ $# -gt 2 ]
    then
        read -p "Enter a branch name: " newBranchName
    else
        newBranchName=$1
    fi

    git checkout -b $newBranchName origin/$newBranchName

    echo "Getting new branch" $value
    git branch
}

# Проверка изменений git
# alias gcheck="gCheck '/home/bitrix/ext_www/site.info' 'site.info' && gCheck '/home/bitrix/kernel/bitrix' 'kernel'"
gCheck() {
    path=$1
    name=$2

    echo -e "check ${_BRed}$name${_Norm}"
    cd $path
    gitStatus=$(git status -s)

    gitStatusLines=$(git status -s | wc -l)


    if [[ "$gitStatusLines" -lt 1 ]]
    then
        echo -e " ${_Green}Изменений не найдено${_Norm}"
    else
        echo -e "${_Red}$gitStatus${_Norm}"
    fi

    echo '============='
}


