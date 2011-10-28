package menus
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    /*
    * @author soul248
    */

    public class MainMenu extends Sprite
    {
        private var background:Sprite;
        private var gameLogo:Sprite;
        private var singlePlayerOption:Sprite;
        private var multiPlayerOption:Sprite;

        public function MainMenu()
        {
            //Draw background
            background = new Sprite();
            addChild(background);

            background.x = 0;
            background.y = 0;
            background.graphics.beginFill(0x000FFF);
            background.graphics.drawRect(0, 0, 1024, 768);
            background.graphics.endFill();

            gameLogo = new Sprite();
            addChild(gameLogo);

            gameLogo.x = (1024 / 2) - 250;
            gameLogo.y = 200;
            gameLogo.graphics.beginFill(0xFFF000);
            gameLogo.graphics.drawRect(0, 0, 500, 150);
            gameLogo.graphics.endFill();

            singlePlayerOption = new Sprite();
            singlePlayerOption.addEventListener(MouseEvent.CLICK, singlePlayerOptionClicked, false, 0, true);
            addChild(singlePlayerOption);

            singlePlayerOption.x = (1024 / 2) - 125;
            singlePlayerOption.y = 450;
            singlePlayerOption.graphics.beginFill(0x00FF00);
            singlePlayerOption.graphics.drawRect(0, 0, 250, 50);
            singlePlayerOption.graphics.endFill();

            multiPlayerOption = new Sprite();
            multiPlayerOption.addEventListener(MouseEvent.CLICK, multiPlayerOptionClicked, false, 0, true);
            addChild(multiPlayerOption);

            multiPlayerOption.x = (1024 / 2) - 125;
            multiPlayerOption.y = 550;
            multiPlayerOption.graphics.beginFill(0x00FF00);
            multiPlayerOption.graphics.drawRect(0, 0, 250, 50);
            multiPlayerOption.graphics.endFill();
        }

        private function singlePlayerOptionClicked(mouseEvent:MouseEvent):void
        {
        
        }

        private function multiPlayerOptionClicked(mouseEvent:MouseEvent):void
        {
        
        }
    }
}
