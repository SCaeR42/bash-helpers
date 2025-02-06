#!/bin/bash

# Функция для перезапуска сервиса, если найденный процесс работает более указанной длительности
restart_process_if_long_running() {
    local process_name=$1
    local service_name=$2
    local max_runtime=$3

    # Если второй параметр (сервис) не передан, используем название процесса как сервис
    if [ -z "$service_name" ]; then
        service_name="$process_name"
    fi

    # Если третий параметр (длительность работы) не передан, устанавливаем по умолчанию 7200 секунд
    if [ -z "$max_runtime" ]; then
        max_runtime=7200
    fi

    # Находим все PIDs для указанного процесса
    pids=$(pgrep -f "$process_name")

    # Если процессы найдены
    if [ -n "$pids" ]; then
        for pid in $pids; do
            # Время работы процесса в секундах
            runtime=$(ps -p $pid -o etimes=)

            # Проверяем, если время работы процесса больше указанного порога
            if [ "$runtime" -gt "$max_runtime" ]; then
                echo "Процесс $process_name (PID $pid) работает более $max_runtime секунд. Перезапуск сервиса $service_name..."
                systemctl restart "$service_name"
                return  # Выход из функции после перезапуска
            # else
                # echo "Процесс $process_name выполняется $runtime."
            fi
        done
    else
        echo "Процесс $process_name не найден."
    fi
}

# Пример вызова функции
# Параметры: процесс, сервис для перезапуска, максимальная длительность работы (в секундах)
# Если сервис не указан, он будет равен процессу
# Если длительность не указана, будет использовано значение по умолчанию 7200 секунд

# Вызов функции с тремя параметрами
# restart_process_if_long_running "mysqld" "mysql" 7200

# Вызов функции с двумя параметрами (сервис равен процессу)
# restart_process_if_long_running "mysqld" "mysql"

# Вызов функции с одним параметром (сервис и длительность по умолчанию)
# restart_process_if_long_running "mysqld"
# restart_process_if_long_running "systemd-journald"
# restart_process_if_long_running "systemd-resolved"

# restart_process_if_long_running "php-fpm" "php8.3-fpm" 7200
