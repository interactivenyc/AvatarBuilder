package
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends Sprite {
		private var makeAvatarButton:MovieClip;
		
		public function Main() {
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			log("Hello World");
		}
		
		private function onAddedToStage(e:Event):void{
			log("onAddedToStage");
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createHelloWorldTextField();
			createAvatarButton();
		}
		
		private function createAvatarButton():void{
			log("createAvatarButton");
			
			makeAvatarButton = getButton("Make Avatar");
			
			makeAvatarButton.x = 20;
			makeAvatarButton.y = 120;
			
			addChild(makeAvatarButton);
			makeAvatarButton.mouseEnabled = true;
			
			makeAvatarButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonClicked);
		}
		
		
		
		private function createHelloWorldTextField():void{
			log("createHelloWorldTextField");
			
			var helloWorldText:TextField = getTextField("Hello World");
			
			helloWorldText.x = 20;
			helloWorldText.y = 20;
			
			addChild(helloWorldText);
		}
		
		private function makeAvatar():void{
			log("makeAvatar");
		}
		
		
		
		
		//********************************************************
		// UTILITY FUNCTIONS
		//********************************************************
		
		private function getTextField(labelText:String):TextField{
			log("createTextField: "+labelText);

			var tf:TextField = new TextField();
			tf.text = labelText;
			var fmt:TextFormat = tf.getTextFormat();
			fmt.size = 24;
			fmt.color = 0xff6600;
			fmt.font = "sans";
			tf.setTextFormat(fmt);
			tf.width = tf.textWidth + 10;
			tf.height = tf.textHeight + 10;
			
			return tf;
		}
		
		private function getFilledMC(w:Number,h:Number,color:Number = 0x0000FF):MovieClip {
			log("getFilledMC() width: "+ w + ", height: "+ h + ", color: "+ color);
			var mc:MovieClip = new MovieClip();
			var rect:Shape = new Shape();
			rect.graphics.beginFill(color);
			rect.graphics.lineStyle(0,color,0);
			rect.graphics.drawRect(0, 0, w, h);
			rect.graphics.endFill();
			mc.addChild(rect);
			
			return mc;
		}
		
		private function getButton(buttonName:String):MovieClip{
			log("getButton: "+buttonName);
			var button:MovieClip = new MovieClip();
			var buttonText:TextField = getTextField(buttonName);
			button.addChild(buttonText);
			var hitArea:MovieClip = getFilledMC(buttonText.width, buttonText.height);
			hitArea.alpha = .3;
			button.hitArea = hitArea;
			button.addChild(hitArea);
			
			return button;
		}
		
		
		
		//********************************************************
		// Event Handlers
		//********************************************************
		
		
		private function onButtonClicked(e:MouseEvent):void{
			switch (e.currentTarget){
				case makeAvatarButton:
					makeAvatar();
					break;
			}
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