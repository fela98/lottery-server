package  {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class lib_pixel extends MovieClip {
		var firsty:int = 0;
		var firstx:int = 0;
		var colorT:ColorTransform;
		
		public function setup(RGB:uint,X:int,Y:int) {
			colorT = new ColorTransform();
			colorT.color=RGB;
			this.transform.colorTransform = colorT;
			firsty = Y;
			firstx = X;
			this.x=X;
			this.y=Y;
		}
		
		public function lib_pixel() {
			
		}
	}
	
}
