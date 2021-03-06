Ddoc

<h1>
<a name="dlang-ui" class="anchor" href="#dlang-ui"><span class="octicon octicon-link"></span></a>Dlang UI</h1>

<p>GUI for D programming language, written in D.</p>

    Alpha stage of development.

<ul>
<li>Crossplatform (Win32 and Linux are supported in current version); can use SDL2 as a backend.</li>
<li>Mostly inspired by Android UI API (layouts, styles, two phase layout, ...)</li>
<li>Supports highly customizable UI themes and styles</li>
<li>Supports internationalization</li>
<li>Hardware acceleration using OpenGL (when built with version USE_OPENGL)</li>
<li>Fallback to Win32 API / XCB when OpenGL is not available</li>
<li>Actually it's a port (with major refactoring) of GUI library for cross platform OpenGL based implementation of Cool Reader app project from C++.</li>
<li>Almost ready for 2D games development</li>
<li>Goal: provide set of widgets suitable for building of IDE.</li>
<li>Non thread safe</li>
</ul>

<h2><a name="widgets" class="anchor" href="#widgets"><span class="octicon octicon-link"></span></a>Widgets</h2>

<ul>
<li>Widget - base class for all widgets and widget containers, similar to Android's View</li>
</ul><p>Currently implemented widgets:</p>

<ul>
<li>TextWidget - simple static text (TODO: implement multiline formatting)</li>
<li>ImageWidget - static image</li>
<li>Button - simple button with text label</li>
<li>ImageButton - image only button</li>
<li>TextImageButton - button with icon and label</li>
<li>CheckBox - check button with label</li>
<li>RadioButton - radio button with label</li>
<li>EditLine - single line edit</li>
<li>EditBox - multiline editor</li>
<li>VSpacer - vertical spacer - just an empty widget with layoutHeight == FILL_PARENT, to fill vertical space in layouts</li>
<li>HSpacer - horizontal spacer - just an empty widget with layoutWidth == FILL_PARENT, to fill horizontal space in layouts</li>
<li>ScrollBar - scroll bar</li>
<li>TabControl - tabs widget, allows to select one of tabs</li>
<li>TabHost - container for pages controlled by TabControl</li>
<li>TabWidget - combination of TabControl and TabHost</li>
</ul>

<h2><a name="layouts" class="anchor" href="#layouts"><span class="octicon octicon-link"></span></a>Layouts</h2>

Similar to layouts in Android

<ul>
<li>LinearLayout - layout children horizontally or vertically depending on orientation</li>
<li>VerticalLayout - just a LinearLayout with vertical orientation</li>
<li>HorizontalLayout - just a LinearLayout with vertical orientation</li>
<li>FrameLayout - all children occupy the same place; usually onle one of them is visible</li>
<li>TableLayout - children are aligned into rows and columns of table</li>
</ul><h2>
<a name="list-views" class="anchor" href="#list-views"><span class="octicon octicon-link"></span></a>List Views</h2>

<p>Lists are implemented similar to Android UI API.</p>

<ul>
<li>ListWidget - layout dynamic items horizontally or vertically (one in row/column) with automatic scrollbar; can reuse widgets for similar items</li>
<li>ListAdapter - interface to provide data and widgets for ListWidget</li>
<li>WidgetListAdapter - simple implementation of ListAdapter interface - just a list of widgets (one per list item) to show</li>
</ul><p>TODOs:</p>

<ul>
<li>Multicolumn lists</li>
<li>Tree view</li>
</ul><h2>
<a name="resources" class="anchor" href="#resources"><span class="octicon octicon-link"></span></a>Resources</h2>

<p>Resources like fonts and images use reference counting. For proper resource freeing, always destroy widgets implicitly.</p>

<ul>
<li>FontManager: provides access to fonts</li>
<li>Images: .png or .jpg images; if filename ends with .9.png, it's autodetected as nine-patch image (see Android drawables description)</li>
<li>StateDrawables: .xml file can describe list of other drawables to choose based on widget's State (.xml files from android themes can be used directly)</li>
<li>imageCache allows to cache unpacked images</li>
<li>drawableCache provides access by resource id (string, usually filename w/o extension) to drawables located in specified list of resource directories.</li>
</ul><h2>
<a name="styles-and-themes" class="anchor" href="#styles-and-themes"><span class="octicon octicon-link"></span></a>Styles and Themes</h2>

<p>Styles and themes are a bit similar to ones in Android API.</p>

<ul>
<li>Theme is a container for styles. Can be load from XML theme resource file.</li>
<li>Styles are accessible in theme by string ID.</li>
<li>Styles can be nested to form hiararchy - when some attribute is missing in style, value from base style will be used.</li>
<li>State substyles are supported: allow to change widget appearance dynamically based on its state.</li>
<li>Widgets use style attributes directly from assigned style. When some attribute is being changed in widget, it creates its own copy of base style, 
which allows to modify some of attributes, while getting base style attributes if they are not changed in widget. This trick can minimize memory usage for widget attributes when 
standard values are used.</li>
</ul><h2>
<a name="win32-builds" class="anchor" href="#win32-builds"><span class="octicon octicon-link"></span></a>Win32 builds</h2>

<ul>
<li>Under windows, uses SDL2 or Win32 API as backend.</li>
<li>Optionally, may use OpenGL acceleration via DerelictGL3/WGL.</li>
<li>Uses Win32 API for font rendering.</li>
<li>Optinally can use FreeType for font rendering.</li>
</ul><p>Build and run using DUB:</p>

-----------------------
    git clone https://github.com/buggins/dlangui.git
    cd dlangui
    dub run dlangui:example1
-----------------------

<p>To develop using Visual-D, download sources for dlabgui and dependencies into some directory:</p>

-----------------------
    git clone https://github.com/buggins/dlangui.git
    git clone https://github.com/DerelictOrg/DerelictUtil.git
    git clone https://github.com/DerelictOrg/DerelictGL3.git
    git clone https://github.com/DerelictOrg/DerelictFI.git
    git clone https://github.com/DerelictOrg/DerelictFT.git
    git clone https://github.com/DerelictOrg/DerelictSDL2.git
-----------------------

<p>Then open .sln using Visual D.</p>

<h2>
<a name="linux-builds" class="anchor" href="#linux-builds"><span class="octicon octicon-link"></span></a>Linux builds</h2>

<ul>
<li>Uses SDL2 or XCB as a backend (SDL2 is recommended, since has better support now).</li>
<li>Uses shared memory images for faster drawing.</li>
<li>Uses FreeType for font rendering.</li>
<li>TODO: Use FontConfig to get font list.</li>
<li>OpenGL is now working under SDL2 only.</li>
<li>Entering of unicode characters is now working under SDL2 only.</li>
</ul><p>For linux build with SDL2 backend, following libraries are required:</p>

-----------------------
        libsdl2
-----------------------

<p>To build dlangui apps with XCB backend, development packages for following libraries required for XCB backend build:</p>

-----------------------
        xcb, xcb-util, xcb-shm, xcb-image, xcb-keysyms, X11-xcb, X11
-----------------------

<p>E.g. in Ubuntu, you can use following command to enable SDL2 backend builds:</p>

-----------------------
        sudo apt-get install libsdl2-dev
-----------------------

<p>or (for XCB backend)</p>

-----------------------
        sudo apt-get install libxcb-image0-dev libxcb-shm0-dev libxcb-keysyms1-dev libfreeimage-dev
-----------------------


<p>In runtime, .so for following libraries are being loaded (binary packages required):</p>

-----------------------
        freetype, opengl, freeimage
-----------------------

<p>Build and run on Linux using DUB:</p>

-----------------------
        dub run dlangui:example1
-----------------------

<p>Development using Mono-D: </p>

<ul>
<li>open solution dlangui/dlanguimonod.sln </li>
<li>build and run project example1</li>
</ul><p>You need fresh version of MonoDevelop to use Mono-D. It can be installed from PPA repository.</p>

-----------------------
    sudo add-apt-repository ppa:ermshiperete/monodevelop
    sudo apt-get update
    sudo apt-get install monodevelop-current
-----------------------

<h2>
<a name="other-platforms" class="anchor" href="#other-platforms"><span class="octicon octicon-link"></span></a>Other platforms</h2>

<ul>
<li>Other platforms support may be added easy</li>
</ul><h2>
<a name="third-party-components-used" class="anchor" href="#third-party-components-used"><span class="octicon octicon-link"></span></a>Third party components used</h2>

<ul>
<li>DerelictGL3 - for OpenGL support</li>
<li>DerelictFT + FreeType library support under linux and optionally under Windows.</li>
<li>DerelictFI + FreeImage library support for decoding of images</li>
<li>DerelictSDL2 + SDL2 for cross platform support</li>
<li>WindowsAPI bindings from <a href="http://www.dsource.org/projects/bindings/wiki/WindowsApi">http://www.dsource.org/projects/bindings/wiki/WindowsApi</a> (patched)</li>
<li>XCB and X11 bindings (patched) when SDL2 is not used; TODO: provide links</li>
</ul><h2>
<a name="hello-world" class="anchor" href="#hello-world"><span class="octicon octicon-link"></span></a>Hello World</h2>

------------------------------------------
// main.d
import dlangui.all;
mixin DLANGUI_ENTRY_POINT;

/// entry point for dlangui based application
extern (C) int UIAppMain(string[] args) {
    // resource directory search paths
    string[] resourceDirs = [
        appendPath(exePath, "../res/"),   // for Visual D and DUB builds
        appendPath(exePath, "../../res/") // for Mono-D builds
    ];

    // setup resource directories - will use only existing directories
    Platform.instance.resourceDirs = resourceDirs;
    // select translation file - for english language
    Platform.instance.uiLanguage = "en";
    // load theme from file "theme_default.xml"
    Platform.instance.uiTheme = "theme_default";

    // create window
    Window window = Platform.instance.createWindow("My Window", null);
    // create some widget to show in window
    window.mainWidget = (new Button()).text("Hello world"d).textColor(0xFF0000); // red text
    // show window
    window.show();
    // run message loop
    return Platform.instance.enterMessageLoop();
}
--------------------------------

