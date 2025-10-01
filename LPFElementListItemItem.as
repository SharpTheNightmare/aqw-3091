package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.text.*;
   import liteAssets.draw.detailedCheck;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2132")]
   public class LPFElementListItemItem extends LPFElementListItem
   {
      
      public var icon:MovieClip;
      
      public var tName:TextField;
      
      public var selBG:MovieClip;
      
      public var tLevel:TextField;
      
      public var wearBG:MovieClip;
      
      public var check:detailedCheck;
      
      public var iconAC:MovieClip;
      
      public var eqpBG:MovieClip;
      
      public var iconRing:MovieClip;
      
      public var hit:MovieClip;
      
      public var sel:Boolean = false;
      
      private var rootClass:MovieClip;
      
      private var allowDesel:Boolean = false;
      
      private var bLimited:Boolean = false;
      
      private var multiSelect:Boolean = false;
      
      private const MAX_SELECTED:int = 100;
      
      private var redCT:ColorTransform = new ColorTransform(1,1,1,1,96,0,0,0);
      
      private var greenCT:ColorTransform = new ColorTransform(1,1,1,1,0,96,0,0);
      
      private var blueCT:ColorTransform = new ColorTransform(1,1,1,1,0,0,96,0);
      
      private var whiteCT:ColorTransform = new ColorTransform(1,1,1,1,64,64,64,0);
      
      private var orangeCT:ColorTransform = new ColorTransform(1,1,1,1,96,36,0,0);
      
      private var yellowCT:ColorTransform = new ColorTransform(1,1,1,1,96,64,24,0);
      
      private var purpleCT:ColorTransform = new ColorTransform(1,1,1,1,96,0,96,0);
      
      private var greyCT:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      private var blackoutCT:ColorTransform = new ColorTransform(0,0,0,1,0,0,0,0);
      
      private var greyoutCT:ColorTransform = new ColorTransform(0,0,0,1,40,40,40,0);
      
      private var staffFilter:GlowFilter = new GlowFilter(16776960,1,5,5,5,1,false,true);
      
      private var mispricedFilter:GlowFilter = new GlowFilter(16711680,1,5,5,5,1,false,true);
      
      public function LPFElementListItemItem()
      {
         super();
         check.visible = false;
         check.mouseEnabled = false;
         addEventListener(MouseEvent.CLICK,onClick,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
      }
      
      override public function fOpen(param1:Object) : void
      {
         fData = param1.fData;
         if("eventType" in param1)
         {
            eventType = param1.eventType;
         }
         if("allowDesel" in param1)
         {
            allowDesel = param1.allowDesel == true;
         }
         if("bLimited" in param1)
         {
            bLimited = param1.bLimited == true;
         }
         if("multiSelect" in param1)
         {
            multiSelect = param1.multiSelect == true;
         }
         rootClass = MovieClip(stage.getChildAt(0));
         fDraw();
      }
      
      override protected function fDraw() : void
      {
         var _loc4_:Object = null;
         var _loc12_:Number = NaN;
         var _loc13_:Class = null;
         var _loc14_:* = undefined;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc1_:Object = rootClass.world.myAvatar.dataLeaf;
         var _loc2_:int = hit.width - 2;
         var _loc3_:* = "<font color=\'#FFFFFF\'>" + fData.sName + "</font>";
         if(fData.bUpg == 1)
         {
            _loc3_ = "<font color=\'#FCC749\'>" + fData.sName + "</font>";
         }
         if(fData.iLvl > _loc1_.intLevel || fData.EnhLvl != null && fData.EnhLvl > _loc1_.intLevel)
         {
            _loc3_ = "<font color=\'#FF0000\'>" + fData.sName + "</font>";
         }
         if(bLimited && fData.iQtyRemain <= 0)
         {
            _loc3_ = "<font color=\'#666666\'>" + fData.sName + "</font>";
         }
         tName.htmlText = _loc3_;
         if(fData.iRty != null)
         {
         }
         if(rootClass.world.enhPatternTree == null)
         {
            rootClass.world.initPatternTree();
         }
         if(["Weapon","he","ar","ba"].indexOf(fData.sES) > -1)
         {
            if(fData.PatternID != null)
            {
               _loc4_ = rootClass.world.enhPatternTree[fData.PatternID];
            }
            if(fData.EnhPatternID != null)
            {
               _loc4_ = rootClass.world.enhPatternTree[fData.EnhPatternID];
            }
            if(_loc4_ != null)
            {
            }
         }
         if(bLimited)
         {
            tName.htmlText += "<font color=\'#AA0000\'> x" + fData.iQtyRemain + "</font>";
         }
         else if(fData.iStk > 1)
         {
            tName.htmlText += "<font color=\'#999999\'> x" + fData.iQty + "</font>";
         }
         if(fData.sES == "ar" && fData.EnhID > 0)
         {
            _loc12_ = Number(rootClass.getRankFromPoints(fData.iQty));
            tName.htmlText += "<font color=\'#999999\'>, Rank " + _loc12_ + "</font>";
         }
         if(fData.EnhLvl != null && fData.EnhLvl > 0)
         {
            tLevel.htmlText = "<font color=\'#00CCFF\'>" + fData.EnhLvl + "</font>";
         }
         else if(fData.iLvl != null && fData.iLvl > 0)
         {
            tLevel.htmlText = "<font color=\'#FFFFFF\'>" + fData.iLvl + "</font>";
         }
         else
         {
            tLevel.visible = false;
         }
         iconAC.visible = false;
         if("bCoins" in fData && fData.bCoins == 1)
         {
            iconAC.visible = true;
         }
         var _loc5_:* = 23;
         var _loc6_:* = 19;
         var _loc7_:* = 13;
         var _loc8_:* = 11;
         var _loc9_:* = _loc5_;
         var _loc10_:* = _loc6_;
         var _loc11_:String = "";
         icon.removeAllChildren();
         icon.visible = false;
         try
         {
            if(fData.sType.toLowerCase() == "enhancement")
            {
               _loc11_ = rootClass.getIconBySlot(fData.sES);
            }
            else if(fData.sType.toLowerCase() == "serveruse" || fData.sType.toLowerCase() == "clientuse")
            {
               if("sFile" in fData && fData.sFile.length > 0 && rootClass.world.getClass(fData.sFile) != null)
               {
                  _loc11_ = fData.sFile;
               }
               else
               {
                  _loc11_ = fData.sIcon;
               }
            }
            else if(fData.sIcon == null || fData.sIcon == "" || fData.sIcon == "none")
            {
               if(fData.sLink.toLowerCase() != "none")
               {
                  _loc11_ = "iidesign";
               }
               else
               {
                  _loc11_ = "iibag";
               }
            }
            else
            {
               _loc11_ = fData.sIcon;
            }
            try
            {
               _loc13_ = rootClass.world.getClass(_loc11_) as Class;
               _loc14_ = icon.addChild(new _loc13_());
               _loc9_ = _loc14_.width;
               _loc10_ = _loc14_.height;
               _loc15_ = 0;
               _loc16_ = 0;
               if(fData.sType.toLowerCase() == "enhancement")
               {
                  _loc15_ = (_loc5_ - _loc7_) / 4 - 1;
                  _loc16_ = (_loc6_ - _loc8_) / 4 - 1;
                  _loc5_ = _loc7_;
                  _loc6_ = _loc8_;
               }
               if(_loc9_ > _loc10_)
               {
                  _loc14_.scaleX = _loc14_.scaleY = _loc5_ / _loc9_;
               }
               else
               {
                  _loc14_.scaleX = _loc14_.scaleY = _loc6_ / _loc10_;
               }
               _loc14_.x = -(_loc14_.width / 2) + _loc15_;
               _loc14_.y = -(_loc14_.height / 2) + _loc16_;
               icon.visible = true;
            }
            catch(e:Error)
            {
            }
            iconRing.visible = true;
            iconRing.y = iconRing.y = 2;
            iconRing.width = iconRing.height = 25;
            if(fData.sType.toLowerCase() == "enhancement")
            {
               icon.transform.colorTransform = blackoutCT;
            }
            else if(fData.EnhLvl != null && fData.EnhLvl > 0)
            {
               iconRing.width = iconRing.height = 19;
               iconRing.x += 3;
               iconRing.y += 3;
            }
            else
            {
               iconRing.visible = false;
               if(["Weapon","he","ar","ba"].indexOf(fData.sES) > -1)
               {
                  icon.transform.colorTransform = greyoutCT;
               }
            }
            if(_loc4_ != null)
            {
               if(_loc4_.hasOwnProperty("COLOR"))
               {
                  iconRing.bg.transform.colorTransform = _loc4_.COLOR;
               }
               else
               {
                  iconRing.bg.transform.colorTransform = getCatCT(_loc4_.sDesc);
               }
            }
            wearBG.visible = false;
            eqpBG.visible = false;
            if(fData.bEquip)
            {
               eqpBG.visible = true;
            }
            else if(Boolean(fData.hasOwnProperty("bWear")) && Boolean(fData.bWear))
            {
               wearBG.visible = true;
            }
            selBG.alpha = 0;
            if(Boolean(rootClass.litePreference.data.bDebugger) && !rootClass.litePreference.data.dOptions["debugColor"])
            {
               if(Number(fData.bStaff) == 1)
               {
                  eqpBG.visible = true;
                  eqpBG.filters = [staffFilter];
               }
               else
               {
                  eqpBG.filters = [];
                  if(Number(fData.iCost) > 12000 && Number(fData.bCoins) == 1)
                  {
                     eqpBG.visible = true;
                     eqpBG.filters = [mispricedFilter];
                  }
                  else if(Number(fData.iCost) == 0)
                  {
                     eqpBG.visible = true;
                     eqpBG.filters = [mispricedFilter];
                  }
               }
            }
            buttonMode = true;
            mouseChildren = false;
         }
         catch(e:*)
         {
         }
      }
      
      override public function select() : void
      {
         sel = true;
         if(multiSelect)
         {
            check.visible = true;
         }
         else
         {
            selBG.alpha = 1;
         }
      }
      
      override public function deselect() : void
      {
         sel = false;
         if(multiSelect)
         {
            check.visible = false;
         }
         else
         {
            selBG.alpha = 0;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(!rootClass.isGreedyModalInStack())
         {
            if(multiSelect)
            {
               if(sel)
               {
                  deselect();
               }
               else if(LPFFrameListViewTabbed(fParent).getSelected() < MAX_SELECTED)
               {
                  select();
               }
               else
               {
                  rootClass.MsgBox.notify("You can only select up to a maximum of " + MAX_SELECTED + " items.");
               }
            }
            else if(!sel)
            {
               _loc2_ = LPFFrameListViewTabbed(fParent).getListItemByiSel();
               if(_loc2_ != null)
               {
                  _loc2_.deselect();
               }
               select();
            }
            else if(allowDesel)
            {
               deselect();
            }
            update();
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(!sel)
         {
            selBG.alpha = 0.6;
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(!sel)
         {
            selBG.alpha = 0;
         }
      }
      
      private function getCatCT(param1:String) : ColorTransform
      {
         var _loc2_:ColorTransform = greyCT;
         if(param1 == "M1")
         {
            _loc2_ = redCT;
         }
         if(param1 == "M2")
         {
            _loc2_ = greenCT;
         }
         if(param1 == "M3")
         {
            _loc2_ = yellowCT;
         }
         if(param1 == "C1")
         {
            _loc2_ = blueCT;
         }
         if(param1 == "C2")
         {
            _loc2_ = whiteCT;
         }
         if(param1 == "C3")
         {
            _loc2_ = orangeCT;
         }
         if(param1 == "S1")
         {
            _loc2_ = purpleCT;
         }
         if(param1 == "none")
         {
            _loc2_ = greyCT;
         }
         return _loc2_;
      }
   }
}

