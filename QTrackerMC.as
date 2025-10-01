package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2729")]
   public class QTrackerMC extends MovieClip
   {
      
      public var bMask:MovieClip;
      
      public var bg:MovieClip;
      
      public var scr:MovieClip;
      
      public var close:SimpleButton;
      
      public var txtDetail:TextField;
      
      public var rootClass:MovieClip;
      
      internal var mDown:Boolean = false;
      
      internal var mbY:*;
      
      internal var mhY:*;
      
      internal var drag:Object = new Object();
      
      public function QTrackerMC()
      {
         super();
         addFrameScript(0,frame1);
         visible = false;
      }
      
      private function initOpen() : void
      {
         rootClass = MovieClip(this.stage.getChildAt(0));
         scr.hit.alpha = 0;
         txtDetail.autoSize = "left";
         close.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,onMoveClick,false,0,true);
      }
      
      private function onCloseClick(param1:MouseEvent) : void
      {
         visible = false;
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         bg.visible = true;
         scr.visible = txtDetail.height > scr.height;
         close.visible = true;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         bg.visible = false;
         scr.visible = false;
         close.visible = false;
      }
      
      public function updateQuest() : void
      {
         var _loc2_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         txtDetail.htmlText = "";
         var _loc1_:int = 0;
         for(_loc2_ in rootClass.world.questTree)
         {
            _loc4_ = rootClass.world.questTree[_loc2_];
            if(_loc4_.status != null)
            {
               _loc1_++;
               txtDetail.htmlText += "<font color=\'#00CC00\'><b>" + _loc4_.sName + "</b></font>";
               if(_loc4_.turnin != null && _loc4_.turnin.length > 0)
               {
                  _loc5_ = "";
                  _loc6_ = 0;
                  while(_loc6_ < _loc4_.turnin.length)
                  {
                     _loc7_ = rootClass.world.invTree[_loc4_.turnin[_loc6_].ItemID];
                     _loc8_ = _loc7_.sName;
                     _loc9_ = int(_loc4_.turnin[_loc6_].iQty);
                     if(_loc6_ > 0)
                     {
                        _loc5_ += ",<br>";
                     }
                     _loc5_ += "    " + _loc8_ + " " + _loc7_.iQty + "/" + _loc9_;
                     _loc6_++;
                  }
                  txtDetail.htmlText += _loc5_;
               }
            }
         }
         if(_loc1_ == 0)
         {
            txtDetail.htmlText = "You are not on any quest!";
         }
         close.x = txtDetail.x + txtDetail.textWidth + 10;
         bg.width = close.x + 20;
         var _loc3_:* = txtDetail.y + txtDetail.textHeight + 10;
         if(_loc3_ > 108)
         {
            _loc3_ = 108;
         }
         bg.height = _loc3_;
         if(txtDetail.height > scr.height)
         {
            scr.visible = true;
            scr.x = close.x + 5;
            scr.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
         }
         else
         {
            scr.visible = false;
         }
      }
      
      private function scrDown(param1:MouseEvent) : *
      {
         mDown = true;
         mbY = int(mouseY);
         mhY = int(MovieClip(param1.currentTarget.parent).h.y);
         stage.addEventListener(MouseEvent.MOUSE_UP,scrUp,false,0,true);
         scr.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
      }
      
      private function scrUp(param1:MouseEvent) : *
      {
         mDown = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,scrUp);
         scr.h.addEventListener(Event.ENTER_FRAME,hEF);
      }
      
      private function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(mDown)
         {
            scr.h.y = mhY + (int(mouseY) - mbY);
            if(scr.h.y + scr.h.height > scr.b.height)
            {
               scr.h.y = int(scr.b.height - scr.h.height);
            }
            if(scr.h.y < 0)
            {
               scr.h.y = 0;
            }
            _loc2_ = -scr.h.y / (scr.b.height - scr.h.height);
            _loc3_ = txtDetail.height - scr.b.height;
            _loc4_ = int(_loc2_ * _loc3_) + 22;
            txtDetail.y = _loc4_;
         }
      }
      
      public function toggle() : void
      {
         if(rootClass.litePreference.data.bDisQTracker)
         {
            visible = false;
            return;
         }
         visible = !visible;
         if(visible)
         {
            updateQuest();
         }
      }
      
      public function onMoveClick(param1:MouseEvent) : void
      {
         if(param1.target != close && param1.target != scr.hit)
         {
            drag.ox = this.x;
            drag.oy = this.y;
            drag.mox = stage.mouseX;
            drag.moy = stage.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_UP,onMoveRelease,false,0,true);
            this.addEventListener(Event.ENTER_FRAME,onMoveEnterFrame,false,0,true);
         }
      }
      
      public function onMoveRelease(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,onMoveRelease);
         this.removeEventListener(Event.ENTER_FRAME,onMoveEnterFrame);
      }
      
      public function onMoveEnterFrame(param1:Event) : *
      {
         this.x = drag.ox + (stage.mouseX - drag.mox);
         if(this.x < 0)
         {
            this.x = 0;
         }
         if(this.x + bg.width > 960)
         {
            this.x = 960 - bg.width;
         }
         this.y = drag.oy + (stage.mouseY - drag.moy);
         if(this.y < 0)
         {
            this.y = 0;
         }
         if(this.y + bg.height > 500)
         {
            this.y = 500 - bg.height;
         }
      }
      
      internal function frame1() : *
      {
         initOpen();
         stop();
      }
   }
}

