package liteAssets.draw
{
   import fl.controls.TextInput;
   import fl.motion.Color;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2302")]
   public class colorPicker extends MovieClip
   {
      
      public var txtGreen:TextInput;
      
      public var txtHex:TextInput;
      
      public var btnColorPick:SimpleButton;
      
      public var txtRed:TextInput;
      
      public var colorPreview:MovieClip;
      
      public var txtBlue:TextInput;
      
      public var ui:MovieClip;
      
      private var _stageBitmap:BitmapData;
      
      public function colorPicker()
      {
         super();
         this.txtRed.text = "255";
         this.txtGreen.text = "255";
         this.txtBlue.text = "255";
         this.txtHex.text = "#ffffff";
         this.ui.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         this.ui.addEventListener(MouseEvent.MOUSE_UP,onMRelease,false,0,true);
         this.ui.btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         this.btnColorPick.addEventListener(MouseEvent.CLICK,onBtColor,false,0,true);
         __setProp_txtHex_mcColorPicker_Layer1_0();
         __setProp_txtRed_mcColorPicker_Layer1_0();
         __setProp_txtBlue_mcColorPicker_Layer1_0();
         __setProp_txtGreen_mcColorPicker_Layer1_0();
      }
      
      public function cleanup() : void
      {
         this.ui.removeEventListener(MouseEvent.MOUSE_DOWN,onDrag);
         this.ui.removeEventListener(MouseEvent.MOUSE_UP,onMRelease);
         this.ui.btnClose.removeEventListener(MouseEvent.CLICK,onClose);
         this.btnColorPick.removeEventListener(MouseEvent.CLICK,onBtColor);
         parent.removeChild(this);
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         cleanup();
      }
      
      private function onBtColor(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_DOWN,getColor,false,0,true);
      }
      
      private function getColor(param1:MouseEvent) : void
      {
         if(_stageBitmap == null)
         {
            _stageBitmap = new BitmapData(stage.width,stage.height);
         }
         _stageBitmap.draw(stage);
         var _loc2_:uint = _stageBitmap.getPixel(stage.mouseX,stage.mouseY);
         var _loc3_:* = _loc2_ >> 16 & 0xFF;
         var _loc4_:* = _loc2_ >> 8 & 0xFF;
         var _loc5_:* = _loc2_ & 0xFF;
         this.txtRed.text = _loc3_.toString();
         this.txtGreen.text = _loc4_.toString();
         this.txtBlue.text = _loc5_.toString();
         this.txtHex.text = "#" + _loc2_.toString(16);
         var _loc6_:Color = new Color();
         _loc6_.setTint(_loc2_,1);
         this.colorPreview.transform.colorTransform = _loc6_;
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,getColor);
      }
      
      private function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMRelease(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      internal function __setProp_txtHex_mcColorPicker_Layer1_0() : *
      {
         try
         {
            txtHex["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtHex.displayAsPassword = false;
         txtHex.editable = true;
         txtHex.enabled = true;
         txtHex.maxChars = 0;
         txtHex.restrict = "";
         txtHex.text = "#FFFFFF";
         txtHex.visible = true;
         try
         {
            txtHex["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_txtRed_mcColorPicker_Layer1_0() : *
      {
         try
         {
            txtRed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtRed.displayAsPassword = false;
         txtRed.editable = true;
         txtRed.enabled = true;
         txtRed.maxChars = 0;
         txtRed.restrict = "";
         txtRed.text = "255";
         txtRed.visible = true;
         try
         {
            txtRed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_txtBlue_mcColorPicker_Layer1_0() : *
      {
         try
         {
            txtBlue["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtBlue.displayAsPassword = false;
         txtBlue.editable = true;
         txtBlue.enabled = true;
         txtBlue.maxChars = 0;
         txtBlue.restrict = "";
         txtBlue.text = "255";
         txtBlue.visible = true;
         try
         {
            txtBlue["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_txtGreen_mcColorPicker_Layer1_0() : *
      {
         try
         {
            txtGreen["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtGreen.displayAsPassword = false;
         txtGreen.editable = true;
         txtGreen.enabled = true;
         txtGreen.maxChars = 0;
         txtGreen.restrict = "";
         txtGreen.text = "255";
         txtGreen.visible = true;
         try
         {
            txtGreen["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

