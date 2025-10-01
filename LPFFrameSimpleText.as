package
{
   import flash.display.MovieClip;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1888")]
   public class LPFFrameSimpleText extends LPFFrame
   {
      
      public var ti:TextField;
      
      private var rootClass:MovieClip;
      
      public function LPFFrameSimpleText()
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
         positionBy(param1.r);
         fDraw();
         positionBy(param1.r);
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
      
      private function fDraw(param1:Boolean = true) : void
      {
         if(param1)
         {
            ti.width = w;
            ti.autoSize = "left";
            ti.wordWrap = true;
            ti.htmlText = fData.msg;
         }
         else
         {
            visible = false;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         if("fData" in param1 && "msg" in param1.fData)
         {
            fData = param1.fData;
         }
         if("r" in param1)
         {
            positionBy(param1.r);
         }
         if(param1.eventType == "listItemASel")
         {
            fDraw(param1.fData.iSel != null);
         }
      }
   }
}

