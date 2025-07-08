#!/bin/bash

# Получаем путь к текущей папке
projects_folder=$(pwd)
folder_name="pr"

# Определяем последний номер проекта
last_project_number=-1
for folder in "$projects_folder"/"$folder_name"*; do
    if [[ -d "$folder" ]]; then
        num=${folder##*"$folder_name"}
        if [[ $num =~ ^[0-9]+$ ]] && [ $num -gt $last_project_number ]; then
            last_project_number=$num
        fi
    fi
done

# Вычисляем номер нового проекта
new_project_number=$((last_project_number + 1))
new_project_name="$folder_name$new_project_number"
new_project_path="$projects_folder/$new_project_name"

# Проверяем, существует ли уже такая папка, если да, увеличиваем номер
while [[ -d "$new_project_path" ]]; do
    new_project_number=$((new_project_number + 1))
    new_project_name="$folder_name$new_project_number"
    new_project_path="$projects_folder/$new_project_name"
done

# Пути к создаваемым папкам
docs_path="$new_project_path/docs"
src_path="$new_project_path/src"
css_path="$src_path/css"
img_path="$src_path/img"
html_path="$src_path/html"

# Создаем все необходимые папки
mkdir -p "$docs_path" "$css_path" "$img_path" "$html_path"

# Создаем базовый index.html с разметкой
cat << EOF > "$new_project_path/index.html"
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="./src/css/style.css">
</head>
<body>

</body>
</html>
EOF

# Создаем пустой style.css
touch "$css_path/style.css"

cat > "$new_project_path/.justfile" << 'EOF'
# Указываем оболочку по умолчанию для Linux
set shell := ["bash", "-uc"]

# Создание новой ветки от main с вводом названия и переключение на нее
create-branch:
    read -p "Введите название новой ветки: " branchName && \
    git checkout main && \
    git branch "$branchName" && \
    git checkout "$branchName" && \
    git branch --show-current

# Коммит и отправка изменений в текущую ветку
push-current:
    read -p "Введите сообщение для коммита: " commitMessage && \
    git add . && \
    git commit -m "$commitMessage" && \
    git push origin $(git branch --show-current)

# Слияние текущей ветки в main и публикация
merge-current:
    currentBranch=$(git branch --show-current) && \
    git checkout main && \
    git merge --no-ff "$currentBranch" -m "merge from $currentBranch" && \
    git push origin main

# Слияние изменений из указанной ветки в main и публикация
merge-to-main:
    git checkout main && \
    read -p "Введите название ветки для слияния: " branchName && \
    git merge --no-ff "$branchName" -m "merge from $branchName" && \
    git push origin main

# Отправка изменений текущей ветки и слияние с main с публикацией
push-and-merge:
    read -p "Введите сообщение для коммита: " commitMessage && \
    git add . && \
    git commit -m "$commitMessage" && \
    currentBranch=$(git branch --show-current) && \
    git push origin "$currentBranch" && \
    git checkout main && \
    git merge --no-ff --no-edit "$currentBranch" && \
    git push origin main

# Откат последнего коммита в текущей ветке
undo-last-commit:
    currentBranch=$(git branch --show-current) && \
    git reset --hard HEAD^ && \
    git push origin main --force

# Откат последнего слияния в main и изменений в исходной ветке
undo-last-merge:
    git checkout main && \
    mergedBranch=$(git for-each-ref --format='%(refname:short)' refs/heads/ | grep -v '^main$' | while read branch; do \
                   if git merge-base --is-ancestor $(git rev-list --parents -n 1 $(git log --merges -1 --pretty=%H) | awk '{print $3}') $branch; then \
                   echo $branch; break; fi; done) && \
    git reset --hard HEAD^ && \
    git push origin main --force && \
    git checkout $mergedBranch && \
    git reset --hard HEAD^ && \
    git push origin $mergedBranch --force
EOF

# Создаем .gitignore и добавляем в него исключения
cat << EOF > "$new_project_path/.gitignore"
docs/
.gitignore
.justfile
EOF

echo "Project structure created at $new_project_path!"