package liteAssets.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2253")]
   public class cEntry extends MovieClip
   {
      
      public var txtEntry:TextField;
      
      public var overEntryBar:MovieClip;
      
      public var entryBar:MovieClip;
      
      private var cellName:String;
      
      private var sCellName:String;
      
      internal var rootClass:MovieClip;
      
      public function cEntry(param1:MovieClip, param2:String, param3:String)
      {
         super();
         rootClass = param1;
         cellName = param2;
         sCellName = param3;
         this.gotoAndStop("idle");
         this.txtEntry.text = param2;
         if(param2 == rootClass.world.strFrame)
         {
            this.txtEntry.textColor = 12283391;
         }
         this.addEventListener(MouseEvent.ROLL_OVER,onHighlight,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,onDeHighlight,false,0,true);
         this.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
      }
      
      internal function onWheel(param1:MouseEvent) : void
      {
         rootClass.cMenuUI.onScroll(param1);
      }
      
      internal function onClick(param1:MouseEvent) : void
      {
         if(sCellName != "")
         {
            rootClass.world.moveToCell(sCellName,cellName);
         }
         rootClass.cMenuUI.reDraw(sCellName != "" ? "" : cellName);
         rootClass.stage.focus = null;
      }
      
      internal function onHighlight(param1:MouseEvent) : void
      {
         this.gotoAndStop("hover");
      }
      
      internal function onDeHighlight(param1:MouseEvent) : void
      {
         this.gotoAndStop("idle");
      }
   }
}

