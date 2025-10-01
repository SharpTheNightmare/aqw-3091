package liteAssets.listOptionsItem
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import liteAssets.handlers.optionHandler;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2155")]
   public class listOptionsItemExtraBtn extends MovieClip
   {
      
      public var txtName:TextField;
      
      public var btnActive:SimpleButton;
      
      public var sDesc:String;
      
      public var rootClass:MovieClip;
      
      public function listOptionsItemExtraBtn(param1:MovieClip, param2:String)
      {
         super();
         rootClass = param1;
         this.sDesc = param2;
         btnActive.addEventListener(MouseEvent.CLICK,onActive,false,0,true);
      }
      
      public function onActive(param1:MouseEvent) : void
      {
         optionHandler.cmd(rootClass,txtName.text);
      }
   }
}

