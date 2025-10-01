package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2490")]
   public dynamic class uProto extends MovieClip
   {
      
      public var t1:MovieClip;
      
      public function uProto()
      {
         super();
         addFrameScript(0,frame1,100,frame101);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame101() : *
      {
         try
         {
            if(parent != null)
            {
               parent.removeChild(this);
            }
         }
         catch(e:Error)
         {
         }
         stop();
      }
   }
}

