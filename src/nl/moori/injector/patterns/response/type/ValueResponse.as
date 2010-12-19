package nl.moori.injector.patterns.response.type
{
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.patterns.response.Response;

	public class ValueResponse extends Response
	{
		private var _value: Object;
		
		public function ValueResponse( value: Object )
		{
			_value = value;
		}
		
		override public function getResponse( injector: IInjector ): Object
		{
			return _value;
		}
	}
}