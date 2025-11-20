#!/usr/bin/env bash

# Сессия todo
tmux new-session -d -s todo -n todo.txt "nvim ~/tasks/todo.txt"
tmux split-window -h -t todo 'nvim /home/solalek/tasks/tomorrow'

# Сессия monitoring
tmux new-session -d -s monitoring -n btop "btop"
tmux new-window -t monitoring -n nethogs "nethogs"

# # Сессия java
# tmux new-session -d -s java -n edit "cd ~/projects/java; exec fish"
# tmux new-window -t java -n launch "cd ~/projects/java; exec fish"

# Пустая сессия default
tmux new-session -d -s default

# Подключаемся к первой сессии
tmux attach-session -t default

