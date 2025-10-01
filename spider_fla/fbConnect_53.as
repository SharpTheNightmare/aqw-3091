package spider_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3639")]
   public dynamic class fbConnect_53 extends MovieClip
   {
      
      public var btnFBLink:SimpleButton;
      
      public var strPassword:TextField;
      
      public var strUsername:TextField;
      
      public var btnClose:SimpleButton;
      
      public var frame:MovieClip;
      
      public var btnFBCreate:SimpleButton;
      
      public function fbConnect_53()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         this.visible = false;
      }
   }
}

