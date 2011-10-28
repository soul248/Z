package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import entities.Player;
    import entities.Map;
    import menus.MainMenu;
    import com.hexagonstar.util.debug.Debug;
    
    import assets.AssetsManager;
    import managers.CollisionManager;
    import managers.EnemyManager;

    public class Main extends Sprite
    {
        private static var mainMenu:MainMenu;
        
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
            var assets:AssetsManager = new AssetsManager(startGame);
        }
        
        public function startGame():void
        {
            mainMenu = new MainMenu();
            stage.addChild(mainMenu);
            
            var map:Map = new Map();
            stage.addChild(map);
            
            var player:Player = new Player("1");
            player.x = 500;
            player.y = 500;
            stage.addChild(player);
            
            
        }
    }
    
    
}
