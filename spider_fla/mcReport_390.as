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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4050")]
   public dynamic class mcReport_390 extends MovieClip
   {
      
      public var submit:MovieClip;
      
      public var btnClose:SimpleButton;
      
      public var tDesc:TextField;
      
      public var bg:MovieClip;
      
      public var i0:MovieClip;
      
      public var i1:MovieClip;
      
      public var ti:TextField;
      
      public var i2:MovieClip;
      
      public var i3:MovieClip;
      
      public var iSel:*;
      
      public var mc:*;
      
      public var defaultDesc:String;
      
      public var tDetailTemplate:*;
      
      public var rootClass:MovieClip;
      
      public function mcReport_390()
      {
         super();
         addFrameScript(0,frame1,4,frame5,9,frame10,14,frame15,19,frame20);
      }
      
      public function itemClick(param1:MouseEvent) : *
      {
         iSel = int(MovieClip(param1.currentTarget).name.substr(1));
         var _loc2_:* = 0;
         while(_loc2_ < 4)
         {
            if(mc["i" + _loc2_] != null)
            {
               mc["i" + _loc2_].d.f1.visible = _loc2_ == iSel;
            }
            _loc2_++;
         }
         mc.submit.visible = true;
         if(tDetailTemplate.indexOf(tDesc.text) > -1 || tDesc.text == defaultDesc || tDesc.text == " " || tDesc.text == "")
         {
            tDesc.text = tDetailTemplate[iSel];
         }
      }
      
      public function submitClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(stage.getChildAt(0));
         var _loc3_:* = MovieClip(parent);
         var _loc4_:String = " ";
         if(tDesc.text.length > 3 && tDesc.text != defaultDesc)
         {
            _loc4_ = tDesc.text;
         }
         _loc2_.world.sendReport(["reportlang",_loc3_.fData.unm,iSel,_loc4_]);
         _loc3_.onClose(null);
      }
      
      public function onClose(param1:Event = null) : void
      {
         if(MovieClip(parent).currentLabel != "Init")
         {
            rootClass.mixer.playSound("Click");
            MovieClip(parent).gotoAndPlay("Init");
         }
      }
      
      internal function frame1() : *
      {
         iSel = -1;
         mc = MovieClip(this);
         defaultDesc = "Type reason for report here.";
         tDetailTemplate = [defaultDesc,defaultDesc,defaultDesc,defaultDesc];
         rootClass = stage.getChildAt(0) as MovieClip;
         gotoAndPlay("full");
      }
      
      internal function frame5() : *
      {
         i0.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
         i1.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
         i2.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
         i3.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
         submit.addEventListener(MouseEvent.CLICK,submitClick,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         i0.buttonMode = true;
         i1.buttonMode = true;
         i2.buttonMode = true;
         i3.buttonMode = true;
         submit.buttonMode = true;
         i0.d.f1.visible = false;
         i1.d.f1.visible = false;
         i2.d.f1.visible = false;
         i3.d.f1.visible = false;
         submit.visible = false;
         ti.text = MovieClip(parent).fData.unm;
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         i1.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
         submit.addEventListener(MouseEvent.CLICK,submitClick,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         i1.buttonMode = true;
         submit.buttonMode = true;
         i1.d.f1.visible = false;
         submit.visible = false;
         ti.text = MovieClip(parent).fData.unm;
      }
      
      internal function frame20() : *
      {
         stop();
      }
   }
}

