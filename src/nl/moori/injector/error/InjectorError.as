package nl.moori.injector.error
{
	public class InjectorError extends Error
	{
		public function InjectorError( message: * = '', id: * = 0 )
		{
			super( message, id );
		}
	}
}