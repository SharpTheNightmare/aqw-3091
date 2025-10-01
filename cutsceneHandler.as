package
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class cutsceneHandler
   {
      
      private var rootClass:MovieClip;
      
      private var strMap:String;
      
      private var strFrame:String = "";
      
      private var strPad:String;
      
      private var changeMap:Boolean = false;
      
      private var strFile:String;
      
      private var cutFrame:String;
      
      private var cutPad:String;
      
      private var cutTimer:Timer;
      
      public function cutsceneHandler(param1:MovieClip)
      {
         super();
         rootClass = param1;
      }
      
      public function setCutsceneTarget(param1:String, param2:String, param3:String = "") : void
      {
         strFrame = param1;
         strPad = param2;
         strMap = param3;
         changeMap = param3 != "";
      }
      
      public function transfer() : void
      {
         if(changeMap)
         {
            rootClass.world.gotoTown(strMap,strFrame,strPad);
         }
         else if(strFrame != "")
         {
            rootClass.world.moveToCell(strFrame,strPad);
         }
         rootClass.clearExternamSWF();
      }
      
      public function showCutscene(param1:String, param2:Boolean = false, param3:String = "Cut1", param4:String = "Left") : void
      {
         strFile = param1;
         cutFrame = param3;
         cutPad = param4;
         if(param2)
         {
            cutTimer = new Timer(3000,1);
            cutTimer.addEventListener(TimerEvent.TIMER,onCutTimer,false,0,true);
            cutTimer.start();
         }
         else
         {
            rootClass.loadExternalSWF(strFile);
            rootClass.world.moveToCell(cutFrame,cutPad);
         }
      }
      
      private function onCutTimer(param1:TimerEvent) : void
      {
         cutTimer.stop();
         cutTimer.removeEventListener(TimerEvent.TIMER,onCutTimer);
         rootClass.loadExternalSWF(strFile);
         rootClass.world.moveToCell(cutFrame,cutPad);
      }
   }
}

