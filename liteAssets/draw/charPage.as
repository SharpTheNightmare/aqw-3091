package liteAssets.draw
{
   import characterA_fla.movFaction_73;
   import fl.data.*;
   import fl.events.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1479")]
   public class charPage extends MovieClip
   {
      
      public var txtClassName:TextField;
      
      public var btClose:SimpleButton;
      
      public var mcCharUI:MovieClip;
      
      public var txtWeapon:TextField;
      
      public var movFaction:movFaction_73;
      
      public var txtArmor:TextField;
      
      public var btCharPage:MovieClip;
      
      public var txtGuildName:TextField;
      
      public var txtHelm:TextField;
      
      public var txtLvl:TextField;
      
      public var txtPet:TextField;
      
      public var txtAlignment:TextField;
      
      public var txtUserName:TextField;
      
      public var txtCape:TextField;
      
      public var txtMisc:TextField;
      
      internal var charPageLoader:URLLoader;
      
      internal var userName:String;
      
      internal var rootClass:MovieClip;
      
      internal var flashvars:URLVariables;
      
      internal var _tempMC:AvatarMC;
      
      private var petMC:PetMC;
      
      public function charPage(param1:MovieClip, param2:String)
      {
         super();
         rootClass = param1;
         this.x = 205;
         this.y = 80;
         this.visible = false;
         userName = param2;
         charPageLoader = new URLLoader();
         charPageLoader.addEventListener(Event.COMPLETE,onCharPage,false,0,true);
         charPageLoader.load(new URLRequest(rootClass.getGamePath() + "api/charpage/fvars?id=" + userName));
         this.btCharPage.addEventListener(MouseEvent.CLICK,onBtCharPage,false,0,true);
         this.btClose.addEventListener(MouseEvent.CLICK,onBtClose,false,0,true);
         txtClassName.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtWeapon.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtArmor.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtHelm.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtCape.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtPet.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         txtMisc.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
      }
      
      public function onWiki(param1:MouseEvent) : void
      {
         if(param1.currentTarget.text == "None")
         {
            return;
         }
         navigateToURL(new URLRequest("http://aqwwiki.wikidot.com/" + param1.currentTarget.text),"_blank");
      }
      
      public function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function onCharPage(param1:Event) : void
      {
         var _loc3_:Class = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(param1.target.data == "Hidden" || param1.target.data == "Empty")
         {
            _loc3_ = rootClass.world.getClass("ModalMC");
            _loc4_ = new _loc3_();
            _loc5_ = {};
            _loc5_.strBody = "User not found: " + userName;
            _loc5_.params = {};
            _loc5_.glow = "red,medium";
            _loc5_.btns = "mono";
            rootClass.stage.addChild(_loc4_);
            _loc4_.init(_loc5_);
            return;
         }
         flashvars = new URLVariables(param1.target.data.substring(1).replace("+","%2B"));
         this.txtUserName.text = flashvars.strName;
         this.txtLvl.text = flashvars.intLevel.split(" -")[0];
         if(flashvars.intLevel.indexOf(" Guild") > -1)
         {
            this.txtGuildName.text = flashvars.intLevel.split("--- ")[1].substring(0,flashvars.intLevel.split("--- ")[1].length - 6);
         }
         else
         {
            this.txtGuildName.text = "None";
         }
         this.txtClassName.text = flashvars.strClassName;
         if(this.txtClassName.text == "")
         {
            this.txtClassName.text = "None";
         }
         this.txtWeapon.text = flashvars.strWeaponName;
         if(this.txtWeapon.text == "")
         {
            this.txtWeapon.text = "None";
         }
         this.txtArmor.text = flashvars.strArmorName;
         if(this.txtArmor.text == "")
         {
            this.txtArmor.text = "None";
         }
         this.txtHelm.text = flashvars.strHelmName;
         if(this.txtHelm.text == "")
         {
            this.txtHelm.text = "None";
         }
         this.txtCape.text = flashvars.strCapeName;
         if(this.txtCape.text == "")
         {
            this.txtCape.text = "None";
         }
         this.txtPet.text = flashvars.strPetName;
         if(this.txtPet.text == "")
         {
            this.txtPet.text = "None";
         }
         if(flashvars.strMiscName)
         {
            this.txtMisc.text = flashvars.strMiscName;
            if(this.txtMisc.text == "")
            {
               this.txtMisc.text = "None";
            }
         }
         else
         {
            this.txtMisc.text = "None";
         }
         var _loc2_:String = flashvars.strFaction;
         this.txtAlignment.text = _loc2_;
         if(_loc2_ == "Neutral")
         {
            this.movFaction.gotoAndStop(2);
         }
         if(_loc2_ == "Good")
         {
            this.movFaction.gotoAndStop(3);
         }
         if(_loc2_ == "Evil")
         {
            this.movFaction.gotoAndStop(4);
         }
         if(_loc2_ == "Chaos")
         {
            this.movFaction.gotoAndStop(5);
         }
         _tempMC = new AvatarMC();
         _tempMC.world = rootClass.world;
         this.copyTo(_tempMC.mcChar);
         _tempMC.hideHPBar();
         _tempMC.name = "DisplayMC";
         this.mcCharUI.mcBG.addChild(_tempMC);
         _tempMC.x = 250;
         _tempMC.y = -30;
         _tempMC.scaleX *= -3;
         _tempMC.scaleY *= 3;
         this.visible = true;
      }
      
      public function getAchievement(param1:int) : int
      {
         if(param1 < 0 || param1 > 31)
         {
            return -1;
         }
         var _loc2_:* = flashvars.ia1;
         if(_loc2_ == null)
         {
            return -1;
         }
         return (_loc2_ & Math.pow(2,param1)) == 0 ? 0 : 1;
      }
      
      public function copyTo(param1:MovieClip) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Avatar = new Avatar(rootClass);
         _loc3_.isCharPage = true;
         _loc3_.pnm = rootClass.world.myAvatar.pnm;
         _loc3_.objData = rootClass.copyObj(rootClass.world.myAvatar.objData);
         _tempMC.pAV = _loc3_;
         _tempMC.pAV.pMC = _tempMC;
         _tempMC.pAV.objData.intColorHair = flashvars.intColorHair;
         _tempMC.pAV.objData.intColorSkin = flashvars.intColorSkin;
         _tempMC.pAV.objData.intColorEye = flashvars.intColorEye;
         _tempMC.pAV.objData.intColorBase = flashvars.intColorBase;
         _tempMC.pAV.objData.intColorTrim = flashvars.intColorTrim;
         _tempMC.pAV.objData.intColorAccessory = flashvars.intColorAccessory;
         _tempMC.pAV.objData.strHairFilename = flashvars.strHairFile;
         _tempMC.pAV.objData.strHairName = flashvars.strHairName;
         _tempMC.pAV.objData.eqp = {};
         _tempMC.pAV.objData.eqp.co = {};
         _tempMC.pAV.objData.eqp.co["sFile"] = flashvars.strClassFile;
         _tempMC.pAV.objData.eqp.co["sLink"] = flashvars.strClassLink;
         _tempMC.pAV.objData.eqp.Weapon = {};
         _tempMC.pAV.objData.eqp.Weapon["sFile"] = flashvars.strWeaponFile;
         _tempMC.pAV.objData.eqp.Weapon["sLink"] = flashvars.strWeaponLink;
         _tempMC.pAV.objData.eqp.Weapon["sType"] = flashvars.strWeaponType;
         _tempMC.pAV.objData.eqp.ba = {};
         _tempMC.pAV.objData.eqp.ba["sFile"] = flashvars.strCapeFile;
         _tempMC.pAV.objData.eqp.ba["sLink"] = flashvars.strCapeLink;
         _tempMC.pAV.objData.eqp.he = {};
         _tempMC.pAV.objData.eqp.he["sFile"] = flashvars.strHelmFile;
         _tempMC.pAV.objData.eqp.he["sLink"] = flashvars.strHelmLink;
         _tempMC.pAV.objData.eqp.mi = {};
         _tempMC.pAV.objData.eqp.mi["sFile"] = flashvars.strMiscFile;
         _tempMC.pAV.objData.eqp.mi["sLink"] = flashvars.strMiscLink;
         _tempMC.pAV.objData.strGender = flashvars.strGender;
         _tempMC.strGender = flashvars.strGender;
         _tempMC.pAV.dataLeaf.showHelm = flashvars.strHelmFile != "none" && this.getAchievement(1) == 0;
         _tempMC.pAV.dataLeaf.showCloak = flashvars.strCapeFile != "none" && this.getAchievement(0) == 0;
         _tempMC.pAV.isCharPage = true;
         var _loc4_:* = ["cape","backhair","robe","backrobe"];
         for(_loc2_ in _loc4_)
         {
            if(typeof param1[_loc4_[_loc2_]] != undefined)
            {
               param1[_loc4_[_loc2_]].visible = false;
            }
         }
         if(!_tempMC.pAV.dataLeaf.showHelm || _tempMC.pAV.objData.eqp.he.sFile == "none")
         {
            _tempMC.loadHair();
         }
         for(_loc5_ in _tempMC.pAV.objData.eqp)
         {
            _loc6_ = _tempMC.pAV.objData.eqp[_loc5_];
            switch(_loc5_)
            {
               case "Weapon":
                  _tempMC.loadWeapon(_loc6_.sFile,_loc6_.sLink);
                  break;
               case "he":
                  if(Boolean(_tempMC.pAV.dataLeaf.showHelm) && _tempMC.pAV.objData.eqp.he.sFile != "none")
                  {
                     _tempMC.loadHelm(_loc6_.sFile,_loc6_.sLink);
                  }
                  break;
               case "ba":
                  if(Boolean(_tempMC.pAV.dataLeaf.showCloak) && _tempMC.pAV.objData.eqp.ba.sFile != "none")
                  {
                     _tempMC.loadCape(_loc6_.sFile,_loc6_.sLink);
                  }
                  break;
               case "co":
                  _tempMC.loadArmor(_loc6_.sFile,_loc6_.sLink);
                  break;
               case "mi":
                  _tempMC.loadMisc(_loc6_.sFile,_loc6_.sLink);
                  break;
            }
         }
         if(flashvars.strPetFile != "none" && this.getAchievement(2) == 0)
         {
            petMC = new PetMC();
            petMC.mouseEnabled = petMC.mouseChildren = false;
            petMC.pAV = _tempMC.pAV;
            rootClass.world.queueLoad({
               "strFile":rootClass.getFilePath() + flashvars.strPetFile,
               "callBackA":onLoadPetComplete,
               "avt":_tempMC.pAV,
               "sES":"Pet"
            });
         }
      }
      
      public function onLoadPetComplete(param1:Event) : void
      {
         var _loc2_:Class = rootClass.world.getClass(flashvars.strPetLink) as Class;
         petMC.removeChildAt(1);
         petMC.mcChar = MovieClip(petMC.addChildAt(new _loc2_(),1));
         mcCharUI.mcBG.addChild(petMC);
         petMC.scale(2);
         petMC.turn("left");
         petMC.x = 50;
         petMC.y = -150;
         petMC.shadow.visible = false;
         mcCharUI.mcBG.setChildIndex(petMC,mcCharUI.mcBG.numChildren - 2);
      }
      
      public function ioErrorHandler(param1:*) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = rootClass.world.getClass("ModalMC");
         _loc3_ = new _loc2_();
         _loc4_ = {};
         _loc4_.strBody = "Connection Error";
         _loc4_.params = {};
         _loc4_.glow = "red,medium";
         _loc4_.btns = "mono";
         rootClass.stage.addChild(_loc3_);
         _loc3_.init(_loc4_);
      }
      
      public function onBtCharPage(param1:*) : void
      {
         navigateToURL(new URLRequest("https://account.aq.com/CharPage?id=" + userName),"_blank");
      }
      
      public function onBtClose(param1:*) : void
      {
         this.parent.removeChild(this);
      }
   }
}

