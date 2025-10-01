package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1964")]
   public class LPFFrameGenericButton extends LPFFrame
   {
      
      public var t1:TextField;
      
      public var t2:TextField;
      
      public var btn1:SimpleButton;
      
      public var btn2:SimpleButton;
      
      private var rootClass:MovieClip;
      
      protected var eventType:String = "";
      
      public function LPFFrameGenericButton()
      {
         super();
         t1.mouseEnabled = false;
         t2.mouseEnabled = false;
         addEventListener(MouseEvent.CLICK,onBtnClick,false,0,true);
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         sMode = "grey";
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         if("buttonNewEventType" in param1)
         {
            eventType = param1.buttonNewEventType;
         }
         if("sMode" in param1)
         {
            sMode = param1.sMode.toLowerCase();
         }
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         removeEventListener(MouseEvent.CLICK,onBtnClick);
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
            if(sMode == "red")
            {
               t1.text = "";
               t2.text = fData.sText;
               btn1.visible = false;
               btn2.visible = true;
            }
            else
            {
               t1.text = fData.sText;
               t2.text = "";
               btn1.visible = true;
               btn2.visible = false;
            }
            visible = true;
         }
         else
         {
            t1.text = "";
            t2.text = "";
            btn1.visible = false;
            btn2.visible = false;
            visible = false;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         if("buttonNewEventType" in param1)
         {
            eventType = param1.buttonNewEventType;
         }
         if("sMode" in param1)
         {
            sMode = param1.sMode.toLowerCase();
         }
         if("r" in param1)
         {
            positionBy(param1.r);
         }
         fDraw();
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         if(eventType != "none")
         {
            rootClass.mixer.playSound("Click");
            if("sModeBroadcast" in fData)
            {
               update({
                  "eventType":eventType,
                  "sModeBroadcast":fData.sModeBroadcast
               });
            }
            else
            {
               update({"eventType":eventType});
            }
         }
      }
   }
}

