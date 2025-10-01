package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1988")]
   public class LPFFrameBuySellButton extends LPFFrame
   {
      
      public var btn:MovieClip;
      
      public var ti:TextField;
      
      private var rootClass:MovieClip;
      
      protected var eventType:String = "";
      
      public function LPFFrameBuySellButton()
      {
         super();
         ti.mouseEnabled = false;
         btn.addEventListener(MouseEvent.CLICK,onBtnClick,false,0,true);
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("eventType" in param1)
         {
            eventType = param1.eventType;
         }
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         btn.removeEventListener(MouseEvent.CLICK,onBtnClick);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function fDraw() : void
      {
         if(fData != null && fData.sText != "")
         {
            ti.text = fData.sText;
            visible = true;
         }
         else
         {
            ti.text = "";
            visible = false;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         if("buttonNewEventType" in param1)
         {
            eventType = param1.buttonNewEventType;
         }
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         fDraw();
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         update({
            "eventType":eventType,
            "sModeBroadcast":fData.sModeBroadcast
         });
      }
   }
}

