# Bash helpers

## Structure

- dotfiles - configs
- helpers - support helpers and aliases
- The script is installed in the `.helpers` directory
- Script for running by `cron` `cron_helpers`
- local alias
- enable variants auto/manual
- builder all helpers to bundle file


## Enable All-In-One file

### Automatic enable

```bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh
```

#### 

option init.sh `-dotfiles` added dotfiles to `~/.dotfiles/` and create symlinks for root user

### Automatic enable whis dotfiles

````bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh -dotfiles
````

### Manual enable

Copy `.helpers` folder to profile and add to .bash_profile

````bash
##### BASH HELPERS #####
bhlp() {
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for script in ~/.helpers/*.sh ; do
    if [ -f $script ] ; then
        . $script
    fi
done
}

alias ??='bhlp'
??
````

## Enable all files RAW

### Manual enable

add to .bash_profile

````bash
if [ -f ~/bash_helpers/helpers/.bash_helpers.sh ]; then
	. ~/bash_helpers/helpers/.bash_helpers.sh
fi
````

OR

```bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for script in ~/.helpers/*.sh ; do
    if [ -f $script ] ; then
        . $script
    fi
done
```

## Build All-In-One bundle file

````bash
bash build.sh
````

This command combine all files in helpers directory to one bundle file

## Temporarily enable all helpers only on current session

````bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh -lite && . ./.helpers/bash_helpers_bundle.sh && . ./.helpers/local_aliases.sh && rm -fr ../bash-helpers && cd ~/
````

## Squares in the package

- restart_process_if_long_running.sh - automatic restart of long processes
  cron_restart_process_if_long_running.sh - File for installation `cron`

