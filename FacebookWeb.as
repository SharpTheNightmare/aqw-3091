package
{
   import com.facebook.graph.*;
   import flash.display.MovieClip;
   
   public class FacebookWeb
   {
      
      public var fb:FBListener;
      
      public var rootClass:MovieClip;
      
      public var extInterface:ExternalCalls;
      
      public function FacebookWeb()
      {
         super();
      }
      
      public function InitListener(param1:MovieClip) : *
      {
         rootClass = param1;
         fb = new FBListener(param1);
         extInterface = param1.extCall;
      }
      
      public function FBMessage(param1:*, param2:*) : *
      {
         fb.handleFBEvent(param1,param2);
      }
      
      public function Login() : void
      {
         extInterface.fbLogin();
      }
      
      public function Logout() : void
      {
         fb.fbLogout();
         fb.logoutFromFB();
      }
   }
}

