package org.sepy.ColorPicker
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2677")]
   public class ColorMap extends MovieClip
   {
      
      private var mc:Sprite;
      
      private var cross_Mc:MovieClip;
      
      private var cross_Mask:MovieClip;
      
      public var newMC:*;
      
      private var b:Bitmap;
      
      private var bmp:BitmapData;
      
      private var _color:Number;
      
      private var down:Boolean = false;
      
      public var m_fillType:String = "linear";
      
      public var m_colors:Array = [16711680,16776960,65280,65535,255,16711935,16711680];
      
      public var m_alphas:Array = [100,100,100,100,100,100,100];
      
      public var m_ratios:Array = [0,42,64,127,184,215,255];
      
      public var m_matrix:Matrix = new Matrix();
      
      public function ColorMap()
      {
         super();
         addFrameScript(0,frame1);
         mc = new Sprite();
         mc.name = "mc";
         this.addChild(mc);
         mc.x = 1;
         mc.y = 1;
         cross_Mc = new cross_mc() as MovieClip;
         cross_Mc.name = "cross_mc";
         this.addChild(cross_Mc);
         cross_Mask = new cross_mask() as MovieClip;
         cross_Mask.name = "cross_mask";
         this.addChild(cross_Mask);
         cross_Mc.mask = cross_Mask;
         init();
      }
      
      private function init() : void
      {
         var _loc1_:String = "linear";
         var _loc2_:Array = [16777215,0,0];
         var _loc3_:Array = [0,0,100];
         var _loc4_:Array = [0,127,255];
         var _loc5_:Matrix = new Matrix();
         _loc5_.createGradientBox(175,187,90 * Math.PI / 180);
         m_matrix.createGradientBox(175,187);
         mc.graphics.beginGradientFill(m_fillType,m_colors,m_alphas,m_ratios,m_matrix as Matrix);
         mc.graphics.moveTo(0,0);
         mc.graphics.lineTo(175,0);
         mc.graphics.lineTo(175,187);
         mc.graphics.lineTo(0,187);
         mc.graphics.lineTo(0,0);
         mc.graphics.endFill();
         newMC = new MovieClip();
         newMC.name = "upper";
         mc.addChild(newMC);
         newMC.graphics.beginGradientFill(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_ as Matrix);
         newMC.graphics.moveTo(0,0);
         newMC.graphics.lineTo(175,0);
         newMC.graphics.lineTo(175,187);
         newMC.graphics.lineTo(0,187);
         newMC.graphics.lineTo(0,0);
         newMC.graphics.endFill();
         this.addEventListener(MouseEvent.MOUSE_DOWN,onDown,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,onUp,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_MOVE,onMove,false,0,true);
         this.draw();
      }
      
      private function onDown(param1:MouseEvent) : void
      {
         down = true;
         onMove(param1);
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         down = false;
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(down)
         {
            _loc2_ = bmp.getPixel(mouseX - mc.x - 1,mouseY - mc.y);
            this.cross_Mc.x = mouseX;
            this.cross_Mc.y = mouseY;
            MovieClip(parent).change(this,_loc2_);
         }
      }
      
      private function draw() : void
      {
         bmp = new BitmapData(mc.width,mc.height);
         bmp.draw(mc);
      }
      
      private function change(param1:MovieClip, param2:Number) : *
      {
         _color = param2;
      }
      
      public function set color(param1:Number) : void
      {
         _color = param1;
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      public function findTheColor(param1:Number) : Boolean
      {
         var _loc2_:Rectangle = bmp.getColorBoundsRect(4294967295,4278190080 + param1,true);
         cross_Mc.x = _loc2_.x + _loc2_.width / 2 + 2;
         cross_Mc.y = _loc2_.y + _loc2_.height / 2 + 2;
         return !(_loc2_.x == 0 && _loc2_.y == 0 && _loc2_.width == bmp.width && _loc2_.width == bmp.height);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

