package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   public class LPFElementListItem extends MovieClip
   {
      
      protected var eventType:String = "";
      
      protected var sMode:String;
      
      public var fData:Object = {};
      
      public var fParent:LPFFrame;
      
      public var state:int = 0;
      
      public function LPFElementListItem()
      {
         super();
      }
      
      protected function update() : void
      {
         var _loc1_:Object = {
            "fData":fData,
            "eventType":eventType,
            "fCaller":fParent.sName
         };
         fParent.update(_loc1_);
      }
      
      public function fOpen(param1:Object) : void
      {
         fData = param1.fData;
         if("eventType" in param1)
         {
            eventType = param1.eventType;
         }
      }
      
      public function fClose() : void
      {
         fData = null;
         removeEventListener(MouseEvent.CLICK,onClick);
         parent.removeChild(this);
      }
      
      protected function fDraw() : void
      {
      }
      
      public function subscribeTo(param1:LPFFrame) : void
      {
         fParent = param1;
      }
      
      public function select() : void
      {
      }
      
      public function deselect() : void
      {
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         update();
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
      }
   }
}

