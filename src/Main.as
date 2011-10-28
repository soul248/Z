package
{
    import flash.display.Sprite;
    import flash.events.Event;
    //import menus.MainMenu;
    
    public class Main extends Sprite
    {
        //var mainMenu:MainMenu;
        
        public function Main():void
        {
            if(stage) init();
            else this.addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        public function init(event:Event = null):void
        {
            //Entry point for app, start the gui
            //mainMenu = new MainMenu();
            //mainMenu.init();
            //this.addChild(mainMenu);
                        
            //Start managers
            
        }
    }
    
    
}