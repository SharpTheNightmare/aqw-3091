package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2306")]
   public dynamic class xpDisplayBonus extends MovieClip
   {
      
      public var t:MovieClip;
      
      public function xpDisplayBonus()
      {
         super();
         addFrameScript(39,frame40);
      }
      
      internal function frame40() : *
      {
         MovieClip(parent).removeChild(this);
         stop();
      }
   }
}

