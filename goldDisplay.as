package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2319")]
   public dynamic class goldDisplay extends MovieClip
   {
      
      public var tMask:MovieClip;
      
      public var t:MovieClip;
      
      public function goldDisplay()
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

