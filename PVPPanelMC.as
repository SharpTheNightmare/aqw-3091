package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2577")]
   public class PVPPanelMC extends MovieClip
   {
      
      public var btnClose:SimpleButton;
      
      public var cnt:MovieClip;
      
      private var rootClass:MovieClip = stage.getChildAt(0) as MovieClip;
      
      private var world:MovieClip = rootClass.world as MovieClip;
      
      private var mcPopup:MovieClip = rootClass.ui.mcPopup;
      
      private var nextMode:String;
      
      private var uoLeaf:Object = world.myLeaf();
      
      private var uoData:Object = world.myAvatar.objData;
      
      private var itemSel:MovieClip;
      
      private var pending:Boolean = false;
      
      public function PVPPanelMC()
      {
         super();
         addFrameScript(0,frame1,4,frame5,11,frame12,24,frame25,29,frame30,36,frame37,49,frame50);
         btnClose.addEventListener(MouseEvent.MOUSE_DOWN,btnCloseClick,false,0,true);
      }
      
      public function openWith(param1:Object) : void
      {
         nextMode = param1.typ;
         if(isValidMode(nextMode))
         {
            if(this.currentLabel != "init" && this.currentLabel.indexOf("-out") < 0)
            {
               this.gotoAndPlay(this.currentLabel + "-out");
            }
            else
            {
               this.gotoAndPlay(nextMode);
            }
         }
      }
      
      public function fClose() : void
      {
         killCurrentListeners();
      }
      
      private function playNextMode() : void
      {
         killCurrentListeners();
         this.gotoAndPlay(nextMode);
      }
      
      private function isValidMode(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this.currentLabels.length && !_loc2_)
         {
            if(this.currentLabels[_loc3_].name == param1)
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function update() : void
      {
         if(MovieClip(this).currentLabel == "maps")
         {
            updateMaps();
         }
         if(MovieClip(this).currentLabel == "results")
         {
            updateResults();
         }
      }
      
      private function updateMaps() : void
      {
         var _loc1_:Object = null;
         var _loc2_:MovieClip = null;
         _loc1_ = {};
         while(cnt.iList.numChildren > 1)
         {
            cnt.iList.removeChildAt(1);
         }
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < world.PVPMaps.length)
         {
            _loc1_ = world.PVPMaps[_loc4_];
            if(!_loc1_.hidden)
            {
               _loc2_ = cnt.iList.addChild(new pvpProto());
               _loc2_.t1.ti.text = _loc1_.nam;
               _loc2_.t2.ti.text = _loc1_.desc;
               _loc2_.icon.gotoAndStop(_loc1_.icon);
               _loc2_.y = _loc3_ * 55;
               _loc2_.iSel = false;
               _loc2_.iHi = false;
               _loc2_.label = _loc1_.label;
               _loc2_.warzone = _loc1_.warzone;
               _loc2_.hit.alpha = 0;
               _loc2_.hit.buttonMode = true;
               _loc2_.hit.addEventListener(MouseEvent.CLICK,onMapItemClick,false,0,true);
               _loc2_.hit.addEventListener(MouseEvent.MOUSE_OVER,onMapItemOver,false,0,true);
               _loc2_.hit.addEventListener(MouseEvent.MOUSE_OUT,onMapItemOut,false,0,true);
               _loc3_++;
            }
            _loc4_++;
         }
         cnt.iList.iproto.visible = false;
         cnt.body.bJoin.addEventListener(MouseEvent.MOUSE_DOWN,btnJoinClick,false,0,true);
         cnt.body.bExit.addEventListener(MouseEvent.MOUSE_DOWN,btnExitClick,false,0,true);
         cnt.body.bJoin.visible = false;
         cnt.body.bExit.visible = false;
         cnt.body.msg.visible = false;
         cnt.body.gotoAndPlay("init");
      }
      
      private function updateResults() : void
      {
         var _loc1_:Object = world.PVPResults;
         var _loc2_:int = int(_loc1_.team);
         if(_loc2_ == world.myAvatar.dataLeaf.pvpTeam)
         {
            cnt.outlineV.visible = true;
            cnt.outlineL.visible = false;
         }
         else
         {
            cnt.outlineV.visible = false;
            cnt.outlineL.visible = true;
         }
         if(world.PVPFactions.length == 0)
         {
            cnt.ti.text = _loc2_ == world.myAvatar.dataLeaf.pvpTeam ? "You won!" : "You lost!";
         }
         else
         {
            cnt.ti.text = "The " + world.PVPFactions[_loc2_].sName + " team won!";
         }
         cnt.back_txt.mouseEnabled = false;
         var _loc3_:String = world.strAreaName;
         if(_loc3_.indexOf("dage1v1") != -1 || _loc3_.indexOf("dagepvp") != -1)
         {
            cnt.back_txt.text = "Legion PvP";
         }
         else if(_loc3_.indexOf("deathpitbrawl") != -1)
         {
            cnt.back_txt.text = "Deathpit Arena";
         }
         else
         {
            cnt.back_txt.text = "Doom Arena";
         }
         cnt.btnBack.addEventListener(MouseEvent.CLICK,btnBackClick,false,0,true);
      }
      
      private function onMapItemClick(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:MovieClip = param1.currentTarget.parent as MovieClip;
         _loc2_.iHi = false;
         if(!_loc2_.iSel)
         {
            itemSel = _loc2_;
            _loc2_.iSel = true;
            _loc2_.gotoAndPlay("in2");
         }
         var _loc4_:int = 1;
         while(_loc4_ < cnt.iList.numChildren)
         {
            _loc3_ = cnt.iList.getChildAt(_loc4_) as MovieClip;
            if(_loc3_ != _loc2_)
            {
               if(_loc3_.iSel)
               {
                  _loc3_.gotoAndPlay("out2");
               }
               if(_loc3_.iHi)
               {
                  _loc3_.gotoAndPlay("out1");
               }
               _loc3_.iSel = false;
               _loc3_.iHi = false;
            }
            _loc4_++;
         }
         cnt.body.gotoAndStop(_loc2_.label);
      }
      
      private function onMapItemOver(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:MovieClip = param1.currentTarget.parent as MovieClip;
         if(!_loc2_.iHi && !_loc2_.iSel)
         {
            _loc2_.iHi = true;
            _loc2_.gotoAndPlay("in1");
         }
         var _loc4_:int = 1;
         while(_loc4_ < cnt.iList.numChildren)
         {
            _loc3_ = cnt.iList.getChildAt(_loc4_) as MovieClip;
            if(_loc3_ != _loc2_)
            {
               if(Boolean(_loc3_.iHi) && !_loc3_.iSel)
               {
                  _loc3_.gotoAndPlay("out1");
               }
               _loc3_.iHi = false;
            }
            _loc4_++;
         }
      }
      
      private function onMapItemOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget.parent as MovieClip;
         if(Boolean(_loc2_.iHi) && !_loc2_.iSel)
         {
            _loc2_.iHi = false;
            _loc2_.gotoAndPlay("out1");
         }
      }
      
      public function updateBody() : void
      {
         var _loc1_:MovieClip = cnt.body;
         if(pending)
         {
            pending = false;
         }
         if(itemSel.warzone != world.PVPQueue.warzone)
         {
            _loc1_.bJoin.visible = true;
            _loc1_.msg.visible = false;
            _loc1_.bExit.visible = false;
         }
         else
         {
            _loc1_.bJoin.visible = false;
            _loc1_.msg.visible = true;
            _loc1_.bExit.visible = true;
         }
      }
      
      private function killCurrentListeners() : void
      {
         if(this.currentLabel == "maps")
         {
            cnt.body.bJoin.removeEventListener(MouseEvent.MOUSE_DOWN,btnJoinClick);
            cnt.body.bExit.removeEventListener(MouseEvent.MOUSE_DOWN,btnExitClick);
         }
         if(this.currentLabel == "results")
         {
            cnt.btnBack.removeEventListener(MouseEvent.CLICK,btnBackClick);
         }
         btnClose.removeEventListener(MouseEvent.MOUSE_DOWN,btnCloseClick);
      }
      
      private function btnCloseClick(param1:MouseEvent = null) : void
      {
         mcPopup.onClose();
      }
      
      private function btnJoinClick(param1:MouseEvent) : void
      {
         if(!pending)
         {
            pending = true;
            world.requestPVPQueue(itemSel.warzone);
         }
      }
      
      private function btnExitClick(param1:MouseEvent) : void
      {
         if(!pending)
         {
            pending = true;
            world.requestPVPQueue("none");
         }
      }
      
      private function btnBackClick(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = world.strAreaName;
         if(_loc2_.indexOf("dage1v1") != -1 || _loc2_.indexOf("dagepvp") != -1)
         {
            _loc3_ = "legionpvp";
         }
         else if(_loc2_.indexOf("deathpitbrawl") != -1)
         {
            _loc3_ = "deathpitarena";
         }
         else
         {
            _loc3_ = "doomarena";
         }
         world.gotoTown(_loc3_,"Enter","Spawn");
         mcPopup.onClose();
      }
      
      internal function frame1() : *
      {
         openWith(MovieClip(parent).fData);
      }
      
      internal function frame5() : *
      {
         update();
      }
      
      internal function frame12() : *
      {
         stop();
      }
      
      internal function frame25() : *
      {
         playNextMode();
      }
      
      internal function frame30() : *
      {
         update();
      }
      
      internal function frame37() : *
      {
         stop();
      }
      
      internal function frame50() : *
      {
         playNextMode();
      }
   }
}

