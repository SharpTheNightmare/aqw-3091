package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.net.*;
   import flash.text.*;
   import liteAssets.draw.detailedCheck;
   import liteAssets.draw.qRewardPrev;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol732")]
   public class QFrameMC extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      public var world:MovieClip;
      
      public var rootClass:MovieClip;
      
      public var qData:Object = null;
      
      internal var qMode:String = null;
      
      internal var choiceID:int = -1;
      
      internal var isOpen:Boolean = false;
      
      internal var mc:MovieClip;
      
      internal var mDown:Boolean = false;
      
      internal var hRun:int = 0;
      
      internal var dRun:int = 0;
      
      internal var mbY:int = 0;
      
      internal var mhY:int = 0;
      
      internal var mbD:int = 0;
      
      internal var qly:int = 70;
      
      internal var qdy:int = 58;
      
      internal var qla:Array = [];
      
      internal var qlb:Array = [];
      
      public var qIDs:Array = [];
      
      public var sIDs:Array = [];
      
      public var tIDs:Array = [];
      
      internal var rewardCount:int = -1;
      
      public function QFrameMC()
      {
         super();
         addFrameScript(6,frame7,11,frame12,15,frame16);
         mc = MovieClip(this);
         mc.x = 0;
         mc.y = 65;
         mc.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK,xClick);
         mc.cnt.bg.btnTry.visible = false;
         mc.cnt.bg.btnPin.visible = false;
         mc.cnt.bg.btnWiki.visible = false;
      }
      
      public function onPin(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         rootClass.pinnedQuests = "";
         if(!param1.shiftKey)
         {
            for each(_loc2_ in qIDs)
            {
               rootClass.pinnedQuests += _loc2_ + ",";
            }
         }
      }
      
      public function open() : *
      {
         rootClass = MovieClip(this.stage.getChildAt(0));
         mc.cnt.bg.btnPin.addEventListener(MouseEvent.CLICK,onPin,false,0,true);
         mc.cnt.bg.btnWiki.addEventListener(MouseEvent.CLICK,onWiki,false,0,true);
         world = rootClass.world;
         mc = MovieClip(this);
         mc.cnt.bg.fx.visible = false;
         if(rootClass.isDialoqueUp())
         {
            mc.cnt.bg.fx.visible = true;
         }
         if(!isOpen)
         {
            isOpen = true;
            mc.cnt.gotoAndPlay("intro");
         }
         else
         {
            isOpen = false;
            fClose();
         }
      }
      
      public function onWiki(param1:MouseEvent) : void
      {
         if(!qData)
         {
            return;
         }
         navigateToURL(new URLRequest("http://aqwwiki.wikidot.com/search:site/a/p/q/" + qData.sName),"_blank");
      }
      
      public function showQuestList() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         mc.cnt.bg.btnPin.visible = rootClass.litePreference.data.bQuestPin;
         mc.cnt.bg.btnWiki.visible = false;
         if(qMode == "l" && world.getActiveQuests() != "" || qMode == "q")
         {
            if(qMode == "l")
            {
               qIDs = world.getActiveQuests().split(",");
            }
            else
            {
               qIDs = new Array();
               _loc1_ = 0;
               while(_loc1_ < sIDs.length)
               {
                  qIDs.push(sIDs[_loc1_]);
                  _loc1_++;
               }
               _loc2_ = 0;
               while(_loc2_ < tIDs.length)
               {
                  if(Boolean(world.isQuestInProgress(tIDs[_loc2_])) && qIDs.indexOf(tIDs[_loc2_]) == -1)
                  {
                     qIDs.push(tIDs[_loc2_]);
                  }
                  _loc2_++;
               }
            }
            world.checkAllQuestStatus();
            buildQuestList();
         }
         else
         {
            showEmptyList();
         }
         if(mc.cnt.bg.btnPin.visible)
         {
            mc.cnt.strTitle.x = 53;
            mc.cnt.strTitle.width = 256;
         }
         else
         {
            mc.cnt.strTitle.x = 42;
            mc.cnt.strTitle.width = 270;
         }
         if(qMode == "l")
         {
            mc.cnt.strTitle.htmlText = "Current Quests<font color=\"#FF0000\">:</font>";
         }
         if(qMode == "q")
         {
            mc.cnt.strTitle.htmlText = "Available Quests<font color=\"#FF0000\">:</font>";
         }
         mc.cnt.qList.visible = true;
         mc.cnt.qList.mHi.visible = false;
         mc.cnt.mouseChildren = true;
      }
      
      private function isQuestAvailable(param1:Object) : Boolean
      {
         if(param1 != null)
         {
            if(param1.bGuild != null && param1.bGuild == 1)
            {
               if(rootClass.world.myAvatar.objData.guild == null)
               {
                  return false;
               }
               if(param1.iReqRep > 0 && rootClass.world.myAvatar.objData.guild.guildRep < param1.iReqRep)
               {
                  return false;
               }
            }
            if(param1.sField != null && world.getAchievement(param1.sField,param1.iIndex) != 0 || param1.iLvl > world.myAvatar.objData.intLevel || param1.bUpg == 1 && !world.myAvatar.isUpgraded() || param1.iSlot >= 0 && world.getQuestValue(param1.iSlot) < Math.abs(param1.iValue) - 1 || param1.iClass > 0 && world.myAvatar.getCPByID(param1.iClass) < param1.iReqCP || param1.FactionID > 1 && world.myAvatar.getRep(param1.FactionID) < param1.iReqRep)
            {
               return false;
            }
            if(param1.QuestID == 3190 && !world.myAvatar.isUpgraded())
            {
               if(world.getQuestValue(43) < 3)
               {
                  return false;
               }
               if(world.getQuestValue(21) < 26)
               {
                  return false;
               }
               if(world.getQuestValue(22) < 35)
               {
                  return false;
               }
               if(world.getQuestValue(25) < 22)
               {
                  return false;
               }
               if(world.getQuestValue(26) < 23)
               {
                  return false;
               }
               if(world.getQuestValue(27) < 14)
               {
                  return false;
               }
               if(world.getQuestValue(32) < 35)
               {
                  return false;
               }
               if(world.getQuestValue(36) < 28)
               {
                  return false;
               }
               if(world.getQuestValue(51) < 34 && world.getQuestValue(52) < 34)
               {
                  return false;
               }
               if(world.getQuestValue(100) < 15)
               {
                  return false;
               }
               if(world.getQuestValue(117) < 17)
               {
                  return false;
               }
               if(world.getQuestValue(131) < 27)
               {
                  return false;
               }
               if(world.getQuestValue(122) < 35)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      private function getQuestListA() : void
      {
         var _loc2_:* = undefined;
         qla = [];
         var _loc1_:int = 0;
         while(_loc1_ < qIDs.length)
         {
            _loc2_ = world.questTree[qIDs[_loc1_]];
            qla.push(isQuestAvailable(_loc2_));
            _loc1_++;
         }
      }
      
      private function getQuestListB() : void
      {
         var _loc2_:* = undefined;
         qlb = [];
         var _loc1_:int = 0;
         while(_loc1_ < qIDs.length)
         {
            _loc2_ = world.questTree[qIDs[_loc1_]];
            qlb.push(isQuestAvailable(_loc2_));
            _loc1_++;
         }
      }
      
      private function nextQuestAvailable() : Object
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < qIDs.length)
         {
            if(qla[_loc2_] == false && qlb[_loc2_] == true)
            {
               _loc1_ = world.questTree[qIDs[_loc2_]];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function hasRequiredItemsForQuest(param1:Object) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(param1.reqd != null && param1.reqd.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.reqd.length)
            {
               _loc3_ = param1.reqd[_loc2_].ItemID;
               _loc4_ = int(param1.reqd[_loc2_].iQty);
               if(rootClass.world.invTree[_loc3_] == null || int(rootClass.world.invTree[_loc3_].iQty) < _loc4_)
               {
                  return false;
               }
               _loc2_++;
            }
         }
         return true;
      }
      
      private function getQuestValidationString(param1:Object) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = undefined;
         if(param1.sField != null && world.getAchievement(param1.sField,param1.iIndex) != 0)
         {
            if(param1.sField == "im0")
            {
               return "Monthly Quests are only available once per month.";
            }
            if(param1.sField == "iw0")
            {
               return "Weekly Quests reset every Friday morning.";
            }
            return "Daily Quests are only available once per day.";
         }
         if(param1.bUpg == 1 && !world.myAvatar.isUpgraded())
         {
            return "Upgrade is required for this quest!";
         }
         if(param1.iSlot >= 0 && world.getQuestValue(param1.iSlot) < param1.iValue - 1)
         {
            return "Quest has not been unlocked!";
         }
         if(param1.iLvl > world.myAvatar.objData.intLevel)
         {
            return "Unlocks at Level " + param1.iLvl + ".";
         }
         if(param1.iClass > 0 && world.myAvatar.getCPByID(param1.iClass) < param1.iReqCP)
         {
            _loc2_ = int(rootClass.getRankFromPoints(param1.iReqCP));
            _loc3_ = param1.iReqCP - rootClass.arrRanks[_loc2_ - 1];
            if(_loc3_ > 0)
            {
               return "Requires " + _loc3_ + " Class Points on " + param1.sClass + ", Rank " + _loc2_ + ".";
            }
            return "Requires " + (rootClass.litePreference.data.bDebugger ? "(" + param1.iClass + ") " : "") + param1.sClass + ", Rank " + _loc2_ + ".";
         }
         if(param1.FactionID > 1 && world.myAvatar.getRep(param1.FactionID) < param1.iReqRep)
         {
            _loc4_ = int(rootClass.getRankFromPoints(param1.iReqRep));
            _loc5_ = param1.iReqRep - rootClass.arrRanks[_loc4_ - 1];
            if(_loc5_ > 0)
            {
               return "Requires " + _loc5_ + " Reputation for " + param1.sFaction + ", Rank " + _loc4_ + ".";
            }
            return "Requires " + param1.sFaction + ", Rank " + _loc4_ + ".";
         }
         if(param1.reqd != null && !hasRequiredItemsForQuest(param1))
         {
            _loc6_ = "Required Item(s): ";
            _loc7_ = 0;
            while(_loc7_ < param1.reqd.length)
            {
               _loc8_ = world.invTree[param1.reqd[_loc7_].ItemID];
               _loc9_ = int(param1.reqd[_loc7_].iQty);
               if(_loc8_.sES == "ar")
               {
                  _loc10_ = int(rootClass.getRankFromPoints(_loc9_));
                  _loc11_ = _loc9_ - rootClass.arrRanks[_loc10_ - 1];
                  if(_loc11_ > 0)
                  {
                     _loc6_ += _loc11_ + " Class Points on ";
                  }
                  if(rootClass.litePreference.data.bDebugger)
                  {
                     _loc6_ += "(" + param1.reqd[_loc7_].ItemID + ")";
                  }
                  _loc6_ += _loc8_.sName + ", Rank " + _loc10_;
               }
               else
               {
                  if(rootClass.litePreference.data.bDebugger)
                  {
                     _loc6_ += "(" + param1.reqd[_loc7_].ItemID + ")";
                  }
                  _loc6_ += _loc8_.sName;
                  if(_loc9_ > 1)
                  {
                     _loc6_ += "x" + _loc9_;
                  }
               }
               _loc6_ += ", ";
               _loc7_++;
            }
            return _loc6_.substr(0,_loc6_.length - 2) + ".";
         }
         return "";
      }
      
      private function isOneTimeQuestDone(param1:*) : Boolean
      {
         return param1.bOnce == 1 && (param1.iSlot < 0 || world.getQuestValue(param1.iSlot) >= param1.iValue);
      }
      
      private function buildQuestList() : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:String = null;
         var _loc1_:* = 0;
         while(_loc1_ < qIDs.length)
         {
            _loc5_ = world.questTree[qIDs[_loc1_]];
            if(_loc5_ != null && !isOneTimeQuestDone(_loc5_))
            {
               _loc6_ = mc.cnt.qList.addChild(new qProto());
               _loc7_ = rootClass.litePreference.data.bDebugger ? "(" + _loc5_.QuestID + ")" : "";
               if(isQuestAvailable(_loc5_))
               {
                  _loc6_.ti.htmlText = "<font color=\'#009900\'><b>" + _loc7_ + _loc5_.sName + "</b></font>";
               }
               else
               {
                  _loc6_.ti.htmlText = "<font color=\'#990000\'><b>" + _loc7_ + _loc5_.sName + "</b></font>";
               }
               _loc6_.addEventListener(MouseEvent.CLICK,qListClick);
               _loc6_.QuestID = _loc5_.QuestID;
               if(_loc5_.sTyp != null)
               {
                  _loc6_.ti.htmlText += " <font color=\"#888888\">" + _loc5_.sTyp + "</font>";
               }
               if(_loc5_.status != null)
               {
                  switch(_loc5_.status)
                  {
                     case "p":
                        _loc6_.ti.htmlText += "<font color=\'#888888\'> - In progress</font>";
                        break;
                     case "c":
                        _loc6_.ti.htmlText += "<font color=\'#99FF00\'> - <b>Complete!</b></font>";
                  }
               }
               _loc6_.addEventListener(MouseEvent.MOUSE_OVER,iMouseOver,false,0,true);
               _loc6_.addEventListener(MouseEvent.MOUSE_OUT,iMouseOut,false,0,true);
               _loc6_.buttonMode = true;
               _loc6_.hit.alpha = 0;
               _loc6_.y = _loc1_ * 20;
               _loc6_.x = 10;
            }
            _loc1_++;
         }
         var _loc2_:* = mc.cnt.scr;
         var _loc3_:* = mc.cnt.bMask;
         var _loc4_:* = mc.cnt.qList;
         _loc2_.h.height = int(_loc2_.b.height / _loc4_.height * _loc2_.b.height);
         hRun = _loc2_.b.height - _loc2_.h.height;
         dRun = _loc4_.height - _loc2_.b.height + 20;
         _loc2_.h.y = 0;
         _loc4_.oy = _loc4_.y = qly;
         _loc2_.visible = false;
         _loc2_.hit.alpha = 0;
         mDown = false;
         if(_loc4_.height > _loc2_.b.height)
         {
            _loc2_.visible = true;
            _loc2_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
            _loc2_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
            _loc4_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
         }
         mc.cnt.qList.iproto.visible = false;
      }
      
      private function qListClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         qData = world.questTree[_loc2_.QuestID];
         _loc2_.removeEventListener(MouseEvent.CLICK,qListClick);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,iMouseOver);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,iMouseOut);
         mc.cnt.gotoAndPlay("out");
         if(mc.cnt.qList.hasEventListener(Event.ENTER_FRAME))
         {
            mc.cnt.qList.removeEventListener(Event.ENTER_FRAME,dEF);
         }
         mc.cnt.qList.mouseEnabled = false;
         mc.cnt.qList.mouseChildren = false;
      }
      
      private function showEmptyList() : *
      {
         var _loc1_:* = mc.cnt.qList.addChild(new qProto());
         _loc1_.ti.htmlText = "<font color=\"#DDDDDD\">You aren\'t on any quests!</font>";
         _loc1_.hit.alpha = 0;
         _loc1_.x = 10;
         mc.cnt.qList.iproto.visible = false;
         mc.cnt.scr.visible = false;
      }
      
      private function isOwned(param1:Boolean, param2:*) : Boolean
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
      
      public function getCount(param1:String) : int
      {
         var _loc2_:* = undefined;
         if(rewardCount != -1)
         {
            return rewardCount;
         }
         rewardCount = 0;
         for(_loc2_ in qData.oRewards[param1])
         {
            ++rewardCount;
         }
         return rewardCount;
      }
      
      public function showQuestDetail() : *
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:Class = null;
         var _loc18_:MovieClip = null;
         var _loc19_:GlowFilter = null;
         var _loc20_:Array = null;
         var _loc21_:String = null;
         var _loc22_:Object = null;
         var _loc23_:MovieClip = null;
         var _loc24_:Object = null;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:String = null;
         var _loc30_:Object = null;
         var _loc31_:Object = null;
         var _loc32_:Object = null;
         var _loc33_:Class = null;
         var _loc34_:DisplayObject = null;
         var _loc35_:* = undefined;
         var _loc36_:TextFormat = null;
         var _loc37_:* = undefined;
         mc.cnt.bg.btnPin.visible = false;
         mc.cnt.bg.btnWiki.visible = true;
         if(mc.cnt.bg.btnWiki.visible)
         {
            mc.cnt.strTitle.x = 53;
            mc.cnt.strTitle.width = 256;
         }
         else
         {
            mc.cnt.strTitle.x = 42;
            mc.cnt.strTitle.width = 270;
         }
         var _loc1_:int = 0;
         choiceID = -1;
         world.checkAllQuestStatus();
         mc.cnt.mouseChildren = true;
         mc.cnt.strTitle.text = qData.sName;
         var _loc5_:* = mc.cnt.core;
         _loc5_.strNote.autoSize = "left";
         _loc5_.strNote.text = getQuestValidationString(qData);
         _loc5_.strDesc.mouseWheelEnabled = false;
         _loc5_.strReq.mouseWheelEnabled = false;
         _loc5_.rewards.strRew.mouseWheelEnabled = false;
         _loc5_.strDesc.autoSize = "left";
         _loc5_.strReq.autoSize = "left";
         _loc5_.rewards.strRew.autoSize = "left";
         if(qData.status == "c" && tIDs.indexOf(String(qData.QuestID)) >= 0 && qData.sEndText != "")
         {
            _loc5_.strDesc.text = qData.sEndText;
         }
         else
         {
            _loc5_.strDesc.text = qData.sDesc;
         }
         _loc5_.strReq.htmlText = "";
         if(qData.turnin != null && qData.turnin.length > 0)
         {
            _loc13_ = "";
            _loc1_ = 0;
            while(_loc1_ < qData.turnin.length)
            {
               _loc14_ = world.invTree[qData.turnin[_loc1_].ItemID];
               _loc15_ = qData.oItems[qData.turnin[_loc1_].ItemID].sName;
               if(rootClass.litePreference.data.bDebugger)
               {
                  _loc15_ = "(" + qData.turnin[_loc1_].ItemID + ") " + _loc15_;
               }
               _loc16_ = int(qData.turnin[_loc1_].iQty);
               if(_loc1_ > 0)
               {
                  _loc13_ += ",<br>";
               }
               if(_loc14_.iQty < _loc16_)
               {
                  _loc13_ += _loc15_ + " <font color=\"#888888\">" + _loc14_.iQty + "/</font>" + _loc16_;
               }
               else
               {
                  _loc13_ += "<font color=\"#888888\">" + _loc15_ + " " + _loc14_.iQty + "/" + _loc16_ + "</font>";
               }
               _loc1_++;
            }
            _loc5_.strReq.htmlText = _loc13_;
         }
         var _loc6_:* = qData.iGold + "<font color=\"#FFCC00\"> gold</font><br>";
         _loc6_ = _loc6_ + (qData.iExp + "<font color=\"#FF00FF\"> xp</font>");
         if(Boolean(qData.hasOwnProperty("metaValues")) && Boolean(qData.metaValues.hasOwnProperty("freeac")))
         {
            _loc6_ += "<br>" + qData.metaValues.freeac + "<font color=\"#FFCC00\"> ac</font>";
         }
         if(qData.FactionID > 1 && qData.iRep > 0)
         {
            _loc6_ += "<br>" + qData.iRep + " <font color=\'#00FF66\'>rep : " + qData.sFaction + "</font>";
         }
         _loc5_.rewards.strRew.htmlText = _loc6_;
         if(_loc5_.strNote.text == "")
         {
            _loc5_.descTitle.y = 0;
         }
         else
         {
            _loc5_.descTitle.y = _loc5_.strNote.y + _loc5_.strNote.textHeight + 10;
         }
         _loc5_.strDesc.y = _loc5_.descTitle.y + 15;
         _loc5_.reqTitle.y = Math.round(_loc5_.strDesc.y + _loc5_.strDesc.textHeight + 10);
         _loc5_.strReq.y = _loc5_.reqTitle.y + 15;
         _loc5_.rewards.y = Math.round(_loc5_.strReq.y + _loc5_.strReq.textHeight + 10);
         var _loc7_:Number = _loc5_.rewards.y + _loc5_.rewards.height + 15;
         if(qData.oRewards != null)
         {
            _loc17_ = world.getClass("DFrameMCcnt");
            _loc20_ = ["itemsS","itemsC","itemsR","itemsrand"];
            _loc1_ = 0;
            while(_loc1_ < _loc20_.length)
            {
               _loc21_ = _loc20_[_loc1_];
               switch(_loc21_)
               {
                  case "itemsS":
                  default:
                     _loc23_ = _loc5_.rewardsStatic;
                     break;
                  case "itemsC":
                     _loc23_ = _loc5_.rewardsChoice;
                     break;
                  case "itemsR":
                     _loc23_ = _loc5_.rewardsRoll;
                     break;
                  case "itemsrand":
                     _loc23_ = _loc5_.rewardsRandom;
               }
               if(qData.oRewards[_loc21_] == null)
               {
                  _loc23_.visible = false;
               }
               else
               {
                  _loc22_ = qData.oRewards[_loc21_];
                  _loc26_ = 16;
                  for(_loc2_ in _loc22_)
                  {
                     _loc24_ = _loc22_[_loc2_];
                     _loc25_ = int(_loc24_.iQty);
                     _loc18_ = _loc23_.addChild(new _loc17_()) as MovieClip;
                     _loc18_.ItemID = _loc24_.ItemID;
                     _loc18_.strName.autoSize = "left";
                     _loc27_ = rootClass.litePreference.data.bDebugger ? "(" + _loc24_.ItemID + ")" : "";
                     _loc18_.strName.text = _loc27_ + _loc24_.sName;
                     _loc18_.strName.width = _loc18_.strName.textWidth + 6;
                     _loc28_ = "100";
                     if(_loc21_ != "itemsrand")
                     {
                        for each(_loc32_ in qData.reward)
                        {
                           if(_loc32_.ItemID == _loc18_.ItemID && _loc32_.iQty == _loc25_)
                           {
                              _loc28_ = _loc32_.iRate;
                           }
                        }
                     }
                     if(_loc21_ == "itemsrand")
                     {
                        _loc28_ = Number(Number(_loc28_) / getCount(_loc21_)).toFixed(2).toString();
                     }
                     _loc18_.strType.text = _loc28_ ? _loc24_.sType + " (" + _loc28_ + "%)" : _loc24_.sType;
                     _loc18_.strType.width = 100;
                     _loc18_.strRate.visible = false;
                     _loc18_.bg.width = int(_loc18_.strName.textWidth) + 75;
                     if(_loc18_.bg.width < 175)
                     {
                        _loc18_.bg.width = 175;
                     }
                     _loc18_.fx1.width = _loc18_.bg.width;
                     if(_loc25_ > 1)
                     {
                        _loc18_.strQ.text = "x" + _loc25_;
                        _loc18_.strQ.x = _loc18_.bg.width - _loc18_.strQ.width - 7;
                        _loc18_.strQ.visible = true;
                     }
                     else
                     {
                        _loc18_.strQ.x = 0;
                        _loc18_.strQ.visible = false;
                     }
                     _loc19_ = new GlowFilter(world.rarityCA[_loc24_.iRty],1,8,8,2,1,false,false);
                     _loc18_.bg.filters = [_loc19_];
                     _loc18_.icon.removeAllChildren();
                     _loc29_ = "";
                     if(_loc24_.sType.toLowerCase() == "enhancement")
                     {
                        _loc29_ = rootClass.getIconBySlot(_loc24_.sES);
                     }
                     else if(_loc24_.sIcon == null || _loc24_.sIcon == "" || _loc24_.sIcon == "none")
                     {
                        if(_loc24_.sLink.toLowerCase() != "none")
                        {
                           _loc29_ = "iidesign";
                        }
                        else
                        {
                           _loc29_ = "iibag";
                        }
                     }
                     else
                     {
                        _loc29_ = _loc24_.sIcon;
                     }
                     try
                     {
                        _loc33_ = world.getClass(_loc29_) as Class;
                        _loc34_ = _loc18_.icon.addChild(new _loc33_());
                        _loc34_.scaleX = _loc34_.scaleY = 0.5;
                        _loc19_ = new GlowFilter(world.rarityCA[_loc24_.iRty],1,8,8,2,1,false,false);
                        _loc18_.icon.filters = [_loc19_];
                        if(isOwned(_loc24_.bHouse,_loc24_.ItemID))
                        {
                           _loc35_ = _loc18_.icon.addChild(new detailedCheck());
                           _loc35_.width = _loc18_.icon.width;
                           _loc35_.height = _loc18_.icon.height;
                        }
                     }
                     catch(e:Error)
                     {
                     }
                     _loc18_.y = _loc26_;
                     _loc26_ += Math.round(_loc18_.height + 8);
                     if(_loc21_ == "itemsC" && qMode != "l" && qData.status != null && qData.status == "c" && tIDs.indexOf(String(qData.QuestID)) >= 0)
                     {
                        _loc18_.mouseEnabled = true;
                        _loc18_.mouseChildren = false;
                        _loc18_.buttonMode = true;
                        _loc18_.addEventListener(MouseEvent.CLICK,btnRewardClick,false,0,true);
                     }
                     if(_loc24_.bCoins != 1)
                     {
                        _loc18_.fadedAC.visible = false;
                     }
                     else
                     {
                        _loc18_.fadedAC.x = _loc18_.bg.width - 72;
                     }
                     if(_loc24_.bUpg)
                     {
                        _loc36_ = _loc18_.strName.defaultTextFormat;
                        _loc36_.color = 16566089;
                        _loc18_.strName.setTextFormat(_loc36_);
                        _loc36_ = _loc18_.strQ.defaultTextFormat;
                        _loc36_.color = 16566089;
                        _loc18_.strQ.setTextFormat(_loc36_);
                     }
                     for each(_loc31_ in qData.oRewards)
                     {
                        for each(_loc32_ in _loc31_)
                        {
                           if(_loc32_.ItemID == _loc18_.ItemID)
                           {
                              _loc30_ = _loc32_;
                           }
                        }
                     }
                     if(!_loc18_.hasEventListener(MouseEvent.CLICK))
                     {
                        _loc18_.addEventListener(MouseEvent.CLICK,onRewardPreview,false,0,true);
                     }
                  }
               }
               if(_loc23_.visible)
               {
                  _loc23_.y = _loc7_;
                  _loc7_ = _loc23_.y + _loc23_.height + 15;
               }
               _loc1_++;
            }
         }
         rewardCount = -1;
         var _loc8_:* = null;
         var _loc9_:* = {};
         if(qMode != "l")
         {
            if(qData.status == null)
            {
               _loc8_ = mc.cnt.btns.dual;
               mc.cnt.btns.tri.visible = false;
               _loc9_ = {
                  "b1":{
                     "txt":"Accept",
                     "fn":btnAccept
                  },
                  "b2":{
                     "txt":"Decline",
                     "fn":btnBack
                  }
               };
            }
            else if(qData.status == "c" && tIDs.indexOf(String(qData.QuestID)) >= 0)
            {
               _loc8_ = mc.cnt.btns.tri;
               mc.cnt.btns.dual.visible = false;
               _loc9_ = {
                  "b1":{
                     "txt":"Back",
                     "fn":btnBack
                  },
                  "b2":{
                     "txt":"Turn in!",
                     "fn":btnComplete
                  },
                  "b3":{
                     "txt":"Abandon",
                     "fn":btnAbandon
                  }
               };
            }
            else
            {
               _loc8_ = mc.cnt.btns.dual;
               mc.cnt.btns.tri.visible = false;
               _loc9_ = {
                  "b1":{
                     "txt":"Back",
                     "fn":btnBack
                  },
                  "b2":{
                     "txt":"Abandon",
                     "fn":btnAbandon
                  }
               };
            }
         }
         else
         {
            _loc8_ = mc.cnt.btns.dual;
            mc.cnt.btns.tri.visible = false;
            _loc9_ = {
               "b1":{
                  "txt":"Back",
                  "fn":btnBack
               },
               "b2":{
                  "txt":"Abandon",
                  "fn":btnAbandon
               }
            };
         }
         for(_loc10_ in _loc9_)
         {
            _loc37_ = _loc8_[_loc10_];
            _loc37_.buttonMode = true;
            _loc37_.fx.visible = false;
            _loc37_.ti.mouseEnabled = false;
            _loc37_.addEventListener(MouseEvent.MOUSE_OVER,bMouseOver,false,0,true);
            _loc37_.addEventListener(MouseEvent.MOUSE_OUT,bMouseOut,false,0,true);
            _loc37_.ti.text = _loc9_[_loc10_].txt;
            _loc37_.addEventListener(MouseEvent.CLICK,_loc9_[_loc10_].fn,false,0,true);
         }
         _loc11_ = mc.cnt.scr;
         _loc12_ = mc.cnt.bMask;
         _loc11_.h.height = int(_loc11_.b.height / _loc5_.height * _loc11_.b.height);
         hRun = _loc11_.b.height - _loc11_.h.height;
         dRun = _loc5_.height - _loc11_.b.height + 20;
         _loc11_.h.y = 0;
         _loc5_.oy = _loc5_.y = qdy;
         _loc11_.visible = false;
         _loc11_.hit.alpha = 0;
         mDown = false;
         if(_loc5_.height > _loc11_.b.height)
         {
            _loc11_.visible = true;
            _loc11_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
            _loc11_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
            _loc5_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
         }
         mc.cnt.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
      }
      
      private function onRewardPreview(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc5_:Object = null;
         for each(_loc3_ in qData.oRewards)
         {
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_.ItemID == param1.currentTarget.ItemID)
               {
                  _loc2_ = _loc5_;
               }
            }
         }
         if(rootClass.ui.getChildByName("qRewardPrev"))
         {
            rootClass.ui.getChildByName("qRewardPrev").fClose();
         }
         var _loc4_:* = rootClass.ui.addChild(new qRewardPrev(_loc2_));
         _loc4_.world = rootClass.world;
         _loc4_.rootClass = rootClass;
         _loc4_.open();
      }
      
      private function onWheel(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = mc.cnt.scr;
         if(!_loc2_ || !_loc2_.visible)
         {
            return;
         }
         _loc2_.h.y += param1.delta * -1 * 3;
         if(_loc2_.h.y < 0)
         {
            _loc2_.h.y = 0;
         }
         if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
         {
            _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
         }
      }
      
      private function scrDown(param1:MouseEvent) : *
      {
         mbY = int(mouseY);
         mhY = int(MovieClip(param1.currentTarget.parent).h.y);
         mDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,scrUp,false,0,true);
      }
      
      private function scrUp(param1:MouseEvent) : *
      {
         mDown = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,scrUp);
      }
      
      private function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = MovieClip(param1.currentTarget.parent);
            mbD = int(mouseY) - mbY;
            _loc2_.h.y = mhY + mbD;
            if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
            {
               _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
            }
            if(_loc2_.h.y < 0)
            {
               _loc2_.h.y = 0;
            }
         }
      }
      
      private function dEF(param1:Event) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget.parent).scr;
         var _loc3_:* = MovieClip(param1.currentTarget);
         var _loc4_:* = -_loc2_.h.y / hRun;
         var _loc5_:* = int(_loc4_ * dRun) + _loc3_.oy;
         if(Math.abs(_loc5_ - _loc3_.y) > 0.2)
         {
            _loc3_.y += (_loc5_ - _loc3_.y) / 4;
         }
         else
         {
            _loc3_.y = _loc5_;
         }
      }
      
      public function killDetailUI() : *
      {
         if(mc.cnt.core.hasEventListener(Event.ENTER_FRAME))
         {
            mc.cnt.core.removeEventListener(Event.ENTER_FRAME,dEF);
         }
      }
      
      public function turninResult(param1:String) : *
      {
         getQuestListB();
         qData = null;
         if(mc.cnt.currentLabel == "hold")
         {
            if(param1 == "pass")
            {
               qData = nextQuestAvailable();
            }
            mc.cnt.gotoAndPlay("back");
         }
      }
      
      private function xClick(param1:MouseEvent) : *
      {
         fClose();
         if(rootClass.ui.getChildByName("qRewardPrev"))
         {
            rootClass.ui.getChildByName("qRewardPrev").fClose();
         }
      }
      
      public function fClose() : void
      {
         mc.cnt.bg.btnClose.removeEventListener(MouseEvent.CLICK,xClick);
         stage.focus = stage;
         mc.parent.removeChild(mc);
      }
      
      private function btnAccept(param1:MouseEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = getQuestValidationString(qData);
         if(Boolean(qData.hasOwnProperty("sMeta")) && qData.sMeta.indexOf("EmailConfirm") != -1 && world.myAvatar.objData.intActivationFlag < 5)
         {
            rootClass.MsgBox.notify("Confirmed Contact Email Address Required");
         }
         else if(_loc2_ != "")
         {
            MovieClip(Game.root).MsgBox.notify(_loc2_);
         }
         else if(world.coolDown("acceptQuest"))
         {
            _loc3_ = MovieClip(param1.currentTarget);
            setCT(_loc3_.bg,43775);
            _loc3_.removeEventListener(MouseEvent.CLICK,btnAccept);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,bMouseOver);
            _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,bMouseOut);
            world.acceptQuest(qData.QuestID);
            qData = null;
         }
      }
      
      private function btnAbandon(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         world.abandonQuest(qData.QuestID);
         setCT(_loc2_.bg,16711680);
         _loc2_.removeEventListener(MouseEvent.CLICK,btnAbandon);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,bMouseOver);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,bMouseOut);
         qData = null;
         mc.cnt.gotoAndPlay("back");
      }
      
      private function btnComplete(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(Boolean(world.coolDown("tryQuestComplete")) && Boolean(world.canTurnInQuest(qData.QuestID)))
         {
            if(qData.oRewards.itemsC != null && choiceID == -1)
            {
               rootClass.addUpdate("Please choose a reward before turning the quest in!");
               rootClass.chatF.pushMsg("warning","Please choose a reward before turning the quest in!","SERVER","",0);
               return;
            }
            _loc2_ = MovieClip(param1.currentTarget);
            setCT(_loc2_.bg,65280);
            _loc2_.removeEventListener(MouseEvent.CLICK,btnAbandon);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,bMouseOver);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,bMouseOut);
            mc.cnt.gotoAndPlay("hold");
            getQuestListA();
            if(qData.sField == null && world.maximumQuestTurnIns(qData.QuestID) > 1 && qData.bOnce == 0)
            {
               _loc3_ = new ModalMC();
               _loc4_ = {};
               _loc4_.params = {};
               _loc4_.strBody = "Turn-in the quest how many times?";
               _loc4_.callback = onQtyComplete;
               _loc4_.qtySel = {
                  "min":1,
                  "max":world.maximumQuestTurnIns(qData.QuestID),
                  "base":1
               };
               _loc4_.glow = "white,medium";
               _loc4_.greedy = false;
               rootClass.ui.ModalStack.addChild(_loc3_);
               _loc3_.init(_loc4_);
            }
            else
            {
               world.tryQuestComplete(qData.QuestID,choiceID);
            }
         }
      }
      
      private function onQtyComplete(param1:Object) : void
      {
         if(param1.accept)
         {
            world.tryQuestComplete(qData.QuestID,choiceID,false,Number(param1.iQty));
         }
      }
      
      private function btnBack(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         setCT(_loc2_.bg,11184810);
         _loc2_.removeEventListener(MouseEvent.CLICK,btnBack);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,bMouseOver);
         _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,bMouseOut);
         mc.cnt.mouseChildren = false;
         qData = null;
         mc.cnt.gotoAndPlay("back");
      }
      
      private function btnRewardClick(param1:MouseEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:Array = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:MovieClip = _loc2_.parent as MovieClip;
         choiceID = _loc2_.ItemID;
         var _loc6_:int = 1;
         while(_loc6_ < _loc3_.numChildren)
         {
            _loc4_ = _loc3_.getChildAt(_loc6_) as MovieClip;
            _loc5_ = _loc4_.bg.filters;
            if(choiceID == _loc4_.ItemID && _loc5_.length == 1)
            {
               _loc5_.push(new GlowFilter(16763955,1,5,5,2,1,true,false));
               _loc4_.bg.filters = _loc5_;
            }
            if(choiceID != _loc4_.ItemID && _loc5_.length > 1)
            {
               _loc5_.pop();
               _loc4_.bg.filters = _loc5_;
            }
            _loc6_++;
         }
      }
      
      private function bMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.fx.visible = true;
      }
      
      private function bMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.fx.visible = false;
      }
      
      private function setCT(param1:*, param2:*) : *
      {
         var _loc3_:* = param1.transform.colorTransform;
         _loc3_.color = param2;
         param1.transform.colorTransform = _loc3_;
      }
      
      private function iMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.parent.mHi.visible = true;
         _loc2_.parent.mHi.y = _loc2_.y;
      }
      
      private function iMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.parent.mHi.visible = false;
      }
      
      internal function frame7() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
      }
      
      internal function frame16() : *
      {
         fClose();
      }
   }
}

