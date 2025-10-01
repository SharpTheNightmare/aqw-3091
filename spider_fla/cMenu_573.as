package spider_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2486")]
   public dynamic class cMenu_573 extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var mHi:MovieClip;
      
      public var iproto:cProto;
      
      public function cMenu_573()
      {
         super();
         addFrameScript(0,frame1,19,frame20);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame20() : *
      {
         MovieClip(parent).gotoAndPlay("out");
         gotoAndStop("hold");
      }
   }
}

