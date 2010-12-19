package nl.moori.injector.patterns.target.type
{
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.patterns.target.Target;
	
	public class CompleteTarget extends Target
	{
		protected var _methodName: String;
		
		public function CompleteTarget( info: XML, injector: IInjector )
		{
			super( info, injector );
		}
		
		override public function inject( obj: Object ):void
		{
			obj[ _methodName ]();
		}
		
		override protected function initializeTarget(): void
		{
			_methodName = _info.parent().@name.toString();
		}
	}
}