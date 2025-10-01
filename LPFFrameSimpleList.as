package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.*;
   import liteAssets.draw.mergeScroll;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1893")]
   public class LPFFrameSimpleList extends LPFFrame
   {
      
      public var bg:MovieClip;
      
      public var iList:MovieClip;
      
      public var ti:TextField;
      
      private var rootClass:MovieClip;
      
      private var r:Object;
      
      internal var maskMC:Shape;
      
      internal var scrollMC:mergeScroll;
      
      internal var mDown:Boolean = false;
      
      internal var hRun:int = 0;
      
      internal var dRun:int = 0;
      
      internal var mbY:int = 0;
      
      internal var mhY:int = 0;
      
      internal var mbD:int = 0;
      
      public function LPFFrameSimpleList()
      {
         super();
         x = 0;
         y = 0;
         fData = null;
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         if("fData" in param1)
         {
            fData = param1.fData;
         }
         r = param1.r;
         w = int(r.w);
         ti.autoSize = "left";
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("msg" in fData && fData.msg.length > 0)
         {
            ti.htmlText = fData.msg;
         }
         fDraw();
         positionBy(r);
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         fData = null;
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function fDraw() : void
      {
         var _loc1_:LPFElementSimpleItem = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         while(iList.numChildren > 0)
         {
            iList.removeChildAt(0);
         }
         if(scrollMC)
         {
            scrollMC.visible = false;
            scrollMC.h.y = 0;
            iList.y = 0;
            bg.height = iList.height + 1;
            ti.y = bg.height + 2;
            scrollMC.hit.removeEventListener(MouseEvent.MOUSE_DOWN,merge_scrDown);
            scrollMC.h.removeEventListener(Event.ENTER_FRAME,merge_hEF);
            iList.removeEventListener(Event.ENTER_FRAME,merge_dEF);
            removeEventListener(MouseEvent.MOUSE_WHEEL,onMergeBoxScroll);
            removeChild(scrollMC);
            removeChild(maskMC);
            scrollMC = null;
            maskMC = null;
            iList.mask = null;
         }
         if(fData != null && fData.turnin != null)
         {
            _loc4_ = fData.turnin;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc6_];
               _loc1_ = new LPFElementSimpleItem();
               _loc2_ = iList.addChild(_loc1_);
               _loc1_.fOpen({"fData":_loc5_});
               if(_loc6_ > 0)
               {
                  _loc3_ = iList.getChildAt(_loc6_ - 1);
                  _loc2_.y = _loc3_.y + _loc3_.height;
               }
               _loc2_.x = int(w / 2 - _loc2_.width / 2);
               _loc6_++;
            }
            bg.height = int(iList.height + iList.y * 2) + 1;
            bg.width = int(w);
            ti.width = int(w - 2);
            if(ti.htmlText.length > 0)
            {
               ti.y = bg.height + 2;
               ti.visible = true;
            }
            else
            {
               ti.visible = false;
            }
            visible = true;
            if(_loc4_.length >= 5)
            {
               bg.height = 166;
               maskMC = new Shape();
               maskMC.graphics.beginFill(0);
               maskMC.graphics.drawRect(0,0,bg.width,bg.height);
               maskMC.graphics.endFill();
               addChild(maskMC);
               maskMC.name = "maskMC";
               maskMC.x = bg.x;
               maskMC.y = bg.y;
               iList.mask = maskMC;
               scrollMC = new mergeScroll();
               addChild(scrollMC);
               scrollMC.name = "scrollMC";
               scrollMC.x = bg.x + bg.width - scrollMC.width / 2;
               scrollMC.y = bg.y + 5;
               scrollMC.height = bg.height - 10;
               scrollMC.h.height /= 2;
               hRun = scrollMC.b.height - scrollMC.h.height;
               dRun = int(iList.height + iList.y * 2) + 1 - maskMC.height + 5;
               scrollMC.h.y = 0;
               iList.y = 0;
               iList.oy = iList.y;
               scrollMC.hit.alpha = 0;
               mDown = false;
               scrollMC.hit.addEventListener(MouseEvent.MOUSE_DOWN,merge_scrDown,false,0,true);
               scrollMC.h.addEventListener(Event.ENTER_FRAME,merge_hEF,false,0,true);
               iList.addEventListener(Event.ENTER_FRAME,merge_dEF,false,0,true);
               ti.y = bg.height + 2;
               addEventListener(MouseEvent.MOUSE_WHEEL,onMergeBoxScroll,false,0,true);
            }
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
            fData = null;
            if(param1.fData != null && param1.fData.oSel != null)
            {
               fData = param1.fData.oSel;
            }
            fDraw();
            positionBy(r);
         }
         if(param1.eventType == "refreshItems")
         {
            fDraw();
            positionBy(r);
         }
         if(param1.eventType == "updateQtyValue")
         {
            fDraw();
            positionBy(r);
         }
      }
      
      private function merge_scrDown(param1:MouseEvent) : *
      {
         mbY = int(param1.currentTarget.parent.mouseY);
         mhY = int(MovieClip(param1.currentTarget.parent).h.y);
         mDown = true;
         rootClass.stage.addEventListener(MouseEvent.MOUSE_UP,merge_scrUp,false,0,true);
      }
      
      private function merge_scrUp(param1:MouseEvent) : *
      {
         mDown = false;
         rootClass.stage.removeEventListener(MouseEvent.MOUSE_UP,merge_scrUp);
      }
      
      private function merge_hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = MovieClip(param1.currentTarget.parent);
            mbD = int(param1.currentTarget.parent.mouseY) - mbY;
            _loc2_.h.y = mhY + mbD;
            if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
            {
               _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
            }
            if(_loc2_.h.y < 0)
            {
               _loc2_.h.y = 0;
            }
         }
      }
      
      private function merge_dEF(param1:Event) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget.parent).getChildByName("scrollMC");
         var _loc3_:* = MovieClip(param1.currentTarget);
         var _loc4_:* = -_loc2_.h.y / hRun;
         var _loc5_:* = int(_loc4_ * dRun) + _loc3_.oy;
         if(Math.abs(_loc5_ - _loc3_.y) > 0.2)
         {
            _loc3_.y += (_loc5_ - _loc3_.y) / 4;
         }
         else
         {
            _loc3_.y = _loc5_;
         }
      }
      
      public function onMergeBoxScroll(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget.getChildByName("scrollMC"));
         _loc2_.h.y += param1.delta * -1 * 6;
         if(_loc2_.h.y < 0)
         {
            _loc2_.h.y = 0;
         }
         if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
         {
            _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
         }
      }
   }
}

