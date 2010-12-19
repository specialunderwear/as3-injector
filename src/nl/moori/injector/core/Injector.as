package nl.moori.injector.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import nl.moori.injector.patterns.request.IRequest;
	import nl.moori.injector.patterns.request.Request;
	import nl.moori.injector.patterns.response.type.ClassResponse;
	import nl.moori.injector.patterns.response.type.SingletonResponse;
	import nl.moori.injector.patterns.response.type.ValueResponse;
	import nl.moori.injector.patterns.target.ITarget;
	import nl.moori.injector.patterns.target.type.CompleteTarget;
	import nl.moori.injector.patterns.target.type.MethodTarget;
	import nl.moori.injector.patterns.target.type.PropertyTarget;
	
	public class Injector implements IInjector
	{
		public function get parentInjector(): IInjector {
			return _parentInjector;
		}
		
		public function set parentInjector( value: IInjector ): void {
			_parentInjector = value;
		}
		
		protected var _requestMap: Dictionary;
		protected var _targetMap: Dictionary;
		protected var _parentInjector: IInjector;
		
		public function Injector()
		{
			_requestMap = new Dictionary;
			_targetMap = new Dictionary;
		}
		
		public function instantiate( classReference: Class ): Object
		{
			return inject( new classReference );
		}
		
		public function inject( obj: Object ): Object
		{
			var target: ITarget;
			var targets: Vector.<ITarget> = _targetMap[ obj ] ? _targetMap[ obj ] : getTargets( obj );
			
			for each( target in targets )
				target.inject( obj );
			
			return obj;
		}
		
		public function mapValue( value: Object, requestClass: Class, requestName: String = '' ): void
		{
			getRequest( requestClass, requestName ).response = new ValueResponse( value );
		}
		
		public function mapClass( classReference: Class, requestClass: Class, requestName: String = '' ): void
		{
			getRequest( requestClass, requestName ).response = new ClassResponse( classReference );
		}
		
		public function mapSingleton( classReference: Class, requestClass: Class, requestName: String = '' ): void
		{
			getRequest( requestClass, requestName ).response = new SingletonResponse( classReference );
		}
		
		public function hasMap( requestClass: Class, requestName: String = '' ): Boolean
		{
			return _requestMap[ getQualifiedClassName( requestClass ) + requestName ] != null;
		}
		
		public function unMap( requestClass: Class, requestName: String = '' ): void
		{
			_requestMap[ getQualifiedClassName( requestClass ) + requestName ] = null;
		}
		
		public function createChildInjector(): IInjector
		{
			var injector: IInjector = new Injector;
			injector.parentInjector = this;
			
			return injector;
		}
		
		public function getRequest( requestClass: Class, requestName: String = '', getFromAncestors: Boolean = false ): IRequest
		{
			var name: String = getQualifiedClassName( requestClass ) + requestName;
			var request: IRequest;
			
			if( _requestMap[ name ] )
				request = _requestMap[ name ] as IRequest;
			else if( !_requestMap[ name ] && getFromAncestors && _parentInjector ) {
				return _parentInjector.getRequest( requestClass, requestName, true );
			}
			else {
				request = new Request( requestClass, requestName );
				
				_requestMap[ name ] = request;
			}
			
			return request;
		}
		
		public function getTargets( obj: Object ): Vector.<ITarget>
		{
			var targets: Vector.<ITarget> = new Vector.<ITarget>;
			
			var info: XML = describeType( Class( getDefinitionByName( getQualifiedClassName( obj ))));
			var node: XML;
			
			for each( node in info.factory.*.( name() == 'variable' || name() == 'accessor' ).metadata.( @name == 'Inject' ))
				targets.push( new PropertyTarget( node, this ));
			
			for each( node in info.factory.method.metadata.( @name == 'Inject' ))
				targets.push( new MethodTarget( node, this ));
			
			for each( node in info.factory.method.metadata.( @name == 'InjectComplete' ))
				targets.push( new CompleteTarget( node, this ));
			
			_targetMap[ obj ] = targets;
			
			return targets;
		}
	}
}