## Setup

Download the source files and include them into your project. If you prefer to use a swc library file, download one of the packages and add it to your project library files.

## Compiler arguments

Since this utility uses custom meta tags (Inject and InjectComplete) you should keep these meta tags while compiling your swf files. Include the following two lines in your compiler arguments:

* `-keep-as3-metadata+=Inject`
* `-keep-as3-metadata+=InjectComplete`

## Usage

### Injection targets

Dependencies can be injected into an Object as a property, setter or method. To indicate an injection target, you should use the Inject meta tag and make the target public.

`[Inject]
public var myValue: String;`

Named injection targets can be indicated as followed:

`[Inject( name="myInjectionName" )]
public var myValue: String;`

Probably you will ask yourself: at what point do I know all injections are done? Therefore we have the InjectComplete meta tag which can be used for a public method. This method will be triggered as soon all dependencies are injected. You can use the InjectComplete meta tags as followed:

`[InjectComplete]
public function initialize(): void {}`