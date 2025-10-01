package org.sepy.ColorPicker
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2667")]
   public class IntInput extends MovieClip
   {
      
      public var _value:Number;
      
      private var broadcastMessage:Function;
      
      private var input:TextField;
      
      private var tlabel:TextField;
      
      private var _label:String;
      
      private var _max:Number;
      
      public function IntInput(param1:String, param2:String)
      {
         var _loc3_:TextFormat = null;
         super();
         _loc3_ = new TextFormat();
         _loc3_.font = "_sans";
         _loc3_.size = 10;
         tlabel = new TextField();
         tlabel.width = 31;
         tlabel.height = 16;
         this.addChildAt(tlabel,1);
         tlabel.x = 2;
         tlabel.y = 1;
         tlabel.defaultTextFormat = _loc3_;
         tlabel.text = param1;
         input = new TextField();
         input.height = 16;
         input.width = 31;
         input.name = "input";
         this.addChildAt(input,2);
         input.x = 22;
         input.y = 1;
         input.type = param2;
         input.maxChars = 3;
         input.restrict = "[0-9]";
         input.defaultTextFormat = _loc3_;
         input.addEventListener(Event.CHANGE,onChanged,false,0,true);
      }
      
      public function set value(param1:Number) : *
      {
         _value = param1;
         input.text = _value.toString(10);
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      private function onChanged(param1:Event) : *
      {
         var _loc2_:Number = Number(input.text);
         if(isNaN(_loc2_))
         {
            input.text = "0";
         }
         if(_loc2_ > _max)
         {
            input.text = _max.toString();
         }
         _value = Number(input.text);
         MovieClip(parent).changed(this,Number(input.text));
      }
      
      public function set label(param1:String) : void
      {
         _label = param1;
         tlabel.text = param1;
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function set max(param1:Number) : *
      {
         _max = param1;
      }
      
      public function get max() : Number
      {
         return _max;
      }
   }
}

