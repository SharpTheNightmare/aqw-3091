package
{
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class mapData
   {
      
      private var rootClass:MovieClip;
      
      private var qID:int;
      
      private var qAccepted:Boolean;
      
      private var qTimer:Timer;
      
      public function mapData(param1:MovieClip)
      {
         super();
         rootClass = param1;
      }
      
      public function initObjSess(param1:Array, param2:Array) : void
      {
         var _loc3_:uint = 0;
         if(rootClass.world.objSession[rootClass.world.strMapName] == null)
         {
            rootClass.world.objSession[rootClass.world.strMapName] = new Object();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               initClicky(param2[_loc3_],param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function updateSessArray(param1:String, param2:int = 0) : void
      {
         rootClass.world.objSession[rootClass.world.strMapName][param1 + param2] = true;
      }
      
      public function checkSess(param1:String, param2:int = 0) : Boolean
      {
         return rootClass.world.objSession[rootClass.world.strMapName][param1 + param2];
      }
      
      public function checkSessArr(param1:String, param2:Array) : Boolean
      {
         var _loc3_:* = checkSess(param1,param2[0] - 1);
         var _loc4_:uint = 1;
         while(_loc4_ < param2.length)
         {
            _loc3_ &&= checkSess(param1,param2[_loc4_] - 1);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function completeQuest(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:* = undefined;
         if(param2)
         {
            if(rootClass.world.isQuestInProgress(param1))
            {
               _loc3_ = rootClass.world.questTree[param1];
               if(_loc3_ != null)
               {
                  if(!isOneTimeQuestDone(_loc3_) && _loc3_.status != null && _loc3_.status == "c")
                  {
                     rootClass.world.tryQuestComplete(param1);
                  }
               }
               else
               {
                  rootClass.world.tryQuestComplete(param1);
               }
            }
         }
         else
         {
            rootClass.world.tryQuestComplete(param1);
         }
      }
      
      public function delayedTurnin(param1:int, param2:Boolean = false) : void
      {
         qID = param1;
         qAccepted = param2;
         qTimer = new Timer(3000,1);
         qTimer.addEventListener(TimerEvent.TIMER,onQuestTimer,false,0,true);
         qTimer.start();
      }
      
      public function checkChaos() : Boolean
      {
         var _loc1_:Boolean = Boolean(rootClass.world.getAchievement("ia1",20));
         _loc1_ ||= Boolean(rootClass.world.getAchievement("ia1",21));
         _loc1_ ||= Boolean(rootClass.world.getAchievement("ia1",22));
         return _loc1_ || Boolean(rootClass.world.getAchievement("ia1",23));
      }
      
      public function checkUpholder() : Boolean
      {
         var _loc1_:Boolean = Boolean(rootClass.world.getAchievement("ip0",3)) || Boolean(rootClass.world.getAchievement("ip0",4));
         _loc1_ = _loc1_ || Boolean(rootClass.world.getAchievement("ip0",10)) || Boolean(rootClass.world.getAchievement("ip0",24));
         _loc1_ = _loc1_ || Boolean(rootClass.world.getAchievement("ip1",16)) || Boolean(rootClass.world.getAchievement("ip2",27));
         return _loc1_ || Boolean(rootClass.world.getAchievement("ip4",22)) || Boolean(rootClass.world.getAchievement("ip8",11));
      }
      
      private function onQuestTimer(param1:TimerEvent) : void
      {
         qTimer.stop();
         qTimer.removeEventListener(TimerEvent.TIMER,onQuestTimer);
         completeQuest(qID,qAccepted);
      }
      
      private function initClicky(param1:int, param2:String) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < param1)
         {
            rootClass.world.objSession[rootClass.world.strMapName][param2 + _loc3_] = false;
            _loc3_++;
         }
      }
      
      private function isOneTimeQuestDone(param1:*) : Boolean
      {
         return param1.bOnce == 1 && (param1.iSlot < 0 || rootClass.world.getQuestValue(param1.iSlot) >= param1.iValue);
      }
   }
}

