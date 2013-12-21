package com.piterwilson.drawing{
    
    public class CakeSlice extends DrawingShape{
        
        public var radius:Number;
        private var _startAngle:Number;
        private var _arc:Number
        
        public function CakeSlice(){
            //deafult
            radius=50;
            _startAngle=0;
            _arc=45;
        }
        
        public function set startAngle(num:Number){
            if(num<=360){
                _startAngle=Math.abs(num)
            }else{
                throw("Start angle cant be more than 360");
            }
        }
        
        public function get startAngle():Number{
            return _startAngle;
        }
        
        public function set arc(num:Number){
            if(num<=360){
                _arc=Math.abs(num)
            }else{
                throw("Sweep angle cant be more than 360");
            }
        }
        
        public function get arc():Number{
            return _arc;
        }
        
        override public function draw(){

            graphics.clear();
            graphics.lineStyle(border,borderColor,borderAlpha);
            graphics.beginFill(fillColor,fillAlpha);
            
            // based on mc.drawWedge() - by Ric Ewing (ric@formequalsfunction.com) - version 1.3 - 6.12.2002
            // adapted for AS3 Juan Ospina (piterwilson@gmail.com) - version 1.0 - 22.8.2008
            var segAngle, theta, angle, angleMid, segs, ax, ay, bx, by, cx, cy;
	       graphics.moveTo(0, 0);
	       // Flash uses 8 segments per circle, to match that, we draw in a maximum
	       // of 45 degree segments. First we calculate how many segments are needed
	       // for our _arc.
	       segs = Math.ceil(Math.abs(_arc)/45);
	       // Now calculate the sweep of each segment.
	       segAngle = _arc/segs;
	       // The math requires radians rather than degrees. To convert from degrees
	       // use the formula (degrees/180)*Math.PI to get radians.
		   theta = -(segAngle/180)*Math.PI;
	       // convert angle _startAngle to radians
	       angle = -(_startAngle/180)*Math.PI;
	       // draw the curve in segments no larger than 45 degrees.
	       if (segs>0) {
		      // draw a line from the center to the start of the curve
		      ax = Math.cos(_startAngle/180*Math.PI)*radius;
		      ay = Math.sin(-_startAngle/180*Math.PI)*radius;
		      graphics.lineTo(ax, ay);
		      // Loop for drawing curve segments
		      for (var i:int = 0; i<segs; i++) {
			     angle += theta;
			     angleMid = angle-(theta/2);
			     bx = Math.cos(angle)*radius;
			     by = Math.sin(angle)*radius;
			     cx = Math.cos(angleMid)*(radius/Math.cos(theta/2));
			     cy = Math.sin(angleMid)*(radius/Math.cos(theta/2));
			     graphics.curveTo(cx, cy, bx, by);
		      }
		  // close the wedge by drawing a line to the center
		  graphics.lineTo(0, 0);
	      }
        }
    //end class
    }

}