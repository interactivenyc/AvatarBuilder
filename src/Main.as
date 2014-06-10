package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends Sprite {
		private var _currentShirt:Shirt;
		
		public function Main() {
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			log("Hello World");
			createTextField();
			
			
		}
		
		private function onAddedToStage(e:Event):void{
			log("onAddedToStage");
			addHead();
			addShirt();
			
		}
		
		private function createTextField():void{
			log("createTextField");

			var tf:TextField = new TextField();
			tf.text = "Hello World";
			var fmt:TextFormat = tf.getTextFormat();
			fmt.size = 72;
			fmt.color = 0xff6600;
			tf.setTextFormat(fmt);
			tf.width = tf.textWidth + 10;
			tf.x = 20;
			tf.y = 20;
			addChild(tf);
		}
		
		private function addHead():void{
			var head:Head = new Head();
			head.x = 200;
			head.y = 300;
			addChild(head);
			head.mouth.alpha = .5;
			head.tongue.alpha = .5;
			
			head.addEventListener(MouseEvent.MOUSE_DOWN, addChildTop);
			head.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			head.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}
		
		private function addShirt():void{
			var shirt:Shirt = new Shirt();
			shirt.x = 400;
			shirt.y = 300;
			addChild(shirt);
			
			_currentShirt = shirt;
			
			shirt.doubleClickEnabled = true;
			shirt.mouseChildren = false;
			shirt.addEventListener(MouseEvent.DOUBLE_CLICK, editFill);
			
			shirt.addEventListener(MouseEvent.MOUSE_DOWN, addChildTop);
			shirt.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			shirt.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}
		
		private function editFill(e:MouseEvent):void{
			log("editFill");
			var currentTarget:MovieClip = e.currentTarget as MovieClip;
			var file:File = File.applicationDirectory.resolvePath("assets");
			//file.resolvePath("./assets");
			file.browse();
			file.addEventListener(Event.SELECT, selectFill);
		}
		
		private function selectFill(e:Event):void{
			e.currentTarget.removeEventListener(Event.SELECT, selectFill);

			log("selectFill: " + (e.target as File).name);
			log("selectFill: " + (e.target as File).nativePath);
			
			var loader:Loader = new Loader();
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = (e.target as File).name;
			loader.addEventListener(Event.COMPLETE, fillLoaded);
			loader.load(urlRequest);
			
			_currentShirt.addChild(loader);
			
		}
		
		private function fillLoaded():void{
			
			log("fillLoaded: ");
			
		}
		
		private function addChildTop(e:MouseEvent):void{
			log("addChildTop");
			addChild(e.currentTarget as MovieClip);
		}
		
		private function onStartDrag(e:Event):void{
			log("onStartDrag: "+e.currentTarget);
			(e.currentTarget as MovieClip).startDrag();

		}
		
		private function onStopDrag(e:Event):void{
			log("onStopDrag: "+e.currentTarget);
			(e.currentTarget as MovieClip).stopDrag();
		}
		
		private function log(msg:String):void{
			trace("[ Main ] "+msg);
		}
		
		
		
		
		
	}
}