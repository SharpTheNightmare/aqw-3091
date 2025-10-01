package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2661")]
   public class CancelButton extends MovieClip
   {
      
      public function CancelButton()
      {
         super();
         addFrameScript(0,frame1);
         useHandCursor = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,onRollOver,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,onRollOut,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,onPress,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,onRelease,false,0,true);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         this.gotoAndStop(1);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         gotoAndStop(1);
      }
      
      internal function onPress(param1:MouseEvent) : void
      {
         gotoAndStop(2);
      }
      
      internal function onRelease(param1:MouseEvent) : void
      {
         gotoAndStop(1);
         MovieClip(parent).click(this);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

