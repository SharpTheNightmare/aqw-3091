package liteAssets.draw
{
   import Game_fla.chkBox_32;
   import Game_fla.searchBtn_664;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2470")]
   public class bankFilters extends MovieClip
   {
      
      public var btnFilter:searchBtn_664;
      
      public var chkLegend:chkBox_32;
      
      public var chkRarity:chkBox_32;
      
      public var chkGold:chkBox_32;
      
      public var chkFree:chkBox_32;
      
      public var chkAC:chkBox_32;
      
      internal var rootClass:MovieClip;
      
      public function bankFilters(param1:MovieClip)
      {
         super();
         rootClass = param1;
         this.chkAC.checkmark.visible = false;
         this.chkGold.checkmark.visible = false;
         this.chkLegend.checkmark.visible = false;
         this.chkFree.checkmark.visible = false;
         this.chkRarity.checkmark.visible = false;
         this.chkAC.addEventListener(MouseEvent.CLICK,onChkChange,false,0,true);
         this.chkGold.addEventListener(MouseEvent.CLICK,onChkChange,false,0,true);
         this.chkLegend.addEventListener(MouseEvent.CLICK,onChkChange,false,0,true);
         this.chkFree.addEventListener(MouseEvent.CLICK,onChkChange,false,0,true);
         this.chkRarity.addEventListener(MouseEvent.CLICK,onChkChange,false,0,true);
         this.btnFilter.addEventListener(MouseEvent.CLICK,onBtnFilter,false,0,true);
      }
      
      public function onChkChange(param1:MouseEvent) : void
      {
         param1.currentTarget.checkmark.visible = !param1.currentTarget.checkmark.visible;
         switch(param1.currentTarget.name)
         {
            case "chkAC":
               if(param1.currentTarget.checkmark.visible)
               {
                  chkGold.checkmark.visible = false;
               }
               break;
            case "chkGold":
               if(param1.currentTarget.checkmark.visible)
               {
                  chkAC.checkmark.visible = false;
               }
               break;
            case "chkLegend":
               if(param1.currentTarget.checkmark.visible)
               {
                  chkFree.checkmark.visible = false;
               }
               break;
            case "chkFree":
               if(param1.currentTarget.checkmark.visible)
               {
                  chkLegend.checkmark.visible = false;
               }
         }
      }
      
      public function onFilter(param1:*, param2:int = -1, param3:Array = null) : Boolean
      {
         var _loc4_:* = true;
         if(chkAC.checkmark.visible)
         {
            _loc4_ = param1.bCoins == 1;
         }
         else if(chkGold.checkmark.visible)
         {
            _loc4_ = param1.bCoins == 0;
         }
         if(chkLegend.checkmark.visible)
         {
            _loc4_ &&= param1.bUpg == 1;
         }
         else if(chkFree.checkmark.visible)
         {
            _loc4_ &&= param1.bUpg == 0;
         }
         if(chkRarity.checkmark.visible)
         {
            _loc4_ &&= param1.iRty == 30;
         }
         if(!chkAC.checkmark.visible && !chkGold.checkmark.visible && !chkLegend.checkmark.visible && !chkFree.checkmark.visible && !chkRarity.checkmark.visible)
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
      
      public function dispatch() : void
      {
         btnFilter.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onBtnFilter(param1:MouseEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = new Array();
         for each(_loc3_ in rootClass.world.bankinfo.lastSearch == "" ? rootClass.world.bankinfo.bankItems : rootClass.world.bankinfo.searchArr)
         {
            _loc2_.push(_loc3_);
         }
         rootClass.world.bankController.searchArr = new Array();
         for each(_loc4_ in _loc2_.filter(onFilter))
         {
            rootClass.world.bankController.searchArr.push(_loc4_);
         }
         MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshItems"});
      }
   }
}

