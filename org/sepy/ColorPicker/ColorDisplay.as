package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2680")]
   public class ColorDisplay extends MovieClip
   {
      
      private var face:MovieClip;
      
      public function ColorDisplay()
      {
         super();
         this.useHandCursor = false;
         face = new FaceColor();
         face.name = "face";
         this.addChild(face);
         face.x = 1;
         face.y = 1;
         face.width = 39;
         face.height = 17;
      }
      
      public function set color(param1:Number) : *
      {
         face.color = param1;
      }
      
      public function get color() : Number
      {
         return face.color;
      }
      
      public function getRGB() : String
      {
         return "0x" + face.color.toString(16);
      }
   }
}

