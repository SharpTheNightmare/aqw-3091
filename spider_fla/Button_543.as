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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4191")]
   public dynamic class Button_543 extends MovieClip
   {
      
      public var btnButton:MovieClip;
      
      public var txtLabel:TextField;
      
      public var rootClass:*;
      
      public var world:*;
      
      public function Button_543()
      {
         super();
         addFrameScript(1,frame2);
      }
      
      public function onButtonPress(param1:MouseEvent) : void
      {
         if(this.bitMemberOnly)
         {
            rootClass.showUpgradeWindow();
         }
         else
         {
            navigateToURL(new URLRequest("https://www.aq.com/order-now/direct/"),"_blank");
         }
      }
      
      internal function frame2() : *
      {
         rootClass = MovieClip(this.stage.getChildAt(0));
         world = rootClass.world;
         btnButton.addEventListener(MouseEvent.MOUSE_DOWN,onButtonPress,false,0,true);
         stop();
      }
   }
}

