package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol995")]
   public class DFrame2MC extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      internal var world:MovieClip;
      
      internal var rootClass:MovieClip;
      
      internal var fData:Object = null;
      
      internal var isOpen:Boolean = false;
      
      internal var iniFrameT:int = 0;
      
      internal var iniFrameC:int = 0;
      
      internal var durFrameT:int = 35;
      
      internal var durFrameC:int = 0;
      
      internal var mc:MovieClip;
      
      internal var rarityCA:Array = [6710886,16777215,6749952,2663679,16711935,16763904,16711680];
      
      public var fWidth:int = 250;
      
      public var fHeight:int = 86;
      
      public var fX:int = 0;
      
      public var fY:int = 0;
      
      public function DFrame2MC(param1:Object)
      {
         super();
         addFrameScript(3,frame4,11,frame12);
         fData = param1;
      }
      
      public function init() : *
      {
         var mcFilter:*;
         var sIcon:String;
         var AssetClass:Class = null;
         var mcIcon:DisplayObject = null;
         var legend_format:TextFormat = null;
         mc = MovieClip(this);
         rootClass = MovieClip(stage.getChildAt(0));
         mc.cnt.strName.autoSize = "left";
         mc.cnt.strName.text = fData.sName;
         if(fData.iStk > 1)
         {
            mc.cnt.strName.text += " x" + fData.iQty;
         }
         mc.cnt.bg.width = Math.max(mc.cnt.strName.x + int(mc.cnt.strName.textWidth) + 15,250);
         mc.cnt.ybtn.bg.width = Math.round(mc.cnt.bg.width / 2);
         mc.cnt.nbtn.bg.width = Math.round(mc.cnt.bg.width - mc.cnt.ybtn.bg.width);
         mc.cnt.nbtn.x = mc.cnt.ybtn.width;
         mc.cnt.ybtn.ti.x = mc.cnt.ybtn.bg.width / 2 - mc.cnt.ybtn.ti.textWidth / 2 + 4;
         mc.cnt.nbtn.ti.x = mc.cnt.nbtn.bg.width / 2 - mc.cnt.nbtn.ti.textWidth / 2 - 4;
         mc.cnt.ybtn.ti.mouseEnabled = false;
         mc.cnt.nbtn.ti.mouseEnabled = false;
         mc.cnt.strType.text = rootClass.getDisplaysType(fData);
         mcFilter = mc.cnt.bg.filters;
         mc.cnt.icon.removeAllChildren();
         sIcon = "";
         if(fData.sType.toLowerCase() == "enhancement")
         {
            sIcon = rootClass.getIconBySlot(fData.sES);
         }
         else if(fData.sType.toLowerCase() == "serveruse" || fData.sType.toLowerCase() == "clientuse")
         {
            if("sFile" in fData && fData.sFile.length > 0 && rootClass.world.getClass(fData.sFile) != null)
            {
               sIcon = fData.sFile;
            }
            else
            {
               sIcon = fData.sIcon;
            }
         }
         else if(fData.sIcon == null || fData.sIcon == "" || fData.sIcon == "none")
         {
            if(fData.sLink.toLowerCase() != "none")
            {
               sIcon = "iidesign";
            }
            else
            {
               sIcon = "iibag";
            }
         }
         else
         {
            sIcon = fData.sIcon;
         }
         try
         {
            AssetClass = rootClass.world.getClass(sIcon) as Class;
            mcIcon = mc.cnt.icon.addChild(new AssetClass());
         }
         catch(e:Error)
         {
            AssetClass = rootClass.world.getClass("iibag") as Class;
            mcIcon = mc.cnt.icon.addChild(new AssetClass());
         }
         mcIcon.scaleX = mcIcon.scaleY = 0.5;
         mcFilter = mc.cnt.icon.filters;
         mcFilter = new GlowFilter(rarityCA[fData.iRty],1,8,8,2,1,false,false);
         mc.cnt.icon.filters = [mcFilter];
         mc.cnt.icon.detailedCheck.visible = isOwned(fData.bHouse,fData.ItemID);
         if(fData.bUpg)
         {
            legend_format = mc.cnt.strName.defaultTextFormat;
            legend_format.color = 16566089;
            mc.cnt.strName.setTextFormat(legend_format);
         }
         mc.cnt.fadedAC.visible = fData.bCoins == 1;
         if(fData.bCoins == 1)
         {
            mc.cnt.fadedAC.x = mc.cnt.bg.width - 115;
         }
         mc.cnt.ybtn.buttonMode = true;
         mc.cnt.nbtn.buttonMode = true;
         mc.cnt.ybtn.addEventListener(MouseEvent.CLICK,yClick,false,0,true);
         mc.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OVER,yMouseOver,false,0,true);
         mc.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OUT,yMouseOut,false,0,true);
         mc.cnt.nbtn.addEventListener(MouseEvent.CLICK,nClick,false,0,true);
         mc.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OVER,nMouseOver,false,0,true);
         mc.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OUT,nMouseOut,false,0,true);
         if(rootClass.litePreference.data.bDraggable)
         {
            mc.addEventListener(MouseEvent.MOUSE_DOWN,dStartDrag,false,0,true);
            mc.addEventListener(MouseEvent.MOUSE_UP,dStopDrag,false,0,true);
         }
      }
      
      public function isOwned(param1:Boolean, param2:*) : Boolean
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1 ? rootClass.world.myAvatar.houseitems : rootClass.world.myAvatar.items)
         {
            if(_loc3_.ItemID == param2)
            {
               return true;
            }
         }
         if(rootClass.world.bankinfo.isItemInBank(param2))
         {
            return true;
         }
         return false;
      }
      
      private function dStartDrag(param1:MouseEvent) : void
      {
         param1.currentTarget.startDrag();
      }
      
      private function dStopDrag(param1:MouseEvent) : void
      {
         param1.currentTarget.stopDrag();
      }
      
      private function yClick(param1:MouseEvent) : *
      {
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:Boolean = true;
         for each(_loc3_ in rootClass.world.myAvatar.items)
         {
            if(_loc3_.ItemID == fData.ItemID && _loc3_.iQty < _loc3_.iStk)
            {
               _loc2_ = false;
            }
         }
         if(_loc2_ && rootClass.world.myAvatar.items.length < rootClass.world.myAvatar.objData.iBagSlots)
         {
            _loc2_ = false;
         }
         if(Boolean(rootClass.isHouseItem(fData)) && rootClass.world.myAvatar.houseitems.length >= rootClass.world.myAvatar.objData.iHouseSlots)
         {
            rootClass.MsgBox.notify("House Inventory Full!");
         }
         else if(!rootClass.isHouseItem(fData) && _loc2_)
         {
            rootClass.MsgBox.notify("Item Inventory Full!");
         }
         else
         {
            _loc4_ = MovieClip(param1.currentTarget);
            _loc5_ = MovieClip(_loc4_.parent.parent);
            setCT(_loc4_.bg,3385873);
            _loc5_.cnt.ybtn.mouseEnabled = false;
            _loc5_.cnt.ybtn.mouseChildren = false;
            rootClass.sfc.sendXtMessage("zm","getDrop",[fData.ItemID],"str",rootClass.world.curRoom);
         }
      }
      
      private function nClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         var _loc3_:* = MovieClip(_loc2_.parent.parent);
         setCT(_loc2_.bg,16711680);
         _loc3_.mouseChildren = false;
         killButtons();
         _loc3_.gotoAndPlay("out");
      }
      
      private function yMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         setCT(_loc2_.bg,2236962);
      }
      
      private function yMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         setCT(_loc2_.bg,0);
      }
      
      private function nMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         setCT(_loc2_.bg,2236962);
      }
      
      private function nMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         setCT(_loc2_.bg,0);
      }
      
      private function killButtons() : void
      {
         mc.cnt.ybtn.removeEventListener(MouseEvent.CLICK,yClick);
         mc.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OVER,yMouseOver);
         mc.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OUT,yMouseOut);
         mc.cnt.nbtn.removeEventListener(MouseEvent.CLICK,nClick);
         mc.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OVER,nMouseOver);
         mc.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OUT,nMouseOut);
         if(mc.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            mc.removeEventListener(MouseEvent.MOUSE_DOWN,dStartDrag);
            mc.removeEventListener(MouseEvent.MOUSE_UP,dStopDrag);
         }
      }
      
      public function fClose() : void
      {
         killButtons();
         MovieClip(this).parent.removeChild(this);
      }
      
      private function setCT(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
         fClose();
      }
   }
}

