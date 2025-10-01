package org.sepy.ColorPicker
{
   public class RGB
   {
      
      private var _r:Number;
      
      private var _g:Number;
      
      private var _b:Number;
      
      public function RGB(param1:Number, param2:Number, param3:Number)
      {
         super();
         _r = param1;
         _g = param2;
         _b = param3;
      }
      
      public function set r(param1:Number) : void
      {
         _r = param1;
      }
      
      public function get r() : Number
      {
         return _r;
      }
      
      public function set g(param1:Number) : void
      {
         _g = param1;
      }
      
      public function get g() : Number
      {
         return _g;
      }
      
      public function set b(param1:Number) : void
      {
         _b = param1;
      }
      
      public function get b() : Number
      {
         return _b;
      }
      
      public function getRGB() : Number
      {
         return r << 16 | g << 8 | b;
      }
      
      public function toString() : String
      {
         return "[R:" + r + ", G:" + g + ", B:" + b + "]";
      }
   }
}

