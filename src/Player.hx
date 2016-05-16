import luxe.Entity;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.Input;

class Player extends Sprite{
	
	var arrow:Visual;
	var lastMousePos:Vector;
	
	public function new() {
		
		super({
            name: 'player',
            pos: Luxe.screen.mid,
            color: new Color().rgb(0x3498DB),
            size: new Vector(128, 128)
        });
		
		var arrowOptions:VisualOptions = {
            size: new Vector(16, 16),
            color: new Color().rgb(0x3498DB),
            geometry: Luxe.draw.ngon({
                r: 32,
                sides: 3,
                color: new Color().rgb(0x3498DB),
                solid: true,
                x: Luxe.screen.mid.x,
                y: Luxe.screen.mid.y - 144
            }),
            no_geometry: false
        };
        
        arrow = new Visual(arrowOptions);
        arrow.pos = this.pos;
        arrow.origin = new Vector(this.pos.x, this.pos.y);
		
	}
	
	override function onmousemove(e:MouseEvent) {
        
        arrow.rotation_z = Math.atan2(e.pos.y - this.pos.y, e.pos.x - this.pos.x) * 180 / Math.PI + 90;
        lastMousePos = e.pos;
        
    } // onmousemove
    
    override function update(dt:Float) {
        
        // arrow.rotation_z = Math.atan2(lastMousePos.y - this.pos.y, lastMousePos.x - this.pos.x) * 180 / Math.PI + 90;
        // arrow.pos = this.pos;
        
    } // update
	
} // Player