package org.sepy.ColorPicker
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2671")]
   public class ColorSlider extends MovieClip
   {
      
      private var mc:MovieClip;
      
      private var slider:MovieClip;
      
      private var _color:Number;
      
      private var bmp:BitmapData;
      
      private var down:Boolean = false;
      
      public function ColorSlider()
      {
         super();
         addFrameScript(0,frame1);
         mc = new MovieClip();
         mc.name = "mc";
         this.addChildAt(mc,1);
         mc.x = 1;
         mc.y = 1;
         mc.useHandCursor = false;
         this.addEventListener(MouseEvent.MOUSE_DOWN,onPressDown,false,0,true);
         slider = new slider_mc();
         slider.name = "slider";
         this.addChildAt(slider,2);
         slider.x = 15;
         slider.y = 98;
      }
      
      private function onPressDown(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,onUp,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove,false,0,true);
         changing(mouseY);
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,onUp,false);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove,false);
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         if(mouseY >= 0 && mouseY <= mc.height)
         {
            changing(mouseY);
         }
      }
      
      private function changing(param1:Number) : *
      {
         slider.y = param1;
         var _loc2_:Number = bmp.getPixel(5,slider.y);
         MovieClip(parent).changing(_loc2_);
      }
      
      public function getCurrentColor() : Number
      {
         return bmp.getPixel(5,slider.y);
      }
      
      public function set color(param1:Number) : void
      {
         _color = param1;
         draw();
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      private function draw() : void
      {
         mc.graphics.clear();
         var _loc1_:Array = [0,color,16777215];
         var _loc2_:Array = [100,100,100];
         var _loc3_:Array = [0,127,255];
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(187,187,270 * Math.PI / 180);
         mc.graphics.clear();
         mc.graphics.beginGradientFill("linear",_loc1_,_loc2_,_loc3_,_loc4_ as Matrix,"reflect","linear");
         mc.graphics.moveTo(0,0);
         mc.graphics.lineTo(12,0);
         mc.graphics.lineTo(12,187);
         mc.graphics.lineTo(0,187);
         mc.graphics.lineTo(0,0);
         mc.graphics.endFill();
         bmp = new BitmapData(mc.width,mc.height,false);
         bmp.draw(mc);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

