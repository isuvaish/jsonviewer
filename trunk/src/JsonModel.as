package
{
	public class JsonModel
	{
		import com.adobe.serialization.json.JSON;
		private static const ROOT_LABEL:String = "ROOT";
		private var _jsonString:String;
		private var _jsonModel:Object;
		public function JsonModel(json:String=null)
		{
			if (json)
			{
				this.jsonString = json;
			}
		}
		[Bindable]
		public function get jsonString():String
		{
			return _jsonString;
		}
		public function set jsonString(json:String):void
		{
			_jsonString = json;
			this.jsonModel = JSON.decode(json);
		}
		[Bindable]
		public function get jsonModel():Object
		{
			return _jsonModel;
		}
		public function set jsonModel(obj:Object):void
		{
			_jsonString = JSON.encode(obj);
			_jsonModel = buildModel(obj);
		}
		
		// static utilities
		private static function buildModel(obj:Object):Object
		{
			return makeModel(obj, ROOT_LABEL);
		}
		private static function makeModel(obj:Object, name:String) : Object 
		{
			var model:Object = {};
			model.label = name;
			model.children = [];
			for (var prop:String in obj)
			{
				var value:Object = obj[prop];
				if (value is String || value is Number || value is Boolean)
				{
					var node:Object = {};
					node.label = prop;
					node.data = value;
					model.children.push(node);
				} 
				else
				{
					model.children.push(makeModel(value,prop));
				}
			}
			return model;
		}		
	}
}