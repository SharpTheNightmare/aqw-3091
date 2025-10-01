package liteAssets.draw
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.*;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2093")]
   public class statsPanel extends MovieClip
   {
      
      public var btnHelp:MovieClip;
      
      public var tName:TextField;
      
      public var bContainer:MovieClip;
      
      public var tCombat2:TextField;
      
      public var tCombat1:TextField;
      
      public var btnExit:MovieClip;
      
      public var bg:MovieClip;
      
      public var btnHelp2:MovieClip;
      
      public var tCat:TextField;
      
      public var btnHelp3:MovieClip;
      
      public var tMod:TextField;
      
      public var tStats:TextField;
      
      public var tCore:TextField;
      
      private var r:MovieClip;
      
      private var world:MovieClip;
      
      internal var tt:MovieClip;
      
      private var allocated:Object;
      
      private var nextMode:String;
      
      private var uoLeaf:Object;
      
      private var uoData:Object;
      
      private var stp:Object;
      
      private var stg:Object;
      
      internal var tStatVals:Array = ["STR","INT","DEX","END","WIS","LCK"];
      
      internal var tStatFormats:Array = [];
      
      internal var tFormats:Array = [];
      
      internal var tValues:Array = ["$cai","$cao","$cpi","$cpo","$cmi","$cmo","$chi","$cho","$cdi","$cdo","$cmc"];
      
      internal var tCombatFormats1:Array = [];
      
      internal var tCombatFormats2:Array = [];
      
      internal var tCombat1Vals:Array = ["$ap","$sp","$thi","$tha"];
      
      internal var tCombat2Vals:Array = ["$tcr","$scm","$tdo"];
      
      internal var boostsObj:Object = {};
      
      public function statsPanel(param1:MovieClip)
      {
         super();
         r = param1;
         world = r.world;
         uoLeaf = world.myLeaf();
         uoData = world.myAvatar.objData;
         stp = new Object();
         stg = new Object();
         this.addEventListener(Event.ADDED_TO_STAGE,onStage,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,onStop,false,0,true);
         this.btnHelp.addEventListener(MouseEvent.CLICK,onHelp,false,0,true);
         this.btnHelp2.addEventListener(MouseEvent.CLICK,onHelp,false,0,true);
         this.btnHelp3.addEventListener(MouseEvent.CLICK,onHelp,false,0,true);
         this.btnExit.addEventListener(MouseEvent.CLICK,onExit,false,0,true);
         tName.mouseEnabled = false;
         tCat.mouseEnabled = false;
         updateBoosts();
      }
      
      public function onHelp(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.aq.com/lore/guides/stats"),"_blank");
      }
      
      public function cleanup() : void
      {
         var _loc1_:MovieClip = null;
         if(parent != null)
         {
            _loc1_ = MovieClip(parent);
            _loc1_.removeChild(this);
            r.stage.focus = null;
         }
      }
      
      public function onExit(param1:MouseEvent) : void
      {
         cleanup();
      }
      
      public function onStage(param1:Event) : void
      {
         updateBase();
         update();
         this.removeEventListener(Event.ADDED_TO_STAGE,onStage);
         tt = new ToolTipMC(r);
         addChild(tt);
      }
      
      private function getCatDefinition() : String
      {
         switch(uoData.sClassCat)
         {
            case "M1":
               return "Tank Melee";
            case "M2":
               return "Dodge Melee";
            case "M3":
               return "Full Hybrid";
            case "M4":
               return "Power Melee";
            case "C1":
               return "Offensive Caster";
            case "C2":
               return "Defensive Caster";
            case "C3":
               return "Power Caster";
            case "S1":
               return "Luck Hybrid";
            default:
               return "Adventurer";
         }
      }
      
      private function buildStu() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc1_:Object = r.getCategoryStats(uoData.sClassCat,uoLeaf.intLevel);
         var _loc2_:String = "";
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < r.stats.length)
         {
            _loc2_ = r.stats[_loc3_];
            stg["^" + _loc2_] = 0;
            stp["_" + _loc2_] = Math.floor(_loc1_[_loc2_]);
            _loc3_++;
         }
         var _loc4_:* = world.uoTree[r.sfc.myUserName.toLowerCase()];
         for(_loc5_ in _loc4_.tempSta)
         {
            if(_loc5_ != "innate")
            {
               for(_loc6_ in _loc4_.tempSta[_loc5_])
               {
                  if(stg["^" + _loc6_] == null)
                  {
                     stg["^" + _loc6_] = 0;
                  }
                  stg["^" + _loc6_] += int(_loc4_.tempSta[_loc5_][_loc6_]);
               }
            }
         }
      }
      
      private function fixValues(param1:String, param2:Number) : Array
      {
         var _loc3_:Array = [param1 == "$chi" || param1 == "$cmc" || param1 == "$tha" ? r.coeffToPct(param2) : r.coeffToPct(param2 - 1)];
         switch(param1)
         {
            case "$cai":
               _loc3_[0] *= -1;
               return param2 <= 0.2 ? [r.coeffToPct(1 - 0.2),"*"] : _loc3_;
            case "$cao":
               return param2 <= 0.1 ? [r.coeffToPct(0.1 - 1),"*"] : _loc3_;
            case "$tha":
               return param2 >= 0.5 ? [r.coeffToPct(1 - 0.5),"*"] : _loc3_;
            case "$cpi":
               _loc3_[0] *= -1;
               return param2 <= 0.2 ? [r.coeffToPct(1 - 0.2),"*"] : _loc3_;
            case "$cmi":
               _loc3_[0] *= -1;
               return param2 <= 0.2 ? [r.coeffToPct(1 - 0.2),"*"] : _loc3_;
            case "$cmo":
               return param2 <= 0.2 ? [r.coeffToPct(1 - 0.1),"*"] : _loc3_;
            case "$cdi":
               _loc3_[0] *= -1;
               return _loc3_;
            default:
               return _loc3_;
         }
      }
      
      private function determineColor(param1:String, param2:Number) : *
      {
         if(!allocated[param1])
         {
            allocated[param1] = param2;
            return 13421772;
         }
         var _loc3_:Number = fixValues(param1,param2)[0] - 1;
         var _loc4_:Number = fixValues(param1,allocated[param1])[0] - 1;
         if(param1 == "$cmc")
         {
            _loc3_ *= -1;
            _loc4_ *= -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 6710886;
         }
         if(_loc3_ > _loc4_)
         {
            return 13408512;
         }
         return 13421772;
      }
      
      private function determineStatColor(param1:String, param2:Number) : *
      {
         var _loc3_:Number = stp["_" + param1] + stg["^" + param1];
         var _loc4_:Number = param2;
         if(_loc3_ > _loc4_)
         {
            return 6710886;
         }
         if(_loc3_ < _loc4_)
         {
            return 13408512;
         }
         return 13421772;
      }
      
      private function allocateBaseValues() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!allocated)
         {
            allocated = new Object();
         }
         if(r.baseClassStats)
         {
            for(_loc3_ in r.baseClassStats)
            {
               allocated[_loc3_] = r.baseClassStats[_loc3_];
            }
            allocated["intHPMax"] = uoData.intHPMax;
            r.baseClassStats = null;
            return;
         }
         var _loc1_:* = world.uoTree[r.sfc.myUserName.toLowerCase()].sta;
         for each(_loc2_ in tValues)
         {
            allocated[_loc2_] = _loc1_[_loc2_];
         }
         for each(_loc2_ in tCombat1Vals)
         {
            allocated[_loc2_] = _loc1_[_loc2_];
         }
         for each(_loc2_ in tCombat2Vals)
         {
            allocated[_loc2_] = _loc1_[_loc2_];
         }
         allocated["intHPMax"] = uoData.intHPMax;
      }
      
      public function updateBase() : void
      {
         tName.text = uoData.strClassName;
         tCat.text = getCatDefinition();
         allocateBaseValues();
      }
      
      public function update() : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:Array = null;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:TextFormat = null;
         buildStu();
         var _loc1_:* = world.uoTree[r.sfc.myUserName.toLowerCase()].sta;
         var _loc2_:int = Math.floor(100 - world.myAvatar.getEquippedItemBySlot("Weapon").iRng);
         var _loc3_:int = 100 + world.myAvatar.getEquippedItemBySlot("Weapon").iRng;
         var _loc4_:Object = getEnhances();
         tCore.text = _loc2_ + "% - " + _loc3_ + "%\n" + _loc4_["Weapon"][0] + _loc4_["Weapon"][1] + (_loc4_["Weapon"][2] != "" ? ", " + _loc4_["Weapon"][2] : "") + "\n" + _loc4_["ar"][0] + _loc4_["ar"][1] + "\n" + _loc4_["ba"][0] + _loc4_["ba"][1] + (_loc4_["ba"][2] != "" ? ", " + _loc4_["ba"][2] : "") + "\n" + _loc4_["he"][0] + _loc4_["he"][1] + (_loc4_["he"][2] != "" ? ", " + _loc4_["he"][2] : "") + "\n";
         var _loc7_:int = 0;
         tStats.text = "";
         for each(_loc8_ in tStatVals)
         {
            tStats.text += stp["_" + _loc8_] + stg["^" + _loc8_] + " (" + (!_loc1_["$" + _loc8_] ? 0 : _loc1_["$" + _loc8_]) + ")\n";
            tStatFormats[_loc7_] = [tStats.text.lastIndexOf("(") + 1,tStats.text.lastIndexOf(")"),determineStatColor(_loc8_,_loc1_["$" + _loc8_])];
            _loc7_++;
         }
         tCombat1.text = "";
         _loc7_ = 0;
         for each(_loc9_ in tCombat1Vals)
         {
            if(_loc9_ == "$ap" || _loc9_ == "$sp")
            {
               _loc5_ = String(_loc1_[_loc9_]);
            }
            if(_loc9_ == "$thi")
            {
               _loc5_ = r.coeffToPct(Number(1 - r.baseMiss + _loc1_["$thi"])) + "%";
            }
            if(_loc9_ == "$tha")
            {
               _loc13_ = fixValues("$tha",_loc1_["$tha"]);
               _loc5_ = (_loc13_.length == 2 ? _loc13_[1] : "") + _loc13_[0] + "%";
            }
            _loc6_ = tCombat1.length;
            tCombat1.text += _loc5_ + "\n";
            tCombatFormats1[_loc7_] = [_loc6_,tCombat1.length,determineColor(_loc9_,_loc1_[_loc9_])];
            _loc7_++;
         }
         tCombat2.text = "";
         _loc7_ = 0;
         for each(_loc10_ in tCombat2Vals)
         {
            _loc6_ = tCombat2.length;
            tCombat2.text += r.coeffToPct(_loc1_[_loc10_]) + "%\n";
            tCombatFormats2[_loc7_] = [_loc6_,tCombat2.length,determineColor(_loc10_,_loc1_[_loc10_])];
            _loc7_++;
         }
         _loc6_ = tCombat2.length;
         tCombat2.text += uoData.intHPMax;
         tCombatFormats2[_loc7_] = [_loc6_,tCombat2.length,determineColor("intHPMax",uoData.intHPMax)];
         tMod.text = "";
         _loc7_ = 0;
         for each(_loc11_ in tValues)
         {
            _loc14_ = stg["^" + _loc11_] != null ? _loc1_[_loc11_] + stg["^" + _loc11_] : _loc1_[_loc11_];
            _loc15_ = fixValues(_loc11_,_loc14_);
            _loc6_ = tMod.length;
            tMod.text += (_loc15_.length == 2 ? _loc15_[1] + _loc15_[0] : _loc15_[0]) + "%\n";
            tFormats[_loc7_] = [_loc6_,tMod.length,determineColor(_loc11_,_loc14_)];
            _loc7_++;
         }
         for each(_loc12_ in tStatFormats)
         {
            _loc16_ = tStats.getTextFormat(_loc12_[0],_loc12_[1]);
            _loc16_.color = _loc12_[2];
            _loc16_.leading = 4;
            tStats.setTextFormat(_loc16_,_loc12_[0],_loc12_[1]);
         }
         for each(_loc12_ in tFormats)
         {
            _loc16_ = tMod.getTextFormat(_loc12_[0],_loc12_[1]);
            _loc16_.color = _loc12_[2];
            _loc16_.leading = 2.6;
            tMod.setTextFormat(_loc16_,_loc12_[0],_loc12_[1]);
         }
         for each(_loc12_ in tCombatFormats1)
         {
            _loc16_ = tCombat1.getTextFormat(_loc12_[0],_loc12_[1]);
            _loc16_.color = _loc12_[2];
            _loc16_.leading = 2;
            tCombat1.setTextFormat(_loc16_,_loc12_[0],_loc12_[1]);
         }
         for each(_loc12_ in tCombatFormats2)
         {
            _loc16_ = tCombat2.getTextFormat(_loc12_[0],_loc12_[1]);
            _loc16_.color = _loc12_[2];
            _loc16_.leading = 2;
            tCombat2.setTextFormat(_loc16_,_loc12_[0],_loc12_[1]);
         }
      }
      
      private function getProc(param1:Object) : String
      {
         var _loc2_:String = "";
         if(Boolean(param1) && Boolean(param1.hasOwnProperty("ProcID")))
         {
            switch(param1.ProcID)
            {
               case 2:
                  _loc2_ = "Spiral Carve";
                  break;
               case 3:
                  _loc2_ = "Awe Blast";
                  break;
               case 4:
                  _loc2_ = "Health Vamp";
                  break;
               case 5:
                  _loc2_ = "Mana Vamp";
                  break;
               case 6:
                  _loc2_ = "Powerword DIE";
                  break;
               case 7:
                  _loc2_ = "Lacerate";
                  break;
               case 8:
                  _loc2_ = "Smite";
                  break;
               case 9:
                  _loc2_ = "Valiance";
                  break;
               case 10:
                  _loc2_ = "Arcana\'s Concerto";
                  break;
               case 11:
                  _loc2_ = "Acheron";
                  break;
               case 12:
                  _loc2_ = "Elysium";
                  break;
               case 13:
                  _loc2_ = "Praxis";
                  break;
               case 14:
                  _loc2_ = "Dauntless";
                  break;
               case 15:
                  _loc2_ = "Ravenous";
                  break;
               default:
                  _loc2_ = "None";
            }
         }
         return _loc2_;
      }
      
      private function getEnh(param1:String) : Array
      {
         var _loc4_:* = undefined;
         var _loc2_:Array = ["None","",""];
         var _loc3_:Object = world.myAvatar.getEquippedItemBySlot(param1);
         _loc2_[2] = getProc(_loc3_);
         if(!_loc3_)
         {
            return _loc2_;
         }
         if(_loc3_.PatternID != null)
         {
            _loc4_ = r.world.enhPatternTree[_loc3_.PatternID];
         }
         if(_loc3_.EnhPatternID != null)
         {
            _loc4_ = r.world.enhPatternTree[_loc3_.EnhPatternID];
         }
         if(!_loc4_)
         {
            return _loc2_;
         }
         _loc2_[0] = _loc4_.sName;
         _loc2_[1] = _loc3_.EnhRty > 1 ? " +" + String(_loc3_.EnhRty - 1) : "";
         if(_loc4_.hasOwnProperty("DIS"))
         {
            _loc2_[0] = r.getDisplayEnhName(_loc4_);
            _loc2_[2] = r.getDisplayEnhTraitName(_loc4_);
         }
         return _loc2_;
      }
      
      private function getEnhances() : Object
      {
         var _loc2_:* = undefined;
         var _loc1_:Object = {
            "Weapon":[],
            "ar":[],
            "ba":[],
            "he":[]
         };
         r.world.initPatternTree();
         for(_loc2_ in _loc1_)
         {
            _loc1_[_loc2_] = getEnh(_loc2_);
         }
         return _loc1_;
      }
      
      private function handleMissing(param1:String) : String
      {
         return param1 == "NaN" ? "100" : param1;
      }
      
      private function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStop(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function updateBoosts() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:MovieClip = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:* = undefined;
         while(bContainer.numChildren > 1)
         {
            bContainer.removeChildAt(1);
         }
         var _loc1_:Object = r.world.myAvatar.boosts;
         var _loc2_:Boolean = false;
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_[0] > 0)
            {
               _loc2_ = true;
               break;
            }
         }
         bContainer.visible = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         boostsObj = {};
         boostsObj["dmgBoost"] = "";
         for(_loc3_ in _loc1_)
         {
            _loc7_ = _loc1_[_loc3_][0];
            if(Number(_loc7_) == 0)
            {
               continue;
            }
            _loc8_ = Math.round((Number(_loc7_) - 1) * 100).toString();
            switch(_loc3_)
            {
               case "dmgall":
                  boostsObj["dmgBoost"] += "All +" + _loc8_ + "%\n";
                  break;
               case "undead":
                  boostsObj["dmgBoost"] += "Undead +" + _loc8_ + "%\n";
                  break;
               case "human":
                  boostsObj["dmgBoost"] += "Human +" + _loc8_ + "%\n";
                  break;
               case "chaos":
                  boostsObj["dmgBoost"] += "Chaos +" + _loc8_ + "%\n";
                  break;
               case "dragonkin":
                  boostsObj["dmgBoost"] += "Dragonkin +" + _loc8_ + "%\n";
                  break;
               case "orc":
                  boostsObj["dmgBoost"] += "Orc +" + _loc8_ + "%\n";
                  break;
               case "drakath":
                  boostsObj["dmgBoost"] += "Drakath +" + _loc8_ + "%\n";
                  break;
               case "elemental":
                  boostsObj["dmgBoost"] += "Elemental +" + _loc8_ + "%\n";
                  break;
               case "cp":
                  boostsObj["classBoost"] = "Class Points +" + _loc8_ + "%";
                  break;
               case "gold":
                  boostsObj["goldBoost"] = "Gold +" + _loc8_ + "%";
                  break;
               case "rep":
                  boostsObj["repBoost"] = "Reputation +" + _loc8_ + "%";
                  break;
               case "exp":
                  boostsObj["xpBoost"] = "Experience +" + _loc8_ + "%";
                  break;
            }
         }
         _loc4_ = new damageBoost();
         for(_loc5_ in boostsObj)
         {
            switch(_loc5_)
            {
               case "dmgBoost":
                  if(boostsObj[_loc5_] != "")
                  {
                     bContainer.addChild(_loc4_);
                     _loc4_.scaleX = 0.043;
                     _loc4_.scaleY = 0.04;
                     _loc4_.name = "dmgBoost";
                     _loc4_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                     _loc4_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                  }
                  break;
               case "classBoost":
                  _loc9_ = new classBoost();
                  bContainer.addChild(_loc9_);
                  _loc9_.scaleX = 0.043;
                  _loc9_.scaleY = 0.04;
                  _loc9_.name = "classBoost";
                  _loc9_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                  _loc9_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                  break;
               case "goldBoost":
                  _loc10_ = new goldBoost();
                  bContainer.addChild(_loc10_);
                  _loc10_.scaleX = 0.043;
                  _loc10_.scaleY = 0.04;
                  _loc10_.name = "goldBoost";
                  _loc10_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                  _loc10_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                  break;
               case "repBoost":
                  _loc11_ = new repBoost();
                  bContainer.addChild(_loc11_);
                  _loc11_.scaleX = 0.043;
                  _loc11_.scaleY = 0.04;
                  _loc11_.name = "repBoost";
                  _loc11_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                  _loc11_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                  break;
               case "xpBoost":
                  _loc12_ = new xpBoost();
                  bContainer.addChild(_loc12_);
                  _loc12_.scaleX = 0.043;
                  _loc12_.scaleY = 0.04;
                  _loc12_.name = "xpBoost";
                  _loc12_.addEventListener(MouseEvent.MOUSE_OVER,onBoostGet,false,0,true);
                  _loc12_.addEventListener(MouseEvent.MOUSE_OUT,onBoostOut,false,0,true);
                  break;
            }
         }
         _loc6_ = 1;
         while(_loc6_ < bContainer.numChildren)
         {
            _loc13_ = bContainer.getChildAt(_loc6_);
            if(_loc13_ is MovieClip)
            {
               _loc13_.y = 3;
               _loc13_.x = (_loc6_ - 1) * _loc13_.width + 2;
            }
            _loc6_++;
         }
      }
      
      private function onBoostGet(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         tt.openWith({
            "str":boostsObj[_loc2_],
            "fromlocal":{
               "x":bContainer.x + bContainer.width / 2,
               "y":bContainer.y + bContainer.height
            }
         });
      }
      
      private function onBoostOut(param1:MouseEvent) : void
      {
         tt.close();
      }
   }
}

