package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol735")]
   public class ItemPreview extends MovieClip
   {
      
      public var btnClose:SimpleButton;
      
      internal var rootClass:MovieClip = MovieClip(Game.root);
      
      internal var mcStage:MovieClip;
      
      internal var curItem:Object;
      
      internal var sLinkArmor:String = "";
      
      internal var sLinkCape:String = "";
      
      internal var sLinkHelm:String = "";
      
      internal var sLinkPet:String = "";
      
      internal var sLinkWeapon:String = "";
      
      internal var pLoaderD:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
      
      internal var pLoaderC:LoaderContext = new LoaderContext(false,pLoaderD);
      
      public function ItemPreview()
      {
         super();
         this.x = 50;
         this.y = 90;
         this.btnClose.addEventListener(MouseEvent.CLICK,xClick,false,0,true);
         mcStage = MovieClip(this.addChild(new MovieClip()));
      }
      
      private function xClick(param1:MouseEvent) : *
      {
         this.btnClose.removeEventListener(MouseEvent.CLICK,xClick);
         rootClass.clearModalStack();
      }
      
      public function loadItem(param1:Object) : void
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
                  loadItemFile();
            }
         }
      }
      
      private function clearStage() : void
      {
         var _loc1_:int = mcStage.numChildren - 1;
         while(_loc1_ >= 0)
         {
            mcStage.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      private function loadWeapon(param1:*, param2:*) : void
      {
         clearStage();
         sLinkWeapon = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,onLoadWeaponComplete,false,0,true);
      }
      
      private function loadCape(param1:*, param2:*) : void
      {
         clearStage();
         sLinkCape = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadCapeComplete,false,0,true);
      }
      
      private function loadHelm(param1:*, param2:*) : void
      {
         clearStage();
         sLinkHelm = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHelmComplete,false,0,true);
      }
      
      private function loadPet(param1:*, param2:*) : void
      {
         clearStage();
         sLinkPet = param2;
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + param1),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadPetComplete,false,0,true);
      }
      
      private function loadHouse(param1:*) : void
      {
         clearStage();
         var _loc2_:* = "maps/" + curItem.sFile.substr(0,-4) + "_preview.swf";
         var _loc3_:* = new Loader();
         _loc3_.load(new URLRequest(Game.serverFilePath + _loc2_),pLoaderC);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadHouseComplete,false,0,true);
      }
      
      internal function onLoadHouseComplete(param1:Event) : void
      {
         var _loc2_:* = curItem.sFile.substr(0,-4).substr(curItem.sFile.lastIndexOf("/") + 1).split("-").join("_") + "_preview";
         var _loc3_:Class = pLoaderD.getDefinition(_loc2_) as Class;
         var _loc4_:* = new _loc3_();
         _loc4_.x = 150;
         _loc4_.y = 200;
         mcStage.addChild(_loc4_);
         addGlow(_loc4_);
      }
      
      private function loadArmor(param1:*, param2:*) : void
      {
         clearStage();
         sLinkArmor = param2;
         var _loc3_:* = mcStage.addChild(new AvatarMC());
         _loc3_.strGender = rootClass.world.myAvatar.objData.strGender;
         _loc3_.x = 150;
         _loc3_.y = 250;
         _loc3_.scaleX = _loc3_.scaleY = 1.65;
         _loc3_.pAV = rootClass.world.myAvatar;
         _loc3_.world = MovieClip(Game.root).world;
         _loc3_.hideHPBar();
         _loc3_.name = "previewMC";
         _loc3_.loadArmor(param1,param2);
         addGlow(_loc3_.mcChar);
      }
      
      internal function onLoadWeaponComplete(param1:Event) : void
      {
         var mc:MovieClip = null;
         var AssetClass:Class = null;
         var e:Event = param1;
         try
         {
            AssetClass = pLoaderD.getDefinition(sLinkWeapon) as Class;
            mc = new AssetClass();
         }
         catch(err:Error)
         {
            mc = e.target.content;
         }
         mc.x = 150;
         mc.y = 180;
         mc.scaleX = mc.scaleY = 0.3;
         mcStage.addChild(mc);
         addGlow(mc);
      }
      
      internal function onLoadCapeComplete(param1:Event) : void
      {
         var _loc2_:Class = pLoaderD.getDefinition(sLinkCape) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.x = 150;
         _loc3_.y = 150;
         _loc3_.scaleX = _loc3_.scaleY = 0.5;
         mcStage.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      internal function onLoadHelmComplete(param1:Event) : void
      {
         var _loc2_:Class = pLoaderD.getDefinition(sLinkHelm) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.x = 170;
         _loc3_.y = 200;
         mcStage.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      internal function onLoadPetComplete(param1:Event) : void
      {
         var _loc2_:Class = pLoaderD.getDefinition(sLinkPet) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.x = 150;
         _loc3_.y = 250;
         _loc3_.scaleX = _loc3_.scaleY = 2;
         mcStage.addChild(_loc3_);
         addGlow(_loc3_);
      }
      
      private function addGlow(param1:MovieClip) : void
      {
         var _loc2_:* = new GlowFilter(16777215,1,8,8,2,1,false,false);
         param1.filters = [_loc2_];
      }
      
      private function loadItemFile() : void
      {
         clearStage();
         var _loc1_:* = new Loader();
         _loc1_.load(new URLRequest(Game.serverFilePath + curItem.sFile),pLoaderC);
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadItemFileComplete,false,0,true);
      }
      
      internal function onLoadItemFileComplete(param1:Event) : void
      {
         var _loc2_:Class = pLoaderD.getDefinition(curItem.sLink) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.x = 150;
         _loc3_.y = 250;
         if(_loc3_.height > 225)
         {
            _loc3_.height = 225;
            _loc3_.scaleX = _loc3_.scaleY;
         }
         if(_loc3_.width > 275)
         {
            _loc3_.width = 275;
            _loc3_.scaleY = _loc3_.scaleX;
         }
         mcStage.addChild(_loc3_);
         addGlow(_loc3_);
      }
   }
}

