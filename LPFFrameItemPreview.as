package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1947")]
   public class LPFFrameItemPreview extends LPFFrame
   {
      
      public var btnFGender:SimpleButton;
      
      public var btnWiki:SimpleButton;
      
      public var tInfo:TextField;
      
      public var mcPreview:MovieClip;
      
      public var mcCoin:MovieClip;
      
      public var btnMGender:SimpleButton;
      
      public var mcUpgrade:MovieClip;
      
      public var btnDelete:SimpleButton;
      
      public var btnTry:SimpleButton;
      
      protected var iSel:Object;
      
      private var previewArgs:Object = {};
      
      protected var rootClass:MovieClip;
      
      protected var curItem:Object;
      
      private var sLinkArmor:String = "";
      
      private var sLinkCape:String = "";
      
      private var sLinkHelm:String = "";
      
      private var sLinkPet:String = "";
      
      private var sLinkWeapon:String = "";
      
      private var sLinkMisc:String = "";
      
      private var pLoaderD:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
      
      private var pLoaderC:LoaderContext = new LoaderContext(false,pLoaderD);
      
      private var loaderStack:Array = [];
      
      private var killStack:Array = [];
      
      internal var preventSpam:Boolean;
      
      public function LPFFrameItemPreview()
      {
         super();
         mcCoin.visible = false;
         mcUpgrade.visible = false;
         btnTry.visible = false;
         btnFGender.visible = false;
         btnMGender.visible = false;
         btnWiki.visible = false;
         btnTry.addEventListener(MouseEvent.CLICK,onBtnTryClick,false,0,true);
         btnTry.addEventListener(MouseEvent.MOUSE_OVER,onTryTTOver,false,0,true);
         btnTry.addEventListener(MouseEvent.MOUSE_OUT,onTryTTOut,false,0,true);
         btnMGender.addEventListener(MouseEvent.CLICK,onBtnGender,false,0,true);
         btnMGender.addEventListener(MouseEvent.MOUSE_OVER,onGenderTTOver,false,0,true);
         btnMGender.addEventListener(MouseEvent.MOUSE_OUT,onGenderTTOut,false,0,true);
         btnFGender.addEventListener(MouseEvent.CLICK,onBtnGender,false,0,true);
         btnFGender.addEventListener(MouseEvent.MOUSE_OVER,onGenderTTOver,false,0,true);
         btnFGender.addEventListener(MouseEvent.MOUSE_OUT,onGenderTTOut,false,0,true);
         btnWiki.addEventListener(MouseEvent.CLICK,onBtnWiki,false,0,true);
         btnWiki.addEventListener(MouseEvent.MOUSE_OVER,onWikiTTOver,false,0,true);
         btnWiki.addEventListener(MouseEvent.MOUSE_OUT,onWikiTTOut,false,0,true);
         btnDelete.addEventListener(MouseEvent.CLICK,onBtnDeleteClick,false,0,true);
         btnDelete.addEventListener(MouseEvent.MOUSE_OVER,onDeleteTTOver,false,0,true);
         btnDelete.addEventListener(MouseEvent.MOUSE_OUT,onDeleteTTOut,false,0,true);
         mcCoin.addEventListener(MouseEvent.MOUSE_OVER,onCoinTTOver,false,0,true);
         mcCoin.addEventListener(MouseEvent.MOUSE_OUT,onCoinTTOut,false,0,true);
         mcUpgrade.addEventListener(MouseEvent.MOUSE_OVER,onUpgradeTTOver,false,0,true);
         mcUpgrade.addEventListener(MouseEvent.MOUSE_OUT,onUpgradeTTOut,false,0,true);
         addEventListener(Event.ENTER_FRAME,onEF,false,0,true);
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         btnWiki.removeEventListener(MouseEvent.CLICK,onBtnWiki);
         btnWiki.removeEventListener(MouseEvent.MOUSE_OVER,onWikiTTOver);
         btnWiki.removeEventListener(MouseEvent.MOUSE_OUT,onWikiTTOut);
         btnTry.removeEventListener(MouseEvent.CLICK,onBtnTryClick);
         btnTry.removeEventListener(MouseEvent.MOUSE_OVER,onTryTTOver);
         btnTry.removeEventListener(MouseEvent.MOUSE_OUT,onTryTTOut);
         btnMGender.removeEventListener(MouseEvent.CLICK,onBtnGender);
         btnMGender.removeEventListener(MouseEvent.MOUSE_OVER,onGenderTTOver);
         btnMGender.removeEventListener(MouseEvent.MOUSE_OUT,onGenderTTOut);
         btnFGender.removeEventListener(MouseEvent.CLICK,onBtnGender);
         btnFGender.removeEventListener(MouseEvent.MOUSE_OVER,onGenderTTOver);
         btnFGender.removeEventListener(MouseEvent.MOUSE_OUT,onGenderTTOut);
         btnDelete.removeEventListener(MouseEvent.CLICK,onBtnDeleteClick);
         btnDelete.removeEventListener(MouseEvent.MOUSE_OVER,onDeleteTTOver);
         btnDelete.removeEventListener(MouseEvent.MOUSE_OUT,onDeleteTTOut);
         mcCoin.removeEventListener(MouseEvent.MOUSE_OVER,onCoinTTOver);
         mcCoin.removeEventListener(MouseEvent.MOUSE_OUT,onCoinTTOut);
         mcUpgrade.removeEventListener(MouseEvent.MOUSE_OVER,onUpgradeTTOver);
         mcUpgrade.removeEventListener(MouseEvent.MOUSE_OUT,onUpgradeTTOut);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function onBtnTryClick(param1:MouseEvent) : void
      {
         if(!iSel)
         {
            return;
         }
         rootClass.xTryMe(iSel);
         if(rootClass.ui.mcPopup.currentLabel == "MergeShop")
         {
            rootClass.ui.mcPopup.getChildByName("mcShop").fClose();
         }
         else
         {
            rootClass.ui.mcPopup.getChildByName("mcShop").previewPanel.visible = false;
         }
         rootClass.ui.ToolTip.close();
      }
      
      protected function onBtnWiki(param1:MouseEvent) : void
      {
         if(!iSel)
         {
            return;
         }
         navigateToURL(new URLRequest("http://aqwwiki.wikidot.com/" + iSel.sName),"_blank");
      }
      
      protected function onBtnGender(param1:MouseEvent) : void
      {
         if(preventSpam || !iSel)
         {
            return;
         }
         clearPreview();
         var _loc2_:String = param1.currentTarget.name == "btnMGender" ? "F" : "M";
         btnMGender.visible = _loc2_ == "M";
         btnFGender.visible = _loc2_ == "F";
         sLinkArmor = iSel.sLink;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + "classes/" + _loc2_ + "/" + iSel.sFile),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadArmorComplete,false,0,true);
         addToLoaderStack(_loc3_);
         preventSpam = true;
      }
      
      protected function fDraw() : void
      {
         btnDelete.visible = false;
         var _loc1_:String = "";
         var _loc2_:String = "";
         var _loc3_:String = "#00CCFF";
         var _loc4_:Object = iSel;
         if(_loc4_ != null)
         {
            btnDelete.visible = true;
            tInfo.htmlText = rootClass.getItemInfoStringB(_loc4_);
            tInfo.y = tInfo.textHeight >= 109.8 ? int(btnDelete.y + btnDelete.height - tInfo.height + 10) : int(btnDelete.y + btnDelete.height - tInfo.textHeight - 3);
            mcUpgrade.visible = false;
            mcCoin.visible = false;
            if(_loc4_.bUpg == 1)
            {
               mcUpgrade.visible = true;
            }
            if(_loc4_.bCoins == 1)
            {
               mcUpgrade.visible = false;
               mcCoin.visible = true;
            }
            loadPreview(_loc4_);
         }
         else
         {
            tInfo.htmlText = "Please select an item to preview.";
            while(mcPreview.numChildren > 0)
            {
               mcPreview.removeChildAt(0);
            }
            clearPreview();
         }
         btnDelete.visible = true;
         if(getLayout().sMode.toLowerCase().indexOf("shop") > -1)
         {
            btnDelete.visible = false;
         }
         if(_loc4_ != null)
         {
            if(!btnDelete.visible && _loc4_.sType != "Enhancement")
            {
               switch(_loc4_.sES)
               {
                  case "Weapon":
                  case "he":
                  case "ba":
                  case "pe":
                  case "ar":
                  case "co":
                  case "mi":
                     if(_loc4_.bUpg == 1)
                     {
                        if(!rootClass.world.myAvatar.isUpgraded())
                        {
                           btnTry.visible = false;
                           break;
                        }
                     }
                     btnTry.visible = true;
                     break;
                  case "ho":
                  case "hi":
                  default:
                     btnTry.visible = false;
               }
            }
            if(_loc4_.sType != "Enhancement")
            {
               switch(_loc4_.sES)
               {
                  case "ar":
                  case "co":
                     if(rootClass.world.myAvatar.objData.strGender == "M")
                     {
                        btnFGender.visible = false;
                        btnMGender.visible = true;
                     }
                     else
                     {
                        btnFGender.visible = true;
                        btnMGender.visible = false;
                     }
                     break;
                  default:
                     btnFGender.visible = false;
                     btnMGender.visible = false;
               }
            }
            if(!btnFGender.visible && !btnMGender.visible)
            {
               btnWiki.y = btnMGender.y;
            }
            else
            {
               btnWiki.y = 121;
            }
            if(!btnTry.visible && !btnDelete.visible)
            {
               btnWiki.y = btnTry.y;
            }
            btnWiki.visible = true;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         iSel = null;
         if(param1.fData.eSel != null)
         {
            iSel = param1.fData.eSel;
         }
         if(param1.fData.iSel != null)
         {
            iSel = param1.fData.iSel;
         }
         fDraw();
      }
      
      protected function onBtnDeleteClick(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         rootClass.mixer.playSound("Click");
         if(iSel.bEquip && iSel.sType != "Wall Item" && iSel.sType != "Floor Item" || iSel.bEquip >= iSel.iQty)
         {
            if(iSel.sType == "Wall Item" || iSel.sType == "Floor Item")
            {
               rootClass.MsgBox.notify("Item is currently placed in your house!");
            }
            else
            {
               rootClass.MsgBox.notify("Item is currently equipped!");
            }
         }
         else
         {
            _loc2_ = new ModalMC();
            _loc3_ = {};
            _loc3_.params = {};
            if(iSel.bCoins != null && iSel.bCoins == 1 && (iSel.iQty > 0 || iSel.sES == "ar"))
            {
               _loc3_.strBody = "<font color=\'#FF0000\'><b>AC items can not be deleted!</b></font>\n\nYou may sell the item if you really want, but there is no limit on AC item storage!";
               _loc3_.btns = "mono";
            }
            else
            {
               if(iSel.sES == "ar")
               {
                  _loc3_.strBody = "Are you sure you want to delete \'" + iSel.sName + "\' and the rank associated with it?";
               }
               else
               {
                  _loc3_.strBody = "Are you sure you want to delete \'" + iSel.sName + "\'?";
               }
               _loc3_.callback = deleteRequest;
               _loc4_ = iSel.iQty != null ? int(iSel.iQty) : 1;
               if(iSel.sES == "ar")
               {
                  _loc4_ = 1;
               }
               if(_loc4_ > 1)
               {
                  if(iSel.sType == "Wall Item" || iSel.sType == "Floor Item")
                  {
                     _loc5_ = int(iSel.iQty) - int(iSel.bEquip);
                     if(_loc5_ > 1)
                     {
                        _loc3_.qtySel = {
                           "min":1,
                           "max":_loc5_
                        };
                     }
                  }
                  else
                  {
                     _loc3_.qtySel = {
                        "min":1,
                        "max":_loc4_
                     };
                  }
               }
            }
            _loc3_.glow = "white,medium";
            _loc3_.greedy = true;
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
      }
      
      protected function deleteRequest(param1:Object) : void
      {
         if(param1.accept)
         {
            if(param1.iQty != null)
            {
               rootClass.world.sendRemoveItemRequest(iSel,param1.iQty);
            }
            else
            {
               rootClass.world.sendRemoveItemRequest(iSel);
            }
         }
      }
      
      protected function loadPreview(param1:Object) : void
      {
         if(param1.sType.toLowerCase() != "enhancement")
         {
            if(curItem != param1)
            {
               curItem = param1;
               switch(param1.sES)
               {
                  case "Weapon":
                     loadWeapon(param1.sFile,param1.sLink);
                     break;
                  case "he":
                     loadHelm(param1.sFile,param1.sLink);
                     break;
                  case "ba":
                     loadCape(param1.sFile,param1.sLink);
                     break;
                  case "pe":
                     loadPet(param1.sFile,param1.sLink);
                     break;
                  case "ar":
                  case "co":
                     loadArmor(param1.sFile,param1.sLink);
                     break;
                  case "ho":
                     loadHouse(param1.sFile);
                     break;
                  case "hi":
                     loadHouseItem(param1.sFile,param1.sLink);
                     break;
                  case "mi":
                     loadMisc(param1.sFile,param1.sLink);
                     break;
                  default:
                     if(param1.sType.toLowerCase() == "item" && String(param1.sLink).toLowerCase() != "none")
                     {
                        loadBag(param1);
                     }
                     else if(param1.sES == "am")
                     {
                        loadBag(param1,true);
                     }
                     else if(param1.sType.toLowerCase() == "serveruse" || param1.sType.toLowerCase() == "clientuse")
                     {
                        loadBag(param1);
                     }
                     else
                     {
                        clearPreview();
                     }
               }
            }
         }
         else
         {
            loadEnhancement(param1);
         }
      }
      
      protected function clearPreview() : void
      {
         var _loc3_:int = 0;
         clearLoaderStack();
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         while(_loc2_ < mcPreview.numChildren)
         {
            _loc1_ = true;
            if("fClose" in MovieClip(mcPreview.getChildAt(_loc2_)))
            {
               rootClass.recursiveStop(MovieClip(mcPreview.getChildAt(_loc2_)));
               _loc3_ = 0;
               while(_loc3_ < killStack.length)
               {
                  if(killStack[_loc3_].mc == mcPreview.getChildAt(_loc2_))
                  {
                     _loc1_ = false;
                  }
                  _loc3_++;
               }
               if(_loc1_)
               {
                  killStack.push({
                     "c":0,
                     "mc":mcPreview.getChildAt(_loc2_)
                  });
               }
            }
            else
            {
               mcPreview.removeChildAt(_loc2_);
               _loc2_--;
            }
            _loc2_++;
         }
         curItem = null;
      }
      
      protected function loadEnhancement(param1:*) : void
      {
         var mc:MovieClip = null;
         var AssetClass:Class = null;
         var item:* = param1;
         clearPreview();
         try
         {
            AssetClass = rootClass.world.getClass("iidesign") as Class;
            mc = new AssetClass();
         }
         catch(err:Error)
         {
         }
         mc.scaleX = mc.scaleY = 3;
         mcPreview.addChild(mc);
         addGlow(mc);
      }
      
      protected function loadBag(param1:*, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         clearPreview();
         var _loc4_:Class = rootClass.world.getClass("iibag") as Class;
         if(param2 || (param1 == null || !("sFile" in param1) || String(param1.sFile).length < 1 || rootClass.world.getClass(param1.sFile) == null))
         {
            _loc4_ = rootClass.world.getClass(param1.sIcon) as Class;
         }
         else if(param1 != null && "sFile" in param1 && String(param1.sFile).length > 0 && rootClass.world.getClass(param1.sFile) != null)
         {
            _loc4_ = rootClass.world.getClass(param1.sFile) as Class;
         }
         try
         {
            _loc3_ = new _loc4_();
            _loc3_.scaleX = _loc3_.scaleY = 3;
            mcPreview.addChild(_loc3_);
            addGlow(_loc3_);
         }
         catch(e:Error)
         {
         }
      }
      
      protected function loadMisc(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkMisc = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadMiscComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function loadWeapon(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkWeapon = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadWeaponComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function loadCape(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkCape = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadCapeComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function loadHelm(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkHelm = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHelmComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function loadPet(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkPet = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadPetComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function loadHouse(param1:*) : void
      {
         clearPreview();
         var _loc2_:* = "maps/" + param1.substr(0,-4) + "_preview.swf";
         previewArgs.sFile = param1;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + _loc2_),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHouseComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function onLoadHouseComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:* = previewArgs.sFile.substr(0,-4).substr(previewArgs.sFile.lastIndexOf("/") + 1).split("-").join("_") + "_preview";
         var _loc3_:Class = pLoaderD.getDefinition(_loc2_) as Class;
         var _loc4_:* = new _loc3_();
         mcPreview.addChild(_loc4_);
         addGlow(_loc4_);
      }
      
      protected function loadArmor(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkArmor = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + "classes/" + rootClass.world.myAvatar.objData.strGender + "/" + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadArmorComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function onLoadMiscComplete(param1:Event) : void
      {
         var mc:MovieClip = null;
         var AssetClass:Class = null;
         var e:Event = param1;
         removeFromLoaderStack(e.target);
         try
         {
            AssetClass = pLoaderD.getDefinition(sLinkMisc) as Class;
            mc = new AssetClass();
         }
         catch(err:Error)
         {
            mc = e.target.content;
         }
         mcPreview.addChild(mc);
         addGlow(mc);
      }
      
      protected function onLoadWeaponComplete(param1:Event) : void
      {
         var mc:MovieClip = null;
         var AssetClass:Class = null;
         var e:Event = param1;
         removeFromLoaderStack(e.target);
         try
         {
            AssetClass = pLoaderD.getDefinition(sLinkWeapon) as Class;
            mc = new AssetClass();
         }
         catch(err:Error)
         {
            mc = e.target.content;
         }
         mc.scaleX = mc.scaleY = 0.3;
         mcPreview.addChild(mc);
         addGlow(mc);
      }
      
      protected function onLoadCapeComplete(param1:Event) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         removeFromLoaderStack(param1.target);
         try
         {
            _loc2_ = pLoaderD.getDefinition(sLinkCape) as Class;
            _loc3_ = new _loc2_();
            _loc3_.scaleX = _loc3_.scaleY = 0.5;
            mcPreview.addChild(_loc3_);
            addGlow(_loc3_);
         }
         catch(e:Error)
         {
         }
      }
      
      protected function onLoadHelmComplete(param1:Event) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         var _loc4_:Class = null;
         var _loc5_:* = undefined;
         removeFromLoaderStack(param1.target);
         try
         {
            _loc2_ = pLoaderD.getDefinition(sLinkHelm) as Class;
            _loc3_ = new _loc2_();
            _loc3_.scaleX = _loc3_.scaleY = 0.8;
            mcPreview.addChild(_loc3_);
            try
            {
               _loc4_ = pLoaderD.getDefinition(sLinkHelm + "_backhair") as Class;
               if(_loc4_ != null)
               {
                  _loc5_ = new _loc4_();
                  _loc5_.x = _loc3_.getChildAt(0).x + 1;
                  _loc5_.y = _loc3_.getChildAt(0).y - 28;
                  _loc5_.scaleX = _loc5_.scaleY = 3.2;
                  _loc3_.addChild(_loc5_);
                  _loc3_.setChildIndex(_loc5_,0);
               }
            }
            catch(e0:Error)
            {
            }
            addGlow(_loc3_);
         }
         catch(e:Error)
         {
         }
      }
      
      protected function onLoadArmorComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:* = mcPreview.addChild(new AvatarMC());
         _loc2_.visible = false;
         _loc2_.strGender = rootClass.world.myAvatar.objData.strGender;
         if(btnMGender.visible || btnFGender.visible)
         {
            _loc2_.strGender = btnMGender.visible ? "M" : "F";
         }
         _loc2_.pAV = rootClass.world.myAvatar;
         _loc2_.world = MovieClip(Game.root).world;
         _loc2_.hideHPBar();
         _loc2_.name = "previewMCB";
         addGlow(_loc2_.mcChar,false);
         _loc2_.loadArmorPiecesFromDomain(sLinkArmor,pLoaderD);
         _loc2_.visible = true;
         preventSpam = false;
      }
      
      protected function onLoadPetComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:Class = pLoaderD.getDefinition(sLinkPet) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = 2;
         mcPreview.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      protected function addGlow(param1:MovieClip, param2:Boolean = true) : void
      {
         var _loc3_:* = new GlowFilter(16777215,1,8,8,2,1,false,false);
         param1.filters = [_loc3_];
         if(param2)
         {
            repositionPreview(param1);
         }
      }
      
      public function repositionPreview(param1:MovieClip) : void
      {
         var _loc2_:Rectangle = param1.getBounds(this);
         if(_loc2_.height > 175)
         {
            param1.scaleX *= 175 / _loc2_.height;
            param1.scaleY *= 175 / _loc2_.height;
         }
         param1.x -= int(param1.getBounds(this).x + param1.getBounds(this).width / 2 - this.width / 2);
         param1.y = int(param1.y - param1.getBounds(this).y);
      }
      
      protected function loadHouseItem(param1:*, param2:*) : void
      {
         clearPreview();
         var _loc3_:* = new Loader();
         previewArgs.sLink = param2;
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onloadHouseItemComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      protected function onloadHouseItemComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:Class = pLoaderD.getDefinition(previewArgs.sLink) as Class;
         var _loc3_:* = new _loc2_();
         mcPreview.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      protected function onWikiTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Search on Wiki"});
      }
      
      protected function onWikiTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function onGenderTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Switch Gender"});
      }
      
      protected function onGenderTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function onTryTTOver(param1:MouseEvent) : void
      {
         if(Boolean(rootClass.world.myAvatar.objData.eqp[iSel.sES]) && iSel.sFile == rootClass.world.myAvatar.objData.eqp[iSel.sES].sFile)
         {
            rootClass.ui.ToolTip.openWith({"str":"Revert Try Me"});
         }
         else
         {
            rootClass.ui.ToolTip.openWith({"str":"Try Me!"});
         }
      }
      
      protected function onTryTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function onDeleteTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Delete item"});
      }
      
      protected function onDeleteTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function onCoinTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"This item requires Adventure Coins to purchase."});
      }
      
      protected function onCoinTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function onUpgradeTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"This item is exclusive to upgraded members."});
      }
      
      protected function onUpgradeTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      protected function addToLoaderStack(param1:Loader) : void
      {
         clearLoaderStack();
         loaderStack.push(param1);
      }
      
      protected function removeFromLoaderStack(param1:Object) : void
      {
         var _loc2_:Loader = null;
         for each(_loc2_ in loaderStack)
         {
            if(_loc2_.contentLoaderInfo == param1)
            {
               loaderStack.splice(loaderStack.indexOf(_loc2_),1);
            }
         }
      }
      
      protected function clearLoaderStack() : void
      {
         var _loc1_:Loader = null;
         while(loaderStack.length > 0)
         {
            _loc1_ = loaderStack.shift();
            try
            {
               _loc1_.removeEventListener(Event.INIT,onLoadWeaponComplete);
               _loc1_.removeEventListener(Event.INIT,onLoadArmorComplete);
               _loc1_.removeEventListener(Event.COMPLETE,onLoadCapeComplete);
               _loc1_.removeEventListener(Event.COMPLETE,onLoadHelmComplete);
               _loc1_.removeEventListener(Event.COMPLETE,onLoadPetComplete);
               _loc1_.removeEventListener(Event.COMPLETE,onLoadHouseComplete);
               _loc1_.removeEventListener(Event.COMPLETE,onloadHouseItemComplete);
               _loc1_.close();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      protected function onEF(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < killStack.length)
         {
            if(killStack[_loc2_].c++ > 2)
            {
               mcPreview.removeChild(killStack[_loc2_].mc);
               killStack.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
      }
   }
}

