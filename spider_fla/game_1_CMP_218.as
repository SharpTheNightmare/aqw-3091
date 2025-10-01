package spider_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3807")]
   public dynamic class game_1_CMP_218 extends MovieClip
   {
      
      public var chkBtn:SimpleButton;
      
      public var checkmark:MovieClip;
      
      public var bitChecked:Boolean;
      
      public function game_1_CMP_218()
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
         chkBtn.addEventListener(MouseEvent.CLICK,onClick,false,1,true);
      }
   }
}

