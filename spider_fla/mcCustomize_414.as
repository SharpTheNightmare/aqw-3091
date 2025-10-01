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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4071")]
   public dynamic class mcCustomize_414 extends MovieClip
   {
      
      public var cpEye:ColorPicker2;
      
      public var btnLeft:SimpleButton;
      
      public var submit:SimpleButton;
      
      public var cpHair:ColorPicker2;
      
      public var btnClose:SimpleButton;
      
      public var btnColor:MovieClip;
      
      public var bg:MovieClip;
      
      public var txtHair:TextField;
      
      public var cpSkin:ColorPicker2;
      
      public var btnRight:SimpleButton;
      
      public var rootClass:*;
      
      public var avt:Avatar;
      
      public var backData:*;
      
      public var HairStyle:Array;
      
      public var intHairStyleIndex:int;
      
      public var arrColors:*;
      
      public var arrEyeColors:*;
      
      public var mcSets:colorSets;
      
      public function mcCustomize_414()
      {
         super();
         addFrameScript(0,frame1,19,frame20,35,frame36);
         __setProp_cpEye_mcCustomize_cptabs_0();
         __setProp_cpSkin_mcCustomize_Layer22_0();
         __setProp_cpHair_mcCustomize_Layer23_0();
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
         if(avt.objData.HairID != backData.HairID)
         {
            avt.objData.HairID = backData.HairID;
            avt.objData.strHairName = backData.strHairName;
            avt.objData.strHairFilename = backData.strHairFilename;
            avt.pMC.loadHair();
         }
         avt.objData.intColorSkin = backData.intColorSkin;
         avt.objData.intColorHair = backData.intColorHair;
         avt.objData.intColorEye = backData.intColorEye;
         avt.pMC.updateColor();
         MovieClip(Game.root).mixer.playSound("Click");
         gotoAndPlay("out");
      }
      
      public function onSaveClick(param1:Event) : *
      {
         if(backData.HairID != avt.objData.HairID || backData.intColorSkin != avt.objData.intColorSkin || backData.intColorHair != avt.objData.intColorHair || backData.intColorEye != avt.objData.intColorEye)
         {
            rootClass.world.sendChangeColorRequest(avt.objData.intColorSkin,avt.objData.intColorHair,avt.objData.intColorEye,avt.objData.HairID);
         }
         MovieClip(Game.root).mixer.playSound("Click");
         gotoAndPlay("out");
      }
      
      public function nextHairStyle(param1:Event) : *
      {
         if(param1.currentTarget.name == "btnRight")
         {
            intHairStyleIndex = (intHairStyleIndex + 1) % HairStyle.length;
         }
         else if(param1.currentTarget.name == "btnLeft")
         {
            intHairStyleIndex = (intHairStyleIndex + HairStyle.length - 1) % HairStyle.length;
         }
         avt.objData.HairID = HairStyle[intHairStyleIndex].HairID;
         avt.objData.strHairName = HairStyle[intHairStyleIndex].sName;
         avt.objData.strHairFilename = HairStyle[intHairStyleIndex].sFile;
         txtHair.text = avt.objData.strHairName;
         avt.pMC.loadHair();
      }
      
      public function onColorSelect(param1:Event) : void
      {
         switch(param1.target.name)
         {
            case "cpSkin":
               avt.objData.intColorSkin = param1.target.selectedColor;
               break;
            case "cpEye":
               avt.objData.intColorEye = param1.target.selectedColor;
               break;
            case "cpHair":
               avt.objData.intColorHair = param1.target.selectedColor;
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
            case "cpSkin":
               _loc2_.intColorSkin = param1.target.selectedColor;
               break;
            case "cpEye":
               _loc2_.intColorEye = param1.target.selectedColor;
               break;
            case "cpHair":
               _loc2_.intColorHair = param1.target.selectedColor;
         }
         avt.pMC.updateColor(_loc2_);
      }
      
      public function onItemRollOut(param1:Event) : void
      {
         avt.pMC.updateColor();
      }
      
      internal function __setProp_cpEye_mcCustomize_cptabs_0() : *
      {
         try
         {
            cpEye["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpEye.allowUserColor = true;
         cpEye.selectedColor = 0;
         cpEye.columns = 21;
         cpEye.direction = "DL";
         cpEye.useAdvancedColorSelector = true;
         cpEye.useNoColorSelector = false;
         try
         {
            cpEye["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cpSkin_mcCustomize_Layer22_0() : *
      {
         try
         {
            cpSkin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpSkin.allowUserColor = true;
         cpSkin.selectedColor = 0;
         cpSkin.columns = 21;
         cpSkin.direction = "DL";
         cpSkin.useAdvancedColorSelector = true;
         cpSkin.useNoColorSelector = false;
         try
         {
            cpSkin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cpHair_mcCustomize_Layer23_0() : *
      {
         try
         {
            cpHair["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cpHair.allowUserColor = true;
         cpHair.selectedColor = 0;
         cpHair.columns = 21;
         cpHair.direction = "DL";
         cpHair.useAdvancedColorSelector = true;
         cpHair.useNoColorSelector = false;
         try
         {
            cpHair["componentInspectorSetting"] = false;
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
         backData.HairID = avt.objData.HairID;
         backData.strHairName = avt.objData.strHairName;
         backData.strHairFilename = avt.objData.strHairFilename;
         backData.intColorSkin = avt.objData.intColorSkin;
         backData.intColorHair = avt.objData.intColorHair;
         backData.intColorEye = avt.objData.intColorEye;
         btnColor.addEventListener(MouseEvent.CLICK,onColorClick,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         submit.addEventListener(MouseEvent.CLICK,onSaveClick,false,0,true);
         HairStyle = rootClass.world.hairshopinfo.hair;
         intHairStyleIndex = -1;
         btnLeft.addEventListener(MouseEvent.CLICK,nextHairStyle,false,0,true);
         btnRight.addEventListener(MouseEvent.CLICK,nextHairStyle,false,0,true);
         arrColors = [65793,16777215,12767958,9673634,8556972,5398908,4478310,2500663,3422539,4541285,6182021,3618922,2102889,8476790,9319279,4928583,14188924,2436920,6593232,4817850,3366536,3559294,1977414,9622526,10074585,13557484,5220272,7715142,5674563,5668932,4808462,4020272,3560001,4421735,5405282,3433818,3033928,3753268,14019773,10540396,16763904,14922046,11509315,11040791,13597462,14515004,10900510,16777164,16777113,16509316,13026702,8488053,10027008,6684672,4786437,15230291,13382701,12927265,10234126,10053171,7753511,9322016,7746331,8601921,6041135,4465190,13088131,9602663,8218929,15388042,14658389,15982797,15121555,14460011,14121559,13001261,3157797,13092792,5197887,7497554,4008995,6178103,8542790,7027237,3678742,5977124,9265949,5127967,10000828,65535,3381657,26367,2635172,91294,13158,16776960,16777062,16750848,65280,39219,7065902,16711680,11046487,4536088,10040064,16724940,16724869,10432464,4925009,6684876];
         arrEyeColors = [65793,16777215,10000828,8556972,5398908,65535,3381657,10074585,4817850,3366536,3559294,26367,2635172,91294,2500663,1977414,16776960,16777062,14922046,11040791,16750848,16763904,65280,39219,7065902,5674563,4808462,3753268,16711680,10027008,8601921,6041135,4465190,11046487,4536088,10053171,7753511,9322016,7746331,10040064,6684672,16724940,10432464,4925009,6684876];
         cpSkin.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpEye.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpHair.addEventListener("CHANGE",onColorSelect,false,0,true);
         cpSkin.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpEye.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpHair.addEventListener("ROLL_OVER",onItemRollOver,false,0,true);
         cpSkin.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpEye.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpHair.addEventListener("ROLL_OUT",onItemRollOut,false,0,true);
         cpSkin.selectedColor = avt.objData.intColorSkin;
         cpHair.selectedColor = avt.objData.intColorHair;
         cpEye.selectedColor = avt.objData.intColorEye;
         txtHair.text = avt.objData.strHairName;
         if(!getChildByName("mcColorSets") && Boolean(rootClass.litePreference.data.bColorSets))
         {
            mcSets = new colorSets(rootClass);
            mcSets.name = "mcColorSets";
            mcSets.mode = "mcCustomize";
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

