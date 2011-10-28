package managers
{
    import entities.Bullet;
    import entities.Enemy;
    
    public class CollisionManager
    {
        private var activeProjectiles:Array;
        private var activeEnemies:Array;
        
        public function CollisionManager()
        {
            if(!this.instance)
            {
                activeProjectiles = new Array();
                activeEnemies = new Array();
            }
            else throw new Error("CollisionManager is a singleton");
        }
        
        public function init():void
        {
            
        }
        
        private function update():void
        {
            for(var i:int = 0; i < this.activeProjectiles.length; i++)
            {
                for(var j:int = 0; j < this.activeEnemies.length; j++)
                {
                    if(activeProjectiles[i].hitTest(activeEnemies[j]))
                    {
                        activeProjectiles[i].collision(activeEnemies[j]);
                        activeEnemies[j].collision(activeProjectiles[i]);
                    }
                }
            }
        }
        
        public function addProjectile(projectile:Bullet):void
        {
            activeProjectiles.push(projectile);
        }
    
        public function removeProjectile(projectile:Bullet):void
        {
            var index:int = activeProjectiles.indexOf(projectile);
            if(index > -1) activeProjectiles.splice(index, 1);
        }
        
        public function addEnemy(enemy:Enemy):void
        {
            activeEnemies.push(enemy);
        }
        
        public function removeEnemy(enemy:Enemy):void
        {
            var index:int = activeEnemies.indexOf(enemy);
            if(index > -1) activeEnemies.splice(index, 1);
        }
    
        public static var instance:CollisionManager = new CollisionManager();
    
        public static function getInstance():CollisionManager
        {
            return this.instance;
        }
    
    }
}