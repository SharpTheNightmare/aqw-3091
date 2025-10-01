package liteAssets.draw
{
   import fl.data.DataProvider;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2242")]
   public class dEntry extends MovieClip
   {
      
      public var btPreview:MovieClip;
      
      public var icon:MovieClip;
      
      public var overEntryBar:MovieClip;
      
      public var btNo:MovieClip;
      
      public var txtDrop:TextField;
      
      public var iconAC:MovieClip;
      
      public var btYes:MovieClip;
      
      public var entryBar:MovieClip;
      
      public var itemObj:Object;
      
      internal var format:TextFormat;
      
      internal var rootClass:MovieClip;
      
      internal var allowPass:Boolean = false;
      
      public function dEntry(param1:MovieClip, param2:Object, param3:int)
      {
         var sIcon:String;
         var AssetClass:Class = null;
         var mcIcon:* = undefined;
         var check:detailedCheck = null;
         var r:MovieClip = param1;
         var resObj:Object = param2;
         var relQty:int = param3;
         format = new TextFormat();
         super();
         rootClass = r;
         allowPass = false;
         this.gotoAndStop("idle");
         this.btYes.visible = false;
         this.btNo.visible = false;
         this.btPreview.visible = false;
         itemObj = resObj;
         this.iconAC.visible = resObj.bCoins == 1;
         this.txtDrop.text = "";
         this.txtDrop.htmlText = "";
         if(resObj.bUpg == 1)
         {
            this.txtDrop.htmlText = "<font color=\'#FCC749\'>" + resObj.sName + " x " + relQty + "</font>";
         }
         else
         {
            this.txtDrop.text = resObj.sName + " x " + relQty;
         }
         this.txtDrop.autoSize = TextFieldAutoSize.LEFT;
         if(this.txtDrop.width > this.entryBar.width - this.txtDrop.x - 20)
         {
            this.txtDrop.autoSize = TextFieldAutoSize.NONE;
            this.txtDrop.width = this.entryBar.width - this.txtDrop.x - 20 - (iconAC.visible ? iconAC.width : 0);
         }
         if(this.iconAC.visible)
         {
            this.iconAC.x = this.txtDrop.x + this.txtDrop.width;
         }
         sIcon = "";
         if(resObj.sType.toLowerCase() == "enhancement")
         {
            sIcon = rootClass.getIconBySlot(resObj.sES);
         }
         else if(resObj.sType.toLowerCase() == "serveruse" || resObj.sType.toLowerCase() == "clientuse")
         {
            if("sFile" in resObj && resObj.sFile.length > 0 && rootClass.world.getClass(resObj.sFile) != null)
            {
               sIcon = resObj.sFile;
            }
            else
            {
               sIcon = resObj.sIcon;
            }
         }
         else if(resObj.sIcon == null || resObj.sIcon == "" || resObj.sIcon == "none")
         {
            if(resObj.sLink.toLowerCase() != "none")
            {
               sIcon = "iidesign";
            }
            else
            {
               sIcon = "iibag";
            }
         }
         else
         {
            sIcon = resObj.sIcon;
         }
         try
         {
            AssetClass = rootClass.world.getClass(sIcon) as Class;
            mcIcon = this.icon.addChild(new AssetClass());
         }
         catch(e:Error)
         {
            AssetClass = rootClass.world.getClass("iibag") as Class;
            mcIcon = this.icon.addChild(new AssetClass());
         }
         if(isOwned(resObj.bHouse,resObj.ItemID))
         {
            check = new detailedCheck();
            check.width = mcIcon.width;
            check.height = mcIcon.height;
            check.x = 0;
            check.y = 0;
            mcIcon.addChild(check);
         }
         mcIcon.scaleX = mcIcon.scaleY = 16 / mcIcon.height;
         this.addEventListener(MouseEvent.ROLL_OVER,onHighlight,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,onDeHighlight,false,0,true);
         this.addEventListener(MouseEvent.CLICK,onShiftClick,false,0,true);
         this.btYes.addEventListener(MouseEvent.CLICK,onBtYes,false,0,true);
         this.btNo.addEventListener(MouseEvent.CLICK,onBtNo,false,0,true);
         this.btPreview.addEventListener(MouseEvent.CLICK,onBtPreview,false,0,true);
      }
      
      internal function onShiftClick(param1:MouseEvent) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1.shiftKey)
         {
            if(itemObj.sName.indexOf("Item of Digital Awesomeness.") > -1)
            {
               _loc2_ = rootClass.world.getClass("ModalMC");
               _loc3_ = new _loc2_();
               _loc4_ = {};
               _loc4_.strBody = "You can NOT block IoDAs!";
               _loc4_.callback = null;
               _loc4_.glow = "red,medium";
               _loc4_.btns = "mono";
               rootClass.stage.addChild(_loc3_);
               _loc3_.init(_loc4_);
               return;
            }
            _loc2_ = rootClass.world.getClass("ModalMC");
            _loc3_ = new _loc2_();
            _loc4_ = {};
            _loc4_.strBody = "Are you sure you want to add " + itemObj.sName + " to the item block list?";
            _loc4_.callback = onModifyBlacklist;
            _loc4_.params = {
               "sName":itemObj.sName,
               "ItemID":itemObj.ItemID
            };
            _loc4_.glow = "red,medium";
            _loc4_.btns = "dual";
            rootClass.stage.addChild(_loc3_);
            _loc3_.init(_loc4_);
         }
      }
      
      internal function onModifyBlacklist(param1:Object) : void
      {
         var _loc2_:DataProvider = null;
         if(param1.accept)
         {
            _loc2_ = new DataProvider(rootClass.litePreference.data.blackList);
            _loc2_.addItem({
               "label":param1.sName.toUpperCase(),
               "value":param1.ItemID
            });
            rootClass.litePreference.data.blackList = _loc2_.toArray();
            rootClass.litePreference.flush();
            this.btNo.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         rootClass.stage.focus = null;
      }
      
      internal function isOwned(param1:Boolean, param2:*) : Boolean
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1 ? rootClass.world.myAvatar.houseitems : rootClass.world.myAvatar.items)
         {
            if(_loc3_.ItemID == param2)
            {
               return true;
            }
         }
         if(rootClass.world.bankinfo.isItemInBank(param2))
         {
            return true;
         }
         return false;
      }
      
      internal function updateFormat(param1:int) : void
      {
         format.size = param1;
         this.txtDrop.setTextFormat(format);
      }
      
      internal function onBtYes(param1:MouseEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Boolean = true;
         for each(_loc3_ in rootClass.world.myAvatar.items)
         {
            if(_loc3_.ItemID == itemObj.ItemID && _loc3_.iQty < _loc3_.iStk)
            {
               _loc2_ = false;
            }
         }
         if(_loc2_ && rootClass.world.myAvatar.items.length < rootClass.world.myAvatar.objData.iBagSlots)
         {
            _loc2_ = false;
         }
         if(Boolean(rootClass.isHouseItem(itemObj)) && rootClass.world.myAvatar.houseitems.length >= rootClass.world.myAvatar.objData.iHouseSlots)
         {
            rootClass.MsgBox.notify("House Inventory Full!");
         }
         else if(!rootClass.isHouseItem(itemObj) && _loc2_)
         {
            rootClass.MsgBox.notify("Item Inventory Full!");
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","getDrop",[itemObj.ItemID],"str",rootClass.world.curRoom);
         }
         rootClass.stage.focus = null;
      }
      
      internal function onDeclineDrop(param1:Object) : void
      {
         if(param1.accept)
         {
            allowPass = true;
            this.btNo.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      internal function onBtNo(param1:MouseEvent) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(rootClass.litePreference.data.dOptions["warnDecline"])
         {
            if(!allowPass)
            {
               _loc2_ = rootClass.world.getClass("ModalMC");
               _loc3_ = new _loc2_();
               _loc4_ = {};
               _loc4_.strBody = "Are you sure you want to decline the drop for " + itemObj.sName + "?";
               _loc4_.callback = onDeclineDrop;
               _loc4_.params = {"sName":itemObj.sName};
               _loc4_.glow = "red,medium";
               _loc4_.btns = "dual";
               rootClass.stage.addChild(_loc3_);
               _loc3_.init(_loc4_);
               return;
            }
         }
         rootClass.cDropsUI.onBtNo(itemObj);
         allowPass = false;
         rootClass.stage.focus = null;
      }
      
      internal function onBtPreview(param1:MouseEvent) : void
      {
         if(rootClass.ui.getChildByName("qRewardPrev"))
         {
            rootClass.ui.getChildByName("qRewardPrev").fClose();
         }
         var _loc2_:* = rootClass.ui.addChild(new qRewardPrev(itemObj));
         _loc2_.world = rootClass.world;
         _loc2_.rootClass = rootClass;
         _loc2_.isDropPreview();
         _loc2_.open();
         rootClass.stage.focus = null;
      }
      
      internal function onHighlight(param1:MouseEvent) : void
      {
         this.gotoAndStop("hover");
         this.btYes.visible = true;
         this.btNo.visible = true;
         this.btPreview.visible = true;
      }
      
      internal function onDeHighlight(param1:MouseEvent) : void
      {
         this.gotoAndStop("idle");
         this.btYes.visible = false;
         this.btNo.visible = false;
         this.btPreview.visible = false;
      }
   }
}

