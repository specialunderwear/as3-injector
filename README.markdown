# AS3 Model View Controller / Inversion of Control Framework

## Available patterns

* Model
	* Proxy
* View
	* Mediator
* Controller
	* Command
	* MacroCommand
	* AsyncCommand
	* ASyncMacroCommand

## Inversion of Control (Dependency Injection)

This framework uses the [Injector](https://github.com/moorinteractive/as3-injector/) utility to provide all Objects of it's dependencies. If you don't prefer using IoC, I suggest you to use another framework (for example [PureMVC](http://puremvc.org/)).

## Setup

Download the source files and include them into your project. If you prefer to use a swc library file, download one of the packages and add it to your project library files.

## Usage

## Extending the Framework

The first thing to setup a new project environment is to create the heart of your application. Within that Class you should write your initial code for the application (such as required mappings).

	package nl.moori.application
	{
		import flash.display.DisplayObjectContainer;

		import nl.moori.framework.core.Framework;

		public class Application extends Framework
		{
			public function Application( container: DisplayObjectContainer )
			{
				super( container );
			}
		
			override protected function initialize(): void
			{
				// do you mappings
			}
		}
	}

To initialize your heart of the application, just create and store an instance of your Class in your scope. **Note**: do not store the instance is a variable which is out of the scope, since the Garbage Collector will clean up this variable.

	package
	{
		import flash.display.Sprite;
		import flash.display.StageAlign;
		import flash.display.StageScaleMode;
		import flash.events.Event;
	
		import nl.moori.demo.Application;
	
		public class Demo extends Sprite
		{
			private var application: Application;
		
			public function Demo()
			{
				super();
			
				addEventListener( Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true );
			}
		
			private function onAddedToStage( evt: Event ): void
			{
				removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.frameRate = 30;
			
				application = new Application( this );
			}
		}
	}

Now you will be ready to start writing the logic of your application. Probably you want to dispatch an StartupEvent which executes a StartupCommand.

	package nl.moori.demo
	{
		import flash.display.DisplayObjectContainer;

		import nl.moori.demo.controller.StartupCommand;
		import nl.moori.demo.events.ApplicationEvent;
		import nl.moori.framework.core.Framework;

		public class Application extends Framework
		{
			public function Application( container: DisplayObjectContainer )
			{
				super( container );
			}
	
			public function startup( options: Object ): void
			{
				dispatchEvent( new ApplicationEvent( ApplicationEvent.STARTUP, options ));
			}
	
			override protected function initialize(): void
			{
				controller.mapEvent( ApplicationEvent.STARTUP, ApplicationEvent, StartupCommand );
			}
		}
	}

## Model & Proxies

Since this framework uses Dependency Injection, we assume when you use a Proxy you will inject it. Therefore you won't find a property like model or proxyMap.

To inject a Proxy, simply use the injector to map an instance/singleton of your Proxy (in most cases a singleton, since we only need one instance of it though the application):
	
	injector.mapSingleton( MyProxy, IMyProxy );
	injector.mapClass( MyProxy, IMyProxy );

## View & Mediator's

Mediator's can be registered in two ways in your framework. You can manually attach a Mediator to an existing viewComponent or let the framework automatically attach Mediator's when a specific type of viewComponent is added  on the Display List. When a Mediator is registered by the View (automatically), the Mediator will also be detached when the viewComponent is removed from the Stage. Therefore we have the `onRegister` and `onRemove` methods you can override. The viewComponent will be injected into the attached Mediator which you can retrieve by it's Class type. Let's take a look at the following examples:

### Manual mapping

	var menu: Menu = new Menu;

	container.addChild( menu );

	view.instantiateMediator( menu, MenuMediator );

### Automatic mapping

	view.mapView( Menu, MenuMediator );

	container.addChild( new Menu );

### MenuMediator

	package nl.moori.demo.view.menu
	{
		import nl.moori.framework.patterns.mediator.Mediator;

		public class MenuMediator extends Mediator
		{
			[Inject]
			public var view: Menu;
		
			override public function onRegister(): void
			{
				// add view/framewok listeners
			}
		
			override public function onRemove(): void
			{
				// remove view/framewok listeners
			}
		}
	}

## Controller & Commands