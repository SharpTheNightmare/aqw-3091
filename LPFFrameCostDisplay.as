package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1974")]
   public class LPFFrameCostDisplay extends LPFFrame
   {
      
      public var mcCoins:MovieClip;
      
      public var mcGold:MovieClip;
      
      public var bg:MovieClip;
      
      private var rootClass:MovieClip;
      
      private var r:Object;
      
      public function LPFFrameCostDisplay()
      {
         super();
         x = 0;
         y = 0;
         fData = {};
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         fData = param1.fData;
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("r" in param1)
         {
            r = param1.r;
         }
         fDraw();
         positionBy(r);
         getLayout().registerForEvents(this,eventTypes);
         mcCoins.addEventListener(MouseEvent.MOUSE_OVER,onCoinsTTOver,false,0,true);
         mcCoins.addEventListener(MouseEvent.MOUSE_OUT,onTTOut,false,0,true);
         mcGold.addEventListener(MouseEvent.MOUSE_OVER,onGoldTTOver,false,0,true);
         mcGold.addEventListener(MouseEvent.MOUSE_OUT,onTTOut,false,0,true);
         mcGold.hit.alpha = 0;
         mcCoins.hit.alpha = 0;
      }
      
      override public function fClose() : void
      {
         mcCoins.removeEventListener(MouseEvent.MOUSE_OVER,onCoinsTTOver);
         mcCoins.removeEventListener(MouseEvent.MOUSE_OUT,onTTOut);
         mcGold.removeEventListener(MouseEvent.MOUSE_OVER,onGoldTTOver);
         mcGold.removeEventListener(MouseEvent.MOUSE_OUT,onTTOut);
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      private function get qty_parent() : *
      {
         return MovieClip(MovieClip(parent).parent).iQty ? MovieClip(MovieClip(parent).parent) : MovieClip(parent);
      }
      
      private function fDraw() : void
      {
         var _loc4_:int = 0;
         visible = false;
         var _loc1_:* = getLayout().sMode == "shopSell";
         var _loc2_:Number = 0;
         var _loc3_:String = "#FFFFFF";
         if(getLayout().sMode.indexOf("shop") > -1 && fData != null)
         {
            visible = true;
            mcGold.visible = false;
            mcCoins.visible = false;
            mcGold.x = 0;
            mcCoins.x = 0;
            mcGold.ti.text = "";
            mcCoins.ti.text = "";
            _loc2_ = Number(fData.iCost);
            if(qty_parent.eSel != null && getLayout().sMode == "shopBuy" && Boolean(getLayout().hasOwnProperty("splitPanel")))
            {
               if(getLayout().splitPanel.visible)
               {
                  _loc4_ = int(getLayout().splitPanel.frames[2].mc.getSelected());
                  if(_loc4_ > 1)
                  {
                     _loc2_ *= _loc4_;
                  }
               }
            }
            else if(getLayout().sMode.indexOf("shop") > -1 && qty_parent && hasSlider() && qty_parent.iQty > 1)
            {
               if(fData.sES != "ar")
               {
                  _loc2_ *= qty_parent.iQty;
               }
            }
            if(_loc2_ > 0)
            {
               if("bCoins" in fData && fData.bCoins == 1)
               {
                  if(_loc1_)
                  {
                     if(fData.ItemID == 8939)
                     {
                        _loc2_ = Math.ceil(_loc2_ / 4);
                     }
                     else if(fData.iHrs < 24)
                     {
                        _loc2_ = Math.ceil(_loc2_ * 9 / 10);
                     }
                     else
                     {
                        _loc2_ = Math.ceil(_loc2_ / 4);
                     }
                  }
                  else if(_loc2_ > rootClass.world.myAvatar.objData.intCoins)
                  {
                     _loc3_ = "#FF0000";
                  }
                  mcCoins.ti.htmlText = "<font color=\'" + _loc3_ + "\'>" + rootClass.strNumWithCommas(_loc2_) + "</font>";
                  mcCoins.visible = true;
               }
               else
               {
                  if(_loc1_)
                  {
                     _loc2_ = Math.ceil(_loc2_ / 4);
                  }
                  else if(_loc2_ > rootClass.world.myAvatar.objData.intGold)
                  {
                     _loc3_ = "#FF0000";
                  }
                  mcGold.ti.htmlText = "<font color=\'" + _loc3_ + "\'>" + rootClass.strNumWithCommas(_loc2_) + "</font>";
                  mcGold.visible = true;
               }
               mcGold.hit.width = mcGold.ti.x + mcGold.ti.textWidth + 2;
               mcCoins.hit.width = mcCoins.ti.x + mcCoins.ti.textWidth + 2;
               if(rootClass.ui.mcPopup.currentLabel == "MergeShop" && hasSlider())
               {
                  positionBy({
                     "x":450,
                     "y":-102,
                     "w":-1,
                     "h":-1,
                     "xPosRule":"centerOnX"
                  });
               }
               else if(rootClass.ui.mcPopup.currentLabel == "MergeShop" && !hasSlider())
               {
                  positionBy(r);
               }
               visible = true;
            }
            else
            {
               visible = false;
            }
         }
      }
      
      private function hasSlider() : Boolean
      {
         if(getLayout().sMode == "shopBuy" && (rootClass.world.maximumShopBuys(fData) < 2 || fData.bCoins == 1 && fData.iCost > 0))
         {
            return false;
         }
         if(getLayout().sMode == "shopSell" && rootClass.world.maximumShopSells(fData) < 2)
         {
            return false;
         }
         return true;
      }
      
      override protected function positionBy(param1:Object) : *
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(mcGold.visible)
         {
            bg.width = mcGold.x + mcGold.ti.x + mcGold.ti.textWidth + 10;
            w = bg.width;
            _loc2_ = 1;
         }
         else
         {
            bg.width = mcCoins.x + mcCoins.ti.x + mcCoins.ti.textWidth + 10;
            w = bg.width;
         }
         if(param1 != null && "xPosRule" in param1)
         {
            if(param1.xPosRule == "centerOnX")
            {
               x = int(param1.x - w / 2) + _loc2_;
            }
         }
         else if(param1.x > -1)
         {
            x = param1.x;
         }
         else
         {
            x = int(fParent.w / 2 - w / 2) + _loc2_;
         }
         if(param1.y > -1)
         {
            y = param1.y;
         }
         else if(param1.y == -1)
         {
            _loc3_ = fParent.numChildren;
            if(_loc3_ > 1)
            {
               y = fParent.getChildAt(_loc3_ - 2).y + fParent.getChildAt(_loc3_ - 2).height + 10;
            }
            else
            {
               y = 10;
            }
         }
         else
         {
            y = fParent.h + param1.y;
         }
      }
      
      override public function notify(param1:Object) : void
      {
         if(param1.eventType == "listItemASel" || param1.eventType == "listItemBSel")
         {
            if(param1.fData != null && param1.fData.oSel != null)
            {
               fData = param1.fData.oSel;
            }
            fDraw();
         }
         if(param1.eventType == "updateQtyValue")
         {
            fDraw();
         }
      }
      
      private function onCoinsTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Adventure Coins"});
      }
      
      private function onGoldTTOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":"Gold"});
      }
      
      private function onTTOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
   }
}

