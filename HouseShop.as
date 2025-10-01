package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2608")]
   public class HouseShop extends MovieClip
   {
      
      public var tabInv:MovieClip;
      
      public var btnPreview:SimpleButton;
      
      public var strGold:TextField;
      
      public var strCost:TextField;
      
      public var mcItemList:ItemList;
      
      public var mcCoin:MovieClip;
      
      public var strInfo:TextField;
      
      public var mcUpgrade:MovieClip;
      
      public var txtTitle:TextField;
      
      public var txtAction:TextField;
      
      public var bg1:MovieClip;
      
      public var tabShop:MovieClip;
      
      public var bg2:MovieClip;
      
      public var btnAction:SimpleButton;
      
      public var mcShopList:ItemList;
      
      public var strCoins:TextField;
      
      internal var rootClass:* = MovieClip(parent.parent.parent);
      
      internal var bitShop:Boolean = true;
      
      public function HouseShop()
      {
         super();
         bg1.btnClose.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         btnPreview.addEventListener(MouseEvent.CLICK,onPreviewClick,false,0,true);
         btnAction.addEventListener(MouseEvent.CLICK,onActionClick,false,0,true);
         tabShop.addEventListener(MouseEvent.CLICK,onClickShop,false,0,true);
         tabInv.addEventListener(MouseEvent.CLICK,onClickInv,false,0,true);
         mcShopList.inventorySlot = rootClass.world.shopinfo.items.length;
         mcShopList.init(rootClass.world.shopinfo.items);
         mcItemList.inventorySlot = rootClass.world.myAvatar.houseitems.length;
         mcItemList.init(rootClass.world.myAvatar.houseitems);
         txtAction.mouseEnabled = false;
         updateGoldCoin();
         onClickShop(null);
      }
      
      internal function onCloseClick(param1:Event) : *
      {
         MovieClip(parent).onClose();
      }
      
      public function refreshDetail() : void
      {
         if(selectedItem == null)
         {
            strInfo.htmlText = "Please select an item to view details.";
            txtAction.visible = false;
            btnAction.visible = false;
            btnPreview.visible = false;
            strCost.text = "";
            mcCoin.visible = mcUpgrade.visible = false;
         }
         else
         {
            showItemDetail();
         }
      }
      
      public function get selectedItem() : Object
      {
         if(bitShop)
         {
            return mcShopList.selectedItem;
         }
         return mcItemList.selectedItem;
      }
      
      public function showItemDetail() : void
      {
         var _loc1_:Object = null;
         var _loc2_:* = "#CC9900";
         if(bitShop)
         {
            _loc1_ = mcShopList.selectedItem;
            strInfo.htmlText = rootClass.getItemInfoString(_loc1_);
            if(_loc1_.bCoins == 0 && _loc1_.iCost > rootClass.world.myAvatar.objData.intGold || _loc1_.bCoins == 1 && _loc1_.iCost > rootClass.world.myAvatar.objData.intCoins)
            {
               _loc2_ = "#CC0000";
            }
            if(_loc1_.bCoins == 0)
            {
               strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>" + Number(_loc1_.iCost) + " Gold</b></font>";
            }
            else
            {
               strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>" + Number(_loc1_.iCost) + " ACs</b></font>";
            }
            txtAction.text = "Buy";
            btnPreview.visible = true;
         }
         else
         {
            _loc1_ = mcItemList.selectedItem;
            strInfo.htmlText = rootClass.getItemInfoString(_loc1_);
            if(_loc1_.bCoins == 0)
            {
               if(rootClass.world.myAvatar.objData.intGold > 100000000)
               {
                  strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>0 Gold</b></font>";
               }
               else
               {
                  strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>" + Math.ceil(_loc1_.iCost / 4) + " Gold</b></font>";
               }
            }
            else if(_loc1_.iHrs < 24)
            {
               strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>" + Math.ceil(_loc1_.iCost * 9 / 10) + " ACs</b></font>";
            }
            else
            {
               strCost.htmlText = "<font size=\'14\' color=\'" + _loc2_ + "\'><b>" + Math.ceil(_loc1_.iCost / 4) + " ACs</b></font>";
            }
            txtAction.text = "Sell";
            btnPreview.visible = false;
         }
         txtAction.visible = true;
         btnAction.visible = true;
         mcCoin.visible = _loc1_.bCoins == 1;
         mcUpgrade.visible = _loc1_.bUpg == 1;
      }
      
      public function updateGoldCoin() : void
      {
         strGold.text = rootClass.world.myAvatar.objData.intGold;
         strCoins.text = rootClass.world.myAvatar.objData.intCoins;
      }
      
      internal function onClickShop(param1:Event) : *
      {
         tabShop.select();
         tabInv.unselect();
         mcShopList.visible = true;
         mcItemList.visible = false;
         txtTitle.text = "Shop";
         bitShop = true;
         refreshDetail();
      }
      
      internal function onClickInv(param1:Event) : *
      {
         tabShop.unselect();
         tabInv.select();
         mcShopList.visible = false;
         mcItemList.visible = true;
         txtTitle.text = "Inventory";
         bitShop = false;
         refreshDetail();
      }
      
      public function onActionClick(param1:Event) : *
      {
         if(bitShop)
         {
            onBuyClick();
         }
         else
         {
            onSellClick();
         }
      }
      
      public function onBuyClick() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if((rootClass.world.shopinfo.bStaff == 1 || mcShopList.selectedItem.bStaff == 1) && rootClass.world.myAvatar.objData.intAccessLevel < 40)
         {
            rootClass.MsgBox.notify("Test Item.. cannot be purchased yet!");
         }
         else if(rootClass.world.shopinfo.sField != "" && rootClass.world.getAchievement(rootClass.world.shopinfo.sField,rootClass.world.shopinfo.iIndex) != 1)
         {
            rootClass.MsgBox.notify("Item requires special requirement!");
         }
         else if(mcShopList.selectedItem.bUpg == 1 && !rootClass.world.myAvatar.isUpgraded())
         {
            rootClass.showUpgradeWindow();
         }
         else if(mcShopList.selectedItem.FactionID > 1 && rootClass.world.myAvatar.getRep(mcShopList.selectedItem.FactionID) < mcShopList.selectedItem.iReqRep)
         {
            rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
         }
         else if(mcShopList.selectedItem.iClass > 0 && rootClass.world.myAvatar.getCPByID(mcShopList.selectedItem.iClass) < mcShopList.selectedItem.iReqCP)
         {
            rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
         }
         else if((Boolean(rootClass.world.myAvatar.isItemInInventory(mcShopList.selectedItem.ItemID)) || Boolean(rootClass.world.myAvatar.isItemInBank(mcShopList.selectedItem.ItemID))) && Boolean(rootClass.world.myAvatar.isItemStackMaxed(mcShopList.selectedItem.ItemID)))
         {
            _loc1_ = ["zero","one","two","three","four","five","six","seven","eight","nine"];
            rootClass.MsgBox.notify("You cannot have more than " + _loc1_[mcShopList.selectedItem.iStk] + " of that item!");
         }
         else if(mcShopList.selectedItem.bCoins == 0 && mcShopList.selectedItem.iCost > rootClass.world.myAvatar.objData.intGold || mcShopList.selectedItem.bCoins == 1 && mcShopList.selectedItem.iCost > rootClass.world.myAvatar.objData.intCoins)
         {
            rootClass.MsgBox.notify("Insufficient Funds!");
         }
         else if(rootClass.world.myAvatar.houseitems.length >= rootClass.world.myAvatar.objData.iHouseSlots)
         {
            rootClass.MsgBox.notify("House Inventory Full!");
         }
         else
         {
            _loc2_ = new ModalMC();
            _loc3_ = {};
            _loc3_.strBody = "Are you sure you want to buy \"" + mcShopList.selectedItem.sName + "\"?";
            _loc3_.params = {};
            _loc3_.params.item = mcShopList.selectedItem;
            _loc3_.callback = buyRequest;
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
      }
      
      public function buyRequest(param1:*) : void
      {
         if(param1.accept)
         {
            rootClass.world.sendBuyItemRequest(param1.item);
         }
      }
      
      public function onSellClick() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(mcItemList.selectedItem.bEquip)
         {
            rootClass.MsgBox.notify("Item is currently equipped!");
         }
         else if(mcItemList.selectedItem.bTemp == 0)
         {
            _loc1_ = new ModalMC();
            _loc2_ = {};
            _loc2_.strBody = "Are you sure you want to sell \"" + mcItemList.selectedItem.sName + "\"?";
            _loc2_.params = {};
            _loc2_.params.item = mcItemList.selectedItem;
            _loc2_.callback = sellRequest;
            rootClass.ui.ModalStack.addChild(_loc1_);
            _loc1_.init(_loc2_);
         }
      }
      
      public function sellRequest(param1:*) : void
      {
         if(param1.accept)
         {
            rootClass.world.sendSellItemRequest(param1.item);
         }
      }
      
      public function onPreviewClick(param1:Event) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = mcShopList.selectedItem;
         if(_loc2_.sType == "Floor Item" || _loc2_.sType == "Wall Item" || _loc2_.sType == "House")
         {
            _loc3_ = rootClass.attachOnModalStack("ItemPreview");
            _loc3_.loadItem(_loc2_);
         }
      }
      
      public function reset() : void
      {
         mcItemList.inventorySlot = rootClass.world.myAvatar.houseitems.length;
         mcItemList.init(rootClass.world.myAvatar.houseitems);
         updateGoldCoin();
      }
   }
}

