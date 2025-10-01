package liteAssets.draw
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol731")]
   public class qRewardPrev extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public var world:MovieClip;
      
      public var rootClass:MovieClip;
      
      public var qData:Object = null;
      
      internal var qMode:String = null;
      
      internal var choiceID:int = -1;
      
      internal var isOpen:Boolean = false;
      
      internal var mc:MovieClip;
      
      internal var mDown:Boolean = false;
      
      internal var hRun:int = 0;
      
      internal var dRun:int = 0;
      
      internal var mbY:int = 0;
      
      internal var mhY:int = 0;
      
      internal var mbD:int = 0;
      
      internal var qly:int = 70;
      
      internal var qdy:int = 58;
      
      internal var qla:Array = [];
      
      internal var qlb:Array = [];
      
      public var qIDs:Array = [];
      
      public var sIDs:Array = [];
      
      public var tIDs:Array = [];
      
      private var previewArgs:Object = {};
      
      private var curItem:Object;
      
      private var sLinkArmor:String = "";
      
      private var sLinkCape:String = "";
      
      private var sLinkHelm:String = "";
      
      private var sLinkPet:String = "";
      
      private var sLinkWeapon:String = "";
      
      private var pLoaderD:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
      
      private var pLoaderC:LoaderContext = new LoaderContext(false,pLoaderD);
      
      private var loaderStack:Array = [];
      
      private var killStack:Array = [];
      
      internal var mcPreview:MovieClip;
      
      internal var rItem:Object;
      
      public function qRewardPrev(param1:Object)
      {
         super();
         addFrameScript(6,frame7,11,frame12,15,frame16);
         this.rItem = param1;
         mc = MovieClip(this);
         mc.name = "qRewardPrev";
         mc.x = 377.1 - 5;
         mc.y = 65;
         mc.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK,xClick);
      }
      
      public function tryClick(param1:MouseEvent) : void
      {
         rootClass.xTryMe(rItem);
         fClose();
      }
      
      public function isDropPreview() : void
      {
         mc.x -= 75;
      }
      
      public function open() : *
      {
         rootClass = MovieClip(this.stage.getChildAt(0));
         world = rootClass.world;
         mc = MovieClip(this);
         mc.cnt.bg.fx.visible = false;
         if(rootClass.isDialoqueUp())
         {
            mc.cnt.bg.fx.visible = true;
         }
         if(!isOpen)
         {
            isOpen = true;
            mc.cnt.gotoAndPlay("intro");
         }
         else
         {
            isOpen = false;
            fClose();
         }
         switch(rItem.sES)
         {
            case "Weapon":
            case "he":
            case "ba":
            case "pe":
            case "ar":
            case "co":
               if(rItem.bUpg == 1)
               {
                  if(!world.myAvatar.isUpgraded())
                  {
                     mc.cnt.bg.btnTry.visible = false;
                     break;
                  }
               }
               mc.cnt.bg.btnTry.visible = true;
               break;
            case "ho":
            case "hi":
            default:
               mc.cnt.bg.btnTry.visible = false;
         }
         mc.cnt.bg.btnPin.visible = false;
         mc.cnt.bg.btnWiki.visible = true;
         if(mc.cnt.bg.btnTry.visible)
         {
            mc.cnt.bg.btnWiki.y = 57.3;
         }
         mc.cnt.bg.btnWiki.addEventListener(MouseEvent.CLICK,onWikiClick,false,0,true);
         mc.cnt.bg.btnTry.addEventListener(MouseEvent.CLICK,tryClick,false,0,true);
      }
      
      public function onWikiClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://aqwwiki.wikidot.com/" + rItem.sName),"_blank");
      }
      
      public function showQuestList() : *
      {
         buildReward();
         mc.cnt.strTitle.x = 53;
         mc.cnt.strTitle.width = 256;
         mc.cnt.strTitle.htmlText = rItem.sName;
         mc.cnt.strTitle.mouseEnabled = false;
         mc.cnt.qList.visible = true;
         mc.cnt.qList.mHi.visible = false;
         mc.cnt.mouseChildren = true;
         mcPreview.mouseEnabled = mcPreview.mouseChildren = false;
      }
      
      private function buildReward() : *
      {
         mcPreview = mc.cnt.qList;
         var _loc1_:* = mc.cnt.scr;
         var _loc2_:* = mc.cnt.bMask;
         _loc1_.visible = false;
         while(mcPreview.numChildren > 0)
         {
            mcPreview.removeChildAt(0);
         }
         loadPreview(rItem);
      }
      
      private function loadPreview(param1:Object) : void
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
                  default:
                     loadBag(param1);
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
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         try
         {
            clearPreview();
            _loc2_ = "maps/" + curItem.sFile.substr(0,-4) + "_preview.swf";
            _loc3_ = new Loader();
            _loc3_.load(new URLRequest(Game.serverFilePath + _loc2_),pLoaderC);
            _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHouseComplete,false,0,true);
            addToLoaderStack(_loc3_);
         }
         catch(e:*)
         {
         }
      }
      
      private function onLoadHouseComplete(param1:Event) : void
      {
         removeFromLoaderStack(param1.target);
         var _loc2_:* = curItem.sFile.substr(0,-4).substr(curItem.sFile.lastIndexOf("/") + 1).split("-").join("_") + "_preview";
         var _loc3_:Class = pLoaderD.getDefinition(_loc2_) as Class;
         var _loc4_:* = new _loc3_();
         _loc4_.x = 150;
         _loc4_.y = 200;
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
         _loc2_.scaleX *= 2;
         _loc2_.scaleY *= 2;
         _loc2_.x = 150;
         _loc2_.y = 250;
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
         param1.mouseEnabled = param1.mouseChildren = false;
         if(param2)
         {
            repositionPreview(param1);
         }
      }
      
      public function repositionPreview(param1:MovieClip) : void
      {
         var _loc2_:Rectangle = param1.getBounds(mc.cnt.bMask);
         if(_loc2_.height > 175)
         {
            param1.scaleX *= 175 / _loc2_.height;
            param1.scaleY *= 175 / _loc2_.height;
         }
         param1.x -= int(param1.getBounds(mc.cnt.bMask).x + param1.getBounds(mc.cnt.bMask).width / 2 - mc.cnt.bMask.width / 2);
         param1.y -= int(param1.getBounds(mc.cnt.bMask).y + param1.getBounds(mc.cnt.bMask).height / 2 - mc.cnt.bMask.height / 2);
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
      
      private function xClick(param1:MouseEvent) : *
      {
         fClose();
      }
      
      public function fClose() : void
      {
         mc.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK,xClick);
         mc.cnt.bg.btnTry.removeEventListener(MouseEvent.CLICK,tryClick);
         stage.focus = stage;
         mc.parent.removeChild(mc);
      }
      
      private function setCT(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      internal function frame7() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
      }
      
      internal function frame16() : *
      {
         fClose();
      }
   }
}

