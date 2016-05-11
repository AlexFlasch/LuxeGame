import luxe.Entity;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Visual;
import luxe.options.VisualOptions;

class Player extends Sprite{
	
	var arrow:Visual;
	
	public function new() {
		
		super({
            name: 'player',
            pos: Luxe.screen.mid,
            color: new Color().rgb(0x3498DB),
            size: new Vector(128, 128)
        });
		
		this.add(new Reticle());
		
	}
	
} // Player