package spider_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3519")]
   public dynamic class game_1_mcNotificationWrapper_2 extends MovieClip
   {
      
      public var mcNoticeBubble:MovieClip;
      
      public function game_1_mcNotificationWrapper_2()
      {
         super();
         addFrameScript(0,frame1,59,frame60);
      }
      
      public function notify(param1:String) : void
      {
         mcNoticeBubble.strNotice.text = param1;
         gotoAndPlay(3);
         visible = true;
      }
      
      internal function frame1() : *
      {
         visible = false;
         stop();
      }
      
      internal function frame60() : *
      {
         visible = false;
         stop();
      }
   }
}

