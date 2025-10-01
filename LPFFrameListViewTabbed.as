package
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1918")]
   public class LPFFrameListViewTabbed extends LPFFrame
   {
      
      public var tMsg:TextField;
      
      public var listMask:MovieClip;
      
      public var bgTabs:MovieClip;
      
      public var bgList:MovieClip;
      
      public var tabs:MovieClip;
      
      public var iList:MovieClip;
      
      public var scr:LPFElementScrollBar;
      
      private var listA:Array = [];
      
      private var aSel:Array = [];
      
      private var iSel:Object;
      
      private var tSel:Object;
      
      private var tabStates:Array = [];
      
      private var filterMap:Object = {};
      
      private var itemEventType:String;
      
      private var tabEventType:String;
      
      private var sortOrder:Array = [];
      
      private var filter:String = "";
      
      private var allowDesel:Boolean = false;
      
      private var onDemand:Boolean = false;
      
      private var openBlank:Boolean = false;
      
      private var refreshTabs:Boolean = false;
      
      private var bLimited:Boolean = false;
      
      private var multiSelect:Boolean = false;
      
      private var itemList:Array;
      
      public function LPFFrameListViewTabbed()
      {
         super();
         x = 0;
         y = 0;
         fData = {};
      }
      
      override public function fOpen(param1:Object) : void
      {
         fData = param1.fData;
         itemList = fData.list;
         positionBy(param1.r);
         drawBG();
         if("tabStates" in param1)
         {
            tabStates = param1.tabStates;
         }
         if("filterMap" in param1)
         {
            filterMap = param1.filterMap;
         }
         if("sortOrder" in param1)
         {
            sortOrder = param1.sortOrder;
         }
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("filter" in param1)
         {
            filter = param1.filter;
         }
         if("itemEventType" in param1)
         {
            itemEventType = param1.itemEventType;
         }
         if("tabEventType" in param1)
         {
            tabEventType = param1.tabEventType;
         }
         if("sName" in param1)
         {
            sName = param1.sName;
         }
         if("allowDesel" in param1)
         {
            allowDesel = param1.allowDesel == true;
         }
         if("openBlank" in param1)
         {
            openBlank = param1.openBlank == true;
         }
         if("onDemand" in param1)
         {
            onDemand = param1.onDemand == true;
         }
         if("refreshTabs" in param1)
         {
            refreshTabs = param1.refreshTabs == true;
         }
         if("multiSelect" in param1)
         {
            multiSelect = param1.multiSelect == true;
         }
         if("bLimited" in fData)
         {
            bLimited = param1.fData.bLimited == true;
         }
         if(!openBlank)
         {
            if(iSel == null)
            {
               tSel = getTabByFilter("*");
            }
            else
            {
               tSel = getTabByFilter(iSel.sType);
            }
         }
         initTabs();
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      private function fRefresh(param1:Object) : void
      {
         if("tabStates" in param1)
         {
            tabStates = param1.tabStates;
         }
         if("filterMap" in param1)
         {
            filterMap = param1.filterMap;
         }
         if("sortOrder" in param1)
         {
            sortOrder = param1.sortOrder;
         }
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         if("filter" in param1)
         {
            filter = param1.filter;
         }
         if("itemEventType" in param1)
         {
            itemEventType = param1.itemEventType;
         }
         if("tabEventType" in param1)
         {
            tabEventType = param1.tabEventType;
         }
         if("sName" in param1)
         {
            sName = param1.sName;
         }
         iSel = null;
         tSel = getTabByFilter("*");
         if(fData.list != null)
         {
            itemList = fData.list;
         }
         initTabs();
         fDraw();
      }
      
      private function initTabs() : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Object = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:String = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = {};
         var _loc4_:Array = [];
         var _loc5_:String = "";
         while(tabs.numChildren > 0)
         {
            tabs.removeChildAt(0);
         }
         bgTabs.graphics.clear();
         _loc2_ = 0;
         while(_loc2_ < tabStates.length)
         {
            if(onDemand)
            {
               tabStates[_loc2_].state = 0;
            }
            else
            {
               tabStates[_loc2_].state = -1;
               for each(_loc3_ in fData.list)
               {
                  for(_loc9_ in filterMap)
                  {
                     if(filterMap[_loc9_].indexOf(_loc3_.sType) > -1 || _loc3_.sType == "Enhancement" && _loc3_.sES == _loc9_)
                     {
                        if(tabStates[_loc2_].filter == _loc9_)
                        {
                           tabStates[_loc2_].state = 0;
                        }
                     }
                  }
               }
            }
            _loc2_++;
         }
         _loc4_ = [];
         _loc1_ = 0;
         while(_loc1_ < tabStates.length)
         {
            _loc3_ = tabStates[_loc1_];
            _loc6_ = tabs.addChild(new LPFElementListViewTab()) as MovieClip;
            _loc7_ = getLayout().rootClass.world.getClass(_loc3_.icon);
            _loc8_ = _loc6_.icon.addChild(new _loc7_());
            _loc8_.scaleX = _loc8_.scaleY = 16 / _loc8_.height;
            _loc8_.x -= _loc8_.width / 2;
            _loc8_.y = 2;
            _loc6_.icon.mouseEnabled = false;
            _loc6_.icon.mouseChildren = false;
            _loc6_.o = _loc3_;
            _loc3_.mc = _loc6_;
            _loc6_.bg2.visible = false;
            if(_loc3_ == tSel)
            {
               _loc3_.state = 1;
            }
            if(_loc3_.state == -1)
            {
               _loc6_.icon.alpha = 0.3;
               _loc6_.bg3.visible = true;
               _loc6_.bg2.visible = false;
               _loc6_.bg.visible = false;
               _loc6_.mouseEnabled = false;
               _loc6_.mouseChildren = false;
            }
            else
            {
               _loc6_.bg3.visible = false;
               _loc6_.buttonMode = true;
               if(_loc3_.state == 1)
               {
                  _loc6_.bg.visible = false;
                  _loc6_.bg2.visible = true;
               }
               _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,tabClick,false,0,true);
            }
            _loc6_.x = int((_loc6_.width + 3) * _loc1_) + 1;
            _loc4_.push(_loc6_.getBounds(this.bgTabs));
            _loc1_++;
         }
         drawTabBG();
      }
      
      private function fDraw(param1:Boolean = true) : void
      {
         var _loc8_:String = null;
         var _loc10_:LPFElementListItemItem = null;
         var _loc12_:DisplayObject = null;
         var _loc13_:DisplayObject = null;
         listA = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Object = {};
         while(iList.numChildren > 0)
         {
            LPFElementListItem(iList.getChildAt(0)).fClose();
         }
         if(param1)
         {
            iList.y = bgTabs.height - 1;
         }
         if(tSel == null)
         {
            setMessage("No Tab Selected");
            scr.fOpen({
               "subject":iList,
               "subjectMask":listMask,
               "reset":param1
            });
            return;
         }
         setMessage("");
         if(tSel.filter != "*")
         {
            for each(_loc9_ in itemList)
            {
               if(filterMap[tSel.filter].indexOf(_loc9_.sType) > -1 || _loc9_.sType == "Enhancement" && _loc9_.sES.indexOf(tSel.filter) > -1)
               {
                  if(!(tSel.filter == "pots" && (_loc9_.sLink != "potion" && _loc9_.sLink != "elixir" && _loc9_.sLink != "tonic" && _loc9_.sLink != "scroll")))
                  {
                     _loc5_.push(_loc9_);
                  }
               }
            }
         }
         else
         {
            _loc5_ = itemList;
         }
         if(onDemand && _loc5_.length == 0)
         {
            setMessage("No items of this type");
            scr.fOpen({
               "subject":iList,
               "subjectMask":listMask,
               "reset":param1
            });
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < sortOrder.length)
         {
            _loc2_ = [];
            for each(_loc9_ in _loc5_)
            {
               if(_loc9_.sType == sortOrder[_loc6_])
               {
                  _loc2_.push(_loc9_);
               }
            }
            if(_loc2_.length > 0)
            {
               _loc2_.sortOn(["sName","iLvl"],[undefined,Array.DESCENDING | Array.NUMERIC]);
               listA = listA.concat(_loc2_);
            }
            _loc6_++;
         }
         _loc2_ = [];
         for each(_loc9_ in _loc5_)
         {
            if(listA.indexOf(_loc9_) == -1)
            {
               _loc2_.push(_loc9_);
            }
         }
         if(_loc2_.length > 0)
         {
            _loc2_.sortOn(["sType","sName"]);
            listA = listA.concat(_loc2_);
         }
         var _loc11_:Object = {};
         _loc11_.eventType = itemEventType;
         _loc11_.allowDesel = allowDesel;
         _loc11_.multiSelect = multiSelect;
         _loc11_.bLimited = bLimited && getLayout().sMode == "shopBuy";
         _loc6_ = 0;
         while(_loc6_ < listA.length)
         {
            _loc11_.fData = listA[_loc6_];
            _loc10_ = new LPFElementListItemItem();
            _loc12_ = iList.addChild(_loc10_);
            _loc10_.subscribeTo(this);
            _loc10_.fOpen(_loc11_);
            if(_loc10_.fData == iSel)
            {
               _loc10_.select();
            }
            if(_loc6_ > 0)
            {
               _loc13_ = iList.getChildAt(_loc6_ - 1);
               _loc12_.y = _loc13_.y + _loc13_.height;
            }
            _loc6_++;
         }
         scr.fOpen({
            "subject":iList,
            "subjectMask":listMask,
            "reset":param1
         });
      }
      
      private function getTabByFilter(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         while(_loc3_ < tabStates.length)
         {
            _loc2_ = tabStates[_loc3_];
            if(_loc2_.filter == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         if(tabStates.length > 0 && param1 != "none")
         {
            return tabStates[0];
         }
         return null;
      }
      
      private function tabClick(param1:MouseEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Object = MovieClip(param1.currentTarget).o;
         if(tSel != null)
         {
            tSel.mc.bg.visible = true;
            tSel.mc.bg2.visible = false;
            tSel.state = 0;
         }
         tSel = _loc2_;
         tSel.mc.bg.visible = false;
         tSel.mc.bg2.visible = true;
         tSel.state = 1;
         drawTabBG();
         if(onDemand)
         {
            _loc3_ = {
               "fData":{"types":filterMap[tSel.filter]},
               "eventType":tabEventType,
               "fCaller":sName
            };
            while(iList.numChildren > 0)
            {
               LPFElementListItem(iList.getChildAt(0)).fClose();
            }
            iList.y = bgTabs.height - 1;
            update(_loc3_);
         }
         else
         {
            fDraw();
         }
      }
      
      private function drawTabBG() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Rectangle = null;
         var _loc5_:MovieClip = null;
         var _loc3_:Graphics = bgTabs.graphics;
         var _loc4_:int = bgTabs.bg.height - 1;
         _loc3_.clear();
         _loc3_.lineStyle(0,6710886,1);
         _loc3_.moveTo(0,_loc4_);
         if(tSel != null)
         {
            _loc5_ = tSel.mc;
            if(_loc5_.x > 1)
            {
               _loc3_.lineTo(tSel.mc.x,_loc4_);
            }
            _loc3_.moveTo(tSel.mc.x + tSel.mc.width,_loc4_);
            _loc3_.lineTo(bgList.width,_loc4_);
            bgTabs.bg.x = tSel.mc.x - 1;
            bgTabs.bg.visible = true;
         }
         else
         {
            _loc3_.lineTo(bgList.width,_loc4_);
            bgTabs.bg.visible = false;
         }
      }
      
      private function setMessage(param1:String) : void
      {
         if(param1 != null && param1.length > 0)
         {
            tMsg.text = param1;
            tMsg.visible = true;
         }
         else
         {
            tMsg.text = "";
            tMsg.visible = false;
         }
      }
      
      override public function update(param1:Object) : void
      {
         if(param1.eventType == itemEventType)
         {
            iSel = param1.fData;
         }
         if(param1.eventType == tabEventType)
         {
            iSel = null;
         }
         getLayout().update(param1);
      }
      
      override public function notify(param1:Object) : void
      {
         if(param1.eventType == "sModeSet")
         {
            fData = param1.fData;
            fRefresh(param1);
         }
         if(param1.eventType == "refreshItems")
         {
            if(fData.isBank)
            {
               itemList = getLayout().rootClass.world.bankinfo.items;
            }
            if(itemList.indexOf(iSel) == -1)
            {
               iSel = null;
            }
            fDraw(false);
            if(refreshTabs)
            {
               initTabs();
            }
         }
         if(param1.eventType == "refreshInv")
         {
            itemList = getLayout().rootClass.world.myAvatar.filtered_inventory;
            fDraw(true);
         }
         if(param1.eventType == "refreshBank")
         {
            if(fData.isBank)
            {
               itemList = getLayout().rootClass.world.bankinfo.items;
            }
            fDraw(fData.isBank != null);
         }
         if(param1.eventType == "listItemASel")
         {
            fRefresh(param1);
            if(filter != "")
            {
               shadeListByTypeFilter(param1.fData);
            }
         }
         if(param1.eventType == tabEventType && param1.fData != null)
         {
            if("loadPending" in param1.fData)
            {
               if("msg" in param1.fData)
               {
                  setMessage(param1.fData.msg);
               }
            }
         }
      }
      
      private function shadeListByTypeFilter(param1:Object) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         if(param1.eSel != null)
         {
            _loc3_ = param1.eSel;
         }
         if(param1.iSel != null)
         {
            _loc3_ = param1.iSel;
         }
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < iList.numChildren)
            {
               _loc2_ = iList.getChildAt(_loc4_) as MovieClip;
               if(_loc2_.fData[filter] == _loc3_[filter] && _loc2_.fData.sType != _loc3_.sType)
               {
                  _loc2_.alpha = 1;
                  _loc2_.mouseEnabled = true;
                  _loc2_.mouseChildren = true;
               }
               else
               {
                  _loc2_.alpha = 0.3;
                  _loc2_.mouseEnabled = false;
                  _loc2_.mouseChildren = false;
               }
               _loc4_++;
            }
         }
      }
      
      public function getListItemByiSel() : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < iList.numChildren)
         {
            _loc2_ = MovieClip(iList.getChildAt(_loc1_));
            if(_loc2_.fData == iSel)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function getSelected() : int
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc3_:* = 0;
         while(_loc3_ < iList.numChildren)
         {
            _loc2_ = MovieClip(iList.getChildAt(_loc3_));
            if(_loc2_.sel)
            {
               _loc1_ += 1;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getSelectedItems() : Array
      {
         var _loc2_:MovieClip = null;
         var _loc1_:Array = [];
         var _loc3_:* = 0;
         while(_loc3_ < iList.numChildren)
         {
            _loc2_ = MovieClip(iList.getChildAt(_loc3_));
            if(_loc2_.sel)
            {
               _loc1_.push(_loc2_.fData.ItemID);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function drawBG() : void
      {
         bgList.width = w;
         bgList.height = h - listMask.y + 3;
         bgList.y = listMask.y;
         listMask.width = w;
         listMask.height = h - listMask.y - 0;
         scr.b.height = listMask.height - 2 * scr.a2.height + 1;
         scr.hit.height = scr.b.height;
         scr.hit.alpha = 0;
         scr.a2.y = scr.b.y + scr.b.height + scr.a2.height;
         scr.x = w + 2;
         tMsg.x = Math.round(bgList.width / 2 - tMsg.width / 2);
         tMsg.y = Math.round(bgList.y + (bgList.height / 2 - tMsg.height / 2));
      }
   }
}

