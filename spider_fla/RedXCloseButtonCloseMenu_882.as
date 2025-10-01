package spider_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol143")]
   public dynamic class RedXCloseButtonCloseMenu_882 extends MovieClip
   {
      
      public var btnClose:SimpleButton;
      
      public function RedXCloseButtonCloseMenu_882()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function onButtonPress(param1:MouseEvent) : void
      {
         MovieClip(parent).gotoAndPlay("Close");
      }
      
      internal function frame1() : *
      {
         btnClose.addEventListener(MouseEvent.MOUSE_DOWN,onButtonPress,false,0,true);
      }
   }
}

