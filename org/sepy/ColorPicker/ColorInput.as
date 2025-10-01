package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2688")]
   public class ColorInput extends MovieClip
   {
      
      public var _color:Number;
      
      private var input:TextField;
      
      public function ColorInput()
      {
         var _loc1_:TextFormat = null;
         super();
         _loc1_ = new TextFormat();
         _loc1_.font = "_sans";
         _loc1_.size = 10;
         input = new TextField();
         input.name = "input";
         input.width = 57;
         input.height = 16;
         this.addChildAt(input,1);
         input.x = 2;
         input.y = 1;
         input.type = "input";
         input.maxChars = 7;
         input.defaultTextFormat = _loc1_;
         input.addEventListener(Event.CHANGE,onInput,false,0,true);
      }
      
      public function set color(param1:Number) : *
      {
         _color = param1;
         input.text = "#" + ColorPicker2.ColorToString(param1);
      }
      
      public function get color() : Number
      {
         return _color;
      }
      
      private function onInput(param1:Event) : void
      {
         MovieClip(parent.parent).changed(TextField(param1.currentTarget).text);
      }
   }
}

