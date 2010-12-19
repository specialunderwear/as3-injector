package nl.moori.injector.patterns.response
{
	import nl.moori.injector.core.IInjector;

	public interface IResponse
	{
		function getResponse( injector: IInjector ): Object;
	}
}