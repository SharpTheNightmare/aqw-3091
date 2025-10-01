package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1957")]
   public class LPFFrameGoldDisplay extends LPFFrame
   {
      
      public var btnHelp:MovieClip;
      
      public var mcCoins:MovieClip;
      
      public var mcGold:MovieClip;
      
      private var rootClass:MovieClip;
      
      public function LPFFrameGoldDisplay()
      {
         super();
         x = 0;
         y = 0;
         fData = {};
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         fData = param1.fData;
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         fDraw();
         positionBy(param1.r);
         getLayout().registerForEvents(this,eventTypes);
         mcCoins.addEventListener(MouseEvent.MOUSE_OVER,onCoinsTTOver,false,0,true);
         mcCoins.addEventListener(MouseEvent.MOUSE_OUT,onTTOut,false,0,true);
         mcGold.addEventListener(MouseEvent.MOUSE_OVER,onGoldTTOver,false,0,true);
         mcGold.addEventListener(MouseEvent.MOUSE_OUT,onTTOut,false,0,true);
         btnHelp.addEventListener(MouseEvent.CLICK,onHelpClick,false,0,true);
         btnHelp.addEventListener(MouseEvent.MOUSE_OVER,onHelpTTOver,false,0,true);
         btnHelp.addEventListener(MouseEvent.MOUSE_OUT,onTTOut,false,0,true);
      }
      
      override public function fClose() : void
      {
         mcCoins.removeEventListener(MouseEvent.MOUSE_OVER,onCoinsTTOver);
         mcCoins.removeEventListener(MouseEvent.MOUSE_OUT,onTTOut);
         mcGold.removeEventListener(MouseEvent.MOUSE_OVER,onGoldTTOver);
         mcGold.removeEventListener(MouseEvent.MOUSE_OUT,onTTOut);
         btnHelp.removeEventListener(MouseEvent.CLICK,onHelpClick);
         btnHelp.removeEventListener(MouseEvent.MOUSE_OVER,onHelpTTOver);
         btnHelp.removeEventListener(MouseEvent.MOUSE_OUT,onTTOut);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function fDraw() : void
      {
         mcGold.ti.htmlText = "<font color=\'#FFFFFF\'>" + rootClass.strNumWithCommas(fData.intGold) + "</font><font color=\'#E0B300\'>g</font>";
         mcCoins.ti.text = rootClass.strNumWithCommas(fData.intCoins);
         mcGold.hit.width = mcGold.ti.x + mcGold.ti.textWidth + 2;
         mcGold.hit.alpha = 0;
         mcCoins.hit.width = mcCoins.ti.x + mcCoins.ti.textWidth + 2;
         mcCoins.hit.alpha = 0;
         btnHelp.x = mcCoins.x + mcCoins.hit.width + 20;
      }
      
      override public function notify(param1:Object) : void
      {
         if(param1.eventType == "refreshCoins")
         {
            fDraw();
         }
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         onTTOut();
         update({"eventType":"helpAC"});
      }
      
      private function onHelpTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"How do I get Adventure Coins?"});
      }
      
      private function onCoinsTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Adventure Coins"});
      }
      
      private function onGoldTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Gold"});
      }
      
      private function onTTOut(param1:MouseEvent = null) : void
      {
         rootClass.ui.ToolTip.close();
      }
   }
}

