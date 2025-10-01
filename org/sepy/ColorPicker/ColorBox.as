package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   import flash.geom.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2689")]
   public class ColorBox extends MovieClip
   {
      
      private var faceMC:MovieClip;
      
      private var face_border:MovieClip;
      
      private var colorObj:Object;
      
      public function ColorBox(param1:Object)
      {
         super();
         colorObj = param1;
         this.useHandCursor = false;
         faceMC = new FaceColor() as MovieClip;
         faceMC.name = "face";
         this.addChild(faceMC);
         faceMC.transform.colorTransform = new ColorTransform(1,1,1,1,param1.red,param1.green,param1.blue,0);
         face_border = new face_borders() as MovieClip;
         face_border.name = "face_border";
         this.addChild(face_border);
      }
      
      public function get color() : Object
      {
         return colorObj;
      }
      
      public function getRGB() : String
      {
         return "0x" + faceMC.color.toString(16);
      }
   }
}

