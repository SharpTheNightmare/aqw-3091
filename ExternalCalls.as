package
{
   import flash.display.MovieClip;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   
   public class ExternalCalls
   {
      
      private var isWeb:Boolean = false;
      
      private var sourceID:String;
      
      private var isFBSource:Boolean = false;
      
      private var rootClass:MovieClip;
      
      private var conn:*;
      
      private var webCall:ExternalCallsWeb;
      
      public function ExternalCalls(param1:Boolean, param2:String, param3:MovieClip)
      {
         super();
         isWeb = Game.ISWEB;
         sourceID = param2;
         isFBSource = sourceID == "FACEBOOK";
         rootClass = param3;
         if(isWeb)
         {
            webCall = new ExternalCallsWeb(param2,param3);
         }
      }
      
      public function setGameObject(param1:Object) : void
      {
         if(isWeb)
         {
            webCall.setGameObject(param1);
         }
      }
      
      public function showFeedDialog(param1:String, param2:String, param3:String) : void
      {
         if(!isFBSource)
         {
            return;
         }
         if(isWeb)
         {
            webCall.showFeedDialog(param1,param2,param3);
         }
      }
      
      public function fbLogin() : void
      {
         if(isWeb)
         {
            webCall.fbLogin();
         }
      }
      
      public function fbLoginWithPermissions() : void
      {
         if(isWeb)
         {
            webCall.fbLoginWithPermissions();
         }
      }
      
      public function fbLogout() : void
      {
         if(isWeb)
         {
            webCall.fbLogout();
         }
      }
      
      public function getFBUser() : void
      {
         if(isWeb)
         {
            webCall.getFBUser();
         }
      }
      
      public function showIt(param1:String) : void
      {
         var _loc3_:URLRequest = null;
         var _loc4_:URLLoader = null;
         var _loc2_:Boolean = isWeb;
         switch(param1)
         {
            case "level10":
               navigateToURL(new URLRequest("https://www.aq.com/aw-level10.asp"),"_blank");
               _loc2_ = false;
               break;
            case "signup":
               navigateToURL(new URLRequest("https://www.aq.com/aw-welcome.asp?id=" + rootClass.world.myAvatar.objData.UserID),"_blank");
               _loc3_ = new URLRequest("https://www.aq.com/game/quest.asp?userid=" + rootClass.world.myAvatar.objData.UserID + "&qvalue=1");
               _loc3_.method = URLRequestMethod.GET;
               _loc4_ = new URLLoader();
               _loc4_.load(_loc3_);
               break;
            case "login":
               break;
            default:
               if(!isWeb)
               {
                  navigateToURL(new URLRequest("https://www.aq.com/aextras/offers/"),"_blank");
               }
         }
         if(webCall)
         {
            webCall.showIt(param1);
         }
      }
      
      public function callJSFunction(param1:String) : void
      {
         if(isWeb)
         {
            webCall.callJSFunction(param1);
         }
      }
      
      public function getQueryString() : String
      {
         if(isWeb)
         {
            return webCall.getQueryString();
         }
         return "";
      }
      
      public function setToken(param1:Object) : void
      {
         if(isWeb)
         {
            webCall.setToken(param1);
         }
      }
      
      public function setUpPayment(param1:String) : void
      {
         if(isWeb)
         {
            webCall.setUpPayment(param1);
         }
         else
         {
            navigateToURL(new URLRequest("https://www.aq.com/order-now/direct/"),"_blank");
         }
      }
      
      public function logQuestProgress(param1:int, param2:String) : void
      {
         var request:URLRequest = null;
         var loader:URLLoader = null;
         var uid:int = param1;
         var qsVal:String = param2;
         try
         {
            request = new URLRequest("https://www.aq.com/game/quest.asp?userid=" + rootClass.world.myAvatar.objData.UserID + "&qvalue=" + qsVal);
            request.method = URLRequestMethod.GET;
            loader = new URLLoader();
            loader.load(request);
         }
         catch(e:Error)
         {
         }
      }
      
      public function getGroup() : int
      {
         if(isWeb)
         {
            return webCall.getGroup();
         }
         return 1;
      }
   }
}

