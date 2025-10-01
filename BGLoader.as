package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class BGLoader
   {
      
      internal static var mcLogin:MovieClip;
      
      internal static var sUrl:String;
      
      internal static var sTitle:String = "";
      
      public function BGLoader()
      {
         super();
      }
      
      public static function LoadBG(param1:String, param2:MovieClip, param3:String, param4:String) : void
      {
         mcLogin = param2;
         if(param1.indexOf("file:") > -1)
         {
            sUrl = "https://content.aq.com/game/";
         }
         else
         {
            sUrl = param1;
         }
         sTitle = param4;
         loadTitle(param3);
      }
      
      internal static function onDataComplete(param1:Event) : void
      {
         var _loc2_:URLVariables = new URLVariables(param1.target.data);
         if(_loc2_.status == "success")
         {
            loadTitle(_loc2_.sBG);
         }
      }
      
      internal static function loadTitle(param1:String) : void
      {
         var _loc3_:Loader = null;
         var _loc2_:ApplicationDomain = new ApplicationDomain();
         if(param1 != null)
         {
            _loc3_ = new Loader();
            _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,onTitleComplete);
            _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
            _loc3_.load(new URLRequest(sUrl + "gamefiles/title/" + param1),new LoaderContext(false,_loc2_));
         }
         else
         {
            Game.root["mcLogin"].gotoAndStop("GetLauncher");
         }
      }
      
      internal static function onTitleComplete(param1:Event) : void
      {
         var _loc2_:MovieClip = MovieClip(Loader(param1.target.loader).content);
         mcLogin.mcTitle.removeChildAt(0);
         mcLogin.mcTitle.addChild(_loc2_);
         mcLogin.mcLogo.txtTitle.htmlText = "<font color=\"#FFB231\">New Release:</font> " + sTitle;
         mcLogin = null;
      }
      
      internal static function onError(param1:IOErrorEvent) : *
      {
      }
   }
}

