package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2723")]
   public class TempInventory extends MovieClip
   {
      
      public var strGold:TextField;
      
      public var mcItemList:ItemList;
      
      public var txtEquip:TextField;
      
      public var strInfo:TextField;
      
      public var btnEquip:SimpleButton;
      
      public var bg1:MovieClip;
      
      public var strCoins:TextField;
      
      internal var rootClass:MovieClip = MovieClip(parent.parent.parent);
      
      public function TempInventory()
      {
         super();
         bg1.btnClose.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         btnEquip.addEventListener(MouseEvent.CLICK,onEquipClick,false,0,true);
         txtEquip.mouseEnabled = false;
         init();
      }
      
      public function onDeleteClick(param1:Event) : void
      {
      }
      
      public function onEquipClick(param1:Event) : *
      {
         rootClass.mixer.playSound("Click");
         var _loc2_:* = rootClass.world.getUoLeafById(rootClass.world.myAvatar.uid);
         if(_loc2_.intState != 1)
         {
            rootClass.MsgBox.notify("Action cannot be performed during combat!");
         }
         else if(mcItemList.selectedItem.bEquip == 1)
         {
            if(mcItemList.selectedItem.sES == "Weapon" || mcItemList.selectedItem.sES == "ar")
            {
               rootClass.MsgBox.notify("Selected Item cannot be unequipped!");
            }
            else
            {
               rootClass.world.sendUnequipItemRequest(mcItemList.selectedItem);
            }
         }
         else if(mcItemList.selectedItem.bUpg == 1 && !rootClass.world.myAvatar.isUpgraded())
         {
            rootClass.showUpgradeWindow();
         }
         else if(int(mcItemList.selectedItem.iEnhLvl) > int(rootClass.world.myAvatar.objData.intLevel))
         {
            rootClass.MsgBox.notify("Level requirement not met!");
         }
         else if(mcItemList.selectedItem.sES != "mi" && mcItemList.selectedItem.sES != "co" && mcItemList.selectedItem.EnhID <= 0)
         {
            rootClass.MsgBox.notify("Selected item requires enhancement!");
         }
         else
         {
            rootClass.world.sendEquipItemRequest(mcItemList.selectedItem);
         }
      }
      
      internal function onCloseClick(param1:Event) : *
      {
         MovieClip(parent).onClose();
      }
      
      public function toggleInventory() : void
      {
         this.visible = !this.visible;
      }
      
      public function refreshDetail() : void
      {
         if(selectedItem == null)
         {
            strInfo.htmlText = "Please select an item to view details.";
            btnEquip.visible = txtEquip.visible = false;
         }
         else
         {
            if(selectedItem.bEquip == 1)
            {
               txtEquip.text = "Unequip";
            }
            else
            {
               txtEquip.text = "Equip";
            }
            btnEquip.visible = txtEquip.visible = selectedItem.sES == "co";
            strInfo.htmlText = getItemInfoString(selectedItem);
         }
      }
      
      public function get selectedItem() : Object
      {
         return mcItemList.selectedItem;
      }
      
      public function init() : void
      {
         mcItemList.init(MovieClip(parent.parent.parent).world.myAvatar.tempitems);
         updateGold();
         refreshDetail();
      }
      
      public function updateGold() : void
      {
         strGold.text = MovieClip(parent.parent.parent).world.myAvatar.objData.intGold;
         strCoins.text = MovieClip(parent.parent.parent).world.myAvatar.objData.intCoins;
      }
      
      internal function getItemInfoString(param1:Object) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:* = "<font size=\'14\'><b>" + param1.sName + "</b></font><br>";
         var _loc3_:* = "#009900";
         _loc2_ += "<font color=\'" + _loc3_ + "\'><b>" + param1.sType;
         if(param1.iStk > 1)
         {
            _loc2_ += " - " + param1.iQty + "/" + param1.iStk;
         }
         if(param1.sES == "Weapon")
         {
            if(param1.iEnh > 0)
            {
               _loc2_ += ", Lvl " + param1.iLvl + "<br>";
               _loc4_ = Math.sqrt(param1.iLvl) * 20 * param1.iDPS / 100;
               _loc2_ += Math.ceil(_loc4_ * (100 - Number(param1.iRng)) / 100) + " - " + Math.ceil(_loc4_ * (100 + Number(param1.iRng)) / 100) + " " + param1.sElmt;
            }
            else
            {
               _loc2_ += " Design";
            }
         }
         return _loc2_ + ("</b></font><br>" + param1.sDesc + "<br>");
      }
   }
}

