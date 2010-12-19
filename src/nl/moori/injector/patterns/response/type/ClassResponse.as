package nl.moori.injector.patterns.response.type
{
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.patterns.response.Response;
	
	public class ClassResponse extends Response
	{
		private var _classReference: Object;
		
		public function ClassResponse( classReference: Class )
		{
			_classReference = classReference;
		}
		
		override public function getResponse( injector: IInjector ): Object
		{
			return injector.instantiate( new _classReference );
		}
	}
}