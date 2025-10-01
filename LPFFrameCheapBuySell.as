package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1986")]
   public class LPFFrameCheapBuySell extends LPFFrame
   {
      
      public var btnBuy:MovieClip;
      
      public var btnSell:MovieClip;
      
      private var rootClass:MovieClip;
      
      protected var eventType:String = "";
      
      public function LPFFrameCheapBuySell()
      {
         super();
         btnBuy.addEventListener(MouseEvent.CLICK,onBtnBuyClick,false,0,true);
         btnBuy.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
         btnBuy.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
         btnSell.addEventListener(MouseEvent.CLICK,onBtnSellClick,false,0,true);
         btnSell.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
         btnSell.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
         btnBuy.buttonMode = true;
         btnSell.buttonMode = true;
         btnBuy.sel = btnBuy.bg2.visible = btnBuy.bg3.visible = false;
         btnSell.sel = btnSell.bg2.visible = btnSell.bg3.visible = false;
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         if("eventType" in param1)
         {
            eventType = param1.eventType;
         }
         if("openOn" in param1)
         {
            if(param1.openOn == "shopBuy")
            {
               select(btnBuy);
            }
            if(param1.openOn == "shopSell")
            {
               select(btnSell);
            }
         }
      }
      
      override public function fClose() : void
      {
         btnBuy.removeEventListener(MouseEvent.CLICK,onBtnBuyClick);
         btnBuy.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnBuy.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnSell.removeEventListener(MouseEvent.CLICK,onBtnSellClick);
         btnSell.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnSell.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function fDraw() : void
      {
      }
      
      override public function notify(param1:Object) : void
      {
      }
      
      private function onBtnSellClick(param1:MouseEvent) : void
      {
         if(!btnSell.sel)
         {
            rootClass.mixer.playSound("Click");
            unselect(btnBuy);
            select(btnSell);
            update({
               "eventType":eventType,
               "sModeBroadcast":"shopSell"
            });
         }
      }
      
      private function onBtnBuyClick(param1:MouseEvent) : void
      {
         if(!btnBuy.sel)
         {
            rootClass.mixer.playSound("Click");
            unselect(btnSell);
            select(btnBuy);
            update({
               "eventType":eventType,
               "sModeBroadcast":"shopBuy"
            });
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!_loc2_.sel)
         {
            _loc2_.bg2.visible = true;
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!_loc2_.sel)
         {
            _loc2_.bg2.visible = false;
         }
      }
      
      private function select(param1:MovieClip) : void
      {
         param1.sel = true;
         param1.bg2.visible = false;
         param1.bg3.visible = true;
         setChildIndex(param1,1);
      }
      
      private function unselect(param1:MovieClip) : void
      {
         param1.sel = false;
         param1.bg2.visible = false;
         param1.bg3.visible = false;
         setChildIndex(param1,0);
      }
   }
}

