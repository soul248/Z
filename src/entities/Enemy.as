package entities
{
    public class Enemy extends Sprite
    {
        public function Enemy()
        {
            graphics.beginFill(0x0000FF, 1);
            graphics.drawRect(-20, -50, 30, 50);
            graphics.endFill();
        }

        public function update(player:Player)
        {
            
        }
    }
}
