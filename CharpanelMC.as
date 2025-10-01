package
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2601")]
   public class CharpanelMC extends MovieClip
   {
      
      public var bg:MovieClip;
      
      public var cnt:MovieClip;
      
      private var rootClass:MovieClip = stage.getChildAt(0) as MovieClip;
      
      private var world:MovieClip = rootClass.world as MovieClip;
      
      private var mcPopup:MovieClip = rootClass.ui.mcPopup;
      
      private var nextMode:String;
      
      private var uoLeaf:Object = world.myLeaf();
      
      private var uoData:Object = world.myAvatar.objData;
      
      private var sta:Object = uoLeaf.sta;
      
      private var stp:Object = new Object();
      
      private var stu:Object = new Object();
      
      private var stg:Object = new Object();
      
      private var pts:int = -1;
      
      private var upts:int = -1;
      
      private var spendStuC:Array = [1595286,1470895,1410498,1349844,1289447,1229821];
      
      private var spendStpC:Array = [15098368,15432448,15764992,16032000,16364544,16763904];
      
      private var barVal:int = 150;
      
      private var spendStat:String = "none";
      
      private var spendOp:String = "";
      
      private var spendTicks:int = 0;
      
      private var spendVals:Array = [{
         "a":0,
         "b":1
      },{
         "a":30,
         "b":3
      },{
         "a":60,
         "b":9
      }];
      
      private var ttFields:Array = [];
      
      public function CharpanelMC()
      {
         super();
         addFrameScript(0,frame1,4,frame5,11,frame12,24,frame25);
         bg.x = 0;
         bg.btnClose.addEventListener(MouseEvent.MOUSE_DOWN,btnCloseClick,false,0,true);
         bg.tTitle.text = "Class Overview";
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
         var _loc1_:Array = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(MovieClip(this).currentLabel.indexOf("overview") > -1)
         {
            try
            {
               _loc1_ = [cnt.abilities.a1,cnt.abilities.a2,cnt.abilities.a3,cnt.abilities.a4,cnt.abilities.p1,cnt.abilities.p2];
               for each(_loc3_ in _loc1_)
               {
                  _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,rootClass.actIconOver);
                  _loc3_.addEventListener(MouseEvent.MOUSE_OUT,rootClass.actIconOut);
                  _loc3_.actObj = null;
               }
            }
            catch(e:Error)
            {
            }
         }
         bg.btnClose.removeEventListener(MouseEvent.MOUSE_DOWN,btnCloseClick);
         if(parent != null)
         {
            _loc4_ = MovieClip(parent);
            _loc4_.removeChild(this);
            _loc4_.onClose();
            rootClass.stage.focus = null;
         }
      }
      
      private function playNextMode() : void
      {
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
         if(MovieClip(this).currentLabel.indexOf("overview") > -1)
         {
            updateNext();
         }
      }
      
      private function updateNext() : void
      {
         var _loc7_:MovieClip = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc1_:MovieClip = MovieClip(this).cnt;
         var _loc2_:Object = {};
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc6_:Boolean = false;
         _loc1_.tDesc.autoSize = "left";
         _loc1_.tMana.autoSize = "left";
         _loc1_.tClass.text = uoData.strClassName + "  (Rank " + uoData.iRank + ")";
         _loc1_.tDesc.text = uoData.sClassDesc;
         _loc1_.tMana.text = "";
         for each(_loc5_ in uoData.aClassMRM)
         {
            if(_loc5_.charAt(0) == "-")
            {
               _loc1_.tMana.text += " * " + _loc5_.substr(1);
            }
            else
            {
               _loc1_.tMana.text += _loc5_;
            }
         }
         _loc1_.tManaHeader.y = Math.round(_loc1_.tDesc.y + _loc1_.tDesc.height + 5);
         _loc1_.tMana.y = Math.round(_loc1_.tManaHeader.y + _loc1_.tManaHeader.height + 2);
         _loc3_ = Math.round(_loc1_.tMana.y + _loc1_.tMana.height);
         _loc1_.abilities.y = Math.round(_loc3_ + (188 - _loc3_) / 2);
         if(_loc1_.abilities.y > 188)
         {
            _loc1_.abilities.y = 188;
         }
         var _loc8_:* = ["aa","a1","a2","a3","a4","p1","p2","p3"];
         _loc3_ = 0;
         while(_loc3_ < _loc8_.length)
         {
            _loc2_ = _loc8_[_loc3_];
            if(_loc2_ == "p3" && world.actions.passive.length < 3)
            {
               _loc1_.abilities.x = 46;
               _loc1_.abilities.getChildByName("tRank6").visible = false;
               _loc1_.abilities.getChildByName("p3").visible = false;
            }
            else
            {
               _loc7_ = _loc1_.abilities.getChildByName(_loc2_) as MovieClip;
               _loc7_.actionIndex = _loc3_;
               _loc15_ = rootClass.world.getActionByRef(_loc2_);
               if(_loc15_ == null)
               {
                  _loc7_.visible = false;
               }
               else
               {
                  _loc7_.visible = true;
                  _loc7_.tQty.visible = false;
                  rootClass.updateIcons([_loc7_],_loc15_.icon.split(","),null);
                  if(!_loc15_.isOK)
                  {
                     _loc7_.alpha = 0.33;
                  }
                  _loc7_.actObj = _loc15_;
                  _loc7_.addEventListener(MouseEvent.MOUSE_OVER,rootClass.actIconOver,false,0,true);
                  _loc7_.addEventListener(MouseEvent.MOUSE_OUT,rootClass.actIconOut,false,0,true);
               }
            }
            _loc3_++;
         }
         var _loc9_:Graphics = _loc1_.abilities.bg.graphics;
         _loc9_.clear();
         _loc9_.lineStyle(0,0,0);
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Number = 6710886;
         var _loc13_:String = "#FFFFFF";
         var _loc14_:int = world.actions.passive.length < 3 ? 6 : 7;
         _loc10_ = 0;
         while(_loc10_ < _loc14_)
         {
            _loc11_ = _loc10_ * 51;
            _loc12_ = 6710886;
            _loc13_ = "#FFFFFF";
            if(uoData.iRank < _loc10_ + 1)
            {
               _loc12_ = 2368548;
               _loc13_ = "#999999";
               _loc9_.beginFill(_loc12_);
               _loc9_.moveTo(_loc11_,19);
               _loc9_.lineTo(_loc11_ + 50,19);
               _loc9_.lineTo(_loc11_ + 50,127);
               _loc9_.lineTo(_loc11_,127);
               _loc9_.lineTo(_loc11_,19);
               _loc9_.endFill();
            }
            _loc9_.beginFill(_loc12_);
            _loc9_.moveTo(_loc11_,0);
            _loc9_.lineTo(_loc11_ + 50,0);
            _loc9_.lineTo(_loc11_ + 50,18);
            _loc9_.lineTo(_loc11_,18);
            _loc9_.lineTo(_loc11_,0);
            _loc9_.endFill();
            _loc9_.beginFill(_loc12_);
            _loc9_.moveTo(_loc11_,128);
            _loc9_.lineTo(_loc11_ + 50,128);
            _loc9_.lineTo(_loc11_ + 50,132);
            _loc9_.lineTo(_loc11_,132);
            _loc9_.lineTo(_loc11_,128);
            _loc9_.endFill();
            _loc16_ = _loc1_.abilities.getChildByName("tRank" + (_loc10_ + 1));
            if(_loc16_ != null)
            {
               TextField(_loc16_).htmlText = "<font color=\'" + _loc13_ + "\'>" + TextField(_loc16_).text + "</font>";
            }
            _loc10_++;
         }
      }
      
      private function btnCloseClick(param1:MouseEvent) : void
      {
         fClose();
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
   }
}

