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
scss_path="$src_path/scss"
css_path="$src_path/css"
img_path="$src_path/img"
html_path="$src_path/html"
fonts_path="$src_path/fonts"

# Создаем все необходимые папки
mkdir -p "$docs_path" "$scss_path" "$css_path" "$img_path" "$html_path" "$fonts_path"

# Создаем папки для SCSS 7-1 структуры
mkdir -p "$scss_path/abstracts"
mkdir -p "$scss_path/base"
mkdir -p "$scss_path/components"
mkdir -p "$scss_path/layout"
mkdir -p "$scss_path/pages"
mkdir -p "$scss_path/themes"
mkdir -p "$scss_path/vendors"

# Создаем базовый index.html с разметкой
cat << EOF > "$new_project_path/index.html"
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="./src/css/style.min.css">
</head>
<body>

</body>
</html>
EOF

# Создаем style.scss файл
cat << EOF > "$scss_path/style.scss"
// Abstracts
@import 'abstracts/variables';
@import 'abstracts/functions';
@import 'abstracts/mixins';
@import 'abstracts/extends';

// Vendors

// Base
@import 'base/reset';
@import 'base/typography';
@import 'base/animations';

// Layout
@import 'layout/header';
@import 'layout/footer';

// Components
@import 'components/container';
@import 'components/navigation';

// Pages

// Themes
EOF

# Создаем variables файл с основными переменными
cat << EOF > "$scss_path/abstracts/_variables.scss"
// Breakpoints
\$viewport-max: 1920px;
\$viewport-min: 280px;
\$breakpoint-sm: 576px;
\$breakpoint-md: 768px;
\$breakpoint-lg: 992px;
\$breakpoint-xl: 1200px;

// Grid
\$container-width: 1230px;
\$grid-gap: 30px;
\$container-padding: 15px;

// Base colors
\$white: #FFFFFF;
\$black: #000000;
\$gray-100: #f5f5f5;
\$gray-200: #e0e0e0;
\$gray-300: #cccccc;
\$gray-400: #999999;
\$gray-500: #666666;
\$gray-600: #333333;
\$gray-700: #222222;
\$gray-800: #111111;
\$gray-900: #000000;
\$blue: #007bff;
\$green: #28a745;
\$red: #dc3545;
\$orange: #fd7e14;
\$purple: #6f42c1;

// Semantic colors
\$title-color: \$black;
\$text-color: \$gray-600;
\$text-second-color: \$gray-400;

\$accent-color: \$blue;
\$second-accent-color: \$green;

\$button-color: \$blue;
\$button-second-color: \$gray-500;

\$link-color: \$blue;

\$footer-bg: \$gray-900;

\$border-light: \$gray-200;
\$text-muted: \$gray-400;
\$background-dark: \$gray-700;
\$background-darker: \$gray-800;

// Gradients
// Здесь можно добавить градиенты, например:
// \$section-gradient: linear-gradient(45deg, \$gray-700 0%, \$gray-800 100%);

// Typography
\$title-font: 'Raleway', sans-serif;
\$text-font: 'Montserrat', sans-serif;
\$additional-font: 'Roboto', sans-serif;

// Font Sizes - от малого к большому
\$font-size-xs: 12px;      // Очень маленький текст
\$font-size-sm: 14px;      // Маленький текст
\$font-size-base: 16px;    // Базовый размер текста
\$font-size-md: 18px;      // Средний текст
\$font-size-lg: 20px;      // Большой текст
\$font-size-xl: 24px;      // Очень большой текст
\$font-size-2xl: 30px;     // Заголовок секции
\$font-size-3xl: 36px;     // Большой заголовок
\$font-size-4xl: 48px;     // Очень большой заголовок
\$font-size-5xl: 60px;     // Гигантский заголовок

\$line-height-base: 1.5;
\$line-height-tight: 1.2;
\$line-height-relaxed: 1.8;

// Spacing
\$spacing-unit: 8px;
\$spacing-xs: \$spacing-unit;
\$spacing-sm: \$spacing-unit * 2;
\$spacing-md: \$spacing-unit * 3;
\$spacing-lg: \$spacing-unit * 4;
\$spacing-xl: \$spacing-unit * 5;

// Z-index
\$z-index-header: 1000;
\$z-index-modal: 2000;
\$z-index-tooltip: 3000;
EOF

# Создаем functions файл
cat << EOF > "$scss_path/abstracts/_functions.scss"
// Функция для удаления единиц измерения
@function strip-unit(\$value) {
    @return \$value / (\$value * 0 + 1);
}
EOF

# Создаем mixins файл с улучшенными миксинами
cat << EOF > "$scss_path/abstracts/_mixins.scss"
// ================================================
// Миксин для позиционирования секции
// ================================================
@mixin section-position(\$z-index: 2) {
    position: relative;

    &__content {
        position: relative;
        z-index: \$z-index;
    }
    
    &__background {
        position: absolute;
        inset: 0;
    }

    &__content, &__background {
        @extend %full-size;
    }
}

// ====================================================
// Миксин для создания адаптивного стиля
// ====================================================
@mixin adaptive-style(\$property, \$pc-font-size, \$mobile-font-size) {
    \$add-size: \$pc-font-size - \$mobile-font-size;
    
    @if (unit(\$add-size) == px) {
        \$add-size: strip-unit(\$add-size);
    }

    @if (unit(\$add-size) == rem) {
        \$add-size: strip-unit(\$add-size) * \$font-size-base;
    }

    #{\$property}: calc(#{\$mobile-font-size} + #{strip-unit(\$add-size)} * ((100dvw - #{\$viewport-min + px}) / (#{\$viewport-max} - #{\$viewport-min})));
}

// ====================================================
// Миксин для адаптивного размера шрифта
// ====================================================
@mixin adaptive-font(\$pc-font-size, \$mobile-font-size) {
    @include adaptive-style('font-size', \$pc-font-size, \$mobile-font-size);
}

// ================================================
// Миксин для адаптивной высоты строки
// ================================================
@mixin adaptive-line-height(\$pc-line-height, \$mobile-line-height) {
    @include adaptive-style('line-height', \$pc-line-height, \$mobile-line-height);
}
EOF

# Создаем extends файл с улучшенными утилитами
cat << EOF > "$scss_path/abstracts/_extends.scss"
// Hover эффекты
%hover-text {
    transition: color 300ms ease-out;
    cursor: pointer;

    &:hover {
        color: \$accent-color;
    }
}

%hover-icon {
    cursor: pointer;
    
    & path {
        transition: fill 300ms ease-in-out;
        fill: \$text-color;
    }

    &:hover path {
        fill: \$accent-color;
    }
}

%hover-scale {
    transition: transform 300ms ease-out;
    cursor: pointer;

    &:hover {
        transform: scale(1.1);
    }
}

%active-color {
    transition: filter 300ms ease-out;
    cursor: pointer;

    &:active {
        filter: hue-rotate(15deg);
    }
}

%hover-and-active {
    @extend %hover-scale;
    @extend %active-color;
    transition: transform 300ms ease-out, filter 300ms ease-out;
}

// Flex утилиты
%flex-all-center {
    display: flex;
    justify-content: center;
    align-items: center;
}

%flex-align-center {
    display: flex;
    align-items: center;
}

%flex-justify-center {
    display: flex;
    justify-content: center;
}

%flex-between {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

%flex-column {
    display: flex;
    flex-direction: column;
}

%flex-column-center {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

// Размеры
%full-size {
    width: 100%;
    height: 100%;
}

%full-width {
    width: 100%;
}

%full-height {
    height: 100%;
}

// Позиционирование
%absolute-center {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

%absolute-full {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
}

// Текст
%text-ellipsis {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

%text-break {
    word-break: break-word;
    overflow-wrap: break-word;
}

// Интерактивность
%clickable {
    cursor: pointer;
    user-select: none;
}

%no-select {
    user-select: none;
    -webkit-user-select: none;
}

// Анимации
%fade-in {
    opacity: 0;
    transition: opacity 300ms ease-in;
    
    &.active,
    &:hover {
        opacity: 1;
    }
}

%slide-up {
    transform: translateY(20px);
    opacity: 0;
    transition: transform 300ms ease-out, opacity 300ms ease-out;
    
    &.active {
        transform: translateY(0);
        opacity: 1;
    }
}
EOF

# Создаем reset файл
cat << EOF > "$scss_path/base/_reset.scss"
/* Reset and base styles  */
*, *::before, *::after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html {
	font-size: \$font-size-base;
	-webkit-text-size-adjust: 100%;
}

body {
	font-family: \$text-font;
	line-height: \$line-height-base;
	color: \$text-color;
	background-color: \$white;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

/* Links */

a, a:link, a:visited  {
    text-decoration: none;
	color: inherit;
}

a:hover  {
	text-decoration: none;
}

/* Common */

aside, nav, footer, header, section, main {
	display: block;
}

h1, h2, h3, h4, h5, h6, p {
    font-size: inherit;
	font-weight: inherit;
}

ul, ol {
	list-style: none;
}

img {
	max-width: 100%;
	height: auto;
	display: block;
}

img, svg {
	max-width: 100%;
	height: auto;
}

address {
  font-style: normal;
}

/* Form */

input, textarea, button, select {
	font-family: inherit;
    font-size: inherit;
    color: inherit;
    background-color: transparent;
}

input::-ms-clear {
	display: none;
}

button, input[type="submit"] {
    display: inline-block;
    box-shadow: none;
    background-color: transparent;
    background: none;
    cursor: pointer;
}

input:focus, input:active,
button:focus, button:active {
    outline: none;
}

button::-moz-focus-inner {
	padding: 0;
	border: 0;
}

label {
	cursor: pointer;
}

legend {
	display: block;
}
EOF

# Создаем typography файл
cat << EOF > "$scss_path/base/_typography.scss"
// Подключение шрифтов
// Пример:
// @import '../fonts/montserrat/stylesheet.css';

// Base Typography
html,
body {
    font-family: \$text-font;
}
EOF

echo "// Animations" > "$scss_path/base/_animations.scss"

echo "// Header" > "$scss_path/layout/_header.scss"
echo "// Footer" > "$scss_path/layout/_footer.scss"

# Создаем container файл
cat << EOF > "$scss_path/components/_container.scss"
// Container
.container {
    @extend %full-size;
    max-width: \$container-width;
    margin-inline: auto;
    padding: 0 \$grid-gap;
}
EOF

echo "// Navigation" > "$scss_path/components/_navigation.scss"

# Создаем пустые style.css и style.min.css
touch "$css_path/style.css"
touch "$css_path/style.min.css"

# Создаем .gitignore и добавляем в него исключения
cat << EOF > "$new_project_path/.gitignore"
docs/
.gitignore
.sass-cache/
*.css.map
EOF

echo "Project structure with SCSS 7-1 created at $new_project_path!" 