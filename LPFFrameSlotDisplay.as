package
{
   import flash.display.MovieClip;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1895")]
   public class LPFFrameSlotDisplay extends LPFFrame
   {
      
      public var ti:TextField;
      
      private var rootClass:MovieClip;
      
      private var isBank:Boolean = false;
      
      public function LPFFrameSlotDisplay()
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
         positionBy(param1.r);
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("isBank" in param1)
         {
            isBank = param1.isBank == true || param1.isBank == "true" || param1.isBank == 1;
         }
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         fData = {};
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function fDraw() : void
      {
         if(isBank)
         {
            ti.htmlText = "<font color=\'#FFFFFF\'>";
            ti.htmlText += fData.avatar.iBankCount;
            ti.htmlText += "</font><font color=\'#CCCCCC\'> / </font>";
            ti.htmlText += "<font color=\'#FFFFFF\'>";
            ti.htmlText += fData.avatar.objData.iBankSlots;
            ti.htmlText += " </font><font color=\'#CCCCCC\'>Bank Spaces</font>";
         }
         else
         {
            ti.htmlText = "<font color=\'#FFFFFF\'>";
            ti.htmlText += fData.list.length;
            ti.htmlText += "</font><font color=\'#CCCCCC\'> / </font>";
            ti.htmlText += "<font color=\'#FFFFFF\'>";
            ti.htmlText += rootClass.ui.mcPopup.currentLabel == "HouseInventory" || rootClass.ui.mcPopup.currentLabel == "HouseBank" || rootClass.ui.mcPopup.currentLabel == "HouseShop" ? fData.iHouseSlots : fData.iBagSlots;
            ti.htmlText += " </font><font color=\'#CCCCCC\'>Backpack Spaces</font>";
         }
      }
      
      override public function notify(param1:Object) : void
      {
         fDraw();
      }
   }
}

