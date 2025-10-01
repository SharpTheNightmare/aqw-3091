package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1913")]
   public class LPFElementScrollBar extends MovieClip
   {
      
      public var h:MovieClip;
      
      public var a1:MovieClip;
      
      public var a2:MovieClip;
      
      public var b:MovieClip;
      
      public var hit:MovieClip;
      
      private var mDown:Boolean = false;
      
      private var subjectMask:MovieClip;
      
      private var subject:MovieClip;
      
      private var hRun:int = 0;
      
      private var dRun:int = 0;
      
      private var mbY:int = 0;
      
      private var mhY:int = 0;
      
      private var mbD:int = 0;
      
      private var qly:int = 70;
      
      private var qdy:int = 58;
      
      private var defaultCT:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      private var greyCT:ColorTransform = new ColorTransform(0.4,0.4,0.4,1,-20,-20,-20,0);
      
      public var fParent:LPFFrame;
      
      public function LPFElementScrollBar()
      {
         super();
         hit.buttonMode = true;
         a1.buttonMode = true;
         a2.buttonMode = true;
      }
      
      public function fOpen(param1:Object) : void
      {
         subjectMask = param1.subjectMask;
         subject = param1.subject;
         hRun = b.height - h.height;
         dRun = subject.height - subjectMask.height + 20;
         if(param1.reset || !("oy" in subject) || subject.height <= subjectMask.height)
         {
            if(subject.height <= subjectMask.height)
            {
               subject.y = 24;
            }
            subject.oy = subject.y;
            h.y = 0;
         }
         h.removeEventListener(Event.ENTER_FRAME,hEF);
         hit.removeEventListener(MouseEvent.MOUSE_DOWN,onMDown);
         a1.removeEventListener(MouseEvent.CLICK,onUpArrowClick);
         a2.removeEventListener(MouseEvent.CLICK,onDnArrowClick);
         hit.alpha = 0;
         if(subject.height > subjectMask.height)
         {
            h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
            hit.addEventListener(MouseEvent.MOUSE_DOWN,onMDown,false,0,true);
            a1.addEventListener(MouseEvent.CLICK,onUpArrowClick,false,0,true);
            a2.addEventListener(MouseEvent.CLICK,onDnArrowClick,false,0,true);
            transform.colorTransform = defaultCT;
         }
         else
         {
            transform.colorTransform = greyCT;
         }
         parent.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
         parent.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
      }
      
      public function fClose() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,onMDown);
         removeEventListener(MouseEvent.MOUSE_UP,onMUp);
         a1.removeEventListener(MouseEvent.CLICK,onUpArrowClick);
         a2.removeEventListener(MouseEvent.CLICK,onDnArrowClick);
         parent.removeEventListener(MouseEvent.MOUSE_WHEEL,onWheel);
         parent.removeEventListener(MouseEvent.MOUSE_WHEEL,onWheel);
         stage.removeEventListener(MouseEvent.MOUSE_UP,onMUp);
         parent.removeChild(this);
      }
      
      protected function fDraw() : void
      {
      }
      
      public function subscribeTo(param1:LPFFrame) : void
      {
         fParent = param1;
      }
      
      private function onWheel(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.delta > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.delta)
            {
               a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < param1.delta * -1)
            {
               a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               _loc3_++;
            }
         }
      }
      
      private function onUpArrowClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 1.1 * subject.height / (subject.numChildren - 1);
         var _loc3_:int = Math.ceil(hRun * (_loc2_ / subject.height));
         h.y -= _loc3_;
         if(h.y + h.height > b.height)
         {
            h.y = int(b.height - h.height);
         }
         if(h.y < 0)
         {
            h.y = 0;
         }
      }
      
      private function onDnArrowClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 1.1 * subject.height / subject.numChildren;
         var _loc3_:int = Math.ceil(hRun * (_loc2_ / subject.height));
         h.y += _loc3_;
         if(h.y + h.height > b.height)
         {
            h.y = int(b.height - h.height);
         }
         if(h.y < 0)
         {
            h.y = 0;
         }
      }
      
      private function onMDown(param1:MouseEvent) : *
      {
         if(!h.hitTestPoint(mouseX,mouseY))
         {
            h.y = mouseY - int(h.height / 2);
            if(h.y + h.height > b.height)
            {
               h.y = int(b.height - h.height);
            }
            if(h.y < 0)
            {
               h.y = 0;
            }
         }
         mbY = int(mouseY);
         mhY = int(h.y);
         mDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,onMUp,false,0,true);
      }
      
      private function onMUp(param1:MouseEvent) : *
      {
         mDown = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,onMUp);
      }
      
      private function hEF(param1:Event) : *
      {
         if(mDown)
         {
            mbD = int(mouseY) - mbY;
            h.y = mhY + mbD;
            if(h.y + h.height > b.height)
            {
               h.y = int(b.height - h.height);
            }
            if(h.y < 0)
            {
               h.y = 0;
            }
         }
         var _loc2_:* = -h.y / hRun;
         var _loc3_:* = int(_loc2_ * dRun) + subject.oy;
         if(Math.abs(_loc3_ - subject.y) > 0.2)
         {
            subject.y += (_loc3_ - subject.y) / 1.1;
         }
         else
         {
            subject.y = _loc3_;
         }
      }
   }
}

