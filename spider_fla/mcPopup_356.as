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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4194")]
   public dynamic class mcPopup_356 extends MovieClip
   {
      
      public var mcCharpanel:CharpanelMC;
      
      public var mcBag:SimpleButton;
      
      public var mcHouseShop:HouseShop;
      
      public var mcCustomize:MovieClip;
      
      public var mcMap:MovieClip;
      
      public var mcTempInventory:TempInventory;
      
      public var mcPVPPanel:PVPPanelMC;
      
      public var mcHouseItemHandle:HouseItemHandleMC;
      
      public var reportMC:MovieClip;
      
      public var mcHouseOptions:MovieClip;
      
      public var mcBook:MovieClip;
      
      public var cnt:FactionsMC;
      
      public var mcHouseMenu:HouseMenu;
      
      public var mcCustomizeArmor:MovieClip;
      
      public var GuildBG:MovieClip;
      
      public var mcNews:MovieClip;
      
      public var rootClass:MovieClip;
      
      public var world:MovieClip;
      
      public var fData:Object;
      
      public var layout:LPFLayout;
      
      public var guild:*;
      
      public var li:mcGuildListItem;
      
      public var onlineCount:int;
      
      public var Rank:int;
      
      public var maxGuildSlots:int;
      
      public var i:*;
      
      public var hRun:Number;
      
      public var dRun:Number;
      
      public var oy:Number;
      
      public var mbY:int;
      
      public var mhY:int;
      
      public var mbD:int;
      
      public var mDown:Boolean;
      
      public function mcPopup_356()
      {
         super();
         addFrameScript(0,frame1,1,frame2,6,frame7,14,frame15,23,frame24,29,frame30,39,frame40,48,frame49,57,frame58,64,frame65,71,frame72,78,frame79,86,frame87,94,frame95,102,frame103,111,frame112,120,frame121,128,frame129,138,frame139,148,frame149,159,frame160,168,frame169,175,frame176,182,frame183,189,frame190);
      }
      
      public function fOpen(param1:String, param2:Object = null) : void
      {
         if(currentLabel != param1)
         {
            fClose();
            if(param2 != null)
            {
               fData = param2;
            }
            gotoAndStop(param1);
            visible = true;
         }
      }
      
      public function fClose() : *
      {
         var _loc1_:MovieClip = MovieClip(this);
         if(_loc1_.mcHouseMenu != null)
         {
            _loc1_.mcHouseMenu.fClose();
         }
         if(getChildByName("mcInventory") != null)
         {
            MovieClip(getChildByName("mcInventory")).fClose();
         }
         if(getChildByName("mcShop") != null)
         {
            MovieClip(getChildByName("mcShop")).fClose();
         }
         if(getChildByName("mcBank") != null)
         {
            MovieClip(getChildByName("mcBank")).fClose();
         }
         if(getChildByName("mcCharpanel") != null)
         {
            MovieClip(getChildByName("mcCharpanel")).fClose();
         }
         if(getChildByName("mcO") != null)
         {
            MovieClip(getChildByName("mcO")).fClose();
         }
      }
      
      public function onClose(param1:Event = null) : void
      {
         if(currentLabel != "Init" && currentFrame != 1)
         {
            fClose();
            MovieClip(Game.root).mixer.playSound("Click");
            if(world.isMyHouse() && !world.mapLoadInProgress && currentLabel != "House")
            {
               gotoAndPlay("House");
            }
            else
            {
               gotoAndPlay("Init");
            }
         }
      }
      
      public function loadMap(param1:String) : *
      {
         mcMap.removeChildAt(0);
         var _loc2_:Loader = new Loader();
         _loc2_.load(new URLRequest(Game.serverFilePath + param1),new LoaderContext(false,ApplicationDomain.currentDomain));
         mcMap.addChild(_loc2_);
      }
      
      public function loadNews(param1:String) : *
      {
         mcNews.removeChildAt(0);
         var _loc2_:Loader = new Loader();
         _loc2_.load(new URLRequest(Game.serverFilePath + param1),new LoaderContext(false,ApplicationDomain.currentDomain));
         mcNews.addChild(_loc2_);
      }
      
      public function loadBook(param1:String) : *
      {
         mcBook.removeChildAt(0);
         if(rootClass.newInstance)
         {
            rootClass.newInstance = false;
            rootClass.bolContent.gotoAndStop("NavMenu");
         }
         mcBook.addChild(rootClass.bolContent);
      }
      
      public function updateGuildWindow() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         if(rootClass.world.myAvatar.objData.guildRank == 3 && rootClass.world.myAvatar.objData.guild.MaxMembers < maxGuildSlots)
         {
            _loc1_ = GuildBG.mcBuyButtons;
            _loc2_ = maxGuildSlots - int(rootClass.world.myAvatar.objData.guild.MaxMembers);
            GuildBG.tSlots.text = String(rootClass.world.myAvatar.objData.guild.MaxMembers) + "/" + String(maxGuildSlots);
            _loc1_.txtRest.text = "(" + String(_loc2_) + ")";
            _loc1_.txtRestCost.text = String(_loc2_ * 200) + " AC";
            _loc1_.txtCoins.text = String(rootClass.world.myAvatar.objData.intCoins);
            _loc1_.btnOne.addEventListener(MouseEvent.CLICK,onBuyClick,false,0,true);
            _loc1_.btnRest.addEventListener(MouseEvent.CLICK,onBuyClick,false,0,true);
         }
         else
         {
            GuildBG.tSlots.text = String(rootClass.world.myAvatar.objData.guild.MaxMembers) + "/" + String(maxGuildSlots);
            GuildBG.mcBuyButtons.visible = false;
         }
      }
      
      public function onBuyClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget.name)
         {
            case "btnOne":
               _loc2_ = 1;
               break;
            case "btnRest":
               _loc2_ = maxGuildSlots - int(rootClass.world.myAvatar.objData.guild.MaxMembers);
         }
         if(_loc2_ * 200 > rootClass.world.myAvatar.objData.intCoins)
         {
            rootClass.MsgBox.notify("You do not have enough ACs to purchase this.");
         }
         else
         {
            rootClass.world.addMemSlots(_loc2_);
         }
      }
      
      public function getRank(param1:int) : String
      {
         var _loc2_:String = "";
         switch(Number(param1))
         {
            case 0:
               _loc2_ = "Duffer";
               break;
            case 1:
               _loc2_ = "Member";
               break;
            case 2:
               _loc2_ = "Officer";
               break;
            case 3:
               _loc2_ = "Leader";
         }
         return _loc2_;
      }
      
      public function onGClose(param1:MouseEvent) : void
      {
         GuildBG.scr.hit.removeEventListener(MouseEvent.MOUSE_DOWN,onScrDown);
         stage.removeEventListener(MouseEvent.MOUSE_UP,onScrUp);
         GuildBG.scr.h.removeEventListener(Event.ENTER_FRAME,hEF);
         GuildBG.guildDisplay.removeEventListener(Event.ENTER_FRAME,dEF);
         GuildBG.mcBuyButtons.btnOne.removeEventListener(MouseEvent.CLICK,onBuyClick);
         GuildBG.mcBuyButtons.btnFive.removeEventListener(MouseEvent.CLICK,onBuyClick);
         GuildBG.mcBuyButtons.btnRest.removeEventListener(MouseEvent.CLICK,onBuyClick);
         onClose();
      }
      
      public function onScrDown(param1:MouseEvent) : *
      {
         mbY = int(mouseY);
         mhY = int(GuildBG.scr.h.y);
         mDown = true;
      }
      
      public function onScrUp(param1:MouseEvent) : void
      {
         mDown = false;
      }
      
      public function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = GuildBG.scr;
            mbD = int(mouseY) - mbY;
            _loc2_.h.y = mhY + mbD;
            if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
            {
               _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
            }
            if(_loc2_.h.y < 0)
            {
               _loc2_.h.y = 0;
            }
         }
      }
      
      public function dEF(param1:Event) : *
      {
         var _loc2_:* = GuildBG.scr;
         var _loc3_:* = GuildBG.guildDisplay;
         var _loc4_:* = -_loc2_.h.y / hRun;
         var _loc5_:* = int(_loc4_ * dRun) + oy;
         if(Math.abs(_loc5_ - _loc3_.y) > 0.2)
         {
            _loc3_.y += (_loc5_ - _loc3_.y) / 4;
         }
         else
         {
            _loc3_.y = _loc5_;
         }
      }
      
      internal function frame1() : *
      {
         rootClass = MovieClip(stage.getChildAt(0));
         world = rootClass.world as MovieClip;
         fData = {};
         visible = false;
         stop();
      }
      
      internal function frame2() : *
      {
         fData = {};
         visible = false;
         if(rootClass.mcO != null && Boolean(rootClass.getChildByName("mcO")))
         {
            this.removeChild(rootClass.mcO);
         }
         stop();
      }
      
      internal function frame7() : *
      {
         layout = addChild(new LPFLayoutInvShopEnh()) as LPFLayoutInvShopEnh;
         layout.name = "mcInventory";
         layout.fOpen({
            "fData":{
               "itemsInv":world.myAvatar.items,
               "objData":world.myAvatar.objData
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"inventory"
         });
         layout = null;
         stop();
      }
      
      internal function frame15() : *
      {
         stop();
      }
      
      internal function frame24() : *
      {
         layout = addChild(new LPFLayoutInvShopEnh()) as LPFLayoutInvShopEnh;
         layout.name = "mcShop";
         layout.fOpen({
            "fData":{
               "itemsShop":world.shopinfo.items,
               "itemsInv":world.myAvatar.items,
               "objData":world.myAvatar.objData,
               "shopinfo":world.shopinfo
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"shopBuy"
         });
         layout = null;
         stop();
      }
      
      internal function frame30() : *
      {
         layout = addChild(new LPFLayoutMergeShop()) as LPFLayoutMergeShop;
         layout.name = "mcShop";
         layout.fOpen({
            "fData":{
               "itemsShop":world.shopinfo.items,
               "itemsInv":world.myAvatar.items,
               "objData":world.myAvatar.objData
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"shopBuy"
         });
         layout = null;
         stop();
      }
      
      internal function frame40() : *
      {
         stop();
      }
      
      internal function frame49() : *
      {
         layout = addChild(new LPFLayoutBank()) as LPFLayoutBank;
         layout.name = "mcBank";
         layout.fOpen({
            "fData":{
               "itemsB":world.bankinfo.items,
               "itemsI":world.myAvatar.items,
               "objData":world.myAvatar.objData
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"bank"
         });
         layout = null;
         stop();
      }
      
      internal function frame58() : *
      {
         if(!rootClass.TRAVEL_DATA_READY)
         {
            rootClass.getTravelMapData();
         }
         else
         {
            loadMap(rootClass.world.objInfo.sMap);
         }
         stop();
      }
      
      internal function frame65() : *
      {
         loadNews(rootClass.world.objInfo.sNews);
         stop();
      }
      
      internal function frame72() : *
      {
         if(!rootClass.BOOK_DATA_READY)
         {
            rootClass.retrieveBook();
         }
         else
         {
            loadBook(rootClass.world.objInfo.sBook);
         }
         stop();
      }
      
      internal function frame79() : *
      {
         rootClass.mcO = rootClass.mcO == null ? new mcOption(rootClass) as MovieClip : rootClass.mcO;
         this.addChild(rootClass.mcO);
         rootClass.mcO.name = "mcO";
         rootClass.mcO.x = 600;
         rootClass.mcO.y = 100;
         if(fData.Account == null)
         {
            rootClass.mcO.Init();
         }
         else if(fData.Account != null)
         {
            delete fData.Account;
            rootClass.mcO.InitAccount();
         }
         stop();
      }
      
      internal function frame87() : *
      {
         stop();
      }
      
      internal function frame95() : *
      {
         stop();
      }
      
      internal function frame103() : *
      {
         stop();
      }
      
      internal function frame112() : *
      {
         stop();
      }
      
      internal function frame121() : *
      {
         mcHouseMenu.visible = false;
         mcHouseItemHandle.visible = false;
         mcHouseMenu.fOpen("default");
         stop();
      }
      
      internal function frame129() : *
      {
         stop();
      }
      
      internal function frame139() : *
      {
         stop();
      }
      
      internal function frame149() : *
      {
         stop();
      }
      
      internal function frame160() : *
      {
         GuildBG.btnClose.addEventListener(MouseEvent.CLICK,onGClose,false,0,true);
         guild = rootClass.world.myAvatar.objData.guild;
         GuildBG.tTitle.text = guild.Name;
         onlineCount = 0;
         maxGuildSlots = 225;
         i = 0;
         while(i < guild.ul.length)
         {
            li = new mcGuildListItem();
            li.x = 0;
            li.y = i * 17;
            li.tName.text = String(guild.ul[i].userName);
            li.tRank.text = getRank(guild.ul[i].Rank);
            li.tServer.text = guild.ul[i].Server;
            li.tLevel.text = String(guild.ul[i].Level);
            if(guild.ul[i].Server.toLowerCase() != "offline")
            {
               ++onlineCount;
            }
            GuildBG.guildDisplay.addChild(li);
            ++i;
         }
         GuildBG.tMemCount.text = String(onlineCount) + "/" + String(guild.ul.length) + " Online";
         GuildBG.guildDisplay.mask = GuildBG.cntMask;
         if(GuildBG.guildDisplay.height > GuildBG.cntMask.height)
         {
            GuildBG.scr.visible = true;
            GuildBG.scr.hit.alpha = 0;
            GuildBG.scr.h.height = int(GuildBG.cntMask.height / GuildBG.guildDisplay.height * GuildBG.scr.b.height);
            hRun = GuildBG.scr.b.height - GuildBG.scr.h.height;
            dRun = GuildBG.guildDisplay.height - GuildBG.cntMask.height + 5;
            oy = GuildBG.guildDisplay.y;
            GuildBG.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN,onScrDown,false,0,true);
            stage.addEventListener(MouseEvent.MOUSE_UP,onScrUp,false,0,true);
            GuildBG.scr.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
            GuildBG.guildDisplay.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
         }
         else
         {
            GuildBG.scr.visible = false;
         }
         updateGuildWindow();
         mDown = false;
      }
      
      internal function frame169() : *
      {
         layout = addChild(new LPFLayoutHouseInvShop()) as LPFLayoutHouseInvShop;
         layout.name = "mcInventory";
         layout.fOpen({
            "fData":{
               "itemsInv":world.myAvatar.houseitems,
               "objData":world.myAvatar.objData
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"inventory"
         });
         layout = null;
         stop();
      }
      
      internal function frame176() : *
      {
         layout = addChild(new LPFLayoutHouseBank()) as LPFLayoutHouseBank;
         layout.name = "mcBank";
         layout.fOpen({
            "fData":{
               "itemsB":world.bankinfo.items,
               "itemsI":world.myAvatar.houseitems,
               "objData":world.myAvatar.objData
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"bank"
         });
         layout = null;
         stop();
      }
      
      internal function frame183() : *
      {
         layout = addChild(new LPFLayoutHouseInvShop()) as LPFLayoutHouseInvShop;
         layout.name = "mcShop";
         layout.fOpen({
            "fData":{
               "itemsShop":world.shopinfo.items,
               "itemsInv":world.myAvatar.houseitems,
               "objData":world.myAvatar.objData,
               "shopinfo":world.shopinfo
            },
            "r":{
               "x":0,
               "y":0,
               "w":stage.stageWidth,
               "h":stage.stageHeight
            },
            "sMode":"shopBuy"
         });
         layout = null;
         stop();
      }
      
      internal function frame190() : *
      {
         rootClass.requestInterface("guild/guildpanel.swf","guildPanel");
         stop();
      }
   }
}

