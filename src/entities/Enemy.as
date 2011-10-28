package entities
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.Timer;
    import flash.display.MovieClip;
    import managers.EnemyManager;
    import flash.event.TimerEvent;
    import flash.geom.Point;
    
    public class Enemy extends Sprite
    {
        private var descriptor:Object;
        
        //Graphic variables
        private var asset:MovieClip;
        
        //Setup variables
        private var speed:int = 3;
        private var attackSpeed:int = 2000;
        private var asset:MovieClip;
        private var attackTimer:Timer;
        private var currentState:String = 'chasing';
        private var hp:int = 100;
        
        public function Enemy(position:Point)
        {
            graphics.beginFill(0x00FFFF, 1);
            graphics.drawRect(-20, -50, 30, 50);
            graphics.endFill();
            
            this.x = position.x;
            this.y = position.y;
        }
        
        private function init(event:Event = null):void
        {
            this.addEventListener(Event.ENTER_FRAME, update);
            
            this.attackTimer = new Timer(2000);
            this.attackTimer.addEventListener()
        }
        
        public function destroy():void
        {
            this.removeEventListener(Event.ENTER_FRAME, update);
            this.attackTimer.stop();
            this.attackTimer = null;
            if(this.parent) this.parent.removeChild(this);
        }

        public function collision(projectile:Bullet):void
        {
            this.hp -= projectile.getDamage();
            if(this.hp <= 0) this.die();
        }
        
        private function die():void
        {
            EnemyManager.getInstance().killedEnemy(this);
        }

        public function update(event:Event = null):void
        {
            var targetPlayer:Player;
            var destinationX = this.x;
            var destinationY = this.y;
            switch(this.currentState)
            {
                case 'chasing':
                    targetPlayer = EnemyManager.getInstance().getChasedPlayer(this);
                    if(this.hitTest(chasedPlayer))
                    {
                        this.currentState = 'attacking';
                    }
                    else
                    {
            			destinationX = targetPlayer.x;
            			destinationY = targetPlayer.y;

            			this.x += (destinationX - this.x) / this.speed;
            			this.y += (destinationY - this.y) / this.speed;
                    }
                    break;
                    
                case 'attacking':
                    targetPlayer = EnemyManager.getInstance().getChasedPlayer(this);
                    if(!this.hitTest(attackedPlayer))
                    {
                        this.currentState = 'chasing';
                    }
                    else
                    {
                        this.currentState = 'attacking';
                        //Attack the fucker
                        //attackedPlayer.attacked();
                    }
                    break;
            }
            
            //Make the enemy face the player
            var radians:Number = Math.atan2(destinationY - this.y, destinationX - this.x);
			var degrees:Number = radians / (Math.PI / 180) + 90;
			this.rotation = degrees;
        }
        
    }
}
