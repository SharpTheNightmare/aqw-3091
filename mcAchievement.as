package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1856")]
   public dynamic class mcAchievement extends MovieClip
   {
      
      public var fx2:MovieClip;
      
      public var cnt:MovieClip;
      
      public function mcAchievement()
      {
         super();
         addFrameScript(122,frame123);
      }
      
      internal function frame123() : *
      {
         MovieClip(parent).removeChild(this);
         stop();
      }
   }
}

