package liteAssets.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1019")]
   public class mcDesignNotes extends MovieClip
   {
      
      public var scrollTop:MovieClip;
      
      public var btnLeft:SimpleButton;
      
      public var btnClose:MovieClip;
      
      public var scrollBottom:MovieClip;
      
      public var btnRight:SimpleButton;
      
      public var txtContent:TextField;
      
      public var r:MovieClip;
      
      internal var loader:*;
      
      internal var dnLoader:URLLoader = new URLLoader();
      
      private var posts:Array;
      
      private var pos:Number = 0;
      
      private var bLoaded:Number = 0;
      
      private var bTotal:Number = 0;
      
      public function mcDesignNotes(param1:MovieClip)
      {
         super();
         r = param1;
         r.world.visible = false;
         loader = new (r.world.getClass("mcLoader") as Class)();
         loader.x = 400;
         loader.y = 211;
         loader.name = "loader";
         this.addChild(loader);
         setupTF();
         loadDesignNotes();
         btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         btnLeft.addEventListener(MouseEvent.CLICK,onBtnMove,false,0,true);
         btnRight.addEventListener(MouseEvent.CLICK,onBtnMove,false,0,true);
      }
      
      public function onClose(param1:MouseEvent) : void
      {
         destroy();
      }
      
      public function onBtnMove(param1:MouseEvent) : void
      {
         if(param1.target.name == "btnLeft")
         {
            --pos;
         }
         else
         {
            ++pos;
         }
         if(pos < 0)
         {
            pos = posts.length - 1;
         }
         if(pos >= posts.length)
         {
            pos = 0;
         }
         txtContent.htmlText = cleanup(posts[pos]);
      }
      
      public function destroy() : void
      {
         r.world.visible = true;
         parent.removeChild(this);
      }
      
      public function loadDesignNotes() : void
      {
         dnLoader.addEventListener(Event.COMPLETE,onComplete,false,0,true);
         dnLoader.addEventListener(ProgressEvent.PROGRESS,onProgress,false,0,true);
         dnLoader.addEventListener(IOErrorEvent.IO_ERROR,onError,false,0,true);
         dnLoader.load(new URLRequest("https://www.aq.com/gamedesignnotes/"));
      }
      
      public function setupTF() : void
      {
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.parseCSS("img { display:block; margin-right: auto; margin-left: auto; } p { align:center; } strong { font-weight: bold; } a { color: #990000; font-size:16px; text-decoration:underline; } a:link { color:#f6a70c; } .date { font-weight:bold; font-size:12px; color: #444444; } h2 { font-weight:bold;font-size:24px; color: #222222; } h3 { font-weight:bold; color: #900000; font-size: 18px; }");
         txtContent.styleSheet = _loc1_;
         txtContent.embedFonts = true;
         txtContent.condenseWhite = true;
         txtContent.multiline = true;
         txtContent.wordWrap = true;
      }
      
      public function onComplete(param1:Event) : void
      {
         var _loc2_:String = param1.target.data;
         posts = _loc2_.match(/(?<=<div class='post pull-right'>)((.|\n)*)(?=<\/div><img src='\/img\/gfx\/divider-md.jpg' alt='divider')/igm);
         txtContent.htmlText = cleanup(posts[0]);
      }
      
      public function cleanup(param1:String) : String
      {
         var _loc2_:* = /(?<=<h2>)((.|\n)*)(?=<\/h2>)/im;
         var _loc3_:* = /(?<='>)((.|\n)*)(?=<\/a>)/im;
         var _loc4_:* = /<\/?strong>/igm;
         param1 = param1.replace(_loc2_,param1.match(_loc2_)[0].match(_loc3_)[0]);
         return param1.replace(_loc4_,"");
      }
      
      public function onProgress(param1:ProgressEvent) : void
      {
         if(!loader)
         {
            return;
         }
         bLoaded = param1.bytesLoaded;
         bTotal = param1.bytesTotal;
         var _loc2_:int = bLoaded / bTotal * 100;
         var _loc3_:Number = bLoaded / bTotal;
         loader.mcPct.text = _loc2_ + "%";
         if(bLoaded >= bTotal)
         {
            loader.parent.removeChild(loader);
            loader = null;
         }
      }
      
      public function onError(param1:IOErrorEvent) : void
      {
         destroy();
      }
   }
}

