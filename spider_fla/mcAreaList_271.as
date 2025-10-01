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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2753")]
   public dynamic class mcAreaList_271 extends MovieClip
   {
      
      public var t1:TextField;
      
      public var bMinMax:MovieClip;
      
      public function mcAreaList_271()
      {
         super();
         addFrameScript(0,frame1,9,frame10);
      }
      
      internal function frame1() : *
      {
         t1.mouseEnabled = false;
         bMinMax.a1.visible = false;
         bMinMax.a2.visible = true;
         stop();
      }
      
      internal function frame10() : *
      {
         bMinMax.a1.visible = true;
         bMinMax.a2.visible = false;
         stop();
      }
   }
}

