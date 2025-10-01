package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1074")]
   public class ConnDetailMC extends MovieClip
   {
      
      public var txtContact:TextField;
      
      public var mcPct:TextField;
      
      public var txtBack:TextField;
      
      public var mcSpinner:MovieClip;
      
      public var txtDetail:TextField;
      
      public var mcSpinner2:MovieClip;
      
      public var btnContact:SimpleButton;
      
      public var btnBack:SimpleButton;
      
      private var timerConnDetail:Timer = new Timer(10000,1);
      
      public var rootClass:MovieClip;
      
      private var minutes:int;
      
      private var countDownTimer:Timer;
      
      private var firstJoin:Boolean = false;
      
      public function ConnDetailMC(param1:MovieClip)
      {
         super();
         rootClass = param1;
         txtBack.mouseEnabled = false;
         mcPct.visible = false;
         txtDetail.mouseEnabled = false;
         txtContact.mouseEnabled = false;
         setBtnContact(false);
         btnBack.addEventListener(MouseEvent.CLICK,onBackClick,false,0,true);
         timerConnDetail.removeEventListener(TimerEvent.TIMER,showBackButton);
         timerConnDetail.addEventListener(TimerEvent.TIMER,showBackButton,false,0,true);
         btnContact.addEventListener(MouseEvent.CLICK,onContactClick,false,0,true);
      }
      
      internal function setBtnContact(param1:Boolean) : void
      {
         txtContact.visible = param1;
         btnContact.visible = param1;
         if(param1)
         {
            btnBack.x = 397.25;
            txtBack.x = 340.9;
            txtDetail.y = 397.3;
         }
         else
         {
            btnBack.x = 476.7;
            txtBack.x = 420.35;
            txtDetail.y = 364.7;
         }
      }
      
      internal function logout() : void
      {
         if(rootClass.sfc.isConnected)
         {
            rootClass.sfc.disconnect();
         }
         rootClass.gotoAndPlay("Login");
      }
      
      internal function onContactClick(param1:MouseEvent) : void
      {
         logout();
         navigateToURL(new URLRequest("https://www.aq.com/help/aw-accounts-locked.asp"),"_blank");
         hideConn();
         FacebookConnect.StopPoll();
      }
      
      internal function onBackClick(param1:MouseEvent = null) : void
      {
         if(Boolean(rootClass.sfc.isConnected) && Boolean(rootClass.litePreference.data.bDebugger) && (Boolean(rootClass.world) && Boolean(rootClass.world.myAvatar)))
         {
            hideConn();
            return;
         }
         logout();
         hideConn();
         FacebookConnect.StopPoll();
      }
      
      public function showConn(param1:String, param2:Boolean = false, param3:Boolean = false) : void
      {
         setBtnContact(false);
         mcSpinner.visible = true;
         mcSpinner2.visible = true;
         btnBack.visible = false;
         txtBack.visible = false;
         txtBack.text = "Cancel";
         txtDetail.text = param1;
         firstJoin = param2;
         if(stage == null)
         {
            rootClass.addChild(this);
         }
         rootClass.setChildIndex(this,rootClass.numChildren - 1);
         if(!timerConnDetail.running && !param3)
         {
            timerConnDetail.reset();
            timerConnDetail.start();
         }
      }
      
      public function showDisconnect(param1:String) : void
      {
         setBtnContact(false);
         btnBack.visible = true;
         txtBack.visible = true;
         txtBack.text = "Back";
         txtDetail.text = param1;
         mcSpinner.visible = false;
         mcPct.visible = false;
         if(stage == null)
         {
            rootClass.addChild(this);
         }
         if(timerConnDetail.running)
         {
            timerConnDetail.stop();
         }
      }
      
      public function showBackButton(param1:TimerEvent = null) : void
      {
         btnBack.visible = true;
         txtBack.visible = true;
      }
      
      public function showError(param1:String) : void
      {
         if(stage == null)
         {
            rootClass.addChild(this);
         }
         setBtnContact(true);
         txtDetail.htmlText = param1;
         mcSpinner.visible = false;
         mcSpinner2.visible = false;
         txtBack.text = "Back";
         showBackButton();
      }
      
      public function hideConn() : void
      {
         setBtnContact(false);
         if(stage != null)
         {
            rootClass.removeChild(this);
         }
      }
      
      public function showCountDown(param1:int) : void
      {
         countDownTimer = new Timer(60000,1);
         minutes = param1;
         this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove,false,0,true);
         countDownTimer.addEventListener(TimerEvent.TIMER,onCountdown,false,0,true);
         countDownTimer.start();
      }
      
      private function onRemove(param1:Event) : void
      {
         countDownTimer.removeEventListener(TimerEvent.TIMER,onCountdown);
      }
      
      private function onCountdown(param1:TimerEvent) : void
      {
         --minutes;
         countDownTimer.stop();
         if(minutes > 0)
         {
            countDownTimer.reset();
            countDownTimer.start();
         }
         else
         {
            countDownTimer.removeEventListener(TimerEvent.TIMER,onCountdown);
         }
      }
   }
}

