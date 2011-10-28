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

        public function update(event:Event = null):void
        {
            switch(this.currentState)
            {
                case 'chasing':
                    var chasedPlayer = EnemyManager.getInstance().getChasedPlayer(this);
                    if(this.hitTest(chasedPlayer))
                    {
                        this.currentState = 'attacking';
                    }
                    else
                    {
                        this.currentState = 'chasing';
                        (chasedPlayer.x > this.x)? this.x+=this.speed : this.x-= this.speed;
                        
                        (chasedPlayer.y > this.y)? this.y+=this.speed : this.y-= this.speed;
                    }
                    break;
                    
                case 'attacking':
                    var attackedPlayer = EnemyManager.getInstance().getChasedPlayer(this);
                    if(!this.hitTest(attackedPlayer))
                    {
                        this.currentState = 'chasing';
                    }
                    else
                    {
                        this.currentState = 'attacking';
                        //Attack the fucker
                        attackedPlayer.attacked();
                    }
                    break;
            }
            
            //Make the enemy face the player
            
        }
    }
}
