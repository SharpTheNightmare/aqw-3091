package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2113")]
   public class BankPreview extends MovieClip
   {
      
      public var tInfo:TextField;
      
      public var mcPreview:MovieClip;
      
      public var mcCoin:MovieClip;
      
      public var mcUpgrade:MovieClip;
      
      public var btnDelete:SimpleButton;
      
      private var iSel:Object;
      
      private var previewArgs:Object = {};
      
      private var rootClass:MovieClip;
      
      private var curItem:Object;
      
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
      
      public function BankPreview()
      {
         super();
         mcCoin.visible = false;
         mcUpgrade.visible = false;
         btnDelete.addEventListener(MouseEvent.CLICK,onBtnDeleteClick,false,0,true);
         btnDelete.addEventListener(MouseEvent.MOUSE_OVER,onDeleteTTOver,false,0,true);
         btnDelete.addEventListener(MouseEvent.MOUSE_OUT,onDeleteTTOut,false,0,true);
         mcCoin.addEventListener(MouseEvent.MOUSE_OVER,onCoinTTOver,false,0,true);
         mcCoin.addEventListener(MouseEvent.MOUSE_OUT,onCoinTTOut,false,0,true);
         mcUpgrade.addEventListener(MouseEvent.MOUSE_OVER,onUpgradeTTOver,false,0,true);
         mcUpgrade.addEventListener(MouseEvent.MOUSE_OUT,onUpgradeTTOut,false,0,true);
         addEventListener(Event.ENTER_FRAME,onEF,false,0,true);
      }
      
      public function Open(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         this.x = param1.r.x;
         this.y = param1.r.y;
         this.width = param1.r.w;
         this.height = param1.r.h;
         iSel = param1.item;
         fDraw();
      }
      
      public function fClose() : void
      {
         btnDelete.removeEventListener(MouseEvent.CLICK,onBtnDeleteClick);
         btnDelete.removeEventListener(MouseEvent.MOUSE_OVER,onDeleteTTOver);
         btnDelete.removeEventListener(MouseEvent.MOUSE_OUT,onDeleteTTOut);
         mcCoin.removeEventListener(MouseEvent.MOUSE_OVER,onCoinTTOver);
         mcCoin.removeEventListener(MouseEvent.MOUSE_OUT,onCoinTTOut);
         mcUpgrade.removeEventListener(MouseEvent.MOUSE_OVER,onUpgradeTTOver);
         mcUpgrade.removeEventListener(MouseEvent.MOUSE_OUT,onUpgradeTTOut);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function Show(param1:Object) : void
      {
         if(param1 == null)
         {
            Hide();
            return;
         }
         iSel = param1;
         fDraw();
         this.visible = true;
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      protected function fDraw() : void
      {
         var _loc4_:Object = null;
         btnDelete.visible = false;
         var _loc1_:String = "";
         var _loc2_:String = "";
         var _loc3_:String = "#00CCFF";
         _loc4_ = iSel;
         if(_loc4_ != null)
         {
            btnDelete.visible = true;
            tInfo.htmlText = rootClass.getItemInfoStringB(_loc4_);
            tInfo.y = int(btnDelete.y + btnDelete.height - tInfo.textHeight - 3);
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
            while(mcPreview.numChildren > 0)
            {
               mcPreview.removeChildAt(0);
            }
            clearPreview();
         }
         btnDelete.visible = false;
      }
      
      private function onBtnDeleteClick(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         rootClass.mixer.playSound("Click");
         if(iSel.bEquip)
         {
            rootClass.MsgBox.notify("Item is currently equipped!");
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
                  _loc3_.qtySel = {
                     "min":1,
                     "max":_loc4_
                  };
               }
            }
            _loc3_.glow = "white,medium";
            _loc3_.greedy = true;
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
      }
      
      public function deleteRequest(param1:Object) : void
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
      
      private function loadPreview(param1:Object) : void
      {
         if(param1.sType.toLowerCase() != "enhancement")
         {
            if(curItem != param1)
            {
               curItem = param1;
               switch(param1.sType)
               {
                  case "House":
                     loadHouse(param1.sFile);
                     return;
                  case "Wall Item":
                  case "Floor Item":
                     loadHouseItem(param1.sFile,param1.sLink);
                     return;
                  default:
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
         }
         else
         {
            loadEnhancement(param1);
         }
      }
      
      private function clearPreview() : void
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
      
      private function loadEnhancement(param1:*) : void
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
      
      private function loadBag(param1:*, param2:Boolean = false) : void
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
      
      private function loadMisc(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkMisc = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadMiscComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function loadWeapon(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkWeapon = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadWeaponComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function loadCape(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkCape = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadCapeComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function loadHelm(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkHelm = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHelmComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function loadPet(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkPet = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadPetComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function loadHouse(param1:*) : void
      {
         clearPreview();
         var _loc2_:* = "maps/" + param1.substr(0,-4) + "_preview.swf";
         previewArgs.sFile = param1;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + _loc2_),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHouseComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function onLoadHouseComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:* = previewArgs.sFile.substr(0,-4).substr(previewArgs.sFile.lastIndexOf("/") + 1).split("-").join("_") + "_preview";
         var _loc3_:Class = pLoaderD.getDefinition(_loc2_) as Class;
         var _loc4_:* = new _loc3_();
         mcPreview.addChild(_loc4_);
         addGlow(_loc4_);
      }
      
      private function loadArmor(param1:*, param2:*) : void
      {
         clearPreview();
         sLinkArmor = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + "classes/" + rootClass.world.myAvatar.objData.strGender + "/" + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadArmorComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function onLoadMiscComplete(param1:Event) : void
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
      
      private function onLoadWeaponComplete(param1:Event) : void
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
      
      private function onLoadCapeComplete(param1:Event) : void
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
      
      private function onLoadHelmComplete(param1:Event) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         removeFromLoaderStack(param1.target);
         try
         {
            _loc2_ = pLoaderD.getDefinition(sLinkHelm) as Class;
            _loc3_ = new _loc2_();
            _loc3_.scaleX = _loc3_.scaleY = 0.8;
            mcPreview.addChild(_loc3_);
            addGlow(_loc3_);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onLoadArmorComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:* = mcPreview.addChild(new AvatarMC());
         _loc2_.visible = false;
         _loc2_.strGender = rootClass.world.myAvatar.objData.strGender;
         _loc2_.pAV = rootClass.world.myAvatar;
         _loc2_.world = MovieClip(Game.root).world;
         _loc2_.hideHPBar();
         _loc2_.name = "previewMCB";
         addGlow(_loc2_.mcChar,false);
         _loc2_.loadArmorPiecesFromDomain(sLinkArmor,pLoaderD);
         _loc2_.visible = true;
      }
      
      private function onLoadPetComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:Class = pLoaderD.getDefinition(sLinkPet) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.scaleX = _loc3_.scaleY = 2;
         mcPreview.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      private function addGlow(param1:MovieClip, param2:Boolean = true) : void
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
      
      private function loadHouseItem(param1:*, param2:*) : void
      {
         clearPreview();
         var _loc3_:* = new Loader();
         previewArgs.sLink = param2;
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onloadHouseItemComplete,false,0,true);
         addToLoaderStack(_loc3_);
      }
      
      private function onloadHouseItemComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:Class = pLoaderD.getDefinition(previewArgs.sLink) as Class;
         var _loc3_:* = new _loc2_();
         mcPreview.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      private function onDeleteTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Delete item"});
      }
      
      private function onDeleteTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      private function onCoinTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"This item requires Adventure Coins to purchase."});
      }
      
      private function onCoinTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      private function onUpgradeTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"This item is exclusive to upgraded members."});
      }
      
      private function onUpgradeTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      private function addToLoaderStack(param1:Loader) : void
      {
         clearLoaderStack();
         loaderStack.push(param1);
      }
      
      private function removeFromLoaderStack(param1:Object) : void
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
      
      private function clearLoaderStack() : void
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
      
      private function onEF(param1:Event) : void
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

