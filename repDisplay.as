package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2312")]
   public dynamic class repDisplay extends MovieClip
   {
      
      public var t:MovieClip;
      
      public function repDisplay()
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

