# Помощники Bash

## Структура

- dotfiles - configs
- helpers - поддержка помощников и псевдонимов
- Скрипт устанавливается в каталог `.helpers`
- Скрипт для запуска `cron` `cron_helpers`
- локальный псевдоним
- включить варианты auto/manual
- собрать все помощники в файл пакета

## Включить файл All-In-One

### Автоматическое включение

```bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh
```

####

option init.sh `-dotfiles` добавил dotfiles в `~/.dotfiles/` и создал символические ссылки для пользователя root

### Автоматическое включение whis dotfiles

````bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh -dotfiles
````

### Ручное включение

Скопировать папку `.helpers` в профиль и добавить в .bash_profile

````bash
##### ПОМОЩНИКИ BASH #####
bhlp() {
# Если не запущено в интерактивном режиме, ничего не делать
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

## Включить все файлы RAW

### Включить вручную

добавить в .bash_profile

````bash
if [ -f ~/bash_helpers/helpers/.bash_helpers.sh ]; then
. ~/bash_helpers/helpers/.bash_helpers.sh
fi
````

ИЛИ

```bash

# Если не запущено в интерактивном режиме, ничего не делать
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

## Сборка файла пакета All-In-One

````bash
bash build.sh
````

Эта команда объединяет все файлы в каталоге helpers в один файл пакета

## Временно включает все помощники только в текущем сеансе

````bash
git clone https://github.com/SCaeR42/bash-helpers.git && cd ./bash-helpers && chmod 777 ./init.sh && ./init.sh -lite && . ./.helpers/bash_helpers_bundle.sh && . ./.helpers/local_aliases.sh && rm -fr ../bash-helpers && cd ~/
````

## Скрипы в пакете

- restart_process_if_long_running.sh - Автоматический перезапуск долгих процессов
  cron_restart_process_if_long_running.sh - файл для установки `cron` 

