package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol960")]
   public class mcFBPassword extends MovieClip
   {
      
      public var btnClose:SimpleButton;
      
      public var frame:MovieClip;
      
      public var btnPassClick:SimpleButton;
      
      public var btnManage:SimpleButton;
      
      public var mcPassRecovery:SimpleButton;
      
      public var txtCharName:TextField;
      
      public var txtFBName:TextField;
      
      internal var rootClass:MovieClip;
      
      internal var callBack:Function;
      
      internal var errorFunction:Function;
      
      public function mcFBPassword(param1:MovieClip)
      {
         super();
         rootClass = param1;
         txtCharName.text = rootClass.world.myAvatar.objData.strUsername;
         txtFBName.text = "Linked to Facebook account " + rootClass.strToProperCase(rootClass.FBApi.Name);
         btnPassClick.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
         mcPassRecovery.addEventListener(MouseEvent.CLICK,onForgotClick,false,0,true);
         btnManage.addEventListener(MouseEvent.CLICK,onManageClick,false,0,true);
      }
      
      private function onForgotClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.aq.com/help"),"_blank");
      }
      
      private function onManageClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://account.aq.com/"),"_blank");
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         rootClass.sfc.sendXtMessage("zm","fbCmd",["unlinkAccount",rootClass.FBApi.ID],"str",1);
      }
      
      private function onCloseClick(param1:MouseEvent) : void
      {
         rootClass.ui.removeChild(this);
      }
   }
}

