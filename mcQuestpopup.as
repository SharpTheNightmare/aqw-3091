package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol661")]
   public dynamic class mcQuestpopup extends MovieClip
   {
      
      public var fx2:MovieClip;
      
      public var cnt:MovieClip;
      
      public function mcQuestpopup()
      {
         super();
         addFrameScript(124,frame125);
      }
      
      internal function frame125() : *
      {
         MovieClip(parent).removeChild(this);
         stop();
      }
   }
}

