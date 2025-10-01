package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1006")]
   public class DFrameMC extends MovieClip
   {
      
      public var cnt:DFrameMCcnt;
      
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
      
      public var fWidth:int = 175;
      
      public var fHeight:int = 38;
      
      public var fX:int = 0;
      
      public var fY:int = 0;
      
      public function DFrameMC(param1:Object)
      {
         super();
         addFrameScript(0,frame1,2,frame3,3,frame4,8,frame9,12,frame13);
         fData = param1;
      }
      
      public function init() : *
      {
         mc = MovieClip(this);
         rootClass = MovieClip(stage.getChildAt(0));
         mc.cnt.strName.autoSize = "left";
         mc.cnt.strName.text = fData.sName;
         if(mc.cnt.strName.height > 20)
         {
            mc.cnt.strName.y -= int(mc.cnt.strName.height / 2);
            if(mc.cnt.strName.y < 3)
            {
               mc.cnt.strName.y = 3;
            }
         }
         mc.cnt.strType.text = rootClass.getDisplaysType(fData) + (Boolean(fData.bBank) ? " added to Bank" : "");
         if(fData.virtual)
         {
            mc.cnt.strType.text = "Gold Donation";
         }
         mc.cnt.strType.width = int(mc.cnt.strType.textWidth) + 50;
         if(fData.iQty > 1 && fData.sES != "ar")
         {
            mc.cnt.strQ.text = "x" + fData.iQty;
            mc.cnt.strQ.x = mc.cnt.bg.width - mc.cnt.strQ.width - 7;
            mc.cnt.strQ.visible = true;
            mc.cnt.bg.width = int(mc.cnt.strName.textWidth) + 75;
         }
         else
         {
            mc.cnt.strQ.x = 0;
            mc.cnt.strQ.visible = false;
            mc.cnt.bg.width = int(mc.cnt.strName.textWidth) + 50;
         }
         if(fData.iQty > 1 && fData.sES != "ar")
         {
            mc.cnt.bg.width = int(mc.cnt.strName.textWidth) + 50;
            mc.cnt.bg.width += mc.cnt.strQ.textWidth + 2;
            mc.cnt.fx1.width = mc.cnt.bg.width;
            mc.fWidth = mc.cnt.bg.width;
         }
         else if(mc.cnt.strName.textWidth < mc.cnt.strType.textWidth)
         {
            mc.cnt.bg.width = int(mc.cnt.strType.textWidth) + 50;
            mc.cnt.fx1.width = mc.cnt.bg.width;
            mc.fWidth = mc.cnt.bg.width;
         }
         if(mc.cnt.strType.width > mc.cnt.bg.width)
         {
            mc.cnt.bg.width = int(mc.cnt.strType.textWidth) + 50;
         }
         mc.cnt.strQ.x = mc.cnt.bg.width - 65;
         mc.cnt.fx1.width = mc.cnt.bg.width;
         fWidth = mc.cnt.bg.width;
         var _loc1_:* = mc.cnt.bg.filters;
         _loc1_ = new GlowFilter(rarityCA[fData.iRty],1,8,8,2,1,false,false);
         mc.cnt.bg.filters = [_loc1_];
         mc.cnt.icon.removeAllChildren();
         var _loc2_:String = "";
         if(fData.sType.toLowerCase() == "enhancement")
         {
            _loc2_ = rootClass.getIconBySlot(fData.sES);
         }
         else if(fData.sType.toLowerCase() == "serveruse" || fData.sType.toLowerCase() == "clientuse")
         {
            if("sFile" in fData && fData.sFile.length > 0 && rootClass.world.getClass(fData.sFile) != null)
            {
               _loc2_ = fData.sFile;
            }
            else
            {
               _loc2_ = fData.sIcon;
            }
         }
         else if(fData.sIcon == null || fData.sIcon == "" || fData.sIcon == "none")
         {
            if(fData.sLink.toLowerCase() != "none")
            {
               _loc2_ = "iidesign";
            }
            else
            {
               _loc2_ = "iibag";
            }
         }
         else
         {
            _loc2_ = fData.sIcon;
         }
         var _loc3_:Class = rootClass.world.getClass(_loc2_) as Class;
         var _loc4_:* = mc.cnt.icon.addChild(new _loc3_());
         _loc4_.scaleX = _loc4_.scaleY = 0.5;
         _loc1_ = mc.cnt.icon.filters;
         _loc1_ = new GlowFilter(rarityCA[fData.iRty],1,8,8,2,1,false,false);
         mc.cnt.icon.filters = [_loc1_];
         mc.cnt.fadedAC.visible = false;
         mc.cnt.icon.detailedCheck.visible = false;
      }
      
      private function closeClick(param1:MouseEvent) : *
      {
      }
      
      internal function frame1() : *
      {
         visible = false;
      }
      
      internal function frame3() : *
      {
         ++iniFrameC;
         if(iniFrameC <= MovieClip(parent).getChildIndex(this) * 2)
         {
            this.gotoAndPlay(currentFrame - 1);
         }
      }
      
      internal function frame4() : *
      {
         visible = true;
      }
      
      internal function frame9() : *
      {
         ++durFrameC;
         if(durFrameC <= durFrameT + 5)
         {
            this.gotoAndPlay(currentFrame - 1);
         }
      }
      
      internal function frame13() : *
      {
         MovieClip(parent).removeChild(this);
         stop();
      }
   }
}

