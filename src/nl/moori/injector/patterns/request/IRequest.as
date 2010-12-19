package nl.moori.injector.patterns.request
{
	import nl.moori.injector.patterns.response.IResponse;

	public interface IRequest
	{
		function get requestClass(): Class;
		
		function get requestName(): String;
		
		function get response(): IResponse;
		
		function set response( value: IResponse ): void;
	}
}