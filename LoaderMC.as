package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2140")]
   public class LoaderMC extends MovieClip
   {
      
      public var mcPct:TextField;
      
      public var btnCancel:SimpleButton;
      
      public var strLoad:TextField;
      
      internal var mcDest:MovieClip;
      
      internal var isEvent:Boolean = false;
      
      private var rootClass:MovieClip;
      
      public var history:Object = {};
      
      private var _file:String;
      
      public function LoaderMC(param1:MovieClip)
      {
         super();
         btnCancel.addEventListener(MouseEvent.CLICK,onCancelClick);
         rootClass = param1;
      }
      
      public function loadFile(param1:MovieClip, param2:String, param3:String, param4:Boolean = false) : void
      {
         _file = param2;
         var _loc5_:Number = Number(new Date().getTime());
         if(param2.indexOf("https://") == -1 && param2.indexOf("https://") == -1 && param2.indexOf("file://") == -1)
         {
            param2 = Game.serverFilePath + param2;
         }
         isEvent = param4;
         if(param3 != "Inline Asset")
         {
            MovieClip(Game.root).addChild(this);
         }
         mcDest = param1;
         var _loc6_:* = new Loader();
         _loc6_.load(new URLRequest(param2),new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)));
         _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,onFileLoadComplete,false,0,true);
         _loc6_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onFileLoadProgress,false,0,true);
         history[param2] = {
            "ts":_loc5_,
            "ldr":_loc6_
         };
      }
      
      private function onFileLoadComplete(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc2_:* = rootClass.world;
         var _loc3_:Loader = Loader(param1.target.loader);
         try
         {
            for each(_loc5_ in history)
            {
               if(history[_loc5_].ldr == _loc3_)
               {
                  delete history[_loc5_];
               }
            }
         }
         catch(e:Error)
         {
         }
         _loc3_.contentLoaderInfo.removeEventListener(Event.COMPLETE,onFileLoadComplete);
         _loc3_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onFileLoadProgress);
         var _loc4_:* = MovieClip(_loc3_.content);
         mcDest.addChild(_loc4_);
         if(isEvent && "eventTrigger" in _loc2_.map)
         {
            _loc6_ = {
               "cmd":"fileLoaded",
               "args":{"loc":"default"}
            };
            _loc2_.map.eventTrigger(_loc6_);
         }
         if((_loc2_.strMapName == "buyhouse" || _loc2_.strMapName == "house") && _file == rootClass.bagSpace)
         {
            MovieClip(mcDest.getChildAt(0)).gotoAndPlay("House");
            _file = "";
         }
         mcDest = null;
         try
         {
            MovieClip(parent).removeChild(this);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onFileLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:int = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
         if(param1.bytesTotal <= 0)
         {
            _loc2_ = 0;
         }
         strLoad.text = "Loading!";
         mcPct.text = _loc2_ + "%";
      }
      
      public function closeHistory() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in history)
         {
            try
            {
               history[_loc1_].ldr.close();
            }
            catch(e:Error)
            {
            }
            delete history[_loc1_];
         }
         history = {};
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         MovieClip(Game.root).logout();
         MovieClip(parent).removeChild(this);
      }
   }
}

