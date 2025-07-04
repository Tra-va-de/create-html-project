<h1>Автоматическое создание структуры проекта</h1>

<p>
  <a href="./README.md">English</a> | 
  <a href="./README.ru.md">Русский</a>
</p>

<h2>Описание</h2>
<p>Этот инструмент автоматически создает структуру нового проекта, поддерживая как Windows, так и Linux/macOS. При каждом запуске он генерирует новую папку проекта с увеличивающимся номером (например, <code>pr0</code>, <code>pr1</code>, <code>pr2</code> и т. д.), а также необходимые подпапки и файлы.</p>

<h2>Структура создаваемого проекта</h2>
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

<h2>Функциональность</h2>
<ul>
    <li>Определяет последний созданный проект (<code>prX</code>) и создает следующий (<code>prX+1</code>).</li>
    <li>Создает в проекте подпапки: <code>docs</code>, <code>src</code>, <code>css</code>, <code>img</code>, <code>html</code>.</li>
    <li>Создает базовый <code>index.html</code> с подключением <code>style.css</code> и пустым <code><title></code>.</li>
    <li>Создает <code>.gitignore</code>, исключающий папку <code>docs</code> и сам <code>.gitignore</code>.</li>
</ul>

<h2>Установка и запуск</h2>
<h3>Для Windows</h3>
<ol>
    <li>Скачайте <code>create.bat</code> из <a href="https://github.com/Tra-va-de/create-html-project/releases">последнего релиза</a>.</li>
    <li>Поместите его в папку, где будут храниться проекты.</li>
    <li>Дважды кликните <code>create.bat</code> для запуска.</li>
</ol>

<h3>Для Linux/macOS</h3>
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

<h2>Лицензия</h2>
<p>Этот проект распространяется под лицензией <a href="https://opensource.org/licenses/MIT">MIT</a>.</p>
