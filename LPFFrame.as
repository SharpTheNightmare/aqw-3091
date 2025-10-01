package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.*;
   
   public class LPFFrame extends MovieClip
   {
      
      public var w:int;
      
      public var h:int;
      
      public var fParent:LPFPanel;
      
      public var eventTypes:Array = [];
      
      public var sName:String = "";
      
      protected var fData:Object;
      
      protected var sMode:String;
      
      public function LPFFrame()
      {
         super();
      }
      
      public function subscribeTo(param1:LPFPanel) : void
      {
         fParent = param1;
      }
      
      public function getLayout() : MovieClip
      {
         var _loc1_:* = fParent;
         while("fParent" in _loc1_ && _loc1_.fParent != null)
         {
            _loc1_ = _loc1_.fParent;
         }
         return _loc1_ as MovieClip;
      }
      
      public function notify(param1:Object) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         getLayout().update(param1);
      }
      
      public function getState() : Object
      {
         var _loc1_:Object = {};
         _loc1_.fParent = fParent;
         _loc1_.element = this;
         _loc1_.fData = fData;
         return _loc1_;
      }
      
      public function fOpen(param1:Object) : void
      {
         fData = param1.fData;
         positionBy(param1.r);
         getLayout().registerForEvents(this,eventTypes);
      }
      
      public function fClose() : void
      {
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function fRemove() : void
      {
         if(fParent != null && "delFrame" in fParent)
         {
            fParent.delFrame(this);
         }
      }
      
      protected function positionBy(param1:Object) : *
      {
         var _loc3_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:Rectangle = null;
         var _loc7_:int = 0;
         if("shiftY" in param1)
         {
            y += param1.y;
            return;
         }
         var _loc2_:int = int(fParent.w / 2);
         var _loc4_:int = this.width / 2;
         if(parent != null)
         {
            _loc5_ = 0;
            while(_loc5_ < parent.numChildren)
            {
               if(parent.getChildAt(_loc5_) == this)
               {
                  _loc3_ = parent.getChildAt(_loc5_);
               }
               _loc5_++;
            }
            _loc6_ = _loc3_.getBounds(parent);
            _loc4_ = int(_loc6_.width / 2);
         }
         if("centerOn" in param1)
         {
            _loc2_ = int(param1.centerOn);
         }
         if("center" in param1 && Boolean(param1.center))
         {
            x = int(_loc2_ - _loc4_);
         }
         else if(param1.x > -1)
         {
            x = param1.x;
         }
         else
         {
            x = int(fParent.w / 2 - width / 2);
         }
         if("shiftAmount" in param1)
         {
            x += int(param1.shiftAmount);
         }
         if(param1.y > -1)
         {
            y = param1.y;
         }
         else if(param1.y == -1)
         {
            _loc7_ = fParent.numChildren;
            if(_loc7_ > 1)
            {
               y = fParent.getChildAt(_loc7_ - 2).y + fParent.getChildAt(_loc7_ - 2).height + 10;
            }
            else
            {
               y = 10;
            }
         }
         else
         {
            y = fParent.h + param1.y;
         }
         w = param1.w;
         h = param1.h;
      }
   }
}

