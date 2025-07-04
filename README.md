<h1>Automatic Project Structure Creation</h1>

<p>
  <a href="./README.md">English</a> | 
  <a href="./README.ru.md">Русский</a>
</p>

<h2>Description</h2>
<p>This script is designed to automatically create the structure of a new project, supporting both Windows and Linux/macOS. Each time it runs, it creates a new project folder, incrementing the number in the name (e.g., <code>pr0</code>, <code>pr1</code>, <code>pr2</code>, etc.), as well as the necessary subfolders and files.</p>

<h2>Project Structure</h2>
<pre>
prX/  (new project folder)
├── docs/
├── src/
│   ├── css/
│   │   ├── style.css
│   ├── img/
│   ├── html/
├── index.html
├── .gitignore
</pre>

<h2>Functionality</h2>
<ul>
  <li>Determines the last created project (<code>prX</code>) and creates the next one (<code>prX+1</code>).</li>
  <li>Creates subfolders in the project: <code>docs</code>, <code>src</code>, <code>css</code>, <code>img</code>, <code>html</code>.</li>
  <li>Creates a basic <code>index.html</code> with <code>style.css</code> linked and an empty <code>&lt;title&gt;</code>.</li>
  <li>Creates a <code>.gitignore</code> file excluding the <code>docs</code> folder and itself.</li>
</ul>

<h2>Installation and Usage</h2>
<h3>For Windows</h3>
<ol>
    <li>Download <code>create.bat</code> from the <a href="https://github.com/Tra-va-de/create-html-project/releases">latest release</a>.</li>
    <li>Place it in the folder where projects will be stored.</li>
    <li>Double-click <code>create.bat</code> to run it.</li>
</ol>

<h3>For Linux/macOS</h3>
<ol>
    <li>Download <code>create.sh</code> from the <a href="https://github.com/Tra-va-de/create-html-project/releases">latest release</a>.</li>
    <li>Place it in the folder where projects will be stored.</li>
    <li>Make it executable:
        <pre><code>chmod +x create.sh</code></pre>
    </li>
    <li>Run:
        <pre><code>./create.sh</code></pre>
    </li>
</ol>

<h2>License</h2>
<p>This project is licensed under the <a href="https://opensource.org/licenses/MIT">MIT</a> License.</p>
