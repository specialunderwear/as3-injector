package nl.moori.injector.patterns.request
{
	import nl.moori.injector.patterns.response.IResponse;

	public class Request implements IRequest
	{
		public function get requestClass(): Class {
			return _requestClass;
		}
		
		public function get requestName(): String {
			return _requestName;
		}
		
		public function get response(): IResponse {
			return _response;
		}
		
		public function set response( value: IResponse ): void {
			_response = value;
		}
		
		private var _requestClass: Class;
		private var _requestName: String;
		private var _response: IResponse;
		
		public function Request( requestClass: Class, requestName: String = '' )
		{
			_requestClass = requestClass;
			_requestName = requestName;
		}
	}
}