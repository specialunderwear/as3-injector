## Setup

Download the source files and include them into your project. If you prefer to use a swc library file, download one of the packages and add it to your project library files.

## Compiler arguments

Since this utility uses custom meta tags (Inject and InjectComplete), you should keep these meta tags while compiling your swf files. Include the following two lines in your compiler arguments:

* `-keep-as3-metadata+=Inject`
* `-keep-as3-metadata+=InjectComplete`