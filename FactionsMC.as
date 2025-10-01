package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2715")]
   public class FactionsMC extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public var world:MovieClip;
      
      public var rootClass:MovieClip;
      
      internal var isOpen:Boolean = false;
      
      internal var mc:MovieClip;
      
      internal var mDown:Boolean = false;
      
      internal var hRun:int = 0;
      
      internal var dRun:int = 0;
      
      internal var mbY:int = 0;
      
      internal var mhY:int = 0;
      
      internal var mbD:int = 0;
      
      internal var qly:int = 57;
      
      internal var iRepMax:int = 302500;
      
      public var factions:Array;
      
      public function FactionsMC()
      {
         super();
         addFrameScript(0,frame1,6,frame7,11,frame12,15,frame16);
         mc = MovieClip(this);
         mc.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK,xClick);
      }
      
      public function open() : *
      {
         rootClass = MovieClip(this.stage.getChildAt(0));
         world = rootClass.world;
         factions = world.myAvatar.factions;
         mc = MovieClip(this);
         if(!isOpen)
         {
            isOpen = true;
            mc.cnt.gotoAndPlay("intro");
         }
         else
         {
            isOpen = false;
            fClose();
         }
      }
      
      public function showFactionList() : *
      {
         if(factions.length > 0)
         {
            buildFactionList();
         }
         else
         {
            showEmptyList();
         }
         mc.cnt.fList.visible = true;
         mc.cnt.fList.mHi.visible = false;
         mc.cnt.mouseChildren = true;
      }
      
      private function buildFactionList() : *
      {
         var _loc2_:MovieClip = null;
         var _loc1_:Object = {};
         factions.sortOn("sName");
         var _loc3_:* = 0;
         while(_loc3_ < factions.length)
         {
            _loc1_ = factions[_loc3_];
            if(_loc1_ != null)
            {
               _loc2_ = mc.cnt.fList.addChild(new fProto()) as MovieClip;
               _loc2_.t1.htmlText = _loc1_.sName;
               _loc2_.tRank.htmlText = "Rank " + _loc1_.iRank;
               if(_loc1_.iRank == "10")
               {
                  _loc1_.iSpillRep = 0;
               }
               _loc2_.t2.htmlText = _loc1_.iSpillRep + " <font color=\'#FF0000\'>/</font> " + _loc1_.iRepToRank;
               _loc2_.addEventListener(MouseEvent.MOUSE_OVER,iMouseOver,false,0,true);
               _loc2_.addEventListener(MouseEvent.MOUSE_OUT,iMouseOut,false,0,true);
               _loc2_.hit.alpha = 0;
               _loc2_.y = _loc3_ * 20;
               _loc2_.x = 10;
            }
            _loc3_++;
         }
         var _loc4_:* = mc.cnt.scr;
         var _loc5_:* = mc.cnt.bMask;
         var _loc6_:* = mc.cnt.fList;
         _loc4_.h.height = int(_loc4_.b.height / _loc6_.height * _loc4_.b.height);
         hRun = _loc4_.b.height - _loc4_.h.height;
         dRun = _loc6_.height - _loc4_.b.height + 20;
         _loc4_.h.y = 0;
         _loc6_.oy = _loc6_.y = qly;
         _loc4_.visible = false;
         _loc4_.hit.alpha = 0;
         mDown = false;
         if(_loc6_.height > _loc4_.b.height)
         {
            _loc4_.visible = true;
            _loc4_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
            _loc4_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
            _loc6_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
         }
         mc.cnt.scr.hit.buttonMode = true;
         mc.cnt.fList.iproto.visible = false;
      }
      
      private function fListClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
      }
      
      private function showEmptyList() : *
      {
         var _loc1_:* = mc.cnt.fList.addChild(new fProto());
         _loc1_.t1.htmlText = "<font color=\"#DDDDDD\">No Factions!</font>";
         _loc1_.t2.visible = false;
         _loc1_.tRank.visible = false;
         _loc1_.hit.alpha = 0;
         _loc1_.x = 10;
         mc.cnt.fList.iproto.visible = false;
         mc.cnt.scr.visible = false;
      }
      
      private function scrDown(param1:MouseEvent) : *
      {
         mbY = int(mouseY);
         mhY = int(MovieClip(param1.currentTarget.parent).h.y);
         mDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,scrUp);
      }
      
      private function scrUp(param1:MouseEvent) : *
      {
         mDown = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,scrUp);
      }
      
      private function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = MovieClip(param1.currentTarget.parent);
            mbD = int(mouseY) - mbY;
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
      
      private function dEF(param1:Event) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget.parent).scr;
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
      
      public function xClick(param1:MouseEvent = null) : *
      {
         mc.gotoAndPlay("outro");
      }
      
      public function fClose() : void
      {
         mc.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK,xClick);
         rootClass.ui.mcPopup.onClose();
      }
      
      private function bMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.fx.visible = true;
      }
      
      private function bMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.fx.visible = false;
      }
      
      private function setCT(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      private function iMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.parent.mHi.visible = true;
         _loc2_.parent.mHi.y = _loc2_.y;
      }
      
      private function iMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.parent.mHi.visible = false;
      }
      
      internal function frame1() : *
      {
         open();
      }
      
      internal function frame7() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
      }
      
      internal function frame16() : *
      {
         fClose();
      }
   }
}

