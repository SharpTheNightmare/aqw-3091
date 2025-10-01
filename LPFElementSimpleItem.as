package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2116")]
   public class LPFElementSimpleItem extends MovieClip
   {
      
      public var tQty:TextField;
      
      public var tName:TextField;
      
      private var rootClass:MovieClip;
      
      protected var eventType:String = "";
      
      protected var sMode:String;
      
      public var fData:Object = {};
      
      public var fParent:LPFFrame;
      
      public function LPFElementSimpleItem()
      {
         super();
      }
      
      protected function update() : void
      {
      }
      
      public function fOpen(param1:Object) : void
      {
         fData = param1.fData;
         if("eventType" in param1)
         {
            eventType = param1.eventType;
         }
         rootClass = MovieClip(stage.getChildAt(0));
         fDraw();
      }
      
      public function fClose() : void
      {
         fData = null;
         parent.removeChild(this);
      }
      
      private function get realQty() : int
      {
         var _loc1_:Number = Number(fData.iQty);
         var _loc2_:* = MovieClip(MovieClip(MovieClip(MovieClip(parent).parent).parent).parent);
         if(_loc2_.iQty > 1)
         {
            _loc1_ = fData.iQty * Math.floor(_loc2_.iQty / _loc2_.iSel.iQty);
         }
         return _loc1_;
      }
      
      protected function fDraw() : void
      {
         var _loc8_:* = null;
         tName.htmlText = fData.sName;
         tName.autoSize = TextFieldAutoSize.LEFT;
         tName.wordWrap = true;
         var _loc1_:String = "#FFFFFF";
         var _loc2_:String = "#FFD900";
         var _loc3_:String = "#999999";
         var _loc4_:String = "#666666";
         var _loc5_:Object = rootClass.world.invTree[fData.ItemID];
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         if(_loc5_ != null)
         {
            _loc6_ = int(_loc5_.iQty);
         }
         if(_loc6_ >= realQty)
         {
            _loc7_ = true;
         }
         if(_loc7_)
         {
            _loc8_ = "<font color=\'" + _loc1_ + "\'>" + _loc6_ + "</font>";
            _loc8_ = _loc8_ + ("<font color=\'" + _loc2_ + "\'>/</font>");
            _loc8_ = _loc8_ + ("<font color=\'" + _loc1_ + "\'>" + realQty + "</font>");
         }
         else
         {
            _loc8_ = "<font color=\'" + _loc4_ + "\'>" + _loc6_ + "</font>";
            _loc8_ = _loc8_ + ("<font color=\'" + _loc3_ + "\'>/</font>");
            _loc8_ = _loc8_ + ("<font color=\'" + _loc4_ + "\'>" + realQty + "</font>");
         }
         tQty.htmlText = _loc8_;
         tQty.y = tName.y + tName.height - 4;
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
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
      }
   }
}

