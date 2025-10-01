package liteAssets.draw
{
   import fl.motion.AdjustColor;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2223")]
   public class customDrops extends MovieClip
   {
      
      public var inner_menu:MovieClip;
      
      internal var rootClass:MovieClip;
      
      public var mcDraggable:draggableDrops;
      
      private var inactive:ColorMatrixFilter;
      
      private var isOpen:Boolean = false;
      
      internal var itemCount:Object;
      
      internal var invTree:Array;
      
      public function customDrops(param1:MovieClip)
      {
         super();
         rootClass = param1;
         itemCount = {};
         invTree = new Array();
         var _loc2_:AdjustColor = new AdjustColor();
         _loc2_.saturation = -100;
         _loc2_.brightness = -100;
         _loc2_.contrast = 0;
         _loc2_.hue = 0;
         inactive = new ColorMatrixFilter(_loc2_.CalculateFinalFlatArray());
         this.name = "customDrops";
         rootClass.ui.mcPortrait.iconDrops.visible = true;
         this.visible = true;
         onChange(rootClass.litePreference.data.dOptions["dragMode"]);
      }
      
      public function onChange(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.numChildren > 1)
            {
               while(this.numChildren > 1)
               {
                  this.removeChildAt(1);
               }
            }
            this.inner_menu.visible = false;
            if(inner_menu.hasEventListener(MouseEvent.CLICK))
            {
               this.inner_menu.removeEventListener(MouseEvent.ROLL_OVER,onRollOverAttached);
               this.inner_menu.removeEventListener(MouseEvent.ROLL_OUT,onRollOutAttached);
               this.inner_menu.removeEventListener(MouseEvent.CLICK,onToggleAttached);
            }
            if(rootClass.ui.mcInterface.getChildByName("customDrops"))
            {
               rootClass.ui.mcInterface.removeChild(this);
            }
            rootClass.ui.addChild(this);
            rootClass.ui.setChildIndex(rootClass.ui.getChildByName("customDrops"),rootClass.ui.numChildren - 1);
            this.x = 0;
            this.y = 0;
            mcDraggable = new draggableDrops();
            this.addChild(mcDraggable);
            if(rootClass.litePreference.data.dmtPos)
            {
               mcDraggable.x = rootClass.litePreference.data.dmtPos.x;
               mcDraggable.y = rootClass.litePreference.data.dmtPos.y;
            }
            mcDraggable.visible = true;
            mcDraggable.txtQty.mouseEnabled = false;
            mcDraggable.menuBar.addEventListener(MouseEvent.CLICK,onToggleMenu,false,0,true);
            mcDraggable.menuBar.addEventListener(MouseEvent.MOUSE_DOWN,onHold,false,0,true);
            mcDraggable.menuBar.addEventListener(MouseEvent.MOUSE_UP,onMouseRelease,false,0,true);
            mcDraggable.menu.visible = rootClass.litePreference.data.dOptions["openMenu"];
            lockMode();
            reDraw();
         }
         else
         {
            if(mcDraggable)
            {
               while(mcDraggable.menu.numChildren > 1)
               {
                  mcDraggable.menu.removeChildAt(1);
               }
               mcDraggable.menuBar.removeEventListener(MouseEvent.CLICK,onToggleMenu);
               mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_DOWN,onHold);
               mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_UP,onMouseRelease);
               this.removeChild(mcDraggable);
               mcDraggable = null;
               rootClass.ui.removeChild(this);
            }
            rootClass.ui.mcInterface.addChild(this);
            rootClass.ui.mcInterface.setChildIndex(rootClass.ui.mcInterface.getChildByName("customDrops"),0);
            this.x = 352;
            this.y = rootClass.litePreference.data.dOptions["invertMenu"] ? -530 : -19;
            this.inner_menu.visible = true;
            this.inner_menu.height = rootClass.litePreference.data.dOptions["invertMenu"] ? 42.8 : 157.7;
            this.inner_menu.addEventListener(MouseEvent.ROLL_OVER,onRollOverAttached,false,0,true);
            this.inner_menu.addEventListener(MouseEvent.ROLL_OUT,onRollOutAttached,false,0,true);
            this.inner_menu.addEventListener(MouseEvent.CLICK,onToggleAttached,false,0,true);
            if(rootClass.litePreference.data.dOptions["openMenu"])
            {
               isOpen = true;
               reDraw();
            }
            else
            {
               this.inner_menu.filters = [inactive];
            }
         }
      }
      
      public function lockMode() : void
      {
         if(!mcDraggable)
         {
            return;
         }
         if(!rootClass.litePreference.data.dOptions["lockMode"])
         {
            mcDraggable.menuBar.addEventListener(MouseEvent.MOUSE_DOWN,onHold,false,0,true);
            mcDraggable.menuBar.addEventListener(MouseEvent.MOUSE_UP,onMouseRelease,false,0,true);
         }
         else
         {
            mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_DOWN,onHold);
            mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_UP,onMouseRelease);
         }
      }
      
      public function resetPos() : void
      {
         if(mcDraggable)
         {
            mcDraggable.x = 0;
            mcDraggable.y = 0;
         }
         rootClass.litePreference.data.dmtPos.x = 0;
         rootClass.litePreference.data.dmtPos.y = 0;
      }
      
      public function onToggleMenu(param1:MouseEvent) : void
      {
         mcDraggable.menu.visible = !mcDraggable.menu.visible;
         if(mcDraggable.menu.visible)
         {
            reDraw();
         }
      }
      
      private function onHold(param1:MouseEvent) : void
      {
         mcDraggable.startDrag();
      }
      
      private function onMouseRelease(param1:MouseEvent) : void
      {
         mcDraggable.stopDrag();
         rootClass.litePreference.data.dmtPos = {
            "x":mcDraggable.x,
            "y":mcDraggable.y
         };
         rootClass.litePreference.flush();
      }
      
      public function cleanup() : void
      {
         if(mcDraggable)
         {
            mcDraggable.menuBar.removeEventListener(MouseEvent.CLICK,onToggleMenu);
            mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_DOWN,onHold);
            mcDraggable.menuBar.removeEventListener(MouseEvent.MOUSE_UP,onMouseRelease);
         }
         else
         {
            this.inner_menu.removeEventListener(MouseEvent.ROLL_OVER,onRollOverAttached);
            this.inner_menu.removeEventListener(MouseEvent.ROLL_OUT,onRollOutAttached);
            this.inner_menu.removeEventListener(MouseEvent.CLICK,onToggleAttached);
         }
         rootClass.cDropsUI = null;
         rootClass.ui.mcPortrait.iconDrops.visible = false;
         parent.removeChild(this);
      }
      
      public function isMenuOpen() : Boolean
      {
         return mcDraggable ? mcDraggable.visible : isOpen;
      }
      
      public function onRollOverAttached(param1:MouseEvent) : void
      {
         if(isOpen)
         {
            return;
         }
         this.y = rootClass.litePreference.data.dOptions["invertMenu"] ? -521 : -28;
      }
      
      public function onRollOutAttached(param1:MouseEvent) : void
      {
         if(isOpen)
         {
            return;
         }
         this.y = rootClass.litePreference.data.dOptions["invertMenu"] ? -530 : -19;
      }
      
      public function onToggleAttached(param1:MouseEvent) : void
      {
         isOpen = !isOpen;
         if(!isOpen)
         {
            this.inner_menu.filters = [inactive];
            while(this.numChildren > 1)
            {
               this.removeChildAt(1);
            }
            this.inner_menu.height = rootClass.litePreference.data.dOptions["invertMenu"] ? 42.8 : 157.7;
            this.inner_menu.y = 0;
            this.y = rootClass.litePreference.data.dOptions["invertMenu"] ? -530 : -19;
         }
         else
         {
            this.inner_menu.filters = [];
            reDraw();
         }
      }
      
      public function onShow() : void
      {
         if(mcDraggable)
         {
            mcDraggable.visible = !mcDraggable.visible;
         }
         else
         {
            this.inner_menu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function onUpdate() : *
      {
         itemCount = {};
         invTree.length = 0;
         if(isOpen || Boolean(mcDraggable))
         {
            reDraw();
         }
      }
      
      public function onBtNo(param1:*) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in invTree)
         {
            if(invTree[_loc2_].ItemID == param1.ItemID)
            {
               itemCount[invTree[_loc2_].dID] = null;
               invTree.splice(_loc2_,1);
            }
         }
         if(isOpen || Boolean(mcDraggable))
         {
            reDraw();
         }
      }
      
      public function isBlacklisted(param1:String) : Boolean
      {
         return false;
      }
      
      public function cleanDSUI() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc1_:* = rootClass.ui.getChildByName("dsUI").numChildren;
         _loc1_ -= 2;
         while(_loc1_ > -1)
         {
            _loc2_ = rootClass.ui.getChildByName("dsUI").getChildAt(_loc1_) as MovieClip;
            _loc3_ = rootClass.ui.getChildByName("dsUI").getChildAt(_loc1_ + 1) as MovieClip;
            _loc2_.fY = _loc2_.y = _loc3_.fY - (_loc3_.fHeight + 8);
            _loc1_--;
         }
      }
      
      public function showItem(param1:Object) : void
      {
         if(isBlacklisted(param1.sName.toUpperCase()))
         {
            return;
         }
         if(itemCount[param1.dID] == null)
         {
            itemCount[param1.dID] = int(param1.dQty);
            invTree.push(param1);
         }
         else
         {
            itemCount[param1.dID] += int(param1.dQty);
         }
         if(mcDraggable)
         {
            reDraw();
            if(!mcDraggable.visible)
            {
               rootClass.ui.mcPortrait.iconDrops.onAlert();
            }
            return;
         }
         if(isOpen)
         {
            reDraw();
         }
         else
         {
            rootClass.ui.mcPortrait.iconDrops.onAlert();
         }
      }
      
      public function acceptDrop(param1:Object) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in invTree)
         {
            if(invTree[_loc2_].ItemID == param1.ItemID)
            {
               itemCount[invTree[_loc2_].dID] = null;
               invTree.splice(_loc2_,1);
            }
         }
         if(isOpen || Boolean(mcDraggable))
         {
            reDraw();
         }
      }
      
      public function reDraw() : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc1_:int = 0;
         while((mcDraggable ? mcDraggable.menu : this).numChildren > 1)
         {
            (mcDraggable ? mcDraggable.menu : this).removeChildAt(1);
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         for each(_loc4_ in invTree)
         {
            if(itemCount[_loc4_.dID] % 100 == 0)
            {
               if(_loc4_.ItemID == 6521 && itemCount[_loc4_.dID] % 1000 == 0)
               {
                  _loc2_ = true;
               }
               else if(_loc4_.ItemID != 6521)
               {
                  _loc2_ = true;
               }
            }
            _loc5_ = new dEntry(rootClass,_loc4_,itemCount[_loc4_.dID]);
            if(rootClass.litePreference.data.dOptions["invertMenu"])
            {
               _loc5_.x = 1.5;
               _loc5_.y = !mcDraggable ? 24 + 21.5 * _loc3_ - 0.5 : 161 + 21.5 * _loc3_;
            }
            else
            {
               _loc5_.x = 1.5;
               _loc5_.y = !mcDraggable ? -16 - 21.5 * _loc3_ + 0.5 : 108 - 21.5 * _loc3_;
            }
            _loc5_.name = _loc4_.sName;
            (mcDraggable ? mcDraggable.menu : this).addChild(_loc5_);
            _loc1_ += itemCount[_loc4_.dID];
            _loc3_++;
         }
         if(_loc2_ && Boolean(rootClass.litePreference.data.dOptions["termsAgree"]))
         {
            _loc6_ = new ModalMC();
            _loc7_ = {};
            _loc7_.strBody = "You have an item that\'s over the 100x quantity threshold! Please pick up your drops before you bug out!";
            _loc7_.callback = null;
            _loc7_.btns = "mono";
            _loc7_.glow = "red,medium";
            rootClass.ui.ModalStack.addChild(_loc6_);
            _loc6_.init(_loc7_);
         }
         if(mcDraggable)
         {
            mcDraggable.txtQty.text = " x " + _loc1_;
            if(rootClass.litePreference.data.dOptions["invertMenu"])
            {
               mcDraggable.menu.menuBG.y = 158;
               mcDraggable.menu.menuBG.height = 21.5 * _loc3_ + 6;
            }
            else
            {
               mcDraggable.menu.menuBG.y = 108 - 21.5 * (_loc3_ - 1) - 3;
               mcDraggable.menu.menuBG.height = 21.5 * _loc3_ + 6;
            }
         }
         else if(rootClass.litePreference.data.dOptions["invertMenu"])
         {
            this.inner_menu.y = 0;
            this.inner_menu.height = _loc3_ == 0 ? 47.5 : 47.5 + 21.5 * (_loc3_ - 1);
            this.y = -521;
         }
         else
         {
            this.inner_menu.y = 4 - 21.5 * _loc3_;
            this.inner_menu.height = _loc3_ == 0 ? 157.7 : 157.7 + 21.5 * (_loc3_ - 1);
            this.y = -28;
         }
      }
   }
}

