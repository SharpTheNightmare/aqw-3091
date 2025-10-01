package liteAssets.draw
{
   import fl.data.*;
   import fl.events.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2443")]
   public class cameraTool extends MovieClip
   {
      
      public var weaponUI:MovieClip;
      
      public var background:MovieClip;
      
      public var dummyMC:MovieClip;
      
      public var btnLeft:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var txtRight:TextField;
      
      public var btnExpand:SimpleButton;
      
      public var txtLeft:TextField;
      
      public var btnExpandTxt:TextField;
      
      public var btnRight:SimpleButton;
      
      public var cameratoolUI:MovieClip;
      
      public var AvatarDisplay:AvatarMC;
      
      internal var rootClass:MovieClip;
      
      private var op:*;
      
      private var tp:*;
      
      private var walkTS:*;
      
      private var walkD:*;
      
      public var mcCharHidden:Boolean;
      
      public var mcCharOptions:Object = {
         "backhair":false,
         "robe":false,
         "backrobe":false
      };
      
      public var scaleAvt:Number = 3;
      
      public var weaponDeattached:Boolean;
      
      public var deattachedMain:MovieClip;
      
      public var deattachedOff:MovieClip;
      
      public var weaponFocus:int = 0;
      
      public var isMirrored:Boolean;
      
      public var isMirroredOff:Boolean;
      
      public var isFrozen:Boolean;
      
      public var isStoned:Boolean;
      
      public var isHit:Boolean;
      
      public var glowMain:Boolean;
      
      public var glowOff:Boolean;
      
      public var glowPlayer:Boolean;
      
      internal var oldX:int;
      
      internal var oldY:int;
      
      public function cameraTool(param1:MovieClip)
      {
         super();
         rootClass = param1;
         this.btnExpandTxt.mouseEnabled = false;
         this.weaponUI.visible = false;
         this.dummyMC.visible = false;
         this.cameratoolUI.secondary.visible = false;
         this.btnExpand.addEventListener(MouseEvent.CLICK,onBtnExpand,false,0,true);
         AvatarDisplay = new AvatarMC();
         AvatarDisplay.world = rootClass.world;
         this.copyTo(AvatarDisplay.mcChar);
         AvatarDisplay.x = 650;
         AvatarDisplay.y = 450;
         AvatarDisplay.hideHPBar();
         AvatarDisplay.gotoAndPlay("in2");
         AvatarDisplay.mcChar.gotoAndPlay("Idle");
         this.addChild(AvatarDisplay);
         AvatarDisplay.scale(scaleAvt);
         AvatarDisplay.shadow.visible = false;
         this.cameratoolUI.primary.txtClassName.text = rootClass.world.myAvatar.objData.strClassName;
         this.background.mouseEnabled = true;
         this.background.addEventListener(MouseEvent.CLICK,onWalk,false,0,true);
         this.cameratoolUI.primary.colBG.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,onColBG,false,0,true);
         this.cameratoolUI.primary.colBG.addEventListener(Event.CLOSE,onColBG,false,0,true);
         var _loc2_:Array = [{"label":"Idle"},{"label":"Walk"},{"label":"Dance"},{"label":"Laugh"},{"label":"Point"},{"label":"Use"},{"label":"Stern"},{"label":"SternLoop"},{"label":"Salute"},{"label":"Cheer"},{"label":"Facepalm"},{"label":"Airguitar"},{"label":"Backflip"},{"label":"Sleep"},{"label":"Jump"},{"label":"Punt"},{"label":"Dance2"},{"label":"Swordplay"},{"label":"Feign"},{"label":"Dead"},{"label":"Wave"},{"label":"Bow"},{"label":"Rest"},{"label":"Cry"},{"label":"Unsheath"},{"label":"Fight"},{"label":"Attack1"},{"label":"Attack2"},{"label":"Attack3"},{"label":"Attack4"},{"label":"Hit"},{"label":"Knockout"},{"label":"Getup"},{"label":"Stab"},{"label":"Thrash"},{"label":"Castgood"},{"label":"Cast1"},{"label":"Cast2"},{"label":"Cast3"},{"label":"Sword/ShieldFight"},{"label":"Sword/ShieldAttack1"},{"label":"Sword/ShieldAttack2"},{"label":"ShieldBlock"},{"label":"DuelWield/DaggerFight"},{"label":"DuelWield/DaggerAttack1"},{"label":"DuelWield/DaggerAttack2"},{"label":"FistweaponFight"},{"label":"FistweaponAttack1"}
         ,{"label":"FistweaponAttack2"},{"label":"PolearmFight"},{"label":"PolearmAttack1"},{"label":"PolearmAttack2"},{"label":"RangedFight"},{"label":"UnarmedFight"},{"label":"UnarmedAttack1"},{"label":"UnarmedAttack2"},{"label":"KickAttack"},{"label":"FlipAttack"},{"label":"Dodge"},{"label":"Powerup"},{"label":"Kneel"},{"label":"Jumpcheer"},{"label":"Salute2"},{"label":"Cry2"},{"label":"Spar"},{"label":"Samba"},{"label":"Stepdance"},{"label":"Headbang"},{"label":"Dazed"},{"label":"Psychic1"},{"label":"Psychic2"},{"label":"Danceweapon"},{"label":"Useweapon"},{"label":"Throw"},{"label":"FireBreath"}];
         _loc2_.sortOn("label");
         this.cameratoolUI.primary.cbEmotes.dataProvider = new DataProvider(_loc2_);
         this.cameratoolUI.primary.btnEmote.addEventListener(MouseEvent.CLICK,onBtnEmote,false,0,true);
         this.cameratoolUI.primary.btnClass1.addEventListener(MouseEvent.CLICK,onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass2.addEventListener(MouseEvent.CLICK,onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass3.addEventListener(MouseEvent.CLICK,onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass4.addEventListener(MouseEvent.CLICK,onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass5.addEventListener(MouseEvent.CLICK,onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnToggleDummy.addEventListener(MouseEvent.CLICK,onBtnToggleDummy,false,0,true);
         this.dummyMC.addEventListener(MouseEvent.MOUSE_DOWN,onDummyDown,false,0,true);
         this.dummyMC.addEventListener(MouseEvent.MOUSE_UP,onDummyUp,false,0,true);
         var _loc3_:Array = [{"label":"Mainhand"},{"label":"Offhand"},{"label":"Cape"},{"label":"Helmet"},{"label":"Player"},{"label":"Shadow"},{"label":"Head"},{"label":"Robe"},{"label":"Back Robe"},{"label":"Misc"},{"label":"Backhair"}];
         _loc3_.sortOn("label");
         this.cameratoolUI.primary.cbVisibility.dataProvider = new DataProvider(_loc3_);
         this.cameratoolUI.primary.btnVisibility.addEventListener(MouseEvent.CLICK,onBtnVisibility,false,0,true);
         this.cameratoolUI.primary.numScaling.addEventListener(Event.CHANGE,onNumScaling,false,0,true);
         this.cameratoolUI.primary.btnDeattach.addEventListener(MouseEvent.CLICK,onBtnDeattach,false,0,true);
         this.cameratoolUI.primary.btnShowDeattach.addEventListener(MouseEvent.CLICK,onBtnShowDeattach,false,0,true);
         this.weaponUI.background.addEventListener(MouseEvent.MOUSE_DOWN,onWeaponUIDown,false,0,true);
         this.weaponUI.background.addEventListener(MouseEvent.MOUSE_UP,onWeaponUIUp,false,0,true);
         this.weaponUI.txtFocus.mouseEnabled = false;
         this.weaponUI.btnSetFocus.addEventListener(MouseEvent.CLICK,onBtnSetFocus,false,0,true);
         this.weaponUI.sldrRotation.addEventListener(SliderEvent.CHANGE,onSldrRotation,false,0,true);
         this.weaponUI.btnAddLayer.addEventListener(MouseEvent.CLICK,onBtnAddLayer,false,0,true);
         this.weaponUI.btnDelLayer.addEventListener(MouseEvent.CLICK,onBtnDelLayer,false,0,true);
         this.weaponUI.numWepScale.addEventListener(Event.CHANGE,onNumWepScale,false,0,true);
         this.weaponUI.btnMirror.addEventListener(MouseEvent.CLICK,onBtnMirror,false,0,true);
         this.weaponUI.btnInCombat.addEventListener(MouseEvent.CLICK,onBtnInCombat,false,0,true);
         this.cameratoolUI.primary.btnFreezePlayer.addEventListener(MouseEvent.CLICK,onBtnFreezePlayer,false,0,true);
         this.cameratoolUI.primary.btnStonePlayer.addEventListener(MouseEvent.CLICK,onBtnStonePlayer,false,0,true);
         this.cameratoolUI.primary.btnHitPlayer.addEventListener(MouseEvent.CLICK,onBtnHitPlayer,false,0,true);
         this.cameratoolUI.primary.btnResetPlayer.addEventListener(MouseEvent.CLICK,onBtnResetPlayer,false,0,true);
         this.cameratoolUI.primary.colGlow.addEventListener(Event.CLOSE,onColGlow,false,0,true);
         this.cameratoolUI.primary.colGlow.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,onColGlow,false,0,true);
         this.cameratoolUI.primary.colGlowMain.addEventListener(Event.CLOSE,onColGlowMain,false,0,true);
         this.cameratoolUI.primary.colGlowMain.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,onColGlowMain,false,0,true);
         this.cameratoolUI.primary.colGlowOff.addEventListener(Event.CLOSE,onColGlowOff,false,0,true);
         this.cameratoolUI.primary.colGlowOff.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,onColGlowOff,false,0,true);
         this.cameratoolUI.primary.btnGlowMain.addEventListener(MouseEvent.CLICK,onBtnGlowMain,false,0,true);
         this.cameratoolUI.primary.btnGlowOff.addEventListener(MouseEvent.CLICK,onBtnGlowOff,false,0,true);
         this.cameratoolUI.primary.btnGlowPlayer.addEventListener(MouseEvent.CLICK,onBtnGlowPlayer,false,0,true);
         this.cameratoolUI.secondary.btnGender.addEventListener(MouseEvent.CLICK,onBtnGender,false,0,true);
         this.cameratoolUI.secondary.btnTurnHead.addEventListener(MouseEvent.CLICK,onBtnTurnHead,false,0,true);
         this.txtLeft.mouseEnabled = false;
         this.txtRight.mouseEnabled = false;
         this.btnClose.addEventListener(MouseEvent.CLICK,onBtnClose,false,0,true);
         this.btnLeft.addEventListener(MouseEvent.CLICK,onBtnLeft,false,0,true);
         this.btnRight.addEventListener(MouseEvent.CLICK,onBtnRight,false,0,true);
      }
      
      public function onBtnLeft(param1:MouseEvent) : void
      {
         this.cameratoolUI.primary.visible = !this.cameratoolUI.primary.visible;
         this.cameratoolUI.secondary.visible = !this.cameratoolUI.secondary.visible;
      }
      
      public function onBtnRight(param1:MouseEvent) : void
      {
         this.cameratoolUI.primary.visible = !this.cameratoolUI.primary.visible;
         this.cameratoolUI.secondary.visible = !this.cameratoolUI.secondary.visible;
      }
      
      public function copyTo(param1:MovieClip) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = undefined;
         AvatarDisplay.pAV = rootClass.world.myAvatar;
         AvatarDisplay.pAV.isCameraTool = true;
         AvatarDisplay.strGender = AvatarDisplay.pAV.objData.strGender;
         var _loc3_:* = ["cape","backhair","robe","backrobe"];
         for(_loc2_ in _loc3_)
         {
            if(typeof param1[_loc3_[_loc2_]] != undefined)
            {
               param1[_loc3_[_loc2_]].visible = false;
            }
         }
         if(!AvatarDisplay.pAV.dataLeaf.showHelm || !("he" in AvatarDisplay.pAV.objData.eqp) && AvatarDisplay.pAV.objData.eqp.he == null)
         {
            AvatarDisplay.loadHair();
         }
         for(_loc4_ in rootClass.world.myAvatar.objData.eqp)
         {
            switch(_loc4_)
            {
               case "Weapon":
                  AvatarDisplay.loadWeapon(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  break;
               case "he":
                  if(AvatarDisplay.pAV.dataLeaf.showHelm)
                  {
                     AvatarDisplay.loadHelm(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "ba":
                  if(AvatarDisplay.pAV.dataLeaf.showCloak)
                  {
                     AvatarDisplay.loadCape(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "ar":
                  if(rootClass.world.myAvatar.objData.eqp.co == null)
                  {
                     AvatarDisplay.loadClass(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "co":
                  AvatarDisplay.loadArmor(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,AvatarDisplay.pAV.objData.eqp[_loc4_].sLink);
                  break;
               case "mi":
                  AvatarDisplay.loadMisc(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,AvatarDisplay.pAV.objData.eqp[_loc4_].sLink);
                  break;
            }
         }
      }
      
      public function loadWeaponOff(param1:*, param2:*) : void
      {
         rootClass.world.queueLoad({
            "strFile":rootClass.world.rootClass.getFilePath() + param1,
            "callBackA":this.onLoadWeaponOffComplete,
            "avt":AvatarDisplay.pAV,
            "sES":"weapon"
         });
      }
      
      public function onLoadWeaponOffComplete(param1:Event) : void
      {
         var AssetClass:Class = null;
         AvatarDisplay.pAV.updateLoaded();
         AvatarDisplay.mcChar.weaponOff.removeChildAt(0);
         try
         {
            AssetClass = rootClass.world.getClass(AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            AvatarDisplay.mcChar.weaponOff.addChild(new AssetClass());
         }
         catch(err:Error)
         {
            AvatarDisplay.mcChar.weaponOff.addChild(param1.target.content);
         }
         AvatarDisplay.mcChar.weaponOff.visible = true;
      }
      
      public function onBtnClose(param1:MouseEvent) : void
      {
         rootClass.world.visible = true;
         AvatarDisplay.pAV.isCameraTool = false;
         this.parent.removeChild(this);
         rootClass.stage.focus = null;
      }
      
      public function onWalk(param1:MouseEvent) : void
      {
         if(isFrozen)
         {
            return;
         }
         walkTo(param1.stageX,param1.stageY,16);
      }
      
      public function walkTo(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         param1 = param1;
         param2 = param2;
         param3 = param3;
         op = new Point(AvatarDisplay.x,AvatarDisplay.y);
         tp = new Point(param1,param2);
         _loc4_ = Point.distance(op,tp);
         walkTS = new Date().getTime();
         walkD = Math.round(1000 * (_loc4_ / (param3 * 22)));
         if(walkD > 0)
         {
            _loc5_ = op.x - tp.x;
            if(_loc5_ < 0)
            {
               AvatarDisplay.turn("right");
            }
            else
            {
               AvatarDisplay.turn("left");
            }
            if(!AvatarDisplay.mcChar.onMove)
            {
               AvatarDisplay.mcChar.onMove = true;
               if(AvatarDisplay.mcChar.currentLabel != "Walk")
               {
                  AvatarDisplay.mcChar.gotoAndPlay("Walk");
               }
            }
            AvatarDisplay.removeEventListener(Event.ENTER_FRAME,onEnterFrameWalk);
            AvatarDisplay.addEventListener(Event.ENTER_FRAME,onEnterFrameWalk,false,0,true);
         }
      }
      
      public function onEnterFrameWalk(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Boolean = false;
         var _loc7_:Point = null;
         var _loc8_:Rectangle = null;
         _loc2_ = Number(new Date().getTime());
         _loc3_ = (_loc2_ - walkTS) / walkD;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         if(Point.distance(op,tp) > 0.5 && AvatarDisplay.mcChar.onMove)
         {
            _loc4_ = AvatarDisplay.x;
            _loc5_ = AvatarDisplay.y;
            AvatarDisplay.x = Point.interpolate(tp,op,_loc3_).x;
            AvatarDisplay.y = Point.interpolate(tp,op,_loc3_).y;
            if(Math.round(_loc4_) == Math.round(AvatarDisplay.x) && Math.round(_loc5_) == Math.round(AvatarDisplay.y) && _loc2_ > walkTS + 50)
            {
               stopWalking();
            }
         }
         else
         {
            stopWalking();
         }
      }
      
      public function stopWalking() : void
      {
         if(AvatarDisplay.mcChar.onMove)
         {
            AvatarDisplay.removeEventListener(Event.ENTER_FRAME,onEnterFrameWalk);
         }
         AvatarDisplay.mcChar.onMove = false;
         AvatarDisplay.mcChar.gotoAndPlay("Idle");
      }
      
      public function onBtnExpand(param1:MouseEvent) : void
      {
         if(cameratoolUI.visible)
         {
            this.cameratoolUI.visible = false;
            this.weaponUI.visible = false;
            this.btnLeft.visible = false;
            this.btnRight.visible = false;
            this.txtLeft.visible = false;
            this.txtRight.visible = false;
            this.btnExpandTxt.text = "+";
         }
         else
         {
            this.cameratoolUI.visible = true;
            this.btnLeft.visible = true;
            this.btnRight.visible = true;
            this.txtLeft.visible = true;
            this.txtRight.visible = true;
            this.btnExpandTxt.text = "-";
         }
      }
      
      public function onColBG(param1:*) : void
      {
         var _loc2_:* = new ColorTransform();
         _loc2_.color = "0x" + param1.currentTarget.hexValue;
         this.background.transform.colorTransform = _loc2_;
      }
      
      public function onBtnEmote(param1:MouseEvent) : void
      {
         if(this.cameratoolUI.primary.cbEmotes.selectedItem.label == "Walk")
         {
            AvatarDisplay.mcChar.onMove = true;
         }
         else
         {
            AvatarDisplay.mcChar.onMove = false;
         }
         AvatarDisplay.mcChar.gotoAndPlay(this.cameratoolUI.primary.cbEmotes.selectedItem.label);
      }
      
      public function onBtnClass(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         switch(param1.currentTarget.name)
         {
            case "btnClass1":
               _loc2_ = rootClass.world.actions.active[0].anim;
               _loc3_ = rootClass.world.actions.active[0];
               break;
            case "btnClass2":
               _loc2_ = rootClass.world.actions.active[1].anim;
               _loc3_ = rootClass.world.actions.active[1];
               break;
            case "btnClass3":
               _loc2_ = rootClass.world.actions.active[2].anim;
               _loc3_ = rootClass.world.actions.active[2];
               break;
            case "btnClass4":
               _loc2_ = rootClass.world.actions.active[3].anim;
               _loc3_ = rootClass.world.actions.active[3];
               break;
            case "btnClass5":
               _loc2_ = rootClass.world.actions.active[4].anim;
               _loc3_ = rootClass.world.actions.active[4];
         }
         if(_loc2_.indexOf(",") > -1)
         {
            _loc2_ = _loc2_.split(",")[Math.round(Math.random() * (_loc2_.split(",").length - 1))];
         }
         AvatarDisplay.spFX.strl = _loc3_.strl;
         AvatarDisplay.spFX.fx = _loc3_.fx;
         AvatarDisplay.spFX.tgt = _loc3_.tgt;
         AvatarDisplay.mcChar.gotoAndPlay(_loc2_);
      }
      
      public function init_func() : void
      {
      }
      
      public function castSpellFX(param1:* = null) : *
      {
         var _loc3_:* = undefined;
         if(param1 == null)
         {
            param1 = AvatarDisplay.spFX;
         }
         var _loc2_:Class = rootClass.world.getClass(param1.strl) as Class;
         if(_loc2_ != null)
         {
            _loc3_ = new _loc2_();
            _loc3_.spellDur = 0;
            this.addChild(_loc3_);
            _loc3_.scaleX *= scaleAvt;
            _loc3_.scaleY *= scaleAvt;
            _loc3_.mouseEnabled = false;
            _loc3_.mouseChildren = false;
            _loc3_.visible = true;
            _loc3_.world = this;
            _loc3_.strl = param1.strl;
            if(Boolean(param1.tgt) && param1.tgt == "s")
            {
               _loc3_.tMC = AvatarDisplay;
            }
            else
            {
               if(!this.dummyMC.mcChar)
               {
                  this.dummyMC.mcChar = {"height":122};
               }
               _loc3_.tMC = this.dummyMC;
            }
            switch(param1.fx)
            {
               case "w":
                  _loc3_.x = _loc3_.tMC.x;
                  _loc3_.y = _loc3_.tMC.y + 3;
                  _loc3_.scaleX *= _loc3_.tMC.x < AvatarDisplay.x ? -1 : 1;
                  break;
               case "p":
                  _loc3_.x = AvatarDisplay.x;
                  _loc3_.y = AvatarDisplay.y - AvatarDisplay.mcChar.height * 0.5;
                  _loc3_.dir = _loc3_.tMC.x - AvatarDisplay.x >= 0 ? 1 : -1;
            }
         }
      }
      
      public function showSpellFXHit(param1:*) : *
      {
         var _loc2_:* = {};
         switch(param1.strl)
         {
            case "sp_ice1":
               _loc2_.strl = "sp_ice2";
               break;
            case "sp_el3":
               _loc2_.strl = "sp_el2";
               break;
            case "sp_ed3":
               _loc2_.strl = "sp_ed1";
               break;
            case "sp_ef1":
            case "sp_ef6":
               _loc2_.strl = "sp_ef2";
         }
         _loc2_.fx = "w";
         _loc2_.avts = [param1.tMC];
         this.castSpellFX(_loc2_);
      }
      
      public function onBtnToggleDummy(param1:MouseEvent) : void
      {
         this.dummyMC.visible = !this.dummyMC.visible;
      }
      
      public function onDummyDown(param1:MouseEvent) : void
      {
         this.dummyMC.startDrag();
      }
      
      public function onDummyUp(param1:MouseEvent) : void
      {
         this.dummyMC.stopDrag();
      }
      
      public function get isCharHidden() : Boolean
      {
         return mcCharHidden;
      }
      
      public function onBtnVisibility(param1:MouseEvent) : void
      {
         switch(cameratoolUI.primary.cbVisibility.selectedItem.label)
         {
            case "Mainhand":
               AvatarDisplay.mcChar.weapon.visible = !AvatarDisplay.mcChar.weapon.visible;
               break;
            case "Offhand":
               AvatarDisplay.mcChar.weaponOff.visible = !AvatarDisplay.mcChar.weaponOff.visible;
               break;
            case "Cape":
               AvatarDisplay.mcChar.cape.visible = !AvatarDisplay.mcChar.cape.visible;
               break;
            case "Helmet":
               AvatarDisplay.mcChar.head.helm.visible = !AvatarDisplay.mcChar.head.helm.visible;
               AvatarDisplay.mcChar.head.hair.visible = !AvatarDisplay.mcChar.head.helm.visible;
               break;
            case "Player":
               mcCharHidden = !mcCharHidden;
               if(!mcCharHidden)
               {
                  AvatarDisplay.mcChar.head.visible = true;
                  AvatarDisplay.mcChar.chest.visible = true;
                  AvatarDisplay.mcChar.frontshoulder.visible = true;
                  AvatarDisplay.mcChar.backshoulder.visible = true;
                  AvatarDisplay.mcChar.fronthand.visible = true;
                  AvatarDisplay.mcChar.backhand.visible = true;
                  AvatarDisplay.mcChar.frontthigh.visible = true;
                  AvatarDisplay.mcChar.backthigh.visible = true;
                  AvatarDisplay.mcChar.frontshin.visible = true;
                  AvatarDisplay.mcChar.backshin.visible = true;
                  AvatarDisplay.mcChar.idlefoot.visible = true;
                  AvatarDisplay.mcChar.backfoot.visible = true;
                  AvatarDisplay.mcChar.hip.visible = true;
                  AvatarDisplay.mcChar.robe.visible = mcCharOptions["robe"];
                  AvatarDisplay.mcChar.backrobe.visible = mcCharOptions["backrobe"];
                  AvatarDisplay.mcChar.backhair.visible = mcCharOptions["backhair"];
               }
               else
               {
                  AvatarDisplay.mcChar.head.visible = false;
                  AvatarDisplay.mcChar.chest.visible = false;
                  AvatarDisplay.mcChar.frontshoulder.visible = false;
                  AvatarDisplay.mcChar.backshoulder.visible = false;
                  AvatarDisplay.mcChar.fronthand.visible = false;
                  AvatarDisplay.mcChar.backhand.visible = false;
                  AvatarDisplay.mcChar.frontthigh.visible = false;
                  AvatarDisplay.mcChar.backthigh.visible = false;
                  AvatarDisplay.mcChar.frontshin.visible = false;
                  AvatarDisplay.mcChar.backshin.visible = false;
                  AvatarDisplay.mcChar.idlefoot.visible = false;
                  AvatarDisplay.mcChar.backfoot.visible = false;
                  AvatarDisplay.mcChar.hip.visible = false;
                  if(AvatarDisplay.mcChar.robe.visible)
                  {
                     AvatarDisplay.mcChar.robe.visible = false;
                     mcCharOptions["robe"] = true;
                  }
                  if(AvatarDisplay.mcChar.backrobe.visible)
                  {
                     AvatarDisplay.mcChar.backrobe.visible = false;
                     mcCharOptions["backrobe"] = true;
                  }
                  if(AvatarDisplay.mcChar.backhair.visible)
                  {
                     AvatarDisplay.mcChar.backhair.visible = false;
                     mcCharOptions["backhair"] = true;
                  }
               }
               break;
            case "Shadow":
               AvatarDisplay.shadow.visible = !AvatarDisplay.shadow.visible;
               break;
            case "Head":
               AvatarDisplay.mcChar.head.visible = !AvatarDisplay.mcChar.head.visible;
               break;
            case "Robe":
               AvatarDisplay.mcChar.robe.visible = !AvatarDisplay.mcChar.robe.visible;
               break;
            case "Back Robe":
               AvatarDisplay.mcChar.backrobe.visible = !AvatarDisplay.mcChar.backrobe.visible;
               break;
            case "Misc":
               AvatarDisplay.cShadow.visible = !AvatarDisplay.cShadow.visible;
               break;
            case "Backhair":
               AvatarDisplay.mcChar.backhair.visible = !AvatarDisplay.mcChar.backhair.visible;
         }
      }
      
      public function onNumScaling(param1:Event) : void
      {
         scaleAvt = this.cameratoolUI.primary.numScaling.textField.text;
         AvatarDisplay.scale(scaleAvt);
      }
      
      public function onBtnDeattach(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(weaponDeattached)
         {
            weaponDeattached = false;
            isMirrored = false;
            isMirroredOff = false;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: OFF";
            deattachedMain.removeEventListener(MouseEvent.MOUSE_DOWN,onWeaponDownDrag);
            deattachedMain.removeEventListener(MouseEvent.MOUSE_UP,onWeaponUpDrag);
            AvatarDisplay.mcChar.weapon.visible = true;
            _loc2_ = AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
            if(_loc2_ != null && _loc2_.sType != null)
            {
               if(_loc2_.sType == "Dagger")
               {
                  AvatarDisplay.mcChar.weaponOff.visible = true;
                  deattachedOff.removeEventListener(MouseEvent.MOUSE_DOWN,onWeaponOffDownDrag);
                  deattachedOff.removeEventListener(MouseEvent.MOUSE_UP,onWeaponOffUpDrag);
               }
            }
            AvatarDisplay.mcChar.removeChild(deattachedMain);
            AvatarDisplay.mcChar.removeChild(deattachedOff);
            deattachedMain = null;
            deattachedOff = null;
         }
         else
         {
            weaponDeattached = true;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: ON";
            rootClass.world.queueLoad({
               "strFile":rootClass.world.rootClass.getFilePath() + AvatarDisplay.pAV.objData.eqp.Weapon.sFile,
               "callBackA":this.onLoadWeaponClones,
               "avt":AvatarDisplay.pAV,
               "sES":"weapon"
            });
            AvatarDisplay.mcChar.weapon.visible = false;
            AvatarDisplay.mcChar.weaponOff.visible = false;
         }
      }
      
      public function onLoadWeaponClones(param1:*) : void
      {
         var wItem:Object;
         var e:* = param1;
         var AssetClass:Class = null;
         try
         {
            AssetClass = rootClass.world.getClass(AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            deattachedMain = new AssetClass();
         }
         catch(err:Error)
         {
            deattachedMain = MovieClip(e.target.content);
         }
         AvatarDisplay.mcChar.addChild(deattachedMain);
         deattachedMain.addEventListener(MouseEvent.MOUSE_DOWN,onWeaponDownDrag,false,0,true);
         deattachedMain.addEventListener(MouseEvent.MOUSE_UP,onWeaponUpDrag,false,0,true);
         deattachedMain.scaleX = deattachedMain.scaleY = 0.222;
         wItem = AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
         if(wItem != null && wItem.sType != null)
         {
            if(wItem.sType == "Dagger")
            {
               rootClass.world.queueLoad({
                  "strFile":rootClass.world.rootClass.getFilePath() + AvatarDisplay.pAV.objData.eqp.Weapon.sFile,
                  "callBackA":this.onLoadWeaponOffClones,
                  "avt":AvatarDisplay.pAV,
                  "sES":"weapon"
               });
            }
         }
      }
      
      public function onLoadWeaponOffClones(param1:*) : void
      {
         var e:* = param1;
         var AssetClass:Class = null;
         try
         {
            AssetClass = rootClass.world.getClass(AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            deattachedOff = new AssetClass();
         }
         catch(err:Error)
         {
            deattachedOff = MovieClip(e.target.content);
         }
         AvatarDisplay.mcChar.addChild(deattachedOff);
         deattachedOff.scaleX = deattachedOff.scaleY = 0.222;
         deattachedOff.addEventListener(MouseEvent.MOUSE_UP,onWeaponOffUpDrag,false,0,true);
         deattachedOff.addEventListener(MouseEvent.MOUSE_DOWN,onWeaponOffDownDrag,false,0,true);
      }
      
      public function onWeaponUpDrag(param1:MouseEvent) : void
      {
         deattachedMain.stopDrag();
      }
      
      public function onWeaponDownDrag(param1:MouseEvent) : void
      {
         deattachedMain.startDrag();
      }
      
      public function onWeaponOffUpDrag(param1:MouseEvent) : void
      {
         deattachedOff.stopDrag();
      }
      
      public function onWeaponOffDownDrag(param1:MouseEvent) : void
      {
         deattachedOff.startDrag();
      }
      
      public function onBtnShowDeattach(param1:MouseEvent) : void
      {
         if(!weaponDeattached)
         {
            this.weaponUI.visible = false;
            return;
         }
         this.weaponUI.visible = !this.weaponUI.visible;
         if(this.weaponUI.visible)
         {
            this.setChildIndex(this.weaponUI,this.numChildren - 1);
         }
      }
      
      public function onBtnSetFocus(param1:MouseEvent) : void
      {
         if(!deattachedOff)
         {
            weaponFocus = 0;
            this.weaponUI.txtFocus.text = "Mainhand";
            return;
         }
         ++weaponFocus;
         if(weaponFocus >= 3)
         {
            weaponFocus = 0;
         }
         switch(weaponFocus)
         {
            case 0:
               this.weaponUI.txtFocus.text = "Mainhand";
               break;
            case 1:
               this.weaponUI.txtFocus.text = "Offhand";
               break;
            case 2:
               this.weaponUI.txtFocus.text = "Both";
         }
      }
      
      public function onSldrRotation(param1:Event) : void
      {
         switch(weaponFocus)
         {
            case 0:
               deattachedMain.rotation = this.weaponUI.sldrRotation.value;
               break;
            case 1:
               deattachedOff.rotation = this.weaponUI.sldrRotation.value;
               break;
            case 2:
               deattachedMain.rotation = this.weaponUI.sldrRotation.value;
               deattachedOff.rotation = this.weaponUI.sldrRotation.value;
         }
      }
      
      public function onBtnAddLayer(param1:MouseEvent) : void
      {
         switch(weaponFocus)
         {
            case 0:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedMain) >= AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedMain,AvatarDisplay.mcChar.getChildIndex(deattachedMain) + 1);
               break;
            case 1:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedOff) >= AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedOff,AvatarDisplay.mcChar.getChildIndex(deattachedOff) + 1);
               break;
            case 2:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedMain) >= AvatarDisplay.mcChar.numChildren - 2 || AvatarDisplay.mcChar.getChildIndex(deattachedOff) == AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedMain,AvatarDisplay.mcChar.getChildIndex(deattachedMain) + 1);
               AvatarDisplay.mcChar.setChildIndex(deattachedOff,AvatarDisplay.mcChar.getChildIndex(deattachedOff) + 1);
               break;
         }
      }
      
      public function onBtnDelLayer(param1:MouseEvent) : void
      {
         switch(weaponFocus)
         {
            case 0:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedMain) <= 0)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedMain,AvatarDisplay.mcChar.getChildIndex(deattachedMain) - 1);
               break;
            case 1:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedOff) <= 0)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedOff,AvatarDisplay.mcChar.getChildIndex(deattachedOff) - 1);
               break;
            case 2:
               if(AvatarDisplay.mcChar.getChildIndex(deattachedMain) <= 0 || AvatarDisplay.mcChar.getChildIndex(deattachedOff) <= 0)
               {
                  return;
               }
               AvatarDisplay.mcChar.setChildIndex(deattachedMain,AvatarDisplay.mcChar.getChildIndex(deattachedMain) - 1);
               AvatarDisplay.mcChar.setChildIndex(deattachedOff,AvatarDisplay.mcChar.getChildIndex(deattachedOff) - 1);
               break;
         }
      }
      
      public function onNumWepScale(param1:Event) : void
      {
         switch(weaponFocus)
         {
            case 0:
               deattachedMain.scaleX = deattachedMain.scaleY = this.weaponUI.numWepScale.textField.text * (isMirrored ? -1 : 1);
               break;
            case 1:
               deattachedOff.scaleX = deattachedOff.scaleY = this.weaponUI.numWepScale.textField.text * (isMirroredOff ? -1 : 1);
               break;
            case 2:
               deattachedMain.scaleX = deattachedMain.scaleY = this.weaponUI.numWepScale.textField.text * (isMirrored ? -1 : 1);
               deattachedOff.scaleX = deattachedOff.scaleY = this.weaponUI.numWepScale.textField.text * (isMirroredOff ? -1 : 1);
         }
      }
      
      public function onBtnMirror(param1:MouseEvent) : void
      {
         switch(weaponFocus)
         {
            case 0:
               isMirrored = !isMirrored;
               deattachedMain.scaleX *= -1;
               break;
            case 1:
               isMirroredOff = !isMirroredOff;
               deattachedOff.scaleX *= -1;
               break;
            case 2:
               isMirrored = !isMirrored;
               isMirroredOff = !isMirroredOff;
               deattachedMain.scaleX *= -1;
               deattachedOff.scaleX *= -1;
         }
      }
      
      public function onBtnInCombat(param1:MouseEvent) : void
      {
         switch(weaponFocus)
         {
            case 0:
               if(deattachedMain.bAttack == true && deattachedMain.currentLabel != "Attack")
               {
                  deattachedMain.gotoAndPlay("Attack");
               }
               else
               {
                  deattachedMain.gotoAndPlay("Idle");
               }
               break;
            case 1:
               if(deattachedOff.bAttack == true && deattachedOff.currentLabel != "Attack")
               {
                  deattachedOff.gotoAndPlay("Attack");
               }
               else
               {
                  deattachedOff.gotoAndPlay("Idle");
               }
               break;
            case 2:
               if(deattachedMain.bAttack == true && deattachedMain.currentLabel != "Attack")
               {
                  deattachedMain.gotoAndPlay("Attack");
               }
               else
               {
                  deattachedMain.gotoAndPlay("Idle");
               }
               if(deattachedOff.bAttack == true && deattachedOff.currentLabel != "Attack")
               {
                  deattachedOff.gotoAndPlay("Attack");
               }
               else
               {
                  deattachedOff.gotoAndPlay("Idle");
               }
         }
      }
      
      public function onWeaponUIDown(param1:MouseEvent) : void
      {
         this.weaponUI.startDrag();
      }
      
      public function onWeaponUIUp(param1:MouseEvent) : void
      {
         this.weaponUI.stopDrag();
      }
      
      public function onAvatarDown(param1:MouseEvent) : void
      {
         AvatarDisplay.startDrag();
      }
      
      public function onAvatarUp(param1:MouseEvent) : void
      {
         AvatarDisplay.stopDrag();
      }
      
      public function onBtnFreezePlayer(param1:MouseEvent) : void
      {
         if(!isFrozen)
         {
            isFrozen = true;
            AvatarDisplay.mcChar.stop();
            AvatarDisplay.mcChar.addEventListener(MouseEvent.MOUSE_DOWN,onAvatarDown,false,0,true);
            AvatarDisplay.mcChar.addEventListener(MouseEvent.MOUSE_UP,onAvatarUp,false,0,true);
         }
         else
         {
            isFrozen = false;
            AvatarDisplay.mcChar.play();
            AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_DOWN,onAvatarDown);
            AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_UP,onAvatarUp);
         }
      }
      
      public function onBtnStonePlayer(param1:MouseEvent) : void
      {
         if(!isStoned)
         {
            isStoned = true;
            AvatarDisplay.modulateColor(new ColorTransform(-1.3,-1.3,-1.3,0,100,100,100,0),"+");
         }
         else
         {
            isStoned = false;
            AvatarDisplay.modulateColor(new ColorTransform(-1.3,-1.3,-1.3,0,100,100,100,0),"-");
         }
      }
      
      public function onBtnHitPlayer(param1:MouseEvent) : void
      {
         if(!isHit)
         {
            isHit = true;
            AvatarDisplay.modulateColor(new ColorTransform(0,0,0,0,255,255,255,0),"+");
         }
         else
         {
            isHit = false;
            AvatarDisplay.modulateColor(new ColorTransform(0,0,0,0,255,255,255,0),"-");
         }
      }
      
      public function onBtnResetPlayer(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(isFrozen)
         {
            isFrozen = false;
            AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_DOWN,onAvatarDown);
            AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_UP,onAvatarUp);
         }
         isStoned = false;
         isHit = false;
         glowPlayer = false;
         glowMain = false;
         glowOff = false;
         isMirrored = false;
         isMirroredOff = false;
         mcCharHidden = false;
         mcCharOptions = {
            "backhair":false,
            "robe":false,
            "backrobe":false
         };
         if(weaponDeattached)
         {
            weaponDeattached = false;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: OFF";
            deattachedMain.removeEventListener(MouseEvent.MOUSE_DOWN,onWeaponDownDrag);
            deattachedMain.removeEventListener(MouseEvent.MOUSE_UP,onWeaponUpDrag);
            AvatarDisplay.mcChar.weapon.visible = true;
            _loc2_ = AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
            if(_loc2_ != null && _loc2_.sType != null)
            {
               if(_loc2_.sType == "Dagger")
               {
                  AvatarDisplay.mcChar.weaponOff.visible = true;
                  deattachedOff.removeEventListener(MouseEvent.MOUSE_DOWN,onWeaponOffDownDrag);
                  deattachedOff.removeEventListener(MouseEvent.MOUSE_UP,onWeaponOffUpDrag);
               }
            }
            AvatarDisplay.mcChar.removeChild(deattachedMain);
            AvatarDisplay.mcChar.removeChild(deattachedOff);
            deattachedMain = null;
            deattachedOff = null;
         }
         this.removeChild(AvatarDisplay);
         AvatarDisplay = new AvatarMC();
         AvatarDisplay.world = rootClass.world;
         this.copyTo(AvatarDisplay.mcChar);
         AvatarDisplay.x = 650;
         AvatarDisplay.y = 450;
         AvatarDisplay.hideHPBar();
         AvatarDisplay.gotoAndPlay("in2");
         AvatarDisplay.mcChar.gotoAndPlay("Idle");
         this.addChild(AvatarDisplay);
         AvatarDisplay.scale(scaleAvt);
      }
      
      public function onColGlow(param1:*) : void
      {
         if(!glowPlayer)
         {
            return;
         }
         var _loc2_:* = new GlowFilter(param1.currentTarget.selectedColor,1,8,8,2,1,false,false);
         AvatarDisplay.mcChar.filters = [_loc2_];
      }
      
      public function onColGlowMain(param1:*) : void
      {
         if(!glowMain)
         {
            return;
         }
         var _loc2_:* = new GlowFilter(param1.currentTarget.selectedColor,1,8,8,2,1,false,false);
         if(weaponDeattached)
         {
            deattachedMain.filters = [_loc2_];
         }
         else
         {
            AvatarDisplay.mcChar.weapon.filters = [_loc2_];
         }
      }
      
      public function onColGlowOff(param1:*) : void
      {
         if(!glowOff)
         {
            return;
         }
         var _loc2_:* = new GlowFilter(param1.currentTarget.selectedColor,1,8,8,2,1,false,false);
         if(weaponDeattached && Boolean(deattachedOff))
         {
            deattachedOff.filters = [_loc2_];
         }
         else
         {
            AvatarDisplay.mcChar.weaponOff.filters = [_loc2_];
         }
      }
      
      public function onBtnGlowMain(param1:MouseEvent) : void
      {
         var _loc2_:* = new GlowFilter(this.cameratoolUI.primary.colGlowMain.selectedColor,1,8,8,2,1,false,false);
         if(!glowMain)
         {
            glowMain = true;
            AvatarDisplay.mcChar.weapon.filters = [_loc2_];
         }
         else
         {
            glowMain = false;
            AvatarDisplay.mcChar.weapon.filters = [];
         }
      }
      
      public function onBtnGlowOff(param1:MouseEvent) : void
      {
         var _loc2_:* = new GlowFilter(this.cameratoolUI.primary.colGlowOff.selectedColor,1,8,8,2,1,false,false);
         if(!glowOff)
         {
            glowOff = true;
            AvatarDisplay.mcChar.weaponOff.filters = [_loc2_];
         }
         else
         {
            glowOff = false;
            AvatarDisplay.mcChar.weaponOff.filters = [];
         }
      }
      
      public function onBtnGlowPlayer(param1:MouseEvent) : void
      {
         var _loc2_:* = new GlowFilter(this.cameratoolUI.primary.colGlow.selectedColor,1,8,8,2,1,false,false);
         if(!glowPlayer)
         {
            glowPlayer = true;
            AvatarDisplay.mcChar.filters = [_loc2_];
         }
         else
         {
            glowPlayer = false;
            AvatarDisplay.mcChar.filters = [];
         }
      }
      
      public function onBtnGender(param1:MouseEvent) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = undefined;
         AvatarDisplay.pAV = rootClass.world.myAvatar;
         AvatarDisplay.strGender = AvatarDisplay.strGender == "M" ? "F" : "M";
         var _loc3_:* = ["cape","backhair","robe","backrobe"];
         for(_loc2_ in _loc3_)
         {
            if(typeof AvatarDisplay.mcChar[_loc3_[_loc2_]] != undefined)
            {
               AvatarDisplay.mcChar[_loc3_[_loc2_]].visible = false;
            }
         }
         if(!AvatarDisplay.pAV.dataLeaf.showHelm || !("he" in AvatarDisplay.pAV.objData.eqp) && AvatarDisplay.pAV.objData.eqp.he == null)
         {
            AvatarDisplay.loadHair();
         }
         for(_loc4_ in rootClass.world.myAvatar.objData.eqp)
         {
            switch(_loc4_)
            {
               case "Weapon":
                  AvatarDisplay.loadWeapon(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  break;
               case "he":
                  if(AvatarDisplay.pAV.dataLeaf.showHelm)
                  {
                     AvatarDisplay.loadHelm(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "ba":
                  if(AvatarDisplay.pAV.dataLeaf.showCloak)
                  {
                     AvatarDisplay.loadCape(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "ar":
                  if(rootClass.world.myAvatar.objData.eqp.co == null)
                  {
                     AvatarDisplay.loadClass(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,null);
                  }
                  break;
               case "co":
                  AvatarDisplay.loadArmor(AvatarDisplay.pAV.objData.eqp[_loc4_].sFile,AvatarDisplay.pAV.objData.eqp[_loc4_].sLink);
                  break;
            }
         }
      }
      
      public function onBtnTurnHead(param1:MouseEvent) : void
      {
         if(!oldX)
         {
            oldX = AvatarDisplay.mcChar.head.x;
            oldY = AvatarDisplay.mcChar.head.y;
         }
         AvatarDisplay.mcChar.head.scaleX *= -1;
         if(AvatarDisplay.mcChar.head.scaleX < 0)
         {
            AvatarDisplay.mcChar.head.x -= 7;
         }
         else
         {
            AvatarDisplay.mcChar.head.x = oldX;
            AvatarDisplay.mcChar.head.y = oldY;
         }
      }
   }
}

