package liteAssets.draw
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol144")]
   public class battleAnalyzer extends MovieClip
   {
      
      public var txtStart:TextField;
      
      public var bgStart:MovieClip;
      
      public var btnClose:MovieClip;
      
      public var txtValues:TextField;
      
      internal var startTime:Number;
      
      internal var seconds:Number = 0;
      
      private var _running:Boolean = false;
      
      internal var dmg:Number = 0;
      
      internal var heal:Number = 0;
      
      internal var dmgRecv:Number = 0;
      
      internal var gold:Number = 0;
      
      internal var xp:Number = 0;
      
      internal var kills:Number = 0;
      
      public function battleAnalyzer()
      {
         super();
         this.bgStart.addEventListener(MouseEvent.CLICK,onStart,false,0,true);
         this.bgStart.buttonMode = true;
         this.txtStart.mouseEnabled = false;
         this.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,onStopDrag,false,0,true);
         this.btnClose.addEventListener(MouseEvent.CLICK,onBtnClose,false,0,true);
      }
      
      public function onBattleTimer(param1:Event) : void
      {
         seconds = Math.round(Math.abs(startTime - new Date().getTime()) / 1000);
         updateDisplay();
      }
      
      public function updateDisplay() : void
      {
         this.txtValues.text = formatSeconds() + "\n" + addCommas(dmg) + (" (" + addCommas(Math.round(dmg / seconds)) + "/sec)") + "\n" + addCommas(heal) + (" (" + addCommas(Math.round(heal / seconds)) + "/sec)") + "\n" + addCommas(dmgRecv) + (" (" + addCommas(Math.round(dmgRecv / seconds)) + "/sec)") + "\n" + addCommas(gold) + (" (" + addCommas(Math.round(gold / seconds)) + "/sec)") + "\n" + addCommas(xp) + (" (" + addCommas(Math.round(xp / seconds)) + "/sec)") + "\n" + addCommas(kills) + (" (" + (seconds == 0 ? "0" : Number(kills / (seconds / 60)).toFixed(2)) + "/min)");
      }
      
      public function addCommas(param1:uint) : String
      {
         var _loc4_:uint = 0;
         if(param1 == 0)
         {
            return "0";
         }
         var _loc2_:String = "";
         var _loc3_:uint = param1;
         while(_loc3_ > 0)
         {
            _loc4_ = _loc3_ % 1000;
            _loc2_ = (_loc3_ > 999 ? "," + (_loc4_ < 100 ? (_loc4_ < 10 ? "00" : "0") : "") : "") + _loc4_ + _loc2_;
            _loc3_ /= 1000;
         }
         return _loc2_;
      }
      
      public function isRunning() : Boolean
      {
         return _running;
      }
      
      public function formatSeconds() : String
      {
         var _loc1_:* = Math.floor(seconds / 3600);
         var _loc2_:* = Math.floor(seconds % 3600 / 60);
         var _loc3_:* = seconds % 60;
         if(_loc1_ < 10)
         {
            _loc1_ = "0" + _loc1_;
         }
         if(_loc2_ < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         if(_loc3_ < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc1_ + ":" + _loc2_ + ":" + _loc3_;
      }
      
      public function addDamage(param1:Number) : void
      {
         this.dmg += param1;
      }
      
      public function addHeal(param1:Number) : void
      {
         this.heal += param1;
      }
      
      public function addReceived(param1:Number) : void
      {
         this.dmgRecv += param1;
      }
      
      public function addGold(param1:Number) : void
      {
         this.gold += param1;
      }
      
      public function addExp(param1:Number) : void
      {
         this.xp += param1;
      }
      
      public function addKill() : void
      {
         this.kills += 1;
      }
      
      public function reset() : void
      {
         startTime = new Date().getTime();
         seconds = 0;
         dmg = 0;
         heal = 0;
         dmgRecv = 0;
         gold = 0;
         xp = 0;
         kills = 0;
         updateDisplay();
      }
      
      public function toggle() : void
      {
         this.bgStart.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onStart(param1:MouseEvent) : void
      {
         if(_running)
         {
            this.removeEventListener(Event.ENTER_FRAME,onBattleTimer);
         }
         else
         {
            reset();
            this.addEventListener(Event.ENTER_FRAME,onBattleTimer,false,0,true);
         }
         _running = !_running;
         txtStart.text = _running ? "Stop" : "Start";
      }
      
      public function onBtnClose(param1:MouseEvent) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,onBattleTimer);
         MovieClip(getChildAt(0)).bAnalyzer = null;
         parent.removeChild(this);
      }
      
      public function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
   }
}

