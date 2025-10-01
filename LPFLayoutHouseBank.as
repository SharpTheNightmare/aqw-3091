package
{
   import flash.display.MovieClip;
   import flash.text.*;
   
   public class LPFLayoutHouseBank extends LPFLayout
   {
      
      public var iSel:Object;
      
      public var bSel:Object;
      
      public var itemsI:Array;
      
      public var itemsB:Array;
      
      public var bankPanel:MovieClip;
      
      public var rootClass:MovieClip;
      
      public var previewPanel:MovieClip;
      
      public function LPFLayoutHouseBank()
      {
         super();
         x = 0;
         y = 0;
         panels = [];
         fData = {};
      }
      
      override public function fOpen(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:MovieClip = null;
         rootClass = MovieClip(stage.getChildAt(0));
         fData = param1.fData;
         sMode = param1.sMode;
         if("itemsI" in fData)
         {
            itemsI = fData.itemsI;
         }
         if("itemsB" in fData)
         {
            itemsB = fData.itemsB;
         }
         _loc2_ = param1.r;
         var _loc3_:String = "";
         x = _loc2_.x;
         y = _loc2_.y;
         w = _loc2_.w;
         h = _loc2_.h;
         _loc4_ = {};
         _loc4_.panel = new LPFPanelHouseBank();
         _loc4_.fData = {
            "itemsI":itemsI,
            "itemsB":itemsB,
            "avatar":rootClass.world.myAvatar,
            "objData":fData.objData
         };
         _loc4_.r = {
            "x":30,
            "y":80,
            "w":900,
            "h":400
         };
         _loc4_.isOpen = true;
         bankPanel = addPanel(_loc4_);
         _loc4_ = {};
         _loc4_.panel = new BankPreview();
         _loc3_ = "Preview";
         _loc4_.fData = {"sName":_loc3_};
         _loc4_.r = {
            "x":357,
            "y":197,
            "w":255,
            "h":204.2
         };
         _loc4_.closeType = "hide";
         _loc4_.isOpen = false;
         previewPanel = addChild(_loc4_.panel) as MovieClip;
         previewPanel.Open(_loc4_);
         previewPanel.visible = false;
         previewPanel.mouseEnabled = false;
         previewPanel.mouseChildren = false;
         rootClass.dropStackBoost();
      }
      
      override public function fClose() : void
      {
         var _loc1_:MovieClip = null;
         rootClass.dropStackReset();
         while(panels.length > 0)
         {
            panels[0].mc.fClose();
            panels.shift();
         }
         if(parent != null)
         {
            _loc1_ = MovieClip(parent);
            _loc1_.removeChild(this);
            _loc1_.onClose();
         }
         rootClass.world.bankinfo.resetSearch();
      }
      
      override protected function handleUpdate(param1:Object) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Boolean = false;
         var _loc4_:Object = iSel;
         var _loc5_:Object = bSel;
         var _loc6_:Object = null;
         if(param1.eventType == "inventorySel")
         {
            iSel = param1.fData;
            if(_loc4_ == iSel)
            {
               iSel = null;
            }
            param1.fData = {"iSel":iSel};
            previewPanel.Show(iSel);
         }
         if(param1.eventType == "bankSel")
         {
            bSel = param1.fData;
            if(_loc5_ == bSel)
            {
               bSel = null;
            }
            param1.fData = {"bSel":bSel};
            previewPanel.Show(bSel);
         }
         if(param1.eventType == "categorySel")
         {
            bSel = null;
            param1.eventType = "refreshBank";
         }
         if(param1.eventType == "refreshBank")
         {
         }
         if(param1.eventType == "refreshInventory")
         {
         }
         if(param1.eventType == "refreshItems")
         {
         }
         if(param1.eventType == "sendBankFromInvRequest")
         {
            rootClass.world.sendBankFromInvRequest(iSel);
            iSel = null;
         }
         if(param1.eventType == "sendBankToInvRequest")
         {
            rootClass.world.sendBankToInvRequest(bSel);
            bSel = null;
         }
         if(param1.eventType == "sendBankSwapInvRequest")
         {
            rootClass.world.sendBankSwapInvRequest(bSel,iSel);
            iSel = null;
            bSel = null;
         }
         if(param1.eventType == "buyBagSlots")
         {
            _loc2_ = true;
            rootClass.world.loadMovieFront(rootClass.bagSpace,"Inline Asset");
            fClose();
         }
         if(param1.eventType == "switchBank")
         {
            rootClass.world.toggleBank();
         }
         if(param1.eventType == "helpAC")
         {
            _loc2_ = true;
            rootClass.world.loadMovieFront("interface/goldAC5.swf","Inline Asset");
         }
         updatePreviewButtons(_loc6_);
         _loc4_ = null;
         _loc5_ = null;
         if(!_loc2_)
         {
            return param1;
         }
         return null;
      }
      
      private function updatePreviewButtons(param1:Object = null, param2:Object = null) : void
      {
         var _loc3_:Object = {};
         if(param1 != null && param2 != null)
         {
            _loc3_ = param2;
         }
         else
         {
            _loc3_.eventType = "previewButton1Update";
            _loc3_.fData = {};
            _loc3_.fData.sText = "";
            _loc3_.sMode = "grey";
            _loc3_.buttonNewEventType = "";
            if(iSel != null && bSel == null)
            {
               _loc3_.fData.sText = "< To Bank";
               _loc3_.buttonNewEventType = "sendBankFromInvRequest";
               _loc3_.sMode = "red";
            }
            else if(iSel == null && bSel != null)
            {
               _loc3_.fData.sText = "To Inventory >";
               _loc3_.buttonNewEventType = "sendBankToInvRequest";
               _loc3_.sMode = "red";
            }
            else if(iSel != null && bSel != null)
            {
               _loc3_.fData.sText = "< Swap >";
               _loc3_.buttonNewEventType = "sendBankSwapInvRequest";
               _loc3_.sMode = "red";
            }
            else
            {
               _loc3_.fData.sText = "";
               _loc3_.buttonNewEventType = "";
            }
         }
         notifyByEventType(_loc3_);
      }
      
      public function getTabStates(param1:Object = null, param2:Array = null) : Array
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc3_:Array = [{
            "sTag":"Show All",
            "icon":"iipack",
            "state":-1,
            "filter":"*",
            "mc":{}
         },{
            "sTag":"Show only houses",
            "icon":"ihhouse",
            "state":-1,
            "filter":"House",
            "mc":{}
         },{
            "sTag":"Show only walls",
            "icon":"ihwall",
            "state":-1,
            "filter":"Wall Item",
            "mc":{}
         },{
            "sTag":"Show only floors",
            "icon":"ihfloor",
            "state":-1,
            "filter":"Floor Item",
            "mc":{}
         }];
         if(param2 != null)
         {
            for each(_loc4_ in param2)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc5_].filter == _loc4_)
                  {
                     _loc3_.splice(_loc5_--,1);
                  }
                  _loc5_++;
               }
            }
         }
         if(param1 != null)
         {
            for each(_loc6_ in _loc3_)
            {
               if(_loc6_.filter == param1.sType)
               {
                  return [_loc6_];
               }
            }
            return [_loc3_[0]];
         }
         return _loc3_;
      }
   }
}

