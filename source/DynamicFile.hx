package;

import nme.events.IOErrorEvent;
import nme.Assets;
import nme.utils.Timer;
import nme.Lib;
import nme.events.TimerEvent;
import nme.events.Event;
import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.errors.SecurityError;
import nme.display.Loader;
import nme.net.URLRequest;
import nme.net.URLLoaderDataFormat;
import nme.utils.ByteArray;

class DynamicFile
{	private var contents: String;
	public var urlToLoad: String;
	public var onComplete:Dynamic = null;
	private var downloadType:Bool;
	

	public function new(aUrl:String, _type:Bool)
	{   contents = null;
		
		downloadType = _type;
		
		urlToLoad = aUrl;
		
		loadFile(urlToLoad);
	}

	private function downloadFileAtUrl()			//Not used  ========================
	{	loadFile(urlToLoad);	}

	private function loadFile(aUrl:String)
	{	try
		{	var request:URLRequest = new URLRequest(aUrl);
			var loader = new URLLoader();
			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			//loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.load(request);
		}
			
		catch (unknown : Dynamic)
		{	trace("Unknown exception: " + Std.string(unknown));
			MenuState.an_error = true; }
		
	}

	function errorHandler(event:IOErrorEvent)
	{	trace("Couldnt download file... ERROR: " + urlToLoad);
		MenuState.an_error = true;	}

	private function loaderCompleteHandlerBytes(data:ByteArray):Void
	{	
		if (downloadType == false)
		{	contents = data + '';
			data.writeFile("S_version.txt");
			loaderCompleteHandlerString(contents);
		}
		else
		{	contents = data + '';
			data.writeFile("Estimation Test.xlsm");
			MenuState.download_Finished = true;
			//loaderCompleteHandlerString(contents);
		}
	}

	private function loaderCompleteHandlerString(data:String):Void
	{	contents = data;
		
		if (this.onComplete != null)
		{	onComplete(true, data);	}
	}

	private function loaderCompleteHandler(event:Event):Void
	{	var data:ByteArray = cast(event.target, URLLoader).data;
		loaderCompleteHandlerBytes(data);
	}

}






