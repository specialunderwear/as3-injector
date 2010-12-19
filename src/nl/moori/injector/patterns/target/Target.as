package nl.moori.injector.patterns.target
{
	import nl.moori.injector.core.IInjector;
	import nl.moori.injector.patterns.request.IRequest;
	import nl.moori.injector.patterns.response.IResponse;

	public class Target implements ITarget
	{
		protected var _info: XML;
		protected var _injector: IInjector;
		protected var _request: IRequest;
		
		public function Target( info: XML, injector: IInjector )
		{
			_info = info;
			_injector = injector;
			
			initializeTarget();
		}
		
		protected function initializeTarget(): void
		{
			
		}
		
		public function inject( obj: Object ): void
		{
			
		}
	}
}