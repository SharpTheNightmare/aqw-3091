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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol730")]
   public dynamic class mcQFrame_1530 extends MovieClip
   {
      
      public var aMask:MovieClip;
      
      public var bMask:MovieClip;
      
      public var qList:MovieClip;
      
      public var strTitle:TextField;
      
      public var bg:MovieClip;
      
      public var core:MovieClip;
      
      public var scr:MovieClip;
      
      public var btns:MovieClip;
      
      public var mc:*;
      
      public function mcQFrame_1530()
      {
         super();
         addFrameScript(4,frame5,9,frame10,10,frame11,14,frame15,21,frame22,35,frame36,46,frame47,52,frame53,57,frame58,66,frame67);
      }
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         MovieClip(parent).showQuestList();
         bg.resizeTo(326,379);
      }
      
      internal function frame11() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         MovieClip(parent).showQuestList();
      }
      
      internal function frame22() : *
      {
         stop();
      }
      
      internal function frame36() : *
      {
         MovieClip(parent).showQuestDetail();
         bg.resizeTo(326,379);
      }
      
      internal function frame47() : *
      {
         stop();
      }
      
      internal function frame53() : *
      {
         stop();
      }
      
      internal function frame58() : *
      {
         MovieClip(parent).killDetailUI();
      }
      
      internal function frame67() : *
      {
         mc = MovieClip(parent);
         if(mc.qData != null)
         {
            gotoAndPlay("detail");
         }
         else
         {
            gotoAndPlay("list");
         }
      }
   }
}

