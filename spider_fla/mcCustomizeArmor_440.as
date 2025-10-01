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
   import liteAssets.draw.colorPicker;
   import liteAssets.draw.colorSets;
   import org.sepy.ColorPicker.ColorPicker2;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4076")]
   public dynamic class mcCustomizeArmor_440 extends MovieClip
   {
      
      public var submit:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var cpTrim:ColorPicker2;
      
      public var btnColor:MovieClip;
      
      public var cpAccessory:ColorPicker2;
      
      public var cpBase:ColorPicker2;
      
      public var bg:MovieClip;
      
      public var rootClass:*;
      
      public var avt:Avatar;
      
      public var backData:*;
      
      public var mcSets:colorSets;
      
      public function mcCustomizeArmor_440()
      {
         super();
         addFrameScript(0,frame1,19,frame20,35,frame36);
         __setProp_cpAccessory_mcCustomizeArmor_Layer22_0();
         __setProp_cpTrim_mcCustomizeArmor_Layer23_0();
         __setProp_cpBase_mcCustomizeArmor_Layer24_0();
      }
      
      public function onColorClick(param1:Event) : *
      {
         if(rootClass.stage.getChildByName("mcColorPicker"))
         {
            return;
         }
         var _loc2_:colorPicker = new colorPicker();
         _loc2_.name = "mcColorPicker";
         rootClass.stage.addChild(_loc2_);
      }
      
      public function onCloseClick(param1:Event) : *
      {
         if(backData.intColorBase != avt.objData.intColorBase || backData.intColorTrim != avt.objData.intColorTrim || backData.intColorAccessory != avt.objData.intColorAccessory)
         {
            avt.objData.intColorBase = backData.intColorBase;
            avt.objData.intColorTrim = backData.intColorTrim;
            avt.objData.intColorAccessory = backData.intColorAccessory;
            avt.pMC.updateColor();
         }
         MovieClip(Game.root).mixer.playSound("Click");
         gotoAndPlay("out");
      }
      
      public function onSaveClick(param1:Event) : *
      {
         if(backData.intColorBase != avt.objData.intColorBase || backData.intColorTrim != avt.objData.intColorTrim || backData.intColorAccessory != avt.objData.intColorAccessory)
         {
            rootClass.world.sendChangeArmorColorRequest(avt.objData.intColorBase,avt.objData.intColorTrim,avt.objData.intColorAccessory);
         }
         MovieClip(Game.root).mixer.playSound("Click");
         gotoAndPlay("out");
      }
      
      public function onColorSelect(param1:Event) : void
      {
         switch(param1.target.name)
         {
            case "cpBase":
               avt.objData.intColorBase = param1.target.selectedColor;
               break;
            case "cpTrim":
               avt.objData.intColorTrim = param1.target.selectedColor;
               break;
            case "cpAccessory":
               avt.objData.intColorAccessory = param1.target.selectedColor;
         }
         avt.pMC.updateColor();
      }
      
      public function onItemRollOver(param1:Event) : void
      {
         var _loc2_:* = new Object();
         _loc2_.intColorSkin = avt.objData.intColorSkin;
         _loc2_.intColorHair = avt.objData.intColorHair;
         _loc2_.intColorEye = avt.objData.intColorEye;
         _loc2_.intColorBase = avt.objData.intColorBase;
         _loc2_.intColorTrim = avt.objData.intColorTrim;
         _loc2_.intColorAccessory = avt.objData.intColorAccessory;
         switch(param1.target.name)
         {
            case "cpBase":
               _loc2_.intColorBase = param1.target.selectedColor;
               break;
            case "cpTrim":
               _loc2_.intColorTrim = param1.target.selectedColor;
               break;
            case "cpAccessory":
               _loc2_.intColorAccessory = param1.target.selectedColor;
         }
         avt.pMC.updateColor(_loc2_);
      }
      
      public function onItemRollOut(param1:Event) : void
      {
         avt.pMC.updateColor();
      }
      
      internal function __setProp_cpAccessory_mcCustomizeArmor_Layer22_0() : *
      {
         try
         {
            cpAccessory["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpAccessory.allowUserColor = true;
         cpAccessory.selectedColor = 0;
         cpAccessory.columns = 21;
         cpAccessory.direction = "DL";
         cpAccessory.useAdvancedColorSelector = true;
         cpAccessory.useNoColorSelector = false;
         try
         {
            cpAccessory["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cpTrim_mcCustomizeArmor_Layer23_0() : *
      {
         try
         {
            cpTrim["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpTrim.allowUserColor = true;
         cpTrim.selectedColor = 0;
         cpTrim.columns = 21;
         cpTrim.direction = "DL";
         cpTrim.useAdvancedColorSelector = true;
         cpTrim.useNoColorSelector = false;
         try
         {
            cpTrim["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cpBase_mcCustomizeArmor_Layer24_0() : *
      {
         try
         {
            cpBase["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpBase.allowUserColor = true;
         cpBase.selectedColor = 0;
         cpBase.columns = 21;
         cpBase.direction = "DL";
         cpBase.useAdvancedColorSelector = true;
         cpBase.useNoColorSelector = false;
         try
         {
            cpBase["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function frame1() : *
      {
         rootClass = MovieClip(stage.getChildAt(0));
         avt = rootClass.world.myAvatar;
         backData = new Object();
         backData.intColorBase = avt.objData.intColorBase;
         backData.intColorTrim = avt.objData.intColorTrim;
         backData.intColorAccessory = avt.objData.intColorAccessory;
         btnColor.addEventListener(MouseEvent.CLICK,onColorClick,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         submit.addEventListener(MouseEvent.CLICK,onSaveClick,false,0,true);
         cpBase.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpBase.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpBase.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpTrim.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpTrim.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpTrim.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpAccessory.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpAccessory.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpAccessory.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpBase.selectedColor = avt.objData.intColorBase;
         cpTrim.selectedColor = avt.objData.intColorTrim;
         cpAccessory.selectedColor = avt.objData.intColorAccessory;
         if(!getChildByName("mcColorSets") && Boolean(rootClass.litePreference.data.bColorSets))
         {
            mcSets = new colorSets(rootClass);
            mcSets.name = "mcColorSets";
            mcSets.mode = "mcCustomizeArmor";
            mcSets.y = 224;
            mcSets.onUpdate();
            addChild(mcSets);
            setChildIndex(mcSets,0);
         }
      }
      
      internal function frame20() : *
      {
         stop();
      }
      
      internal function frame36() : *
      {
         MovieClip(parent).onClose();
      }
   }
}

