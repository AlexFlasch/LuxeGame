import luxe.Component;
import luxe.Visual;
import luxe.options.VisualOptions;
import luxe.Vector;
import luxe.Color;
import luxe.Sprite;
import luxe.Input;

class Reticle extends Component {
    
    var arrow:Visual;
    var player:Sprite;
	
	override function init() {
        
        player = cast entity;
        
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
        arrow.pos = player.pos;
        arrow.origin = new Vector(player.pos.x, player.pos.y);
        
    } // init
    
    override function onmousemove(e:MouseEvent) {
        
        arrow.rotation_z = Math.atan2(e.pos.y - player.pos.y, e.pos.x - player.pos.x) * 180 / Math.PI + 90;
        
    }
	
}