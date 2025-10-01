package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2618")]
   public dynamic class HouseItemHandleMC extends MovieClip
   {
      
      public var bCancel:MovieClip;
      
      public var frame:MovieClip;
      
      public var bFlip:MovieClip;
      
      public var bDelete:MovieClip;
      
      public var mDown:Boolean;
      
      public function HouseItemHandleMC()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         mDown = false;
      }
   }
}

