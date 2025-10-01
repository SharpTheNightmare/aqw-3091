package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2774")]
   public class CastBarMC extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public var o:Object = null;
      
      public var isOpen:Boolean = false;
      
      public var callback:Object = null;
      
      public var state:int = -1;
      
      public var dur:int = 1000;
      
      private var world:MovieClip;
      
      private var rootClass:MovieClip;
      
      private var mc:MovieClip;
      
      private var run:int;
      
      private var ts:Number;
      
      private var date:Date;
      
      public function CastBarMC()
      {
         super();
         addFrameScript(0,frame1,4,frame5,5,frame6,9,frame10);
      }
      
      public function init() : void
      {
         mc = MovieClip(this);
         rootClass = MovieClip(stage.getChildAt(0));
      }
      
      public function fOpenWith(param1:*) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         o = param1;
         isOpen = true;
         switch(o.typ)
         {
            case "sia":
               state = o.args.ID;
            case "generic":
               mc.cnt.t1.text = o.txt;
               _loc2_ = mc.cnt.fill;
               _loc3_ = mc.cnt.fillMask;
               _loc3_.x = int(_loc2_.x - _loc3_.width);
               run = int(_loc2_.x - _loc3_.x);
               date = new Date();
               ts = Number(date.getTime());
               dur = int(1000 * o.dur);
               _loc3_.removeEventListener(Event.ENTER_FRAME,slide);
               _loc3_.addEventListener(Event.ENTER_FRAME,slide);
               mc.cnt.tip.removeEventListener(Event.ENTER_FRAME,tipFollow);
               mc.cnt.tip.addEventListener(Event.ENTER_FRAME,tipFollow);
               mc.gotoAndPlay("in");
         }
      }
      
      public function fClose() : void
      {
         var _loc1_:* = undefined;
         if(isOpen)
         {
            o = null;
            state = -1;
            isOpen = false;
            _loc1_ = mc.cnt.fillMask;
            _loc1_.removeEventListener(Event.ENTER_FRAME,slide);
            mc.cnt.tip.removeEventListener(Event.ENTER_FRAME,tipFollow);
            mc.gotoAndPlay("out");
            rootClass.world.myAvatar.pMC.endAction();
         }
      }
      
      private function slide(param1:Event) : void
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         date = new Date();
         var _loc3_:* = date.getTime() - ts;
         var _loc4_:* = _loc3_ / dur;
         if(_loc4_ >= 1)
         {
            mc.gotoAndPlay("out");
            _loc2_.removeEventListener(Event.ENTER_FRAME,slide);
            mc.cnt.tip.removeEventListener(Event.ENTER_FRAME,tipFollow);
            fCallback();
            fClose();
         }
         else
         {
            _loc2_.x = mc.cnt.fill.x - mc.cnt.fillMask.width + run * _loc4_;
         }
      }
      
      private function tipFollow(param1:Event) : void
      {
         var _loc2_:* = mc.cnt.tip;
         var _loc3_:* = mc.cnt.fillMask;
         _loc2_.x = _loc3_.x + _loc3_.width - _loc2_.width;
      }
      
      private function fCallback() : void
      {
         if(o.msg != null)
         {
            rootClass.chatF.pushMsg("event",o.msg,"SERVER","",0);
         }
         if(o.callback != null)
         {
            if(o.args != null)
            {
               o.callback(o.args);
            }
            else
            {
               o.callback();
            }
         }
         if(o.xtObj != null)
         {
            rootClass.sfc.sendXtMessage("zm",o.xtObj.cmd,o.xtObj.args,"str",rootClass.world.curRoom);
         }
      }
      
      internal function frame1() : *
      {
         cnt.visible = false;
         init();
         stop();
      }
      
      internal function frame5() : *
      {
         cnt.visible = true;
         cnt.tip.visible = true;
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         cnt.tip.visible = false;
      }
   }
}

