package nl.moori.injector.patterns.target.type
{
	import flash.utils.getDefinitionByName;
	
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.error.InjectorError;
	import nl.moori.injector.patterns.target.Target;

	public class PropertyTarget extends Target
	{
		protected var _propertyName: String;
		protected var _propertyType: String;
		
		public function PropertyTarget( info: XML, injector: IInjector )
		{
			super( info, injector );
		}
		
		override public function inject( obj: Object ):void
		{
			if( !_request )
				throw new InjectorError( 'No injection for Class type ' + _propertyType + ' on target ' + obj );
			
			obj[ _propertyName ] = _request.response.getResponse( _injector );
		}
		
		override protected function initializeTarget(): void
		{
			_propertyName = _info.parent().@name.toString();
			_propertyType = _info.parent().@type.toString();
			_request = _injector.getRequest( Class( getDefinitionByName( _propertyType )), _info.arg.attribute( 'value' ).toString(), true );
		}
	}
}