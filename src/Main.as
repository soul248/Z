package
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import menus.MainMenu;
    
    public class Main extends Sprite
    {
        private var mainMenu:MainMenu;
        
        public function Main():void
        {
            width = 1024;
            height = 768;

            if(stage) init();
            else this.addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        public function init(event:Event = null):void
        {
            //Entry point for app, start the gui
            mainMenu = new MainMenu();
            stage.addChild(mainMenu);
                        
            //Start managers
            
        }
    }
    
    
}
