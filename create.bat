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
set "css_path=%src_path%\css"
set "img_path=%src_path%\img"
set "html_path=%src_path%\html"

:: Создаем все необходимые папки
mkdir "%docs_path%" "%css_path%" "%img_path%" "%html_path%"

:: Создаем базовый index.html с разметкой
(
    echo ^<^!DOCTYPE html^>
    echo ^<html lang="ru"^>
    echo ^<head^>
    echo     ^<meta charset="UTF-8"^>
    echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
    echo     ^<title^>^</title^>
    echo     ^<link rel="stylesheet" href="./src/css/style.css"^>
    echo ^</head^>
    echo ^<body^>
    echo.
    echo ^</body^>
    echo ^</html^>
) > "%new_project_path%\index.html"

:: Создаем пустой style.css
echo. > "%css_path%\style.css"

:: Создаем .gitignore и добавляем в него исключения
(
    echo docs/
    echo .gitignore
) > "%new_project_path%\.gitignore"

endlocal
