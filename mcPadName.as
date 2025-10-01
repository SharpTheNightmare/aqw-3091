package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol745")]
   public dynamic class mcPadName extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public var isOn:*;
      
      public function mcPadName()
      {
         super();
         addFrameScript(0,frame1,4,frame5,9,frame10,19,frame20);
      }
      
      internal function frame1() : *
      {
         visible = false;
         isOn = false;
         stop();
      }
      
      internal function frame5() : *
      {
         visible = true;
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame20() : *
      {
         visible = false;
         stop();
      }
   }
}

