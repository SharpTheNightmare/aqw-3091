package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1843")]
   public dynamic class mcLevelup extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public function mcLevelup()
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

