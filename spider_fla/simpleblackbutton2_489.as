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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol605")]
   public dynamic class simpleblackbutton2_489 extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var fx:MovieClip;
      
      public var isSelected:Boolean;
      
      public function simpleblackbutton2_489()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function select() : *
      {
         isSelected = true;
         setCT(bg,18278);
      }
      
      public function unselect() : *
      {
         isSelected = false;
         setCT(bg,65793);
      }
      
      public function onMouseOver(param1:MouseEvent) : *
      {
         if(!isSelected)
         {
            this.fx.visible = true;
         }
      }
      
      public function onMouseOut(param1:MouseEvent) : *
      {
         this.fx.visible = false;
      }
      
      public function setCT(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      internal function frame1() : *
      {
         this.buttonMode = true;
         this.fx.visible = false;
         isSelected = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
         stop();
      }
   }
}

