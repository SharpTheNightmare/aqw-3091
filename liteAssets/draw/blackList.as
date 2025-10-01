package liteAssets.draw
{
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol123")]
   public class blackList extends MovieClip
   {
      
      public var btnClear:SimpleButton;
      
      public var btnDel:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var frame:MovieClip;
      
      public var listBlack:List;
      
      internal var rootClass:MovieClip;
      
      public function blackList(param1:MovieClip)
      {
         super();
         rootClass = param1;
         this.frame.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         this.frame.addEventListener(MouseEvent.MOUSE_UP,onMRelease,false,0,true);
         this.btnDel.addEventListener(MouseEvent.CLICK,onBtnRemoveBlacklist,false,0,true);
         this.btnClear.addEventListener(MouseEvent.CLICK,onBtnClearBlacklist,false,0,true);
         this.btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         if(rootClass.litePreference.data.blackList)
         {
            this.listBlack.dataProvider = new DataProvider(rootClass.litePreference.data.blackList.sortOn("label"));
         }
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
      }
      
      private function onBtnRemoveBlacklist(param1:MouseEvent) : void
      {
         if(this.listBlack.selectedIndex != -1)
         {
            this.listBlack.removeItemAt(this.listBlack.selectedIndex);
            this.listBlack.selectedIndex = -1;
         }
         rootClass.litePreference.data.blackList = this.listBlack.dataProvider.toArray();
         rootClass.litePreference.flush();
      }
      
      private function onBtnClearBlacklist(param1:MouseEvent) : void
      {
         if(!this.listBlack)
         {
            return;
         }
         this.listBlack.removeAll();
         rootClass.litePreference.data.blackList = this.listBlack.dataProvider.toArray();
         rootClass.litePreference.flush();
      }
      
      private function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMRelease(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
   }
}

