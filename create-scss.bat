@echo off
setlocal enabledelayedexpansion

:: Получаем путь к текущей папке
set "projects_folder=%~dp0"
set "folder_name=pr"

:: Определяем последний номер проекта
set "last_project_number=-1"
for /d %%i in (%projects_folder%%folder_name%*) do (
    set "folder=%%~ni"
    for /f "tokens=2 delims=%folder_name%" %%j in ("!folder!") do (
        set /a "num=%%j" 2>nul
        if !num! gtr !last_project_number! set "last_project_number=!num!"
    )
)

:: Вычисляем номер нового проекта
set /a new_project_number=last_project_number+1
set "new_project_name=%folder_name%%new_project_number%"
set "new_project_path=%projects_folder%%new_project_name%"

:: Проверяем, существует ли уже такая папка, если да, увеличиваем номер
:check_folder
if exist "%new_project_path%" (
    set /a new_project_number+=1
    set "new_project_name=%folder_name%%new_project_number%"
    set "new_project_path=%projects_folder%%new_project_name%"
    goto check_folder
)

:: Пути к создаваемым папкам
set "docs_path=%new_project_path%\docs"
set "src_path=%new_project_path%\src"
set "scss_path=%src_path%\scss"
set "css_path=%src_path%\css"
set "img_path=%src_path%\img"
set "html_path=%src_path%\html"
set "fonts_path=%src_path%\fonts"

:: Создаем все необходимые папки
mkdir "%docs_path%" "%scss_path%" "%css_path%" "%img_path%" "%html_path%" "%fonts_path%"

:: Создаем папки для SCSS 7-1 структуры
mkdir "%scss_path%\abstracts"
mkdir "%scss_path%\base"
mkdir "%scss_path%\components"
mkdir "%scss_path%\layout"
mkdir "%scss_path%\pages"
mkdir "%scss_path%\themes"
mkdir "%scss_path%\vendors"

:: Создаем базовый index.html с разметкой
(
    echo ^<^^!DOCTYPE html^>
    echo ^<html lang="ru"^>
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    echo     ^<title^>^</title^>
    echo     ^<link rel="stylesheet" href="./src/css/style.min.css"^>
    echo ^</head^>
    echo ^<body^>
    echo.
    echo ^</body^>
    echo ^</html^>
) > "%new_project_path%\index.html"

:: Создаем main.scss файл
(
    echo // Abstracts
    echo @import 'abstracts/variables';
    echo @import 'abstracts/functions';
    echo @import 'abstracts/mixins';
    echo @import 'abstracts/extends';
    echo.
    echo // Vendors
    echo.
    echo // Base
    echo @import 'base/reset';
    echo @import 'base/typography';
    echo @import 'base/animations';
    echo.
    echo // Layout
    echo @import 'layout/header';
    echo @import 'layout/footer';
    echo.
    echo // Components
    echo @import 'components/container';
    echo @import 'components/navigation';
    echo.
    echo // Pages
    echo.
    echo // Themes
) > "%scss_path%\style.scss"

:: Создаем базовые SCSS файлы
:: Создаем variables файл с основными переменными
(
    echo // Breakpoints
    echo $viewport-max: 1920px;
    echo $viewport-min: 280px;
    echo $breakpoint-sm: 576px;
    echo $breakpoint-md: 768px;
    echo $breakpoint-lg: 992px;
    echo $breakpoint-xl: 1200px;
    echo.
    echo // Grid
    echo $container-width: 1230px;
    echo $grid-gap: 30px;
    echo $container-padding: 15px;
    echo.
    echo // Base colors
    echo $white: #FFFFFF;
    echo $black: #000000;
    echo $gray-100: #f5f5f5;
    echo $gray-200: #e0e0e0;
    echo $gray-300: #cccccc;
    echo $gray-400: #999999;
    echo $gray-500: #666666;
    echo $gray-600: #333333;
    echo $gray-700: #222222;
    echo $gray-800: #111111;
    echo $gray-900: #000000;
    echo $blue: #007bff;
    echo $green: #28a745;
    echo $red: #dc3545;
    echo $orange: #fd7e14;
    echo $purple: #6f42c1;
    echo.
    echo // Semantic colors
    echo $title-color: $black;
    echo $text-color: $gray-600;
    echo $text-second-color: $gray-400;
    echo.
    echo $accent-color: $blue;
    echo $second-accent-color: $green;
    echo.
    echo $button-color: $blue;
    echo $button-second-color: $gray-500;
    echo.
    echo $link-color: $blue;
    echo.
    echo $footer-bg: $gray-900;
    echo.
    echo $border-light: $gray-200;
    echo $text-muted: $gray-400;
    echo $background-dark: $gray-700;
    echo $background-darker: $gray-800;
    echo.
    echo // Gradients
    echo // Здесь можно добавить градиенты, например:
    echo // $section-gradient: linear-gradient(45deg, $gray-700 0%%, $gray-800 100%%^);
    echo.
    echo // Typography
    echo $title-font: 'Raleway', sans-serif;
    echo $text-font: 'Montserrat', sans-serif;
    echo $additional-font: 'Roboto', sans-serif;
    echo.
    echo // Font Sizes - от малого к большому
    echo $font-size-xs: 12px;      // Очень маленький текст
    echo $font-size-sm: 14px;      // Маленький текст
    echo $font-size-base: 16px;    // Базовый размер текста
    echo $font-size-md: 18px;      // Средний текст
    echo $font-size-lg: 20px;      // Большой текст
    echo $font-size-xl: 24px;      // Очень большой текст
    echo $font-size-2xl: 30px;     // Заголовок секции
    echo $font-size-3xl: 36px;     // Большой заголовок
    echo $font-size-4xl: 48px;     // Очень большой заголовок
    echo $font-size-5xl: 60px;     // Гигантский заголовок
    echo.
    echo $line-height-base: 1.5;
    echo $line-height-tight: 1.2;
    echo $line-height-relaxed: 1.8;
    echo.
    echo // Spacing
    echo $spacing-unit: 8px;
    echo $spacing-xs: $spacing-unit;
    echo $spacing-sm: $spacing-unit * 2;
    echo $spacing-md: $spacing-unit * 3;
    echo $spacing-lg: $spacing-unit * 4;
    echo $spacing-xl: $spacing-unit * 5;
    echo.
    echo // Z-index
    echo $z-index-header: 1000;
    echo $z-index-modal: 2000;
    echo $z-index-tooltip: 3000;
) > "%scss_path%\abstracts\_variables.scss"

:: Создаем functions файл
(
    echo // Функция для удаления единиц измерения
    echo @function strip-unit($value^) {
    echo     @return $value / ($value * 0 + 1^);
    echo }
) > "%scss_path%\abstracts\_functions.scss"

:: Создаем mixins файл с улучшенными миксинами
(
    echo // ================================================
    echo // Миксин для позиционирования секции
    echo // ================================================
    echo @mixin section-position($z-index: 2^) {
    echo     position: relative;
    echo.
    echo     ^&__content {
    echo         position: relative;
    echo         z-index: $z-index;
    echo     }
    echo.
    echo     ^&__background {
    echo         position: absolute;
    echo         inset: 0;
    echo     }
    echo.
    echo     ^&__content, ^&__background {
    echo         @extend %%full-size;
    echo     }
    echo }
    echo.
    echo // ====================================================
    echo // Миксин для создания адаптивного стиля
    echo // ====================================================
    echo @mixin adaptive-style($property, $pc-font-size, $mobile-font-size^) {
    echo     $add-size: $pc-font-size - $mobile-font-size;
    echo.
    echo     @if (unit($add-size^) == px^) {
    echo         $add-size: strip-unit($add-size^);
    echo     }
    echo.
    echo     @if (unit($add-size^) == rem^) {
    echo         $add-size: strip-unit($add-size^) * $font-size-base;
    echo     }
    echo.
    echo     #{$property}: calc(#{$mobile-font-size} + #{strip-unit($add-size^)} * ((100dvw - #{$viewport-min + px}^) / (#{$viewport-max} - #{$viewport-min}^)^)^);
    echo }
    echo.
    echo // ====================================================
    echo // Миксин для адаптивного размера шрифта
    echo // ====================================================
    echo @mixin adaptive-font($pc-font-size, $mobile-font-size^) {
    echo     @include adaptive-style('font-size', $pc-font-size, $mobile-font-size^);
    echo }
    echo.
    echo // ================================================
    echo // Миксин для адаптивной высоты строки
    echo // ================================================
    echo @mixin adaptive-line-height($pc-line-height, $mobile-line-height^) {
    echo     @include adaptive-style('line-height', $pc-line-height, $mobile-line-height^);
    echo }
) > "%scss_path%\abstracts\_mixins.scss"

:: Создаем extends файл с улучшенными утилитами
(
    echo // Hover эффекты
    echo %%hover-text {
    echo     transition: color 300ms ease-out;
    echo     cursor: pointer;
    echo.
    echo     ^&:hover {
    echo         color: $accent-color;
    echo     }
    echo }
    echo.
    echo %%hover-icon {
    echo     cursor: pointer;
    echo.
    echo     ^& path {
    echo         transition: fill 300ms ease-in-out;
    echo         fill: $text-color;
    echo     }
    echo.
    echo     ^&:hover path {
    echo         fill: $accent-color;
    echo     }
    echo }
    echo.
    echo %%hover-scale {
    echo     transition: transform 300ms ease-out;
    echo     cursor: pointer;
    echo.
    echo     ^&:hover {
    echo         transform: scale(1.1^);
    echo     }
    echo }
    echo.
    echo %%active-color {
    echo     transition: filter 300ms ease-out;
    echo     cursor: pointer;
    echo.
    echo     ^&:active {
    echo         filter: hue-rotate(15deg^);
    echo     }
    echo }
    echo.
    echo %%hover-and-active {
    echo     @extend %%hover-scale;
    echo     @extend %%active-color;
    echo     transition: transform 300ms ease-out, filter 300ms ease-out;
    echo }
    echo.
    echo // Flex утилиты
    echo %%flex-all-center {
    echo     display: flex;
    echo     justify-content: center;
    echo     align-items: center;
    echo }
    echo.
    echo %%flex-align-center {
    echo     display: flex;
    echo     align-items: center;
    echo }
    echo.
    echo %%flex-justify-center {
    echo     display: flex;
    echo     justify-content: center;
    echo }
    echo.
    echo %%flex-between {
    echo     display: flex;
    echo     justify-content: space-between;
    echo     align-items: center;
    echo }
    echo.
    echo %%flex-column {
    echo     display: flex;
    echo     flex-direction: column;
    echo }
    echo.
    echo %%flex-column-center {
    echo     display: flex;
    echo     flex-direction: column;
    echo     justify-content: center;
    echo     align-items: center;
    echo }
    echo.
    echo // Размеры
    echo %%full-size {
    echo     width: 100%%;
    echo     height: 100%%;
    echo }
    echo.
    echo %%full-width {
    echo     width: 100%%;
    echo }
    echo.
    echo %%full-height {
    echo     height: 100%%;
    echo }
    echo.
    echo // Позиционирование
    echo %%absolute-center {
    echo     position: absolute;
    echo     top: 50%%;
    echo     left: 50%%;
    echo     transform: translate(-50%%, -50%%^);
    echo }
    echo.
    echo %%absolute-full {
    echo     position: absolute;
    echo     top: 0;
    echo     left: 0;
    echo     right: 0;
    echo     bottom: 0;
    echo }
    echo.
    echo // Текст
    echo %%text-ellipsis {
    echo     overflow: hidden;
    echo     text-overflow: ellipsis;
    echo     white-space: nowrap;
    echo }
    echo.
    echo %%text-break {
    echo     word-break: break-word;
    echo     overflow-wrap: break-word;
    echo }
    echo.
    echo // Интерактивность
    echo %%clickable {
    echo     cursor: pointer;
    echo     user-select: none;
    echo }
    echo.
    echo %%no-select {
    echo     user-select: none;
    echo     -webkit-user-select: none;
    echo }
    echo.
    echo // Анимации
    echo %%fade-in {
    echo     opacity: 0;
    echo     transition: opacity 300ms ease-in;
    echo.
    echo     ^&.active,
    echo     ^&:hover {
    echo         opacity: 1;
    echo     }
    echo }
    echo.
    echo %%slide-up {
    echo     transform: translateY(20px^);
    echo     opacity: 0;
    echo     transition: transform 300ms ease-out, opacity 300ms ease-out;
    echo.
    echo     ^&.active {
    echo         transform: translateY(0^);
    echo         opacity: 1;
    echo     }
    echo }
) > "%scss_path%\abstracts\_extends.scss"

:: Создаем reset файл
(
    echo /* Reset and base styles  */
    echo *, *::before, *::after {
    echo 	box-sizing: border-box;
    echo 	margin: 0;
    echo 	padding: 0;
    echo }
    echo.
    echo html {
    echo 	font-size: $font-size-base;
    echo 	-webkit-text-size-adjust: 100%%;
    echo }
    echo.
    echo body {
    echo 	font-family: $text-font;
    echo 	line-height: $line-height-base;
    echo 	color: $text-color;
    echo 	background-color: $white;
    echo 	-webkit-font-smoothing: antialiased;
    echo 	-moz-osx-font-smoothing: grayscale;
    echo }
    echo.
    echo /* Links */
    echo.
    echo a, a:link, a:visited  {
    echo     text-decoration: none;
    echo 	color: inherit;
    echo }
    echo.
    echo a:hover  {
    echo 	text-decoration: none;
    echo }
    echo.
    echo /* Common */
    echo.
    echo aside, nav, footer, header, section, main {
    echo 	display: block;
    echo }
    echo.
    echo h1, h2, h3, h4, h5, h6, p {
    echo     font-size: inherit;
    echo 	font-weight: inherit;
    echo }
    echo.
    echo ul, ol {
    echo 	list-style: none;
    echo }
    echo.
    echo img {
    echo 	max-width: 100%%;
    echo 	height: auto;
    echo 	display: block;
    echo }
    echo.
    echo img, svg {
    echo 	max-width: 100%%;
    echo 	height: auto;
    echo }
    echo.
    echo address {
    echo   font-style: normal;
    echo }
    echo.
    echo /* Form */
    echo.
    echo input, textarea, button, select {
    echo 	font-family: inherit;
    echo     font-size: inherit;
    echo     color: inherit;
    echo     background-color: transparent;
    echo }
    echo.
    echo input::-ms-clear {
    echo 	display: none;
    echo }
    echo.
    echo button, input[type="submit"] {
    echo     display: inline-block;
    echo     box-shadow: none;
    echo     background-color: transparent;
    echo     background: none;
    echo     cursor: pointer;
    echo }
    echo.
    echo input:focus, input:active,
    echo button:focus, button:active {
    echo     outline: none;
    echo }
    echo.
    echo button::-moz-focus-inner {
    echo 	padding: 0;
    echo 	border: 0;
    echo }
    echo.
    echo label {
    echo 	cursor: pointer;
    echo }
    echo.
    echo legend {
    echo 	display: block;
    echo }
) > "%scss_path%\base\_reset.scss"

:: Создаем typography файл
(
    echo // Подключение шрифтов
    echo // Пример:
    echo // @import '../fonts/montserrat/stylesheet.css';
    echo.
    echo // Base Typography
    echo html,
    echo body {
    echo     font-family: $text-font;
    echo }
) > "%scss_path%\base\_typography.scss"

echo // Animations > "%scss_path%\base\_animations.scss"

echo // Header > "%scss_path%\layout\_header.scss"
echo // Footer > "%scss_path%\layout\_footer.scss"

:: Создаем container файл
(
    echo // Container
    echo .container {
    echo     @extend %%full-size;
    echo     max-width: $container-width;
    echo     margin-inline: auto;
    echo     padding: 0 $grid-gap;
    echo }
) > "%scss_path%\components\_container.scss"

echo // Navigation > "%scss_path%\components\_navigation.scss"

:: Создаем пустые style.css и style.min.css
echo. > "%css_path%\style.css"
echo. > "%css_path%\style.min.css"

:: Создаем .gitignore и добавляем в него исключения
(
    echo docs/
    echo .gitignore
    echo .sass-cache/
    echo *.css.map
) > "%new_project_path%\.gitignore"

echo Project structure with SCSS 7-1 created at %new_project_path%!

endlocal 