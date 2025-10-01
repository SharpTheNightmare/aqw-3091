package liteAssets.listOptionsItem
{
   import fl.controls.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   import liteAssets.handlers.optionHandler;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2161")]
   public class listOptionsItemExtra extends MovieClip
   {
      
      public var txtName:TextField;
      
      public var chkActive:MovieClip;
      
      public var sDesc:String;
      
      public var rootClass:MovieClip;
      
      internal var bypass:Boolean = false;
      
      public function listOptionsItemExtra(param1:MovieClip, param2:Boolean, param3:String)
      {
         super();
         this.rootClass = param1;
         this.sDesc = param3;
         chkActive.checkmark.visible = param2;
         chkActive.addEventListener(MouseEvent.CLICK,onToggle,false,0,true);
      }
      
      public function confirmAction(param1:Object) : void
      {
         if(param1.accept)
         {
            bypass = true;
            chkActive.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function onToggle(param1:MouseEvent) : void
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         switch(txtName.text)
         {
            case "Quantity Warnings":
               if(!chkActive.checkmark.visible || bypass)
               {
                  break;
               }
               _loc3_ = new ModalMC();
               _loc4_ = {};
               _loc4_.strBody = "Turning this off means that you will not go to player support for unaccepted drops! Are you sure?";
               _loc4_.params = {};
               _loc4_.callback = confirmAction;
               _loc4_.glow = "red,medium";
               rootClass.ui.ModalStack.addChild(_loc3_);
               _loc3_.init(_loc4_);
               return;
         }
         bypass = false;
         chkActive.checkmark.visible = !chkActive.checkmark.visible;
         optionHandler.cmd(rootClass,txtName.text);
      }
   }
}

