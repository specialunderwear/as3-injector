package nl.moori.injector.patterns.target.type
{
	import flash.utils.getDefinitionByName;
	
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.error.InjectorError;
	import nl.moori.injector.patterns.request.IRequest;
	import nl.moori.injector.patterns.target.Target;
	
	public class MethodTarget extends Target
	{
		protected var _requests: Vector.<IRequest>;
		protected var _requiredArguments: int;
		protected var _methodName: String;
		
		public function MethodTarget( info: XML, injector: IInjector )
		{
			super( info, injector );
		}
		
		override public function inject( obj: Object ):void
		{
			var method: Function = obj[ _methodName ];
			method.apply( this, getArgumentValues( obj ));
		}
		
		override protected function initializeTarget(): void
		{
			_requests = new Vector.<IRequest>;
			_requiredArguments = 0;
			_methodName = _info.parent().@name.toString();
			
			getArguments( _info.parent(), _info.arg.( @key == 'name' ));
		}
		
		protected function getArguments( info: XML, argumentNames: XMLList ): void
		{
			var i: int = 0;
			var argument: XML;
			var argumentType: String;
			
			for each( argument in info.parameter )
			{
				argumentType = argument.@type.toString();
				
				if( argumentType == '*' && argument.@optional.toString() == 'false' )
					throw new InjectorError( 'Injected argument may not have type *' );
				
				if( argument.@optional.toString() == 'false' )
					_requiredArguments++;
				
				_requests.push( _injector.getRequest( Class( getDefinitionByName( argumentType )), argumentNames[ i ] ? argumentNames[ i ].@value.toString() : '', true ));
				
				i++;
			}
		}
		
		protected function getArgumentValues( obj: Object ): Array
		{
			var i: int = 0;
			var request: IRequest;
			var values: Array = [];
			
			for each( request in _requests )
			{
				if( !request.response )
				{
					if( i >= _requiredArguments )
						break;
					else
						throw new InjectorError( 'No injection for Class type ' + request.requestClass + ' on method ' + _methodName + ' on target ' + obj );
				}
				
				values.push( request.response.getResponse( _injector ));
				
				i++;
			}
			
			return values;
		}
	}
}