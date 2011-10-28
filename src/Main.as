package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import entities.Player;
    //import menus.MainMenu;
    
    public class Main extends Sprite
    {
        //var mainMenu:MainMenu;
        
        public function Main()
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
            
            
            //Player testing
            var player:Player = new Player("1", null);
            this.addChild(player);
        }
    }
    
    
}