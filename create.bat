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
    echo ^<^^!DOCTYPE html^>
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

:: Создаём justfile для PowerShell
(
    echo # Указываем PowerShell как оболочку
    echo set shell := ["powershell.exe", "-Command"]
    echo.
    echo # Создание новой ветки от main с вводом названия и переключение на нее
    echo create-branch:
    echo     $branchName = Read-Host "Введите название новой ветки"; ^\
    echo     git checkout main; ^\
    echo     git branch $branchName; ^\
    echo     git checkout $branchName; ^\
    echo     git branch --show-current
    echo.
    echo # Коммит и отправка изменений в текущую ветку
    echo push-current:
    echo     $commitMessage = Read-Host "Введите сообщение для коммита"; ^\
    echo     git add .; ^\
    echo     git commit -m $commitMessage; ^\
    echo     git push origin (git branch --show-current^)
    echo.
    echo # Слияние текущей ветки в main и публикация
    echo merge-current:
    echo     $currentBranch = (git branch --show-current^); ^\
    echo     git checkout main; ^\
    echo     git merge --no-ff --no-edit $currentBranch; ^\
    echo     git push origin main
    echo.
    echo # Слияние изменений из указанной ветки в main и публикация
    echo merge-to-main:
    echo     git checkout main; ^\
    echo     $branchName = Read-Host "Введите название ветки для слияния"; ^\
    echo     git merge --no-ff --no-edit $branchName; ^\
    echo     git push origin main
    echo.
    echo # Отправка изменений текущей ветки и слияние с main с публикацией
    echo push-and-merge:
    echo     $commitMessage = Read-Host "Введите сообщение для коммита"; ^\
    echo     git add .; ^\
    echo     git commit -m $commitMessage; ^\
    echo     $currentBranch = (git branch --show-current^); ^\
    echo     git push origin $currentBranch; ^\
    echo     git checkout main; ^\
    echo     git merge --no-ff --no-edit $currentBranch; ^\
    echo     git push origin main
    echo.
    echo # Откат последнего коммита в текущей ветке
    echo undo-last-commit:
    echo     $currentBranch = (git branch --show-current^); ^\
    echo     git reset --mixed HEAD^^; ^\
    echo     git push origin $currentBranch --force
    echo.
    echo # Откат последнего слияния в main и изменений в исходной ветке
    echo undo-last-merge:
    echo    git checkout main; \
    echo    $lastMergeCommit = (git log --merges -1 --format="%%H"^); \
    echo    $parentCommits = (git log --merges -1 --format="%%P"^); \
    echo    $firstParent = ($parentCommits -split " "^)[0]; \
    echo    $secondParent = ($parentCommits -split " "^)[1]; \
    echo    git reset --hard $firstParent; \
    echo    git push origin main --force; \
    echo    $mergedBranch = (git branch --contains $secondParent ^| Where-Object { ^$_ -notmatch "^\*" } ^| ForEach-Object { ^$_.Trim(^) } ^| Select-Object -First 1^); \
    echo    if ($mergedBranch^) { \
    echo        Write-Host "Найдена ветка: $mergedBranch"; \
    echo        git checkout $mergedBranch; \
    echo        git reset --mixed HEAD^^; \
    echo        git push origin $mergedBranch --force; \
    echo        Write-Host "Откат завершен. Main и ветка $mergedBranch откачены на один commit назад."; \
    echo    } else { \
    echo        Write-Host "Откат завершен. Main откачен на один commit назад."; \
    echo    }

) > "%new_project_path%\.justfile"

:: Создаем .gitignore и добавляем в него исключения
(
    echo docs/
    echo .gitignore
    echo .justfile
) > "%new_project_path%\.gitignore"

endlocal
