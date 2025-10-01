package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2686")]
   public class FaceColor extends MovieClip
   {
      
      private var _color:Number;
      
      public function FaceColor()
      {
         super();
      }
      
      public function set color(param1:Number) : *
      {
         _color = param1;
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      public function getRGB() : String
      {
         return "0x" + _color.toString(16);
      }
   }
}

