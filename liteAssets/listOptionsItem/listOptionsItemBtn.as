package liteAssets.listOptionsItem
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.text.TextField;
   import liteAssets.handlers.optionHandler;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2164")]
   public class listOptionsItemBtn extends MovieClip
   {
      
      public var txtName:TextField;
      
      public var btnActive:SimpleButton;
      
      public var sDesc:String;
      
      public var rootClass:MovieClip;
      
      internal var bypass:Boolean = false;
      
      public function listOptionsItemBtn(param1:MovieClip, param2:String)
      {
         super();
         rootClass = param1;
         this.sDesc = param2;
         btnActive.addEventListener(MouseEvent.CLICK,onActive,false,0,true);
      }
      
      public function confirmAction(param1:Object) : void
      {
         if(param1.accept)
         {
            bypass = true;
            btnActive.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function onActive(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         switch(txtName.text)
         {
            case "Decline All Drops":
               if(bypass)
               {
                  break;
               }
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Are you sure you want to decline all drops?";
               _loc3_.params = {};
               _loc3_.callback = confirmAction;
               _loc3_.glow = "red,medium";
               rootClass.ui.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
               return;
         }
         bypass = false;
         optionHandler.cmd(rootClass,txtName.text);
      }
   }
}

