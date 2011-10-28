package entities
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import managers.EnemyManager;
    import flash.events.Event;
    import com.hexagonstar.util.debug.Debug;
    import assets.AssetsManager;
    
    public class Map extends Sprite
    {
        private var background:MovieClip;
        private var id:String;
        
        public function Map()
        {
            this.background = AssetsManager.getAsset("FloorGround");
            this.addChild(background);
        }
        
        public function init():void
        {
            this.addEventListener(Event.ADDED_TO_STAGE, start);
        }
        
        public function start():void
        {
            Debug.trace('Do something : D');
        }
    }
}