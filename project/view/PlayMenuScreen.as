﻿package view{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.core.Starling;

	
	public class PlayMenuScreen extends Sprite{
		
		var continueButton:Image;
		var newGameButton:Image;
		var menuBackground:Image;
		var warningBackground:Image;
		var warningOK:Image;
		var warningCancel:Image;

		
		public function PlayMenuScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event)
		{
			trace("PlayMenuScreen loaded");
			addMenuBackground();
	//if there is a saved game state on the device, then execute
			addContinueButton();
			addNewGameButton();
		}
		
		
		function addMenuBackground(){
			menuBackground = new Image(Main.assets.getTexture("MainMenuBackground"));
			addChild( menuBackground );
		}
		
		//--------------------start of adding buttons----------------

		private function addContinueButton(){
			if(MainMenuScreen.saveDataObject.data.gender=="" || MainMenuScreen.saveDataObject.data.gender==null){
				continueButton = new Image(Main.assets.getTexture("ButtonContinueGrey"));	
			}
			else{
				trace("else", MainMenuScreen.saveDataObject.data.gender);
				continueButton = new Image(Main.assets.getTexture("ButtonContinue"));				
				continueButton.addEventListener( TouchEvent.TOUCH , onContinueButton );
			}
			addChild( continueButton );				
			continueButton.y = 15;
			continueButton.x = (Starling.current.stage.stageWidth - continueButton.width) / 2;
		}
		
		private function addNewGameButton(){
			newGameButton = new Image(Main.assets.getTexture("ButtonNewGame"));
			addChild( newGameButton );
			
			newGameButton.y = continueButton.y + continueButton.height + 10;
			newGameButton.x = (Starling.current.stage.stageWidth - newGameButton.width) / 2;
			
			newGameButton.addEventListener( TouchEvent.TOUCH , onNewGameButton );
		}
		//---------------end of adding buttons------------------
		
		
		
		//---------------start of button's event handlers-------
		
		private function onContinueButton(event:TouchEvent){
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{ 
				Navigator.instance.loadScreen( "levelSelect" ,0);
			}
		}
		
		private function onNewGameButton(event:TouchEvent){
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{ 
// WARNING that New Game deletes all progress! 
				if(MainMenuScreen.saveDataObject.data.gender=="" || MainMenuScreen.saveDataObject.data.gender==null){
					Navigator.instance.loadScreen( "genderSelect" ,0);					
				}
				else{
					warningBackground = new Image(Main.assets.getTexture("MenuBox")); 
					warningBackground.x = (Starling.current.stage.stageWidth - warningBackground.width)-((Starling.current.stage.stageWidth - warningBackground.width) / 2);
					warningBackground.y = 48;
					
					warningOK = new Image(Main.assets.getTexture("ButtonYes")); 
					warningOK.x = (Starling.current.stage.stageWidth - warningOK.width)-((Starling.current.stage.stageWidth - warningOK.width) / 2);
					warningOK.y = 92;
					warningOK.addEventListener( TouchEvent.TOUCH , onOKButton );
				
					warningCancel = new Image(Main.assets.getTexture("ButtonNo")); 
					warningCancel.x = (Starling.current.stage.stageWidth - warningCancel.width)-((Starling.current.stage.stageWidth - warningCancel.width) / 2);
					warningCancel.y = 127;
					warningCancel.addEventListener( TouchEvent.TOUCH , onCancelButton );
					
					addChild(warningBackground);
					addChild(warningOK);
					addChild(warningCancel);
				}
			}
		}
		
		private function onCancelButton(event:TouchEvent){
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{ 
				removeChild(warningBackground);
				removeChild(warningOK);
				removeChild(warningCancel);
			}
		}
		
		private function onOKButton(event:TouchEvent){
			var touch:Touch = event.touches[0];
			if(touch.phase == TouchPhase.BEGAN)
			{ 
				MainMenuScreen.saveDataObject.data.level1Score=0;
				MainMenuScreen.saveDataObject.data.level2Score=0;
				MainMenuScreen.saveDataObject.data.level3Score=0;
				MainMenuScreen.saveDataObject.data.level4Score=0;
				MainMenuScreen.saveDataObject.data.level5Score=0;
				MainMenuScreen.saveDataObject.data.level6Score=0;
				MainMenuScreen.saveDataObject.data.level7Score=0;
				MainMenuScreen.saveDataObject.data.level8Score=0;
				MainMenuScreen.saveDataObject.data.level9Score=0;
				MainMenuScreen.saveDataObject.data.condomCount=0;
				MainMenuScreen.saveDataObject.data.currency=0;
				MainMenuScreen.saveDataObject.data.gender="";
				MainMenuScreen.saveDataObject.flush();
				
				Navigator.instance.loadScreen( "genderSelect" ,0);
			}
		}
		//---------------end of button's event handlers---------

	}
	
}
