package
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2756")]
   public dynamic class mcAreaList extends MovieClip
   {
      
      public var cntMask:MovieClip;
      
      public var cnt:MovieClip;
      
      public var title:MovieClip;
      
      public function mcAreaList()
      {
         super();
         addFrameScript(0,frame1,1,frame2,4,frame5,19,frame20,24,frame25);
      }
      
      internal function frame1() : *
      {
         title.gotoAndStop(1);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame5() : *
      {
         title.gotoAndPlay("in");
         MovieClip(Game.root).areaListGet();
      }
      
      internal function frame20() : *
      {
         stop();
      }
      
      internal function frame25() : *
      {
         title.gotoAndPlay("out");
      }
   }
}

