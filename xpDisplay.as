package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2309")]
   public dynamic class xpDisplay extends MovieClip
   {
      
      public var t:MovieClip;
      
      public function xpDisplay()
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

