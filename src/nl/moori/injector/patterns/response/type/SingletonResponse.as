package nl.moori.injector.patterns.response.type
{
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.patterns.response.Response;
	
	public class SingletonResponse extends Response
	{
		private var _classReference: Class;
		private var _instance: Object;
		
		public function SingletonResponse( classReference: Class )
		{
			_classReference = classReference;
		}
		
		override public function getResponse( injector: IInjector ): Object
		{
			return _instance ||= injector.instantiate( _classReference );
		}
	}
}