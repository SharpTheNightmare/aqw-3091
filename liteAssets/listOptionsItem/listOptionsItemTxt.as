package liteAssets.listOptionsItem
{
   import fl.controls.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.text.*;
   import liteAssets.draw.charPage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2152")]
   public class listOptionsItemTxt extends MovieClip
   {
      
      public var txtName:TextField;
      
      public var txtSearch:TextField;
      
      public var btnActive:SimpleButton;
      
      public var sDesc:String;
      
      public var rootClass:MovieClip;
      
      public function listOptionsItemTxt(param1:MovieClip, param2:String)
      {
         super();
         rootClass = param1;
         this.sDesc = param2;
         btnActive.addEventListener(MouseEvent.CLICK,onActive,false,0,true);
         txtSearch.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress,false,0,true);
      }
      
      public function onActive(param1:MouseEvent) : void
      {
         if(txtSearch.text.length < 1)
         {
            return;
         }
         var _loc2_:charPage = new charPage(rootClass,txtSearch.text);
         rootClass.ui.addChild(_loc2_);
      }
      
      public function onKeyPress(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            btnActive.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

