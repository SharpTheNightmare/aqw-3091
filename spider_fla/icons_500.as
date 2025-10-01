package spider_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2580")]
   public dynamic class icons_500 extends MovieClip
   {
      
      public var shp:MovieClip;
      
      public function icons_500()
      {
         super();
         addFrameScript(1,frame2,29,frame30);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame30() : *
      {
         gotoAndPlay("pulse");
      }
   }
}

