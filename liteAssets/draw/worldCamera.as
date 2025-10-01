package liteAssets.draw
{
   import fl.data.*;
   import fl.events.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol24")]
   public class worldCamera extends MovieClip
   {
      
      public var btnLeft:MovieClip;
      
      public var btnZoomOut:SimpleButton;
      
      public var txtInfo:TextField;
      
      public var btnUp:MovieClip;
      
      public var btnZoomIn:SimpleButton;
      
      public var btnDown:MovieClip;
      
      public var btnExit:SimpleButton;
      
      public var btnReset:SimpleButton;
      
      public var btnRight:MovieClip;
      
      internal var rootClass:MovieClip;
      
      internal var mcMask:DisplayObject;
      
      public function worldCamera(param1:MovieClip)
      {
         super();
         rootClass = param1;
         rootClass.world.myAvatar.isWorldCamera = true;
         rootClass.world.bitWalk = false;
         this.btnExit.addEventListener(MouseEvent.CLICK,onExit,false,0,true);
         this.btnZoomIn.addEventListener(MouseEvent.CLICK,onZoomIn,false,0,true);
         this.btnZoomOut.addEventListener(MouseEvent.CLICK,onZoomOut,false,0,true);
         this.btnUp.addEventListener(MouseEvent.CLICK,onUp,false,0,true);
         this.btnDown.addEventListener(MouseEvent.CLICK,onDown,false,0,true);
         this.btnLeft.addEventListener(MouseEvent.CLICK,onLeft,false,0,true);
         this.btnRight.addEventListener(MouseEvent.CLICK,onRight,false,0,true);
         this.btnReset.addEventListener(MouseEvent.CLICK,onReset,false,0,true);
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,rootClass.world.width,rootClass.world.height);
         _loc2_.graphics.endFill();
         mcMask = rootClass.world.addChild(_loc2_);
         mcMask.name = "worldMask";
         mcMask.x = rootClass.world.x;
         mcMask.y = rootClass.world.y;
         rootClass.world.mask = mcMask;
         rootClass.ui.visible = false;
         rootClass.world.mouseEnabled = rootClass.world.mouseChildren = false;
         rootClass.stage.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         rootClass.stage.addEventListener(MouseEvent.MOUSE_UP,onReleaseDrag,false,0,true);
         rootClass.stage.addEventListener(KeyboardEvent.KEY_UP,onKey,false,0,true);
         var _loc3_:* = rootClass.litePreference.data.keys["World Camera\'s Hide"] == null ? "" : rootClass.keyDict[rootClass.litePreference.data.keys["World Camera\'s Hide"]];
         this.txtInfo.text = "\"" + _loc3_ + "\" to show/hide camera controls!";
      }
      
      public function onKey(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.keyCode == rootClass.litePreference.data.keys["World Camera\'s Hide"])
         {
            _loc2_ = 0;
            while(_loc2_ < this.numChildren)
            {
               this.getChildAt(_loc2_).visible = !this.getChildAt(_loc2_).visible;
               _loc2_++;
            }
         }
      }
      
      public function onDrag(param1:MouseEvent) : void
      {
         rootClass.startDrag();
      }
      
      public function onReleaseDrag(param1:MouseEvent) : void
      {
         rootClass.stopDrag();
      }
      
      public function dispatchExit() : void
      {
         btnExit.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onExit(param1:MouseEvent) : void
      {
         rootClass.removeEventListener(KeyboardEvent.KEY_UP,onKey);
         rootClass.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onDrag);
         rootClass.stage.removeEventListener(MouseEvent.MOUSE_UP,onReleaseDrag);
         rootClass.x = rootClass.y = 0;
         rootClass.scaleX = rootClass.scaleY = 1;
         rootClass.ui.visible = true;
         rootClass.world.mouseEnabled = rootClass.world.mouseChildren = true;
         rootClass.world.myAvatar.isWorldCamera = false;
         rootClass.world.bitWalk = true;
         rootClass.world.mask = null;
         mcMask.parent.removeChild(mcMask);
         this.parent.removeChild(this);
         rootClass.stage.focus = null;
      }
      
      public function onZoomIn(param1:MouseEvent) : void
      {
         rootClass.scaleX = rootClass.scaleY = rootClass.scaleX = rootClass.scaleX + 0.5;
         rootClass.x -= 220;
         rootClass.y -= 150;
      }
      
      public function onZoomOut(param1:MouseEvent) : void
      {
         rootClass.scaleX = rootClass.scaleY = rootClass.scaleX = rootClass.scaleX - 0.5;
         rootClass.x += 220;
         rootClass.y += 150;
      }
      
      public function onReset(param1:MouseEvent) : void
      {
         rootClass.x = rootClass.y = 0;
         rootClass.scaleX = rootClass.scaleY = 1;
      }
      
      public function onUp(param1:MouseEvent) : void
      {
         rootClass.y += 10;
      }
      
      public function onLeft(param1:MouseEvent) : void
      {
         rootClass.x += 10;
      }
      
      public function onRight(param1:MouseEvent) : void
      {
         rootClass.x -= 10;
      }
      
      public function onDown(param1:MouseEvent) : void
      {
         rootClass.y -= 10;
      }
   }
}

