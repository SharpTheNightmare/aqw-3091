package
{
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class Killvis extends EventDispatcher
   {
      
      internal var vobj:*;
      
      internal var vTimer:Timer = new Timer(1000,1);
      
      public function Killvis()
      {
         super();
         vTimer.addEventListener(TimerEvent.TIMER,noVis,false,0,true);
      }
      
      public function kill(param1:Object, param2:int) : *
      {
         this.vobj = param1;
         vTimer.delay = param2;
         vTimer.reset();
         vTimer.start();
      }
      
      public function stopkill() : *
      {
         if(vTimer != null && vTimer.running)
         {
            vTimer.stop();
         }
      }
      
      public function resetkill() : *
      {
         if(vTimer != null && vTimer.running)
         {
            vTimer.reset();
            vTimer.start();
         }
      }
      
      public function noVis(param1:TimerEvent) : *
      {
         vobj.visible = false;
         MovieClip(MovieClip(vobj).parent).kv = null;
      }
   }
}

