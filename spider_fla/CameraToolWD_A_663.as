package spider_fla
{
   import adobe.utils.*;
   import fl.controls.NumericStepper;
   import fl.controls.Slider;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2436")]
   public dynamic class CameraToolWD_A_663 extends MovieClip
   {
      
      public var background:MovieClip;
      
      public var btnMirror:SimpleButton;
      
      public var numWepScale:NumericStepper;
      
      public var txtFocus:TextField;
      
      public var sldrRotation:Slider;
      
      public var btnSetFocus:SimpleButton;
      
      public var btnAddLayer:SimpleButton;
      
      public var btnDelLayer:SimpleButton;
      
      public var btnInCombat:SimpleButton;
      
      public function CameraToolWD_A_663()
      {
         super();
         __setProp_sldrRotation_CameraToolWD_A_Layer1_0();
         __setProp_numWepScale_CameraToolWD_A_Layer1_0();
      }
      
      internal function __setProp_sldrRotation_CameraToolWD_A_Layer1_0() : *
      {
         try
         {
            sldrRotation["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         sldrRotation.direction = "horizontal";
         sldrRotation.enabled = true;
         sldrRotation.liveDragging = true;
         sldrRotation.maximum = 360;
         sldrRotation.minimum = 0;
         sldrRotation.snapInterval = 0;
         sldrRotation.tickInterval = 0;
         sldrRotation.value = 0;
         sldrRotation.visible = true;
         try
         {
            sldrRotation["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_numWepScale_CameraToolWD_A_Layer1_0() : *
      {
         try
         {
            numWepScale["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         numWepScale.enabled = true;
         numWepScale.maximum = 10;
         numWepScale.minimum = 0;
         numWepScale.stepSize = 0.001;
         numWepScale.value = 0.222;
         numWepScale.visible = true;
         try
         {
            numWepScale["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

