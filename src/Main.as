package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends Sprite {
		
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
			
			head.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			head.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
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