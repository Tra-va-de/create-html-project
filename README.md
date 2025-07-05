<h1>Automatic Project Structure Creation</h1>

<p>
  <a href="./README.md">English</a> | 
  <a href="./README.ru.md">Русский</a>
</p>

<h2>Description</h2>
<p>This tool automatically creates project structures, supporting both Windows and Linux/macOS. It generates numbered project folders (e.g., <code>pr0</code>, <code>pr1</code>, <code>pr2</code>, etc.) with subfolders and pre-populated files, including standard HTML and SCSS 7-1 architecture options.</p>

<h2>Project Structure</h2>
<h3>Standard Structure</h3>
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

<h3>SCSS 7-1 Structure</h3>
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

<h2>Functionality</h2>
<ul>
  <li>Determines the last created project (<code>prX</code>) and creates the next one (<code>prX+1</code>).</li>
  <li>Creates subfolders for standard structure: <code>docs</code>, <code>src/css</code>, <code>src/img</code>, <code>src/html</code>.</li>
  <li>Creates SCSS 7-1 structure with <code>src/scss</code> and subfolders: <code>abstracts</code>, <code>base</code>, <code>components</code>, <code>layout</code>, <code>pages</code>, <code>themes</code>, <code>vendors</code>.</li>
  <li>Generates pre-populated <code>index.html</code> with linked <code>style.min.css</code>.</li>
  <li>Generates pre-populated <code>style.scss</code> with 7-1 imports and <code>scss/abstracts/_variables.scss</code>, <code>scss/abstracts/_functions.scss</code>, <code>scss/abstracts/_mixins.scss</code>, <code>scss/abstracts/_extends.scss</code>, <code>scss/base/_reset.scss</code>.</li>
  <li>Creates <code>src/css/style.css</code>, <code>src/css/style.min.css</code>, and <code>.gitignore</code> excluding <code>docs</code>, <code>.sass-cache</code>, <code>*.css.map</code>, and <code>.gitignore</code>.</li>
</ul>

<h2>Installation and Usage</h2>
<h3>For Windows</h3>
<h4>Standard Structure</h4>
<ol>
    <li>Download <code>create.bat</code> from the <a href="https://github.com/Tra-va-de/create-html-project/releases">latest release</a>.</li>
    <li>Place it in the folder where projects will be stored.</li>
    <li>Double-click <code>create.bat</code> to run it.</li>
</ol>

<h4>SCSS 7-1 Structure</h4>
<ol>
    <li>Download <code>create-scss.bat</code> from the <a href="https://github.com/Tra-va-de/create-html-project/releases">latest release</a>.</li>
    <li>Place it in the folder where projects will be stored.</li>
    <li>Double-click <code>create-scss.bat</code> to run it.</li>
</ol>

<h3>For Linux/macOS</h3>
<h4>Standard Structure</h4>
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

<h4>SCSS 7-1 Structure</h4>
<ol>
    <li>Download <code>create-scss.sh</code> from the <a href="https://github.com/Tra-va-de/create-html-project/releases">latest release</a>.</li>
    <li>Place it in the folder where projects will be stored.</li>
    <li>Make it executable:
        <pre><code>chmod +x create-scss.sh</code></pre>
    </li>
    <li>Run:
        <pre><code>./create-scss.sh</code></pre>
    </li>
</ol>

<h2>License</h2>
<p>This project is licensed under the <a href="https://opensource.org/licenses/MIT">MIT</a> License.</p>