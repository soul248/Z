package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import entities.Player;
    import menus.MainMenu;
    import com.hexagonstar.util.debug.Debug;
    
    
    public class Main extends Sprite
    {
        private var mainMenu:MainMenu;
        
        public function Main()
        {
            width = 1024;
            height = 768;
            
            Debug.trace('yeahhh!');
            
            if(stage) init();
            else this.addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        public function init(event:Event = null):void
        {
            //Entry point for app, start the gui
            mainMenu = new MainMenu();
            stage.addChild(mainMenu);
                        
            //Start managers
            
            
            //Player testing
            var player:Player = new Player("1", null);
            player.x = 500;
            player.y = 500;
            stage.addChild(player);

        }
    }
    
    
}
