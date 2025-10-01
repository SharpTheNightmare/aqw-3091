package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2684")]
   public class AdvancedColorButton extends MovieClip
   {
      
      public function AdvancedColorButton()
      {
         super();
         addFrameScript(0,frame1);
         useHandCursor = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,onRollOver,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,onRollOut,false,0,true);
         this.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         gotoAndStop(2);
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         gotoAndStop(1);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         MovieClip(parent.parent).click(this);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

