package entities
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    import com.hexagonstar.util.debug.Debug;

    import assets.AssetsManager;
    
    public class Player extends Sprite
    {
        private var assetStanding:MovieClip;
        private var assetWalking:MovieClip;
        private var assetAttackingStanding:MovieClip;
        private var assetAttackingWalking:MovieClip;
        private var id:String;
        
        //Movement variables
        private var speed:int = 4;
        private var movingUp:Boolean = false;
        private var movingDown:Boolean = false;
        private var movingLeft:Boolean = false;
        private var movingRight:Boolean = false;
        private var attacking:Boolean = false;
        
        //Shooting variables
        private var turnSpeed:int;
        private var currentShootingDirection:Number;
        
        public function Player(id:String)
        {
            this.id = id;
            this.assetStanding = AssetsManager.getAsset("PurpleWizardStand");
            this.assetWalking = AssetsManager.getAsset("PurpleWizardWalk");
            this.assetAttackingStanding = AssetsManager.getAsset("PurpleWizardAtack");
            this.assetAttackingWalking = AssetsManager.getAsset("PurpleWizardWalkAtack");
            this.addChild(this.assetStanding);
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
            stage.addEventListener(MouseEvent.MOUSE_MOVE, rotatePlayer, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, attack, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, stopAttack, false, 0, true);
            stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
        }
        
        private function stopListening():void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
            stage.removeEventListener(KeyboardEvent.KEY_UP, keyRelease);
            stage.removeEventListener(Event.ENTER_FRAME, update);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, rotatePlayer);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, attack);
            stage.removeEventListener(MouseEvent.MOUSE_UP, stopAttack);
            this.addEventListener(Event.ADDED_TO_STAGE, startListening, false, 0, true);
        }

        private function update(event:Event):void
        {
            if(attacking && !movingLeft && !movingRight && !movingUp && !movingDown && !this.contains(assetAttackingStanding))
            {
                if(this.contains(assetStanding)) this.removeChild(assetStanding);
                if(this.contains(assetWalking)) this.removeChild(assetWalking);
                if(this.contains(assetAttackingWalking)) this.removeChild(assetAttackingWalking);
                this.addChild(assetAttackingStanding);
            }
            else if(attacking && (movingLeft || movingRight || movingUp || movingDown) && !this.contains(assetAttackingWalking))
            {
                if(this.contains(assetStanding)) this.removeChild(assetStanding);
                if(this.contains(assetWalking)) this.removeChild(assetWalking);
                if(this.contains(assetAttackingStanding)) this.removeChild(assetAttackingStanding);
                this.addChild(assetAttackingWalking);
            }
            else if(!attacking && (movingLeft || movingRight || movingUp || movingDown) && !this.contains(assetWalking))
            {
                if(this.contains(assetStanding)) this.removeChild(assetStanding);
                if(this.contains(assetAttackingWalking)) this.removeChild(assetAttackingWalking);
                if(this.contains(assetAttackingStanding)) this.removeChild(assetAttackingStanding);
                this.addChild(assetWalking);
            }
            else if(!attacking && !movingLeft && !movingRight && !movingUp && !movingDown && !this.contains(assetStanding))
            {
                if(this.contains(assetWalking)) this.removeChild(assetWalking);
                if(this.contains(assetAttackingWalking)) this.removeChild(assetAttackingWalking);
                if(this.contains(assetAttackingStanding)) this.removeChild(assetAttackingStanding);
                this.addChild(assetStanding);
            }
            
            if(movingLeft && !movingRight) x -= speed;
            if(movingRight && !movingLeft) x += speed;
            if(movingUp && !movingDown) y -= speed;
            if(movingDown && !movingUp) y += speed;
        }
        
        private function rotatePlayer(event:MouseEvent):void
        {
            var radians:Number = Math.atan2(event.stageY - y, event.stageX - x);
            var degrees:Number = radians / (Math.PI / 180) + 90;
            rotation = degrees;
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
        
        private function attack(event:MouseEvent):void
        {
            attacking = true;
        }
        
        private function stopAttack(event:MouseEvent):void
        {
            attacking = false;
        }
    }
}
