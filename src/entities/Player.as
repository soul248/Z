package entities
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.ui.Keyboard;

    import assets.AssetsManager;
    
    public class Player extends Sprite
    {
        private var asset:MovieClip;
        private var id:String;
        
        //Movement variables
        private var speed:int = 4;
        private var movingUp:Boolean = false;
        private var movingDown:Boolean = false;
        private var movingLeft:Boolean = false;
        private var movingRight:Boolean = false;
        
        //Shooting variables
        private var turnSpeed:int;
        private var currentShootingDirection:Number;
        
        public function Player(id:String)
        {
            this.id = id;
            this.asset = AssetsManager.getAsset("PurpleWizardWalk");
            this.addChild(this.asset);
            this.init();
        }
        
        private function init():void
        {
            //Init logic
            this.addEventListener(Event.ADDED_TO_STAGE, startListening, false, 0, true);
        }
        
        private function startListening(e:Event = null):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, startListening);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress, false, 0, true);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyRelease, false, 0, true);
            stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
        }
        
        private function stopListening():void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
            stage.removeEventListener(Event.ENTER_FRAME, update);
            this.addEventListener(Event.ADDED_TO_STAGE, startListening, false, 0, true);
        }

        private function update(event:Event):void
        {
            if(movingLeft && !movingRight)
            {
                x -= speed;
                rotation = 270;
            }

            if(movingRight && !movingLeft)
            {
                x += speed;
                rotation = 90;
            }

            if(movingUp && !movingDown)
            {
                y -= speed;
                rotation = 0;
            }

            if(movingDown && !movingUp)
            {
                y += speed;
                rotation = 180;
            }

            if(movingLeft && movingUp && !movingRight && !movingDown)
            {
                rotation = 315;
            }

            if(movingRight && movingUp && !movingLeft && !movingDown)
            {
                rotation = 45;
            }

            if(movingLeft && movingDown && !movingRight && !movingUp)
            {
                rotation = 225;
            }

            if(movingRight && movingDown && !movingLeft && !movingUp)
            {
                rotation = 135;
            }
        }

        private function keyPress(event:KeyboardEvent):void
        {
            switch(event.keyCode)
            {
                case Keyboard.W:
                    movingUp = true;
                    break;

                case Keyboard.S:
                    movingDown = true;
                    break;

                case Keyboard.A:
                    movingLeft = true;
                    break;

                case Keyboard.D:
                    movingRight = true;
                    break;
            }
        }
        
        private function keyRelease(event:KeyboardEvent):void
        {
            switch(event.keyCode)
            {
                case Keyboard.W:
                    movingUp = false;
                    break;

                case Keyboard.S:
                    movingDown = false;
                    break;

                case Keyboard.A:
                    movingLeft = false;
                    break;

                case Keyboard.D:
                    movingRight = false;
                    break;
            }
        }
    }
}
