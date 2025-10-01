package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class Projectile extends MovieClip
   {
      
      private var rootClass:MovieClip;
      
      private var interPoint:Point = new Point();
      
      private var pointStart:Point;
      
      private var mc:MovieClip;
      
      private var startTime:Number = 0;
      
      private var curTime:Number;
      
      private var timeTotal:Number;
      
      private var mcParent:MovieClip;
      
      private const velocity:Number = 1500;
      
      private var xPos:Number;
      
      private var yPos:Number;
      
      private var tempPoint:Point;
      
      public function Projectile(param1:Point, param2:Point, param3:MovieClip, param4:MovieClip)
      {
         super();
         rootClass = param4;
         pointStart = param1;
         interPoint.x = param2.x - param1.x;
         interPoint.y = param2.y - param1.y;
         mc = param3;
         mc.scaleX = interPoint.x < 0 ? mc.scaleX * -1 : mc.scaleX;
         mcParent = MovieClip(mc.parent);
         var _loc5_:Number = param2.x - param1.x;
         var _loc6_:Number = param2.y - param1.y;
         var _loc7_:Number = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
         timeTotal = 1000 * (_loc7_ / velocity);
         startTime = getTimer();
         this.addEventListener(Event.ENTER_FRAME,onEnter,false,0,true);
      }
      
      private function onEnter(param1:Event) : void
      {
         curTime = getTimer() - startTime;
         curTime = curTime >= timeTotal ? timeTotal : curTime;
         xPos = pointStart.x + interPoint.x * (curTime / timeTotal);
         yPos = pointStart.y + interPoint.y * (curTime / timeTotal);
         mc.x = pointStart.x + interPoint.x * (curTime / timeTotal);
         mc.y = pointStart.y + interPoint.y * (curTime / timeTotal);
         if(curTime >= timeTotal)
         {
            mc.visible = false;
            mcParent.removeChild(mc);
            this.removeEventListener(Event.ENTER_FRAME,onEnter);
            return;
         }
      }
   }
}

