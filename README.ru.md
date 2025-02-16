<h1>Автоматическое создание структуры проекта</h1>

<p>
  <a href="./README.md">English</a> | 
  <a href="./README.ru.md">Русский</a>
</p>

<h2>Описание</h2>
<p>Этот скрипт предназначен для автоматического создания структуры нового проекта в Windows. При каждом запуске он создает новую папку проекта, увеличивая номер в названии (например, <code>pr0</code>, <code>pr1</code>, <code>pr2</code> и т. д.), а также необходимые подпапки и файлы.</p>

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
  <li>Создает базовый <code>index.html</code> с подключением <code>style.css</code> и пустым <code>&lt;title&gt;</code>.</li>
  <li>Создает <code>.gitignore</code>, исключающий папку <code>docs</code> и сам <code>.gitignore</code>.</li>
</ul>

<h2>Установка и запуск</h2>
<ol>
  <li>Скачайте <code>create_project.bat</code>.</li>
  <li>Поместите его в папку, где будут храниться проекты.</li>
  <li>Дважды кликните <code>create_project.bat</code> для запуска.</li>
</ol>

<h2>Лицензия</h2>
<p>Этот проект распространяется под лицензией MIT.</p>
