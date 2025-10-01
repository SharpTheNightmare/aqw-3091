package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.*;
   
   public class LPFLayoutInvShopEnh extends LPFLayout
   {
      
      private var aSel:String = "";
      
      private var bSel:String = "";
      
      public var iQty:int = 1;
      
      public var iSel:Object;
      
      public var eSel:Object;
      
      public var shopinfo:Object;
      
      public var itemsInv:Array;
      
      public var itemsShop:Array;
      
      public var multiPanel:MovieClip;
      
      public var splitPanel:MovieClip;
      
      public var previewPanel:MovieClip;
      
      public var rootClass:MovieClip;
      
      public function LPFLayoutInvShopEnh()
      {
         super();
         x = 0;
         y = 0;
         panels = [];
         fData = {};
      }
      
      override public function fOpen(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:MovieClip = null;
         rootClass = MovieClip(stage.getChildAt(0));
         fData = param1.fData;
         sMode = param1.sMode;
         if("itemsInv" in fData)
         {
            itemsInv = fData.itemsInv;
         }
         if("itemsShop" in fData)
         {
            itemsShop = fData.itemsShop;
         }
         if("shopinfo" in fData)
         {
            shopinfo = fData.shopinfo;
         }
         _loc2_ = param1.r;
         var _loc3_:String = "";
         x = _loc2_.x;
         y = _loc2_.y;
         w = _loc2_.w;
         h = _loc2_.h;
         tempFill();
         _loc4_ = {};
         _loc4_.panel = new LPFPanelListShopInvB();
         _loc3_ = "EnhInventory";
         _loc4_.fData = {
            "items":itemsInv,
            "sName":_loc3_
         };
         _loc4_.r = {
            "x":322,
            "y":3,
            "w":316,
            "h":495
         };
         _loc4_.closeType = "hide";
         _loc4_.hideDir = "right";
         _loc4_.hidePad = 3;
         _loc4_.isOpen = false;
         splitPanel = addPanel(_loc4_);
         splitPanel.visible = false;
         splitPanel.fHide();
         _loc4_ = {};
         _loc4_.panel = new LPFPanelPreview();
         _loc3_ = "Preview";
         _loc4_.fData = {"sName":_loc3_};
         _loc4_.r = {
            "x":322,
            "y":78,
            "w":316,
            "h":420
         };
         _loc4_.closeType = "hide";
         _loc4_.xBuffer = 3;
         _loc4_.showDragonLeft = true;
         _loc4_.isOpen = false;
         previewPanel = addPanel(_loc4_);
         previewPanel.visible = false;
         previewPanel.addEventListener(Event.ENTER_FRAME,previewPanelEF,false,0,true);
         _loc4_ = {};
         _loc4_.panel = new LPFPanelListShopInvA();
         _loc3_ = sMode.toLowerCase().indexOf("shop") > -1 ? rootClass.world.shopinfo.sName : "Inventory";
         _loc4_.fData = {
            "items":(itemsShop != null ? itemsShop : itemsInv),
            "itemsInv":itemsInv,
            "objData":fData.objData,
            "sName":_loc3_
         };
         if(shopinfo != null)
         {
            _loc4_.fData.shopinfo = shopinfo;
         }
         _loc4_.r = {
            "x":641,
            "y":3,
            "w":316,
            "h":495
         };
         _loc4_.closeType = "close";
         _loc4_.showDragonRight = true;
         _loc4_.isOpen = true;
         multiPanel = addPanel(_loc4_);
         updatePreviewButtons();
         rootClass.dropStackBoost();
      }
      
      override public function fClose() : void
      {
         var _loc1_:MovieClip = null;
         rootClass.dropStackReset();
         previewPanel.removeEventListener(Event.ENTER_FRAME,previewPanelEF);
         while(panels.length > 0)
         {
            panels[0].mc.fClose();
            panels.shift();
         }
         if(parent != null)
         {
            _loc1_ = MovieClip(parent);
            _loc1_.removeChild(this);
            _loc1_.onClose();
         }
      }
      
      override protected function handleUpdate(param1:Object) : Object
      {
         var _loc3_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:* = undefined;
         var _loc10_:Object = null;
         var _loc11_:* = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:Object = null;
         var _loc2_:Boolean = false;
         var _loc4_:Object = iSel;
         var _loc5_:Object = eSel;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         if(iSel != null && eSel != null)
         {
            previewPanel.bg.tTitle.text = "Create";
         }
         else
         {
            previewPanel.bg.tTitle.text = "Preview";
         }
         if(param1.eventType == "sModeSet")
         {
            if(sMode != param1.sModeBroadcast)
            {
               sMode = param1.sModeBroadcast;
               iSel = null;
               eSel = null;
               param1.iSel = iSel;
               _loc8_ = itemsInv;
               if(sMode == "shopBuy")
               {
                  _loc8_ = itemsShop;
               }
               param1.fData = {"list":_loc8_};
               splitPanel.fHide();
               previewPanel.fHide();
            }
         }
         if(param1.eventType == "listItemASel")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               iQty = 1;
               eSel = null;
               iSel = null;
               aSel = param1.fData.sType.toLowerCase();
               bSel = "";
               if(aSel == "enhancement")
               {
                  eSel = param1.fData;
               }
               else
               {
                  iSel = param1.fData;
               }
               if(param1.fData.sType.toLowerCase() == "enhancement")
               {
                  param1.tabStates = getTabStates(param1.fData);
               }
               else
               {
                  param1.tabStates = getTabStates({"sES":"enh"});
               }
               param1.fData = {
                  "iSel":iSel,
                  "eSel":eSel,
                  "oSel":param1.fData
               };
               splitPanel.fHide();
               previewPanel.fShow();
               if(iSel != null && eSel == null)
               {
                  splitPanel.bg.tTitle.text = "Select Enhancement to Apply";
               }
               if(iSel == null && eSel != null)
               {
                  splitPanel.bg.tTitle.text = sMode == "shopBuy" ? "Select Items to Enhance" : "Select Item to Enhance";
               }
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "listItemBSel")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               _loc3_ = rootClass.copyObj(param1);
               _loc3_.eventType = "listItemBSolo";
               if(param1.fData.sType.toLowerCase() == "enhancement")
               {
                  _loc3_.fData = {
                     "iSel":null,
                     "eSel":_loc3_.fData
                  };
               }
               else
               {
                  _loc3_.fData = {
                     "iSel":_loc3_.fData,
                     "eSel":null
                  };
               }
               if(bSel == "enhancement")
               {
                  eSel = null;
               }
               else if(bSel != "")
               {
                  iSel = null;
               }
               bSel = param1.fData.sType.toLowerCase();
               if(bSel == "enhancement")
               {
                  eSel = param1.fData;
               }
               else
               {
                  iSel = param1.fData;
               }
               param1.fData = {
                  "iSel":iSel,
                  "eSel":eSel
               };
               if(_loc4_ != iSel || _loc5_ != eSel)
               {
                  notifyByEventType(_loc3_);
               }
               previewPanel.fShow();
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "refreshItems")
         {
            if(itemsInv.indexOf(iSel) == -1)
            {
               iSel = null;
            }
            if(itemsInv.indexOf(eSel) == -1)
            {
               eSel = null;
            }
            param1.fData = {
               "iSel":iSel,
               "eSel":eSel
            };
            if("sInstruction" in param1)
            {
               if(param1.sInstruction == "closeWindows")
               {
                  splitPanel.fHide();
                  previewPanel.fHide();
               }
               if(param1.sInstruction == "previewEquipOnly")
               {
                  splitPanel.fHide();
                  if(iSel != null && iSel.bEquip != 1)
                  {
                     _loc6_ = {};
                     _loc6_.eventType = "previewButton1Update";
                     _loc6_.fData = {};
                     _loc6_.fData.sText = "Equip";
                     _loc6_.sMode = "red";
                     _loc6_.r = {
                        "x":-1,
                        "y":-40,
                        "w":-1,
                        "h":-1
                     };
                     _loc6_.buttonNewEventType = "equipItem";
                     _loc7_ = {};
                     _loc7_.eventType = "previewButton2Update";
                     _loc7_.fData = {};
                     _loc7_.fData.sText = "";
                     _loc7_.sMode = "grey";
                     _loc7_.r = {
                        "x":173,
                        "y":-40,
                        "w":-1,
                        "h":-1
                     };
                  }
                  else
                  {
                     previewPanel.fHide();
                  }
               }
            }
            if(iSel == null && eSel == null)
            {
               splitPanel.fHide();
               previewPanel.fHide();
            }
         }
         if(param1.eventType == "refreshShop")
         {
            rootClass.world.sendReloadShopRequest(shopinfo.ShopID);
            _loc2_ = true;
         }
         if(param1.eventType == "showItemListB")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               splitPanel.fShow();
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "showItemListBNoBtns")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               _loc6_ = {};
               _loc6_.eventType = "previewButton1Update";
               _loc6_.fData = {};
               _loc6_.fData.sText = "";
               _loc7_ = {};
               param1.eventType = "showItemListB";
               splitPanel.fShow();
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "equipItem" || param1.eventType == "unequipItem")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               if(iSel != null)
               {
                  if(iSel.sES == "Weapon" && param1.eventType == "unequipItem")
                  {
                     if(rootClass.world.myAvatar.getItemByID(156) != null)
                     {
                        rootClass.toggleItemEquip(rootClass.world.myAvatar.getItemByID(156));
                        splitPanel.fHide();
                        previewPanel.fHide();
                     }
                     else
                     {
                        rootClass.MsgBox.notify("Selected Item cannot be unequipped!");
                     }
                  }
                  else if(Boolean(rootClass.toggleItemEquip(iSel)) && param1.eventType == "equipItem")
                  {
                     splitPanel.fHide();
                     previewPanel.fHide();
                  }
               }
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "consumePotion")
         {
            if(iSel.bEquip == 1 || Boolean(rootClass.toggleItemEquip(iSel)))
            {
               rootClass.equipPotionOnSeia = true;
               splitPanel.fHide();
               previewPanel.fHide();
            }
         }
         if(param1.eventType == "enhanceItem")
         {
            if(!rootClass.isGreedyModalInStack())
            {
               if(iSel != null && eSel != null)
               {
                  rootClass.tryEnhance(splitPanel.frames[2].mc.getSelectedItems(),eSel,sMode == "shopBuy");
               }
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(param1.eventType == "buyItem")
         {
            _loc9_ = iSel != null ? iSel : eSel;
            if(_loc9_ != null)
            {
               if(_loc9_.iCost <= 0)
               {
                  _loc10_ = {
                     "accept":true,
                     "iSel":_loc9_,
                     "iQty":iQty
                  };
                  rootClass.world.sendBuyItemRequestWithQuantity(_loc10_);
               }
               else
               {
                  _loc11_ = "Are you sure you want to buy \'" + _loc9_.sName + "\'?";
                  if(iQty > 1)
                  {
                     _loc11_ = "Are you sure you want to buy " + String(iQty) + "x \'" + _loc9_.sName + "\'?";
                  }
                  _loc12_ = new ModalMC();
                  _loc13_ = {};
                  _loc13_.strBody = _loc11_;
                  _loc13_.params = {
                     "iSel":_loc9_,
                     "iQty":iQty
                  };
                  _loc13_.callback = rootClass.world.sendBuyItemRequestWithQuantity;
                  _loc13_.glow = "white,medium";
                  _loc13_.greedy = false;
                  rootClass.ui.ModalStack.addChild(_loc12_);
                  _loc12_.init(_loc13_);
               }
            }
         }
         if(param1.eventType == "useItem")
         {
            if(iSel != null)
            {
               rootClass.world.tryUseItem(iSel);
            }
         }
         if(param1.eventType == "sellItem")
         {
            if(iSel != null)
            {
               _loc14_ = iSel;
            }
            else if(eSel != null)
            {
               _loc14_ = eSel;
            }
            if(_loc14_.bEquip && _loc14_.sType != "Floor Item" && _loc14_.sType != "Wall Item" || _loc14_.bEquip >= _loc14_.iQty)
            {
               if(_loc14_.sType == "Floor Item" || _loc14_.sType == "Wall Item")
               {
                  rootClass.MsgBox.notify("Item is currently placed in your house!");
               }
               else
               {
                  rootClass.MsgBox.notify("Item is currently equipped!");
               }
            }
            else if(_loc14_.bCoins == 1 && _loc14_.iHrs == null && _loc14_.ItemID != 8939 && _loc14_.iCost != 0)
            {
               rootClass.MsgBox.notify("Cannot be sold, free storage in your bank!");
            }
            else if(_loc14_ && _loc14_.hasOwnProperty("sMeta") && _loc14_.sMeta.toString().indexOf("NoSell") > -1)
            {
               rootClass.MsgBox.notify("This item cannot be sold!");
            }
            else
            {
               _loc11_ = "Are you sure you want to sell \'" + _loc14_.sName + "\'?";
               if(iQty > 1)
               {
                  _loc11_ = "Are you sure you want to sell " + String(iQty) + "x \'" + _loc14_.sName + "\'?";
               }
               _loc12_ = new ModalMC();
               _loc13_ = {};
               _loc13_.strBody = _loc11_;
               _loc13_.params = {
                  "iSel":_loc14_,
                  "iQty":iQty
               };
               _loc13_.callback = rootClass.world.sendSellItemRequestWithQuantity;
               _loc13_.glow = "white,medium";
               _loc13_.greedy = false;
               rootClass.ui.ModalStack.addChild(_loc12_);
               _loc12_.init(_loc13_);
            }
         }
         if(param1.eventType == "buyBagSlots")
         {
            _loc2_ = true;
            rootClass.world.loadMovieFront(rootClass.bagSpace,"Inline Asset");
            fClose();
         }
         if(param1.eventType == "toggleHouseInventory")
         {
            if(!rootClass.world.uiLock)
            {
               rootClass.ui.mcPopup.fOpen("HouseInventory");
            }
         }
         if(param1.eventType == "helpAC")
         {
            _loc2_ = true;
            rootClass.world.loadMovieFront("interface/goldAC5.swf","Inline Asset");
         }
         if(param1.eventType == "hideItem")
         {
            if(rootClass.world.coolDown("unwearItem"))
            {
               rootClass.sfc.sendXtMessage("zm","unwearItem",[iSel.sES],"str",rootClass.world.curRoom);
            }
            splitPanel.fHide();
            previewPanel.fHide();
         }
         if(param1.eventType == "showItem")
         {
            if(iSel.bUpg == 1 && !rootClass.world.myAvatar.isUpgraded())
            {
               rootClass.showUpgradeWindow();
            }
            else
            {
               if(rootClass.world.coolDown("wearItem"))
               {
                  rootClass.sfc.sendXtMessage("zm","wearItem",[iSel.ItemID],"str",rootClass.world.curRoom);
               }
               splitPanel.fHide();
               previewPanel.fHide();
            }
         }
         updatePreviewButtons(_loc6_,_loc7_);
         _loc4_ = null;
         _loc5_ = null;
         if(!_loc2_)
         {
            return param1;
         }
         return null;
      }
      
      private function updatePreviewButtons(param1:Object = null, param2:Object = null) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc3_:Object = {};
         var _loc4_:Object = {};
         if(param1 != null && param2 != null)
         {
            _loc3_ = param1;
            _loc4_ = param2;
         }
         else
         {
            _loc3_.eventType = "previewButton1Update";
            _loc3_.fData = {};
            _loc3_.fData.sText = "";
            _loc3_.sMode = "grey";
            _loc3_.r = {
               "x":46,
               "y":-40,
               "w":-1,
               "h":-1
            };
            _loc3_.buttonNewEventType = "";
            _loc4_.eventType = "previewButton2Update";
            _loc4_.fData = {};
            _loc4_.fData.sText = "";
            _loc4_.sMode = "grey";
            _loc4_.r = {
               "x":173,
               "y":-40,
               "w":-1,
               "h":-1
            };
            _loc4_.buttonNewEventType = "";
            if(sMode == "inventory")
            {
               if(iSel == null && eSel == null)
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "";
                  _loc4_.buttonNewEventType = "";
               }
               else if(iSel != null && eSel != null)
               {
                  _loc3_.fData.sText = "Enhance!";
                  _loc3_.buttonNewEventType = "enhanceItem";
                  _loc3_.sMode = "red";
                  if(iSel.bEquip == 1)
                  {
                     _loc4_.fData.sText = "Unequip";
                     _loc4_.buttonNewEventType = "unequipItem";
                  }
                  else
                  {
                     _loc4_.fData.sText = "Equip";
                     _loc4_.buttonNewEventType = "equipItem";
                     if(_loc3_.sMode != "red")
                     {
                        _loc4_.sMode = "red";
                     }
                  }
               }
               else if(eSel != null)
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "Apply Now";
                  _loc4_.buttonNewEventType = "showItemListB";
                  _loc4_.sMode = "red";
               }
               else if(iSel != null)
               {
                  if(["Weapon","he","ar","ba"].indexOf(iSel.sES) > -1)
                  {
                     if(iSel.bUpg == 1 && rootClass.world.myAvatar.isUpgraded() || iSel.bUpg == 0)
                     {
                        if(iSel.sES != "ar")
                        {
                           if(iSel.bWear)
                           {
                              _loc3_.fData.sText = "Hide";
                              _loc3_.buttonNewEventType = "hideItem";
                           }
                           else
                           {
                              _loc3_.fData.sText = "Show";
                              _loc3_.buttonNewEventType = "showItem";
                           }
                        }
                     }
                     if(!("EnhLvl" in iSel))
                     {
                        _loc3_.sMode = "red";
                     }
                     else
                     {
                        _loc4_.sMode = "red";
                     }
                     if(iSel.bEquip == 1)
                     {
                        _loc4_.fData.sText = "Unequip";
                        _loc4_.buttonNewEventType = "unequipItem";
                     }
                     else
                     {
                        _loc4_.fData.sText = "Equip";
                        _loc4_.buttonNewEventType = "equipItem";
                     }
                     _loc3_.sMode = "red";
                  }
                  else
                  {
                     _loc5_ = String(iSel.sLink).toLowerCase();
                     _loc6_ = String(iSel.sType).toLowerCase();
                     _loc7_ = _loc6_ == "item" && _loc5_.length > 0 && _loc5_ != "none";
                     if(iSel.sType.toLowerCase() == "pet" || _loc7_ || iSel.sES == "co" || iSel.sES == "am" || iSel.sES == "mi")
                     {
                        if(iSel.bUpg == 1 && rootClass.world.myAvatar.isUpgraded() || iSel.bUpg == 0)
                        {
                           if(iSel.sES == "co")
                           {
                              if(iSel.bWear)
                              {
                                 _loc3_.fData.sText = "Hide";
                                 _loc3_.buttonNewEventType = "hideItem";
                              }
                              else
                              {
                                 _loc3_.fData.sText = "Show";
                                 _loc3_.buttonNewEventType = "showItem";
                              }
                              _loc3_.sMode = "red";
                           }
                           if(iSel.sType.toLowerCase() == "item" && iSel.sName != "Treasure Potion" && iSel.sName.indexOf(" Item of Digital Awesomeness") == -1)
                           {
                              _loc3_.fData.sText = "Consume";
                              _loc3_.buttonNewEventType = "consumePotion";
                              _loc3_.sMode = "red";
                           }
                        }
                        if(iSel.sName.indexOf(" Item of Digital Awesomeness") == -1)
                        {
                           _loc4_.sMode = "red";
                           if(iSel.bEquip == 1)
                           {
                              _loc4_.fData.sText = "Unequip";
                              _loc4_.buttonNewEventType = "unequipItem";
                           }
                           else
                           {
                              _loc4_.fData.sText = "Equip";
                              _loc4_.buttonNewEventType = "equipItem";
                           }
                        }
                     }
                     if(iSel.sType.toLowerCase() == "serveruse" || iSel.sType.toLowerCase() == "clientuse")
                     {
                        _loc4_.sMode = "red";
                        _loc4_.fData.sText = "Use";
                        _loc4_.buttonNewEventType = "useItem";
                     }
                  }
               }
            }
            if(sMode == "shopBuy")
            {
               if(iSel == null && eSel == null)
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "";
                  _loc4_.buttonNewEventType = "";
               }
               else if(iSel != null && eSel != null)
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "Enhance!";
                  _loc4_.buttonNewEventType = "enhanceItem";
                  _loc4_.sMode = "red";
               }
               else if(eSel != null)
               {
                  _loc3_.fData.sText = "Buy and Hold";
                  _loc3_.buttonNewEventType = "buyItem";
                  _loc4_.fData.sText = "Apply Now";
                  _loc4_.buttonNewEventType = "showItemListBNoBtns";
                  _loc4_.sMode = "red";
               }
               else if(iSel != null)
               {
                  if("bLimited" in shopinfo && shopinfo.bLimited && iSel.iQtyRemain <= 0)
                  {
                     _loc3_.fData.sText = "";
                     _loc3_.buttonNewEventType = "";
                     _loc4_.fData.sText = "Sold Out!";
                     _loc4_.buttonNewEventType = "none";
                     _loc4_.sMode = "grey";
                  }
                  else
                  {
                     _loc3_.fData.sText = "";
                     _loc3_.buttonNewEventType = "";
                     _loc4_.fData.sText = "Buy";
                     _loc4_.buttonNewEventType = "buyItem";
                     _loc4_.sMode = "red";
                  }
               }
            }
            if(sMode == "shopSell")
            {
               if(iSel == null && eSel == null)
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "";
                  _loc4_.buttonNewEventType = "";
               }
               else
               {
                  _loc3_.fData.sText = "";
                  _loc3_.buttonNewEventType = "";
                  _loc4_.fData.sText = "Sell";
                  _loc4_.buttonNewEventType = "sellItem";
                  _loc4_.sMode = "red";
               }
            }
         }
         notifyByEventType(_loc3_);
         notifyByEventType(_loc4_);
      }
      
      private function onSellRequest(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.world.sendSellItemRequest(param1.iSel);
         }
      }
      
      public function getTabStates(param1:Object = null) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = [{
            "sTag":"Show All",
            "icon":"iipack",
            "state":-1,
            "filter":"*",
            "mc":{}
         },{
            "sTag":"Show only weapons",
            "icon":"iwsword",
            "state":-1,
            "filter":"Weapon",
            "mc":{}
         },{
            "sTag":"Show only armor",
            "icon":"iiclass",
            "state":-1,
            "filter":"ar",
            "mc":{}
         },{
            "sTag":"Show only helms",
            "icon":"iihelm",
            "state":-1,
            "filter":"he",
            "mc":{}
         },{
            "sTag":"Show only capes",
            "icon":"iicape",
            "state":-1,
            "filter":"ba",
            "mc":{}
         },{
            "sTag":"Show only pets",
            "icon":"iipet",
            "state":-1,
            "filter":"pe",
            "mc":{}
         },{
            "sTag":"Show only amulets",
            "icon":"iin1",
            "state":-1,
            "filter":"am",
            "mc":{}
         },{
            "sTag":"Show only items",
            "icon":"iibag",
            "state":-1,
            "filter":"it",
            "mc":{}
         }];
         if(itemsShop == null)
         {
            _loc2_.push({
               "sTag":"Show only potions & elixirs",
               "icon":"ich1",
               "state":-1,
               "filter":"pots",
               "mc":{}
            });
         }
         else
         {
            _loc2_.push({
               "sTag":"Show only house items",
               "icon":"ihhouse",
               "state":-1,
               "filter":"houseitems",
               "mc":{}
            });
         }
         if(param1 != null)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.filter == param1.sES)
               {
                  return [_loc3_];
               }
            }
            return [_loc2_[0]];
         }
         return _loc2_;
      }
      
      private function previewPanelEF(param1:Event) : void
      {
         var _loc2_:Number = previewPanel.x;
         var _loc3_:Number = splitPanel.x - previewPanel.w - previewPanel.xBuffer;
         var _loc4_:Number = _loc3_ - _loc2_;
         if(_loc4_ > 20 || splitPanel.visible)
         {
            previewPanel.x = splitPanel.x - previewPanel.w - previewPanel.xBuffer;
         }
      }
   }
}

