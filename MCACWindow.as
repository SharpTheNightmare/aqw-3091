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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1819")]
   public dynamic class MCACWindow extends MovieClip
   {
      
      public var btnClose2:SimpleButton;
      
      public var btnBuy:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var txtBody:TextField;
      
      public var txtHrs:TextField;
      
      public var btnUpgrade:SimpleButton;
      
      public var rootClass:*;
      
      public var renewDate:String;
      
      public function MCACWindow()
      {
         super();
         addFrameScript(0,frame1,9,frame10,18,frame19);
      }
      
      internal function frame1() : *
      {
         rootClass = stage.getChildAt(0);
         stop();
      }
      
      internal function frame10() : *
      {
         renewDate = rootClass.world.myAvatar.objData.dUpgExp.toDateString();
         txtBody.htmlText = "Your Membership expired on " + renewDate + ". Renew your account to get full access to AdventureQuest Worlds! Your upgrade will enable chat, allow you to equip pets, and give you access to exclusive items, areas, weapons, and more.";
         stop();
      }
      
      internal function frame19() : *
      {
         stop();
      }
   }
}

