package managers
{
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import entities.Enemy;
    import entities.Player;
    import entities.Map;
    
    public class EnemyManager
    {
        private var activeEnemies:Array;
        private var enemySpawnTimer:Timer;
        private var spawnDelay:int = 800;
        private var spawnPositions:Array;
        private var players:Array;
        private var map:Map;
        
        public function EnemyManager()
        {
            if(!this.instance)
            {
                activeEnemies = new Array();
                players       = new Array();
                
                enemySpawnTimer = new Timer(spawnDelay);
                enemySpawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
                
                spawnPositions = new Array();
                for(var i:int = 0; i < 20; i ++)
                {
                    if(i < 5)
                    {
                        spawnPositions[i] = new Point(-100, Math.floor(Math.random() * 768 % 768));
                    }
                    else if(i < 10)
                    {
                        spawnPositions[i] = new Point(Math.floor(Math.random() * 1024 % 1024), -100);
                    }
                    else if(i < 15)
                    {
                        spawnPositions[i] = new Point(1140, Math.floor(Math.random() * 768 % 768));
                    }
                    else
                    {
                        spawnPositions[i] = new Point(Math.floor(Math.random() * 1024 % 1024), 890);
                    }
                }
            }
            else
            {
                throw new Error("trying to initialize EnemyManager again");
            }
        }
        
        public function start(map:Map):void
        {
            this.map = map;
            enemySpawnTimer.start();
        }
        
        private function spawnEnemy(event:Event):Enemy
        {
            var randomShot = Math.floor(Math.random()*spawnPositions.length%spawnPositions.length);
            var newEnemy:Enemy = new Enemy(this.spawnPositions[randomShot]);
            this.activeEnemies.push(newEnemy);
            this.map.addChild(newEnemy);
        }
        
        public function addPlayer(player:Player):void
        44{
            this.players.push(player);
        }
        
        public function killedEnemy(enemy:Enemy):void
        {
            var index:int = this.activeEnemies.indexOf(enemy);
            if(index > -1)
            {
                CollisionManager.getInstance().removeEnemy(enemy);
                this.activeEnemies[index].destroy();
                this.activeEnemies.splice(index, 1);
            }
        }
        
        public function getChasedPlayer(enemy:Enemy):Player
        {
            /*
            var diff = 2000;
            var targetPlayer:Player;
            for(var i:int = 0; i < this.players.length; i++)
            {
                var sum = Math.abs(this.players[i].x - enemy.x, this.players[i].y - enemy.y);
                if( sum < diff)
                {
                    diff = sum;
                    targetPlayer = this.players[i];
                }
            }
            */
            var targetPlayer = this.players[0];
            if(!targetPlayer) 
                throw new Error("There are no players to chase for.");
            else 
                return targetPlayer;
        }
        
        private static var instance:EnemyManager = new EnemyManager();
        
        public static function getInstance():EnemyManager
        {
            return this.instance;
        }
    }
}