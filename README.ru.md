<h1>Автоматическое создание структуры проекта</h1>

<p>
  <a href="./README.md">English</a> | 
  <a href="./README.ru.md">Русский</a>
</p>

<h2>Описание</h2>
<p>Этот инструмент автоматически создает структуры проектов, поддерживая как Windows, так и Linux/macOS. При каждом запуске он генерирует папку проекта с увеличивающимся номером (например, <code>pr0</code>, <code>pr1</code>, <code>pr2</code> и т. д.) с подпапками и предзаполненными файлами, включая стандартную HTML-структуру и SCSS 7-1 архитектуру.</p>

<h2>Структура создаваемого проекта</h2>
<h3>Стандартная структура</h3>
<pre>
prX/  (новая папка проекта)
├── docs/
├── src/
│   ├── css/
│   │   ├── style.css
│   ├── img/
│   ├── html/
├── index.html
├── .gitignore
</pre>

<h3>Структура SCSS 7-1</h3>
<pre>
prX/  (new project folder)
├── docs/
├── src/
│   ├── css/
│   │   ├── style.css
│   │   ├── style.min.css
│   ├── img/
│   ├── fonts/
│   ├── html/
│   ├── scss/
│   │   ├── abstracts/
│   │   │   ├── _variables.scss
│   │   │   ├── _functions.scss
│   │   │   ├── _mixins.scss
│   │   │   ├── _extends.scss
│   │   ├── base/
│   │   │   ├── _reset.scss
│   │   │   ├── _typography.scss
│   │   │   ├── _animations.scss
│   │   ├── components/
│   │   │   ├── _container.scss
│   │   │   ├── _navigation.scss
│   │   ├── layout/
│   │   │   ├── _header.scss
│   │   │   ├── _footer.scss
│   │   ├── pages/
│   │   ├── themes/
│   │   ├── vendors/
│   │   ├── style.scss
├── index.html
├── .gitignore
</pre>

<h2>Функциональность</h2>
<ul>
    <li>Определяет последний созданный проект (<code>prX</code>) и создает следующий (<code>prX+1</code>).</li>
    <li>Создает подпапки для стандартной структуры: <code>docs</code>, <code>src/css</code>, <code>src/img</code>, <code>src/html</code>.</li>
    <li>Создает структуру SCSS 7-1 с <code>src/scss</code> и подпапками: <code>abstracts</code>, <code>base</code>, <code>components</code>, <code>layout</code>, <code>pages</code>, <code>themes</code>, <code>vendors</code>.</li>
    <li>Генерирует предзаполненный <code>index.html</code> с подключением <code>style.min.css</code>.</li>
    <li>Генерирует предзаполненный <code>style.scss</code> с импортами 7-1 и <code>scss/abstracts/_variables.scss</code>, <code>scss/abstracts/_functions.scss</code>, <code>scss/abstracts/_mixins.scss</code>, <code>scss/abstracts/_extends.scss</code>, <code>scss/base/_reset.scss</code>.</li>
    <li>Создаёт <code>src/css/style.css</code>, <code>src/css/style.min.css</code> и <code>.gitignore</code>, исключающий <code>docs</code>, <code>.sass-cache</code>, <code>*.css.map</code>, сам <code>.gitignore</code>, а теперь также <code>.justfile</code>.</li>
</ul>

<h2>Justfile и автоматизация Git</h2>
<p>Теперь каждый скрипт автоматически создаёт файл <code>.justfile</code> в новой папке проекта. В этом файле содержатся готовые рецепты для работы с git: управление ветками, коммиты, слияния, откат последнего коммита или слияния. Justfile подбирается под вашу ОС (Bash для Linux/macOS, PowerShell для Windows) и упрощает типовые git-операции с помощью простых команд.</p>

<h2>Установка и запуск</h2>
<h3>Для Windows</h3>
<h4>Стандартная структура</h4>
<ol>
    <li>Скачайте <code>create.bat</code> из <a href="https://github.com/Tra-va-de/create-html-project/releases">последнего релиза</a>.</li>
    <li>Поместите его в папку, где будут храниться проекты.</li>
    <li>Дважды кликните <code>create.bat</code> для запуска.</li>
</ol>

<h4>Структура SCSS 7-1</h4>
<ol>
    <li>Скачайте <code>create-scss.bat</code> из <a href="https://github.com/Tra-va-de/create-html-project/releases">последнего релиза</a>.</li>
    <li>Поместите его в папку, где будут храниться проекты.</li>
    <li>Дважды кликните <code>create-scss.bat</code> для запуска.</li>
</ol>

<h3>Для Linux/macOS</h3>
<h4>Стандартная структура</h4>
<ol>
    <li>Скачайте <code>create.sh</code> из <a href="https://github.com/Tra-va-de/create-html-project/releases">последнего релиза</a>.</li>
    <li>Поместите его в папку, где будут храниться проекты.</li>
    <li>Сделайте его исполняемым:
        <pre><code>chmod +x create.sh</code></pre>
    </li>
    <li>Запустите:
        <pre><code>./create.sh</code></pre>
    </li>
</ol>

<h4>Структура SCSS 7-1</h4>
<ol>
    <li>Скачайте <code>create-scss.sh</code> из <a href="https://github.com/Tra-va-de/create-html-project/releases">последнего релиза</a>.</li>
    <li>Поместите его в папку, где будут храниться проекты.</li>
    <li>Сделайте его исполняемым:
        <pre><code>chmod +x create-scss.sh</code></pre>
    </li>
    <li>Запустите:
        <pre><code>./create-scss.sh</code></pre>
    </li>
</ol>

<h2>Лицензия</h2>
<p>Этот проект распространяется под лицензией <a href="https://opensource.org/licenses/MIT">MIT</a>.</p>