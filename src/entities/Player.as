package entities
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.events.Event;

    import com.hexagonstar.util.debug.Debug;
    
    public class Player extends Sprite
    {
        private var asset:MovieClip;
        private var id:String;
        
        //Movement variables
        private var speed:int = 10;
        private var movementKeys:Array = new Array(119, 97, 115, 100); //A = 97, S = 115, D = 100, W = 119
        private var directionModifiers:Point = new Point(0, 0);
        private var walking:Boolean = false;
        
        //Shooting variables
        private var turnSpeed:int;
        private var currentShootingDirection:Number;
        
        public function Player(id:String, asset:MovieClip)
        {
            /*
            this.id = id;
            this.asset = asset;
            this.addChild(this.asset);
            */
            this.init();
            graphics.beginFill(0xffff00, 1);
            graphics.drawRect(-30, -50, 30, 50);
            graphics.endFill();
            Debug.trace('init player '+id+' finished');
        }
        
        private function init():void
        {
            //Init logic
            this.addEventListener(Event.ADDED_TO_STAGE, startListening);
        }
        
        private function startListening(e:Event = null):void
        {
            Debug.trace(22);
            this.removeEventListener(Event.ADDED_TO_STAGE, startListening);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, manageInput);
            this.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
        }
        
        private function stopListening():void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, manageInput);
            this.removeEventListener(Event.ENTER_FRAME, update);
            this.addEventListener(Event.ADDED_TO_STAGE, startListening);
        }
        
        private function manageInput(event:KeyboardEvent):void
        {//A = 97, S = 115, D = 100, W = 119
            switch(event.keyCode)
            {
                case 87: //W
                    this.directionModifiers.y = -1;
                    break;
                case 65:  //A
                    this.directionModifiers.x = -1;
                    break;
                case 83: //S
                    this.directionModifiers.y = 1;
                    break;
                case 68: //D
                    this.directionModifiers.x = 1;
                    break;
            }
        }
        
        private function update(event:Event):void
        {
            //Set the position
            var xModifier:Number = (this.speed * this.directionModifiers.x);
            var yModifier:Number = (this.speed * this.directionModifiers.y);
            var xVector:Number = this.x + xModifier;
            var yVector:Number = this.y + yModifier;
            
            if(xVector != 0 && xVector > 0 - (this.width/2) && xVector < stage.width - (this.width/2)) 
            {
                this.x = xVector;
                this.walking = true;
            }
            if(yVector != 0 && yVector > 0 - (this.height/2) && yVector < stage.height - (this.height/2)) 
            {
                this.y = yVector;
                this.walking = true;
            }
                
            //Reset variables
            this.directionModifiers.x = 0;
            this.directionModifiers.y = 0;
            
        }
        
    }
}