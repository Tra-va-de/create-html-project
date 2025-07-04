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

# Создаем .gitignore и добавляем в него исключения
cat << EOF > "$new_project_path/.gitignore"
docs/
.gitignore
EOF

echo "Project structure created at $new_project_path!"