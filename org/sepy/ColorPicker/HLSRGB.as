package org.sepy.ColorPicker
{
   internal class HLSRGB
   {
      
      private var _red:Number = 0;
      
      private var _green:Number = 0;
      
      private var _blue:Number = 0;
      
      private var _hue:Number = 0;
      
      private var _luminance:Number = 0;
      
      private var _saturation:Number = 0;
      
      public function HLSRGB()
      {
         super();
      }
      
      public function get red() : Number
      {
         return _red;
      }
      
      public function set red(param1:Number) : void
      {
         _red = param1;
         ToHLS();
      }
      
      public function get green() : Number
      {
         return _green;
      }
      
      public function set green(param1:Number) : void
      {
         _green = param1;
         ToHLS();
      }
      
      public function get blue() : Number
      {
         return _blue;
      }
      
      public function set blue(param1:Number) : void
      {
         _blue = param1;
         ToHLS();
      }
      
      public function get luminance() : Number
      {
         return _luminance;
      }
      
      public function set luminance(param1:Number) : void
      {
         if(!(param1 < 0 || param1 > 1))
         {
            _luminance = param1;
            ToRGB();
         }
      }
      
      public function get hue() : Number
      {
         return _hue;
      }
      
      public function set hue(param1:Number) : void
      {
         if(!(param1 < 0 || param1 > 360))
         {
            _hue = param1;
            ToRGB();
         }
      }
      
      public function get saturation() : Number
      {
         return _saturation;
      }
      
      public function set saturation(param1:Number) : void
      {
         if(!(param1 < 0 || param1 > 1))
         {
            _saturation = param1;
            ToRGB();
         }
      }
      
      public function get color() : RGB
      {
         return new RGB(_red,_green,_blue);
      }
      
      public function getRGB() : Number
      {
         return _red << 16 | _green << 8 | _blue;
      }
      
      public function set color(param1:RGB) : void
      {
         _red = param1.r;
         _green = param1.g;
         _blue = param1.b;
         ToHLS();
      }
      
      public function lightenBy(param1:Number) : void
      {
         _luminance *= 1 + param1;
         if(_luminance > 1)
         {
            _luminance = 1;
         }
         ToRGB();
      }
      
      public function darkenBy(param1:Number) : void
      {
         _luminance *= param1;
         ToRGB();
      }
      
      private function ToHLS() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Number = Math.min(_red,Math.min(_green,_blue));
         var _loc2_:Number = Math.max(_red,Math.max(_green,_blue));
         var _loc3_:Number = _loc2_ - _loc1_;
         var _loc4_:Number = _loc2_ + _loc1_;
         _luminance = _loc4_ / 510;
         if(_loc2_ == _loc1_)
         {
            _saturation = 0;
            _hue = 0;
         }
         else
         {
            _loc5_ = (_loc2_ - _red) / _loc3_;
            _loc6_ = (_loc2_ - _green) / _loc3_;
            _loc7_ = (_loc2_ - _blue) / _loc3_;
            _saturation = _luminance <= 0.5 ? _loc3_ / _loc4_ : _loc3_ / (510 - _loc4_);
            if(_red == _loc2_)
            {
               _hue = 60 * (6 + _loc7_ - _loc6_);
            }
            else if(_green == _loc2_)
            {
               _hue = 60 * (2 + _loc5_ - _loc7_);
            }
            else if(_blue == _loc2_)
            {
               _hue = 60 * (4 + _loc6_ - _loc5_);
            }
            _hue %= 360;
         }
      }
      
      private function ToRGB() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(_saturation == 0)
         {
            _red = _green = _blue = _luminance * 255;
         }
         else
         {
            if(_luminance <= 0.5)
            {
               _loc2_ = _luminance + _luminance * _saturation;
            }
            else
            {
               _loc2_ = _luminance + _saturation - _luminance * _saturation;
            }
            _loc1_ = 2 * _luminance - _loc2_;
            _red = ToRGB1(_loc1_,_loc2_,_hue + 120);
            _green = ToRGB1(_loc1_,_loc2_,_hue);
            _blue = ToRGB1(_loc1_,_loc2_,_hue - 120);
         }
      }
      
      private function ToRGB1(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param3 > 360)
         {
            param3 -= 360;
         }
         else if(param3 < 0)
         {
            param3 += 360;
         }
         if(param3 < 60)
         {
            param1 += (param2 - param1) * param3 / 60;
         }
         else if(param3 < 180)
         {
            param1 = param2;
         }
         else if(param3 < 240)
         {
            param1 += (param2 - param1) * (240 - param3) / 60;
         }
         return param1 * 255;
      }
      
      public function toString() : String
      {
         return "[R:" + red + ", G:" + green + ", B:" + blue + ", H:" + hue + ", S:" + saturation + ", L:" + luminance + "]";
      }
   }
}

