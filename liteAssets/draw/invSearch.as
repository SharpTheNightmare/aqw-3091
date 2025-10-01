package liteAssets.draw
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2178")]
   public class invSearch extends MovieClip
   {
      
      public var txtSearch:TextField;
      
      internal var rootClass:MovieClip;
      
      public function invSearch(param1:MovieClip)
      {
         super();
         rootClass = param1;
         this.txtSearch.addEventListener(KeyboardEvent.KEY_DOWN,onInvSearch,false,0,true);
      }
      
      public function onFilter(param1:*, param2:int, param3:Array) : Boolean
      {
         return param1.sName.toLowerCase().indexOf(this.txtSearch.text.toLowerCase()) > -1;
      }
      
      public function apply() : void
      {
         if(rootClass.ui.mcPopup.currentLabel == "Inventory")
         {
            rootClass.world.myAvatar.filtered_list = this.txtSearch.text != "" ? rootClass.world.myAvatar.items.filter(onFilter) : null;
            MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshInv"});
         }
         else if(rootClass.ui.mcPopup.currentLabel == "HouseInventory")
         {
            rootClass.world.myAvatar.filtered_list = this.txtSearch.text != "" ? rootClass.world.myAvatar.houseitems.filter(onFilter) : null;
            MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshInv"});
         }
         else if(rootClass.ui.mcPopup.currentLabel == "Bank")
         {
            rootClass.world.myAvatar.filtered_list = this.txtSearch.text != "" ? rootClass.world.myAvatar.items.filter(onFilter) : null;
            MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshInv"});
         }
         else if(rootClass.ui.mcPopup.currentLabel == "HouseBank")
         {
            rootClass.world.myAvatar.filtered_list = this.txtSearch.text != "" ? rootClass.world.myAvatar.houseitems.filter(onFilter) : null;
            MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshInv"});
         }
      }
      
      internal function onInvSearch(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 13)
         {
            apply();
         }
      }
      
      public function reset() : void
      {
         rootClass.world.myAvatar.filtered_list = null;
      }
   }
}

