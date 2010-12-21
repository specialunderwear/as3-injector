## Setup

Download the source files and include them into your project. If you prefer to use a swc library file, download one of the packages and add it to your project library files.

## Compiler arguments

Since this utility uses custom meta tags (Inject and InjectComplete) you should keep these meta tags while compiling your swf files. This only applies when you are not compiling your project in debug mode. Include the following two lines in your compiler arguments:

* `-keep-as3-metadata+=Inject`
* `-keep-as3-metadata+=InjectComplete`

## Usage

### Injection targets

Dependencies can be injected into an Object as a property, setter or method. To indicate an injection target, you should use the Inject meta tag and make the target public.

    [Inject]
    public var myValue: String;

Named injection targets can be indicated as followed:

    [Inject( name="myInjectionName" )]
    public var myValue: String;

Probably you will ask yourself: at what point do I know all injections are done? Therefore we have the InjectComplete meta tag which can be used on a public method. This method will be triggered as soon all dependencies are injected. You can use the InjectComplete meta tag as followed:

    [InjectComplete]
    public function initialize(): void {}

### Inject Objects

Dependency Injection doesn't just work when you are creating new instances on the fly. Therefore you should manually call the `inject` method or create an instance of your Object by using the `instantiate` method of the injector.

	var injector: IInjector = new Injector;
		
	var foo: MyObject = new MyObject;
	injector.inject( foo );
	
	var bar: MyObject = injector.instantiate( MyObject ) as MyObject;

### Map injections

Now we are familiar with setting up our dependencies in Objects, we only have to map the injections we want to use. We have three type of mappings:

* Mapping a value
* Mapping a new instance of an Object
* Mapping a singleton of an Object (one instance)

**Note**: the name of the (public) property, setter or method doesn't matter. The injector only looks at the type of Class you want to inject an the optional name of it.

#### Mapping a value

	var myValue: String = 'myInjectedValue';
	
	injector.mapValue( myValue, String );

Sample code to inject the mapped value:

	[Inject]
	var myValue: String;

#### Mapping a new instance of an Object

	injector.mapClass( MyClass, MyClass );

Sample code to inject the mapped instance:

	[Inject]
	var myClass: MyClass;

#### Mapping a singleton of an Object (one instance)

	injector.mapSingleton( MyClass, MyClass );

Sample code to inject the mapped singleton:

	[Inject]
	var mySingleton: MyClass;

### Child injection

Due the fact mappings overwrite each other, the injector has the ability to create child injectors. By creating a child injector you will be able to define a new mapping on top of the parent injector's mapping. By injecting an Object, the child injector automatically checks whether to get the injection from it's parent or not. Of course the mappings of the child injector has the highest priority.

	// map default values
	var injector: IInjector = new Injector;
	
	injector.mapValue( 'foo', String );
	injector.mapValue( 10, Number );
	
	injector.instantiate( Foo );
	
	// map child values
	var child: IInjector = injector.createChildInjector();
	
	child.mapValue( 'bar', String );
	
	child.instantiate( Biz );

#### Foo

	package
	{
		public class Foo
		{
			[Inject]
			/**
			 * Value of the property will be 'foo'
			 */
			public var myString: String;

			[Inject]
			/**
			 * Value of the property will be '10'
			 */
			public var myNumber: Number;

			public function Foo() {}
		}
	}

#### Biz

	package
	{
		public class Biz
		{
			[Inject]
			/**
			 * Value of the property will be 'bar'
			 */
			public var myString: String;

			[Inject]
			/**
			 * Value of the property will be '10'
			 */
			public var myNumber: Number;

			public function Biz() {}
		}
	}