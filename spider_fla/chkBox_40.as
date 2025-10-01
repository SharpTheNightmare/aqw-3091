package spider_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3568")]
   public dynamic class chkBox_40 extends MovieClip
   {
      
      public var checkmark:MovieClip;
      
      public var bitChecked:Boolean;
      
      public function chkBox_40()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function onClick(param1:MouseEvent) : *
      {
         bitChecked = !bitChecked;
         checkmark.visible = bitChecked;
      }
      
      internal function frame1() : *
      {
         checkmark.mouseEnabled = false;
         checkmark.visible = bitChecked;
         this.addEventListener(MouseEvent.CLICK,onClick);
      }
   }
}

