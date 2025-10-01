package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1971")]
   public class LPFFrameEnhText extends LPFFrame
   {
      
      public var mcStats:MovieClip;
      
      public var tDesc:TextField;
      
      private var iSel:Object;
      
      private var eSel:Object;
      
      private var iEnh:Object;
      
      private var eEnh:Object;
      
      private var rootClass:MovieClip;
      
      private var curItem:Object;
      
      internal var mcContainer:MovieClip;
      
      internal var boostsObj:Object;
      
      public function LPFFrameEnhText()
      {
         super();
         mcStats.sproto.visible = false;
      }
      
      override public function fOpen(param1:Object) : void
      {
         rootClass = MovieClip(stage.getChildAt(0));
         positionBy(param1.r);
         iEnh = null;
         eEnh = null;
         if("eventTypes" in param1)
         {
            eventTypes = param1.eventTypes;
         }
         fDraw();
         getLayout().registerForEvents(this,eventTypes);
      }
      
      override public function fClose() : void
      {
         var _loc1_:DisplayObject = null;
         while(mcStats.numChildren > 1)
         {
            _loc1_ = mcStats.getChildAt(1);
            mcStats.removeChildAt(1);
         }
         getLayout().unregisterFrame(this);
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      protected function fDraw() : void
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Object = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc1_:* = "";
         var _loc2_:String = "#00CCFF";
         if(iSel != null)
         {
            _loc1_ = "<font size=\'10\' color=\'#FFFFFF\'>Enhancement: </font>";
            if(["Weapon","he","ar","ba"].indexOf(iSel.sES) > -1)
            {
               rootClass.world.initPatternTree();
               iEnh = null;
               eEnh = null;
               if(iSel.PatternID != null)
               {
                  iEnh = rootClass.world.enhPatternTree[iSel.PatternID];
               }
               if(iSel.EnhPatternID != null)
               {
                  iEnh = rootClass.world.enhPatternTree[iSel.EnhPatternID];
               }
               if(eSel != null)
               {
                  if(eSel.sES == iSel.sES)
                  {
                     if(eSel.PatternID != null)
                     {
                        eEnh = rootClass.world.enhPatternTree[eSel.PatternID];
                     }
                     if(eSel.EnhPatternID != null)
                     {
                        eEnh = rootClass.world.enhPatternTree[eSel.EnhPatternID];
                     }
                     _loc1_ += "<font size=\'11\' color=\'" + _loc2_ + "\'>" + rootClass.getDisplayEnhName(eEnh);
                     if(eSel.iRty > 1)
                     {
                        _loc1_ += " +" + (eSel.iRty - 1);
                     }
                     if(eEnh && eEnh.hasOwnProperty("DIS") && Boolean(eEnh["DIS"]))
                     {
                        _loc1_ += ", " + rootClass.getDisplayEnhTraitName(eEnh);
                     }
                     _loc1_ += "</font>";
                     _loc1_ += "<font size=\'11\' color=\'#FFFFFF\'> vs. </font>";
                     _loc2_ = "#999999";
                     if(iEnh != null)
                     {
                        if(iEnh.hasOwnProperty("DIS"))
                        {
                           _loc1_ += "<font size=\'11\' color=\'" + _loc2_ + "\'>Forge";
                        }
                        else
                        {
                           _loc1_ += "<font size=\'11\' color=\'" + _loc2_ + "\'>" + iEnh.sName;
                        }
                        if(iSel.EnhRty > 1)
                        {
                           _loc1_ += " +" + (iSel.EnhRty - 1);
                        }
                        if(Boolean(iEnh.hasOwnProperty("DIS")) && Boolean(iEnh["DIS"]))
                        {
                           _loc1_ += ", " + rootClass.getDisplayEnhTraitName(iEnh);
                        }
                        _loc1_ += "</font>";
                     }
                     else
                     {
                        _loc1_ += "<font size=\'10\' color=\'#00CCFF\'>No enhancement</font>";
                     }
                  }
                  else
                  {
                     _loc1_ += "<font size=\'11\' color=\'#00CCFF\'>Enhancement type must match item slot!</font>";
                  }
               }
               else if(iEnh != null)
               {
                  _loc1_ += "<font size=\'10\' color=\'" + _loc2_ + "\'>" + rootClass.getDisplayEnhName(iEnh);
                  if("EnhRty" in iSel && iSel.EnhRty > 1)
                  {
                     _loc1_ += " +" + (iSel.EnhRty - 1);
                  }
                  else if("iRty" in iSel && iSel.iRty < 10 && iSel.iRty > 1)
                  {
                     _loc1_ += " +" + (iSel.iRty - 1);
                  }
                  if(Boolean(iSel.ProcID) && !iEnh.hasOwnProperty("DIS"))
                  {
                     switch(iSel.ProcID)
                     {
                        case 2:
                           _loc4_ = "Spiral Carve";
                           break;
                        case 3:
                           _loc4_ = "Awe Blast";
                           break;
                        case 4:
                           _loc4_ = "Health Vamp";
                           break;
                        case 5:
                           _loc4_ = "Mana Vamp";
                           break;
                        case 6:
                           _loc4_ = "Powerword DIE";
                           break;
                        case 7:
                           _loc4_ = "Lacerate";
                           break;
                        case 8:
                           _loc4_ = "Smite";
                           break;
                        case 9:
                           _loc4_ = "Valiance";
                           break;
                        case 10:
                           _loc4_ = "Arcana\'s Concerto";
                           break;
                        case 11:
                           _loc4_ = "Acheron";
                           break;
                        case 12:
                           _loc4_ = "Elysium";
                           break;
                        case 13:
                           _loc4_ = "Praxis";
                           break;
                        case 14:
                           _loc4_ = "Dauntless";
                           break;
                        case 15:
                           _loc4_ = "Ravenous";
                           break;
                        default:
                           _loc4_ = "Unknown";
                     }
                     _loc1_ += ", " + _loc4_;
                  }
                  else if(Boolean(iEnh.hasOwnProperty("DIS")) && Boolean(iEnh["DIS"]))
                  {
                     _loc1_ += ", " + rootClass.getDisplayEnhTraitName(iEnh);
                  }
                  _loc1_ += "</font>";
               }
               else
               {
                  _loc1_ += "<font size=\'11\' color=\'#00CCFF\'>No enhancement</font>";
               }
               if(iSel.sType.toLowerCase() == "enhancement")
               {
                  _loc1_ += " <font size=\'11\' color=\'#FFFFFF\'>imbues an item with: </font>";
               }
               _loc3_ = rootClass.copyObj(iSel);
               if(eSel != null)
               {
                  _loc3_ = rootClass.copyObj(eSel);
                  if(iSel != null)
                  {
                     _loc3_.sType = iSel.sType;
                     if("EnhRty" in iSel)
                     {
                        _loc3_.EnhRty = iSel.EnhRty;
                     }
                     if("iRng" in iSel)
                     {
                        _loc3_.iRng = iSel.iRng;
                     }
                     else
                     {
                        _loc3_.iRng = 10;
                     }
                  }
               }
               if(_loc3_.sES.toLowerCase() == "weapon")
               {
                  _loc5_ = _loc3_.sType.toLowerCase() == "enhancement";
                  if(_loc5_)
                  {
                     _loc6_ = Number(_loc3_.iDPS);
                  }
                  else if("EnhDPS" in _loc3_)
                  {
                     _loc6_ = Number(_loc3_.EnhDPS);
                  }
                  else if(eSel != null && "iDPS" in eSel)
                  {
                     _loc6_ = Number(eSel.iDPS);
                  }
                  else
                  {
                     _loc6_ = -1;
                  }
                  if(_loc6_ == 0)
                  {
                     _loc6_ = 100;
                  }
                  if(_loc6_ == -1)
                  {
                     _loc6_ = 100;
                  }
                  _loc6_ /= 100;
                  _loc7_ = "iRng" in _loc3_ ? Number(_loc3_.iRng) : 0;
                  _loc7_ = _loc7_ / 100;
                  _loc8_ = 0;
                  if("iRty" in _loc3_)
                  {
                     _loc8_ = _loc3_.iRty - 1;
                  }
                  if("EnhRty" in _loc3_)
                  {
                     _loc8_ = _loc3_.EnhRty - 1;
                  }
                  if(_loc5_)
                  {
                     _loc9_ = int(_loc3_.iLvl);
                  }
                  else if("EnhLvl" in _loc3_)
                  {
                     _loc9_ = int(_loc3_.EnhLvl);
                  }
                  else if(eSel != null && "iLvl" in eSel)
                  {
                     _loc9_ = int(eSel.iLvl);
                  }
                  else
                  {
                     _loc9_ = int(iSel.iLvl);
                  }
                  _loc10_ = int(rootClass.getBaseHPByLevel(_loc9_ + _loc8_));
                  _loc11_ = 20;
                  _loc12_ = 2;
                  _loc13_ = Math.round(_loc10_ / _loc11_ * _loc6_ * rootClass.PCDPSMod);
                  _loc14_ = Math.round(_loc13_ * _loc12_);
                  _loc15_ = rootClass.world.getAutoAttack();
                  _loc14_ *= _loc15_.damage;
                  _loc16_ = Math.floor(_loc14_ - _loc14_ * _loc7_);
                  _loc17_ = Math.ceil(_loc14_ + _loc14_ * _loc7_);
                  if(_loc3_.sType.toLowerCase() == "enhancement" || ("EnhLvl" in _loc3_ || eSel != null))
                  {
                     _loc1_ += "<br><font color=\'#FFFFFF\'>" + _loc13_ + " DPS";
                  }
                  if(_loc3_.sType.toLowerCase() != "enhancement" && ("EnhLvl" in _loc3_ || eSel != null))
                  {
                     _loc1_ += " ( <font color=\'#999999\'>" + _loc16_ + "-" + _loc17_ + ", " + rootClass.numToStr(_loc15_.cd / 1000,1) + " speed</font> )</font>";
                  }
               }
            }
            else
            {
               _loc1_ += "<font size=\'10\' color=\'#00CCFF\'>This item cannot be enhanced.</font>";
               if(iSel.sES == "pe" || iSel.sES == "co" || iSel.sES == "am" || iSel.sType.toLowerCase() == "item" && iSel.sLink != null && iSel.sLink != "")
               {
               }
            }
            tDesc.htmlText = _loc1_;
            showStats();
         }
         else
         {
            if(MovieClip(getLayout()).iSel != null && !rootClass.doIHaveEnhancements())
            {
               tDesc.htmlText = "<font color=\'#FF0000\'>You need an Enhancement!</font><br>";
               tDesc.htmlText += "<font color=\'#FFFFFF\'>No enhancments for this type of item were found in your backpack. Enhancements are used to power up your item. You can buy at shops or find them on monsters.</font>";
            }
            else
            {
               tDesc.htmlText = "No item selected.";
            }
            showStats();
         }
         tDesc.x = 2;
         tDesc.y = 7;
         mcStats.x = 13;
         mcStats.y = tDesc.y - 1;
      }
      
      override public function notify(param1:Object) : void
      {
         if(param1.eventType != "showItemListB")
         {
            if(param1.eventType == "refreshItems")
            {
               if(iSel != param1.fData.iSel && iSel != param1.fData.eSel)
               {
                  iSel = null;
                  eSel = null;
               }
            }
            else if(param1.eventType == "clearState")
            {
               iSel = null;
               eSel = null;
            }
            else
            {
               iSel = param1.fData.iSel;
               eSel = param1.fData.eSel;
               if(iSel == null && eSel != null)
               {
                  iSel = eSel;
                  eSel = null;
               }
            }
         }
         fDraw();
      }
      
      private function showStats() : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc10_:MovieClip = null;
         var _loc11_:Object = null;
         var _loc12_:Boolean = false;
         var _loc13_:Array = null;
         var _loc14_:MovieClip = null;
         var _loc15_:String = null;
         var _loc16_:* = undefined;
         var _loc17_:int = 0;
         var _loc18_:* = undefined;
         var _loc19_:String = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:MovieClip = null;
         var _loc23_:MovieClip = null;
         var _loc24_:MovieClip = null;
         var _loc25_:MovieClip = null;
         while(mcStats.numChildren > 1)
         {
            mcStats.removeChildAt(1);
         }
         mcStats.sproto.x = 0;
         mcStats.sproto.y = tDesc.textHeight + 8;
         var _loc1_:* = eSel != null;
         _loc4_ = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = "";
         var _loc9_:Class = mcStats.sproto.constructor as Class;
         if(iSel != null && ((iEnh != null || eEnh != null) && (eSel == null || eSel.sES == iSel.sES) || _loc1_ && eSel.sES == iSel.sES))
         {
            if(_loc1_ && iEnh != null)
            {
               _loc2_ = rootClass.getStatsA(eSel,iSel.sES);
               _loc3_ = rootClass.getStatsA(iSel,iSel.sES);
            }
            else
            {
               _loc11_ = rootClass.copyObj(iSel);
               if(_loc1_)
               {
                  _loc11_.EnhPatternID = eSel.PatternID;
                  _loc11_.EnhLvl = eSel.iLvl;
                  _loc11_.EnhRty = eSel.iRty;
                  _loc1_ = false;
               }
               _loc2_ = rootClass.getStatsA(_loc11_,iSel.sES);
            }
            _loc4_ = 0;
            while(_loc4_ < rootClass.orderedStats.length)
            {
               _loc8_ = rootClass.orderedStats[_loc4_];
               _loc7_ = 0;
               if(_loc1_ && _loc3_["$" + _loc8_] != null && _loc2_["$" + _loc8_] == null)
               {
                  _loc2_["$" + _loc8_] = 0;
               }
               if(_loc2_["$" + _loc8_] != null)
               {
                  _loc10_ = new _loc9_();
                  _loc6_ = int(_loc2_["$" + _loc8_]);
                  _loc10_.tSta.text = rootClass.getFullStatName(_loc8_).toUpperCase();
                  _loc10_.tOldval.visible = false;
                  if(_loc1_)
                  {
                     if(_loc3_["$" + _loc8_] != null)
                     {
                        _loc7_ = int(_loc3_["$" + _loc8_]);
                     }
                     _loc10_.tOldval.text = "(" + _loc7_ + ")";
                     _loc10_.tOldval.visible = true;
                     _loc10_.tVal.text = _loc6_;
                  }
                  else
                  {
                     _loc10_.tVal.text = _loc6_;
                  }
                  _loc10_.tOldval.x = _loc10_.tVal.x + _loc10_.tVal.textWidth + 3;
                  _loc10_.x = mcStats.sproto.x + _loc5_ % 3 * 100;
                  _loc10_.y = mcStats.sproto.y + Math.floor(_loc5_ / 3) * 16;
                  _loc10_.hit.alpha = 0;
                  _loc10_.name = "t" + _loc8_;
                  mcStats.addChild(_loc10_);
                  _loc5_++;
               }
               _loc4_++;
            }
            mcStats.visible = true;
         }
         else
         {
            mcStats.visible = false;
         }
         if(Boolean(mcContainer) && Boolean(getChildByName("mcContainer")))
         {
            removeChild(getChildByName("mcContainer"));
         }
         if(Boolean(mcContainer) && Boolean(mcStats.getChildByName("mcContainer")))
         {
            mcStats.removeChild(mcStats.getChildByName("mcContainer"));
         }
         if(iSel != null && iSel.sMeta != null && !(iSel.sMeta is Number) && iSel.sMeta.indexOf(":") > -1)
         {
            _loc12_ = false;
            switch(iSel.sES)
            {
               case "he":
               case "ba":
               case "Weapon":
               case "pe":
               case "co":
               case "mi":
                  _loc12_ = true;
            }
            if(!_loc12_)
            {
               return;
            }
            boostsObj = {};
            mcContainer = new boostsContainer();
            iEnh = null;
            if(iSel.PatternID != null)
            {
               iEnh = rootClass.world.enhPatternTree[iSel.PatternID];
            }
            if(iSel.EnhPatternID != null)
            {
               iEnh = rootClass.world.enhPatternTree[iSel.EnhPatternID];
            }
            if(iEnh)
            {
               mcStats.addChild(mcContainer);
               mcContainer.name = "mcContainer";
               mcContainer.x = -13;
               mcContainer.y = mcStats.height - 8;
            }
            else
            {
               addChild(mcContainer);
               mcContainer.name = "mcContainer";
               mcContainer.x = -2;
               mcContainer.y = 20;
            }
            while(mcContainer.numChildren > 0)
            {
               mcContainer.removeChildAt(0);
            }
            _loc13_ = iSel.sMeta.split(",");
            _loc14_ = new damageBoost();
            if(!boostsObj["dmgBoost"])
            {
               boostsObj["dmgBoost"] = "";
            }
            for each(_loc16_ in _loc13_)
            {
               _loc19_ = _loc16_.split(":")[1];
               _loc15_ = Math.round((Number(_loc19_) - 1) * 100).toString();
               switch(_loc16_.split(":")[0].toLowerCase())
               {
                  case "dmgall":
                     boostsObj["dmgBoost"] += "All +" + _loc15_ + "%\n";
                     break;
                  case "undead":
                     boostsObj["dmgBoost"] += "Undead +" + _loc15_ + "%\n";
                     break;
                  case "human":
                     boostsObj["dmgBoost"] += "Human +" + _loc15_ + "%\n";
                     break;
                  case "chaos":
                     boostsObj["dmgBoost"] += "Chaos +" + _loc15_ + "%\n";
                     break;
                  case "dragonkin":
                     boostsObj["dmgBoost"] += "Dragonkin +" + _loc15_ + "%\n";
                     break;
                  case "orc":
                     boostsObj["dmgBoost"] += "Orc +" + _loc15_ + "%\n";
                     break;
                  case "drakath":
                     boostsObj["dmgBoost"] += "Drakath +" + _loc15_ + "%\n";
                     break;
                  case "elemental":
                     boostsObj["dmgBoost"] += "Elemental +" + _loc15_ + "%\n";
                     break;
                  case "cp":
                     boostsObj["classBoost"] = "Class Points +" + _loc15_ + "%";
                     break;
                  case "gold":
                     boostsObj["goldBoost"] = "Gold +" + _loc15_ + "%";
                     break;
                  case "rep":
                     boostsObj["repBoost"] = "Reputation +" + _loc15_ + "%";
                     break;
                  case "exp":
                     boostsObj["xpBoost"] = "Experience +" + _loc15_ + "%";
                     break;
               }
            }
            _loc17_ = 30;
            for(_loc18_ in boostsObj)
            {
               switch(_loc18_)
               {
                  case "dmgBoost":
                     if(boostsObj[_loc18_] != "")
                     {
                        mcContainer.addChild(_loc14_);
                        _loc14_.width = _loc17_;
                        _loc14_.height = _loc17_;
                        _loc14_.name = "dmgBoost";
                        _loc14_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                        _loc14_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                     }
                     break;
                  case "classBoost":
                     _loc20_ = new classBoost();
                     mcContainer.addChild(_loc20_);
                     _loc20_.width = _loc17_;
                     _loc20_.height = _loc17_;
                     _loc20_.name = "classBoost";
                     _loc20_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                     _loc20_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                     break;
                  case "goldBoost":
                     _loc21_ = new goldBoost();
                     mcContainer.addChild(_loc21_);
                     _loc21_.width = _loc17_;
                     _loc21_.height = _loc17_;
                     _loc21_.name = "goldBoost";
                     _loc21_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                     _loc21_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                     break;
                  case "repBoost":
                     _loc22_ = new repBoost();
                     mcContainer.addChild(_loc22_);
                     _loc22_.width = _loc17_;
                     _loc22_.height = _loc17_;
                     _loc22_.name = "repBoost";
                     _loc22_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                     _loc22_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                     break;
                  case "xpBoost":
                     _loc23_ = new xpBoost();
                     mcContainer.addChild(_loc23_);
                     _loc23_.width = _loc17_;
                     _loc23_.height = _loc17_;
                     _loc23_.name = "xpBoost";
                     _loc23_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                     _loc23_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                     break;
               }
            }
            _loc4_ = 0;
            while(_loc4_ < mcContainer.numChildren)
            {
               _loc24_ = mcContainer.getChildAt(_loc4_) as MovieClip;
               _loc24_.x = _loc4_ * _loc24_.width + 2;
               _loc4_++;
            }
            if(mcContainer.numChildren > 0)
            {
               _loc25_ = new btnMoreInfo();
               _loc25_.addEventListener(MouseEvent.CLICK,onBoostsInfo,false,0,true);
               mcContainer.addChild(_loc25_);
               _loc25_.x = mcContainer.getChildAt(mcContainer.numChildren - 2).x + mcContainer.getChildAt(mcContainer.numChildren - 2).width + 3;
               _loc25_.y = _loc25_.height / 4 + 2;
            }
         }
      }
      
      private function onBoostsInfo(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.aq.com/lore/Guides/AQWBoosts"),"_blank");
      }
      
      private function onBoostGet(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         rootClass.ui.ToolTip.openWith({"str":boostsObj[_loc2_]});
      }
      
      private function onBoostOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      private function onTTFieldMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:String = "";
         switch(_loc2_)
         {
            case "tAP":
               _loc3_ = "Attack Power increases the effectiveness of your physical damage attacks.";
               break;
            case "tSP":
               _loc3_ = "Magic Power increases the effectiveness of your magical damage attacks.";
               break;
            case "tDmg":
               _loc3_ = "This is the damage you would expect to see on a normal melee hit, before any other modifiers.";
               break;
            case "tHP":
               _loc3_ = "Your total Hit Points.  When these reach zero, you will need to wait a short time before being able to continue playing.";
               break;
            case "tHitTF":
               _loc3_ = "Hit chance determines how likely you are to hit a target, before any other modifiers.";
               break;
            case "tHasteTF":
               _loc3_ = "Haste reduces the cooldown on all of your attacks and spells, including Auto Attack, by a certain percentage (hard capped at 50%).";
               break;
            case "tCritTF":
               _loc3_ = "Critical Strike chance increases the likelihood of dealing additional damage on a any attack.";
               break;
            case "tDodgeTF":
               _loc3_ = "Evasion chance allows you to completely avoid incoming damage.";
               break;
            case "tSTR":
            case "sl1":
               _loc3_ = "Strength increases Attack Power, which boosts physical damage. It also improves Critical Strike chance for melee classes.";
               break;
            case "tINT":
            case "sl2":
               _loc3_ = "Intellect increases Magic Power, which boosts magical damage. It also improve Critical Strike chance for caster classes.";
               break;
            case "tEND":
            case "sl3":
               _loc3_ = "Endurance directly contributes to your total Hit Points.  While very useful for all classes, some abilities work best with very high or very low total HP.";
               break;
            case "tDEX":
            case "sl4":
               _loc3_ = "Dexterity is valuable to melee classes. It increases Haste, Hit chance, and Evasion chance. It increases only Evasion chance for caster classes.";
               break;
            case "tWIS":
            case "sl5":
               _loc3_ = "Wisdom is valuable to caster classes. It increases Hit chance, Crit chance, and Evasion chance. It improves only Evasion chance for melee classes.";
               break;
            case "tLCK":
            case "sl6":
               _loc3_ = "Luck increases your Critical Strike modifier value directly, and may have effects outside of combat.";
         }
         rootClass.ui.ToolTip.openWith({"str":_loc3_});
      }
      
      private function onTTFieldMouseOut(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
   }
}

