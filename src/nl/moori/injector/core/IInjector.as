package nl.moori.injector.core
{
	import nl.moori.injector.patterns.request.IRequest;
	import nl.moori.injector.patterns.target.ITarget;

	public interface IInjector
	{
		function get parentInjector(): IInjector;
		function set parentInjector( value: IInjector ): void;
		
		function instantiate( classReference: Class ): Object;
		
		function inject( target: Object ): Object;
		
		function mapValue( value: Object, requestClass: Class, requestName: String = '' ): void;
		
		function mapClass( classReference: Class, requestClass: Class, requestName: String = '' ): void;
		
		function mapSingleton( classReference: Class, requestClass: Class, requestName: String = '' ): void;
		
		function hasMap( requestClass: Class, requestName: String = '' ): Boolean;
		
		function unMap( requestClass: Class, requestName: String = '' ): void;
		
		function createChildInjector(): IInjector;
		
		function getRequest( requestClass: Class, requestName: String = '', getFromAncestors: Boolean = false ): IRequest;
		
		function getTargets( obj: Object ): Vector.<ITarget>;
	}
}