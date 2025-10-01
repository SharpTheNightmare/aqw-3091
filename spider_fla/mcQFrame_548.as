package spider_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol685")]
   public dynamic class mcQFrame_548 extends MovieClip
   {
      
      public var tl3:MovieClip;
      
      public var bl1:MovieClip;
      
      public var btnWiki:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var bg:MovieClip;
      
      public var tr1:MovieClip;
      
      public var fx:MovieClip;
      
      public var tr2:MovieClip;
      
      public var btnPin:SimpleButton;
      
      public var tl1:MovieClip;
      
      public var tr3:MovieClip;
      
      public var br1:MovieClip;
      
      public var tl2:MovieClip;
      
      public var btnTry:SimpleButton;
      
      public function mcQFrame_548()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function buildBounds() : void
      {
         this.boundsOK = true;
         var _loc1_:Array = this.tl = [{
            "mc":tl1,
            "dx":0,
            "dy":0
         },{
            "mc":tl2,
            "dx":0,
            "dy":0
         },{
            "mc":tl3,
            "dx":0,
            "dy":0
         }];
         var _loc2_:Array = this.tr = [{
            "mc":tl1,
            "dx":0,
            "dy":0
         },{
            "mc":tr2,
            "dx":0,
            "dy":0
         },{
            "mc":tr3,
            "dx":0,
            "dy":0
         },{
            "mc":btnClose,
            "dx":0,
            "dy":0
         }];
         var _loc3_:Array = this.bl = [{
            "mc":bl1,
            "dx":0,
            "dy":0
         }];
         var _loc4_:Array = this.br = [{
            "mc":br1,
            "dx":0,
            "dy":0
         }];
         var _loc5_:int = 0;
         var _loc6_:Object = {};
         var _loc7_:Point = new Point();
         var _loc8_:Point = new Point();
         var _loc9_:Rectangle = this.bgA = bg.getBounds(this);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ = _loc1_[_loc5_];
            _loc7_ = _loc9_.topLeft;
            _loc6_.dx = _loc7_.x - _loc6_.mc.x;
            _loc6_.dy = _loc7_.y - _loc6_.mc.y;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc7_ = _loc9_.topLeft;
            _loc7_.x += _loc9_.width;
            _loc6_.dx = _loc7_.x - _loc6_.mc.x;
            _loc6_.dy = _loc7_.y - _loc6_.mc.y;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = _loc9_.topLeft;
            _loc7_.y += _loc9_.height;
            _loc6_.dx = _loc7_.x - _loc6_.mc.x;
            _loc6_.dy = _loc7_.y - _loc6_.mc.y;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = _loc9_.bottomRight;
            _loc6_.dx = _loc7_.x - _loc6_.mc.x;
            _loc6_.dy = _loc7_.y - _loc6_.mc.y;
            _loc5_++;
         }
      }
      
      public function resizeTo(param1:int, param2:int, param3:int = 0) : void
      {
         if(!("boundsOK" in this))
         {
            buildBounds();
         }
         var _loc4_:Array = this.tl;
         var _loc5_:Array = this.tr;
         var _loc6_:Array = this.bl;
         var _loc7_:Array = this.br;
         var _loc8_:int = 0;
         var _loc9_:Object = {};
         var _loc10_:Point = new Point();
         var _loc11_:Point = new Point();
         var _loc12_:Rectangle = this.bgA;
         bg.width = param1;
         bg.height = param2;
         bg.x = _loc12_.topLeft.x + Math.round(bg.width / 2);
         bg.y = _loc12_.topLeft.y + Math.round(bg.height / 2);
         var _loc13_:Rectangle = bg.getBounds(this);
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc9_ = _loc4_[_loc8_];
            _loc11_ = _loc13_.topLeft;
            _loc9_.mc.x = _loc11_.x - _loc9_.dx;
            _loc9_.mc.y = _loc11_.y - _loc9_.dy;
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc9_ = _loc5_[_loc8_];
            _loc11_ = _loc13_.topLeft;
            _loc11_.x += _loc13_.width;
            _loc9_.mc.x = _loc11_.x - _loc9_.dx;
            _loc9_.mc.y = _loc11_.y - _loc9_.dy;
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc9_ = _loc6_[_loc8_];
            _loc11_ = _loc13_.topLeft;
            _loc11_.y += _loc13_.height;
            _loc9_.mc.x = _loc11_.x - _loc9_.dx;
            _loc9_.mc.y = _loc11_.y - _loc9_.dy;
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            _loc11_ = _loc13_.bottomRight;
            _loc9_.mc.x = _loc11_.x - _loc9_.dx;
            _loc9_.mc.y = _loc11_.y - _loc9_.dy;
            _loc8_++;
         }
         fx.y = 110;
      }
      
      internal function frame1() : *
      {
      }
   }
}

