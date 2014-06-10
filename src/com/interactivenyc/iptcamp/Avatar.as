package com.interactivenyc.iptcamp
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Avatar extends MovieClip{
		private var _avatarMC:MovieClip;
		
		private var _numClothing:int = 6;
		private var _numHair:int = 14;
		private var _numEyes:int = 5;
		private var _numMouth:int = 7;
		
		private var _currentClothing:int = 1;
		private var _currentHair:int = 1;
		private var _currentEyes:int = 1;
		private var _currentMouth:int = 1;
		
		public function Avatar() {
			log("CONSTRUCTOR");
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			log("onAddedToStage");
			
			_avatarMC = new AvatarMC();
			addChild(_avatarMC);
			
			_avatarMC.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			_avatarMC.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
		}
		
		public function changeClothing():void{
			log("changeClothing");
			_currentClothing += 1;
			if (_currentClothing > _numClothing) _currentClothing = 1;
			var label:String = "clothing_"+_currentClothing;
			log("changeClothing label: "+label);
			_avatarMC.clothing.gotoAndStop(label);
		}
		
		public function changeHair():void{
			log("changeHair");
			_currentHair += 1;
			if (_currentHair > _numHair) _currentHair = 1;
			var label:String = "hair_"+_currentHair;
			log("changeHair label: "+label);
			_avatarMC.hair.gotoAndStop(label);
		}
		
		public function changeEyes():void{
			log("changeEyes");
			_currentEyes += 1;
			if (_currentEyes > _numEyes) _currentEyes = 1;
			var label:String = "eyes_"+_currentEyes;
			log("changeEyes label: "+label);
			_avatarMC.eyes.gotoAndStop(label);
		}
		
		public function changeMouth():void{
			log("changeMouth");
			_currentMouth += 1;
			if (_currentMouth > _numMouth) _currentMouth = 1;
			var label:String = "mouth_"+_currentMouth;
			log("changeMouth label: "+label);
			_avatarMC.mouth.gotoAndStop(label);
		}
		
		private function onMouseEvent(e:MouseEvent):void{
			log("onMouseEvent e:type: "+e.type);
			
			dispatchEvent(new Event("SET_CURRENT_AVATAR"));
			
			switch(e.type){
				case MouseEvent.MOUSE_DOWN:
					_avatarMC.startDrag();
					break;
				case MouseEvent.MOUSE_UP:
					_avatarMC.stopDrag();
					break;
			}
		}
		
		
		
		
		
		private function log(msg:String):void{
			trace("[ Avatar ] "+msg);
		}
	}
}