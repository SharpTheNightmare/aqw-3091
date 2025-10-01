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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4204")]
   public dynamic class mcSkillUp_564 extends MovieClip
   {
      
      public var rootClass:MovieClip;
      
      public var c:int;
      
      public var t:int;
      
      public function mcSkillUp_564()
      {
         super();
         addFrameScript(0,frame1,1,frame2,10,frame11,41,frame42);
      }
      
      public function fClose() : void
      {
         this.gotoAndStop("reset");
      }
      
      public function onSkillUpClick(param1:MouseEvent) : void
      {
         rootClass.toggleCharpanel("spend");
         fClose();
      }
      
      internal function frame1() : *
      {
         this.visible = false;
         this.x = 961;
         rootClass = stage.getChildAt(0) as MovieClip;
         c = 0;
         t = 60;
         this.addEventListener(MouseEvent.CLICK,onSkillUpClick,false,0,true);
         this.buttonMode = true;
         stop();
      }
      
      internal function frame2() : *
      {
         this.visible = false;
         this.x = 961;
         stop();
      }
      
      internal function frame11() : *
      {
         this.visible = true;
         this.x = 766;
         c = 0;
      }
      
      internal function frame42() : *
      {
         if(++c < t)
         {
            this.gotoAndPlay(this.currentFrame - 1);
         }
         else
         {
            fClose();
         }
      }
   }
}

