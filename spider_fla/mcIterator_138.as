package spider_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3704")]
   public dynamic class mcIterator_138 extends MovieClip
   {
      
      public var cheats:MovieClip;
      
      public var serverStack:MovieClip;
      
      public var cmd:MovieClip;
      
      public var bg:MovieClip;
      
      public var bgfx:MovieClip;
      
      public var eventStack:MovieClip;
      
      public var iClass:IteratorMC;
      
      public function mcIterator_138()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         iClass = new IteratorMC();
         iClass.init(MovieClip(this.parent.parent),this,Game.objLogin);
      }
   }
}

