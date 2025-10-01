package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.*;
   import flash.ui.Keyboard;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1903")]
   public class LPFFrameQtySelector extends LPFFrame
   {
      
      public var t1:TextField;
      
      public var t2:TextField;
      
      public var handle:MovieClip;
      
      public var bar:MovieClip;
      
      private var _min:int = 1;
      
      private var _max:int = 1;
      
      private var isMouseDown:Boolean = false;
      
      private var _p:Point = new Point();
      
      private var _n:Number = 0;
      
      private var _w:int = 0;
      
      private var _dx:int = 0;
      
      private var rootClass:MovieClip;
      
      protected var eventType:String = "";
      
      public function LPFFrameQtySelector()
      {
         super();
         visible = false;
         _w = bar.width - handle.width;
         t1.restrict = "0123456789";
         t1.maxChars = 4;
         handle.buttonMode = true;
      }
      
      private function get qty_container() : *
      {
         return MovieClip(MovieClip(parent).parent);
      }
      
      public function get _val() : int
      {
         return qty_container.iQty;
      }
      
      public function set _val(param1:int) : void
      {
         qty_container.iQty = param1;
         t1.text = String(param1);
      }
      
      public function get val() : int
      {
         var _loc1_:int = int(t1.text);
         if(getLayout().sMode == "shopBuy")
         {
            _loc1_ = fData.iQty * Math.floor(_loc1_ / fData.iQty);
         }
         if(_val != _loc1_)
         {
            _val = _loc1_;
         }
         _val = Math.max(Math.min(_val,_max),_min);
         return _val;
      }
      
      public function set val(param1:int) : void
      {
         var _loc2_:int = param1;
         if(getLayout().sMode == "shopBuy")
         {
            _loc2_ = fData.iQty * Math.floor(param1 / fData.iQty);
         }
         _val = Math.max(Math.min(_loc2_,_max),_min);
      }
      
      private function updateValues() : void
      {
         if(_val == _max)
         {
            t1.htmlText = "<font color=\'#FFFFFF\'>" + _val + "</font>";
         }
         else
         {
            t1.htmlText = "<font color=\'#999999\'>" + _val + "</font>";
         }
         update({"eventType":"updateQtyValue"});
      }
      
      private function updateHandle() : void
      {
         handle.x = Math.round(bar.x + _w * (_val / _max));
      }
      
      private function onEF(param1:Event) : void
      {
         if(isMouseDown)
         {
            _p.x = stage.mouseX;
            _p.y = stage.mouseY;
            _p = globalToLocal(_p);
            _p.x -= _dx;
            handle.x = _n = Math.max(Math.min(_p.x,bar.x + _w),bar.x);
            _n -= bar.x;
            _n /= _w;
            val = Math.round(_n * _max);
            updateValues();
         }
      }
      
      private function onDn(param1:MouseEvent) : void
      {
         isMouseDown = true;
         _p.x = stage.mouseX;
         _p.y = stage.mouseY;
         _p = globalToLocal(_p);
         _dx = _p.x - handle.x;
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         isMouseDown = false;
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         if(param1.charCode == Keyboard.ENTER || param1.charCode == Keyboard.ESCAPE)
         {
            val;
            updateValues();
            updateHandle();
            rootClass.stage.focus = null;
         }
      }
      
      override public function fOpen(param1:Object) : void
      {
         visible = false;
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         getLayout().registerForEvents(this,eventTypes);
         fDraw();
         stage.addEventListener(MouseEvent.MOUSE_UP,onUp,false,0,true);
         addEventListener(Event.ENTER_FRAME,onEF,false,0,true);
         handle.addEventListener(MouseEvent.MOUSE_DOWN,onDn,false,0,true);
         t1.addEventListener(KeyboardEvent.KEY_DOWN,onKey,false,0,true);
         t2.addEventListener(MouseEvent.CLICK,onMax,false,0,true);
      }
      
      private function onMax(param1:MouseEvent) : void
      {
         val = _max;
         updateValues();
         updateHandle();
      }
      
      override public function fClose() : void
      {
         removeEventListener(Event.ENTER_FRAME,onEF);
         handle.removeEventListener(MouseEvent.MOUSE_UP,onDn);
         stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function fDraw() : void
      {
         if(fData != null)
         {
            if(getLayout().sMode == "shopSell")
            {
               _val = _min = 1;
               _max = rootClass.world.maximumShopSells(fData);
            }
            else
            {
               _val = _min = fData.iQty;
               _max = rootClass.world.maximumShopBuys(fData);
            }
            val;
            updateValues();
            updateHandle();
            t2.htmlText = "<font color=\'#FFFFFF\'>" + _max + "</font>";
            visible = true;
         }
         else
         {
            visible = false;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         if(param1.eventType == "listItemASel")
         {
            if("fData" in param1 && Boolean(param1.fData.hasOwnProperty("iSel")))
            {
               if(rootClass.ui.mcPopup.currentLabel == "EnhShop")
               {
                  return;
               }
               if(getLayout().sMode == "shopBuy" && (rootClass.world.maximumShopBuys(param1.fData.iSel) < 2 || param1.fData.iSel.bCoins == 1 && param1.fData.iSel.iCost > 0))
               {
                  fData = null;
               }
               else if(getLayout().sMode == "shopSell" && rootClass.world.maximumShopSells(param1.fData.iSel) < 2)
               {
                  fData = null;
               }
               else
               {
                  fData = param1.fData.iSel;
               }
            }
            fDraw();
         }
      }
   }
}

