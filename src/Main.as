package
{
	import com.interactivenyc.iptcamp.Avatar;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Main extends Sprite {
		private var _makeAvatarButton:MovieClip;
		private var _changeClothingButton:MovieClip;
		private var _changeEyesButton:MovieClip;
		private var _changeMouthButton:MovieClip;
		private var _changeHairButton:MovieClip;
		
		private var _buttonPanel:MovieClip;
		
		private var _currentAvatar:Avatar;
		private var _avatarArray:Array = new Array();
		private var _buttonArray:Array = new Array();
		
		public function Main() {
			super();
			log("CONSTRUCTOR");
			
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
			createAvatarButtons();
		}
		
		private function createAvatarButtons():void{
			log("createAvatarButton");
			
			_buttonPanel = new MovieClip();
			
			_makeAvatarButton = getButton("Make Avatar");
			_buttonPanel.addChild(_makeAvatarButton);
			
			_changeClothingButton = getButton("Change Clothes");
			_buttonPanel.addChild(_changeClothingButton);
			
			_changeEyesButton = getButton("Change Eyes");
			_buttonPanel.addChild(_changeEyesButton);
			
			_changeMouthButton = getButton("Change Mouth");
			_buttonPanel.addChild(_changeMouthButton);
			
			_changeHairButton = getButton("Change Hair");
			_buttonPanel.addChild(_changeHairButton);
			
			_buttonPanel.x = 20;
			_buttonPanel.y = 20;
			
			addChild(_buttonPanel);
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
			
			_currentAvatar = new Avatar();
			_currentAvatar.x = 400;
			_currentAvatar.y = 400;
			_avatarArray.push(_currentAvatar);
			
			hiliteAvatar(_currentAvatar);
			
			_currentAvatar.addEventListener("SET_CURRENT_AVATAR", setCurrentAvatar);
			
			addChild(_currentAvatar);
		}
		
		private function setCurrentAvatar(e:Event):void{
			log("setCurrentAvatar: "+e.currentTarget);
			_currentAvatar = e.currentTarget as Avatar;
			addChild(_currentAvatar);
			hiliteAvatar(_currentAvatar);
		}
		
		private function hiliteAvatar(avatar:Avatar):void{
			for (var i:int=0; i<_avatarArray.length; i++){
				_avatarArray[i].filters = [];
			}
			
			avatar.filters = [new DropShadowFilter(6,45,0,1,8,2)];
		}
		
		
		
		//********************************************************
		// UTILITY FUNCTIONS
		//********************************************************
		
		private function getTextField(labelText:String):TextField{
			log("createTextField: "+labelText);

			var tf:TextField = new TextField();
			tf.text = labelText;
			var fmt:TextFormat = new TextFormat();
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
			button.buttonText = buttonText;
			button.addChild(buttonText);
			
			var hitArea:MovieClip = getFilledMC(buttonText.width, buttonText.height);
			hitArea.alpha = .3;
			button.hitArea = hitArea;
			button.addChild(hitArea);
			
			_buttonArray.push(button)
			
			button.x = 0;
			button.y = (_buttonArray.length * (button.height + 10));
			
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonClicked);
			
			return button;
		}
		
		
		
		//********************************************************
		// Event Handlers
		//********************************************************
		
		
		private function onButtonClicked(e:MouseEvent):void{
			log("onButtonClicked: " + e.currentTarget["buttonText"].text);
			switch (e.currentTarget){
				case _makeAvatarButton:
					makeAvatar();
					break;
				case _changeClothingButton:
					_currentAvatar.changeClothing();
					break;
				case _changeHairButton:
					_currentAvatar.changeHair();
					break;
				case _changeEyesButton:
					_currentAvatar.changeEyes();
					break;
				case _changeMouthButton:
					_currentAvatar.changeMouth();
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