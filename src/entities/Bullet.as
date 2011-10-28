package entities
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import managers.CollisionManager;
    
    public class Bullet extends Sprite
    {
        public var damage:int = 100;
        private var asset:MovieClip;
        
        public function Bullet()
        {
            asset = new MovieClip();
            this.addChild(asset);
        }
        
        public function collision(collisionEnemy:Enemy):void
        {
            //Remove this bullet
            CollisionManager.getInstance().removeProjectile(this);
            if(this.parent) this.parent.removeChild(this);
        }
    }
}