package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class AvatarMCCopier
   {
      
      private var world:*;
      
      private var rootClass:*;
      
      private var mcChar:MovieClip;
      
      private var objLinks:Object = {};
      
      private var pAV:Avatar;
      
      private var strGender:String;
      
      private var helmEquipped:Boolean = false;
      
      public function AvatarMCCopier(param1:MovieClip)
      {
         super();
         world = param1;
      }
      
      public function copyTo(param1:MovieClip) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         mcChar = param1;
         MovieClip(mcChar.parent).pAV = world.myAvatar;
         pAV = world.myAvatar;
         strGender = pAV.objData.strGender;
         var _loc2_:* = ["cape","backhair","robe","backrobe"];
         for(_loc3_ in _loc2_)
         {
            if(typeof mcChar[_loc2_[_loc3_]] != undefined)
            {
               mcChar[_loc2_[_loc3_]].visible = false;
            }
         }
         if(!pAV.dataLeaf.showHelm || !("he" in pAV.objData.eqp) && pAV.objData.eqp.he == null)
         {
            onHairLoadComplete(null);
         }
         for(_loc4_ in world.myAvatar.objData.eqp)
         {
            switch(_loc4_)
            {
               case "Weapon":
                  world.queueLoad({
                     "strFile":world.rootClass.getFilePath() + pAV.objData.eqp[_loc4_].sFile,
                     "callBackA":onLoadWeaponComplete
                  });
                  break;
               case "he":
                  if(pAV.dataLeaf.showHelm)
                  {
                     onLoadHelmComplete(null);
                  }
                  break;
               case "ba":
                  if(pAV.dataLeaf.showCloak)
                  {
                     onLoadCapeComplete(null);
                  }
                  break;
               case "ar":
                  if(world.myAvatar.objData.eqp.co == null)
                  {
                     objLinks.ar = pAV.objData.eqp.ar.sLink;
                     onLoadArmorComplete(null);
                  }
                  break;
               case "co":
                  objLinks.ar = pAV.objData.eqp.co.sLink;
                  onLoadArmorComplete(null);
                  break;
            }
         }
      }
      
      public function loadArmorPieces(param1:String) : void
      {
         var AssetClass:Class = null;
         var child:DisplayObject = null;
         var strSkinLinkage:String = param1;
         try
         {
            AssetClass = world.getClass(strSkinLinkage + strGender + "Head") as Class;
            mcChar.head.addChildAt(new AssetClass(),0);
            mcChar.head.removeChildAt(1);
         }
         catch(err:Error)
         {
            AssetClass = world.getClass("mcHead" + strGender) as Class;
            mcChar.head.addChildAt(new AssetClass(),0);
            mcChar.head.removeChildAt(1);
         }
         AssetClass = world.getClass(strSkinLinkage + strGender + "Chest") as Class;
         mcChar.chest.removeChildAt(0);
         mcChar.chest.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Hip") as Class;
         mcChar.hip.removeChildAt(0);
         mcChar.hip.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "FootIdle") as Class;
         mcChar.idlefoot.removeChildAt(0);
         mcChar.idlefoot.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Foot") as Class;
         mcChar.frontfoot.removeChildAt(0);
         mcChar.frontfoot.addChild(new AssetClass());
         mcChar.frontfoot.visible = false;
         mcChar.backfoot.removeChildAt(0);
         mcChar.backfoot.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Shoulder") as Class;
         mcChar.frontshoulder.removeChildAt(0);
         mcChar.frontshoulder.addChild(new AssetClass());
         mcChar.backshoulder.removeChildAt(0);
         mcChar.backshoulder.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Hand") as Class;
         mcChar.fronthand.removeChildAt(0);
         mcChar.fronthand.addChild(new AssetClass());
         mcChar.backhand.removeChildAt(0);
         mcChar.backhand.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Thigh") as Class;
         mcChar.frontthigh.removeChildAt(0);
         mcChar.frontthigh.addChild(new AssetClass());
         mcChar.backthigh.removeChildAt(0);
         mcChar.backthigh.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Shin") as Class;
         mcChar.frontshin.removeChildAt(0);
         mcChar.frontshin.addChild(new AssetClass());
         mcChar.backshin.removeChildAt(0);
         mcChar.backshin.addChild(new AssetClass());
         AssetClass = world.getClass(strSkinLinkage + strGender + "Robe") as Class;
         if(AssetClass != null)
         {
            mcChar.robe.removeChildAt(0);
            mcChar.robe.addChild(new AssetClass());
            mcChar.robe.visible = true;
         }
         else
         {
            mcChar.robe.visible = false;
         }
         AssetClass = world.getClass(strSkinLinkage + strGender + "RobeBack") as Class;
         if(AssetClass != null)
         {
            mcChar.backrobe.removeChildAt(0);
            mcChar.backrobe.addChild(new AssetClass());
            mcChar.backrobe.visible = true;
         }
         else
         {
            mcChar.backrobe.visible = false;
         }
      }
      
      public function onLoadArmorComplete(param1:Event) : void
      {
         loadArmorPieces(objLinks.ar);
      }
      
      public function onHairLoadComplete(param1:Event) : void
      {
         var _loc2_:Class = null;
         if(helmEquipped)
         {
            return;
         }
         _loc2_ = world.getClass(pAV.objData.strHairName + pAV.objData.strGender + "Hair") as Class;
         if(_loc2_ != null)
         {
            if(mcChar.head.hair.numChildren > 0)
            {
               mcChar.head.hair.removeChildAt(0);
            }
            mcChar.head.hair.addChild(new _loc2_());
            mcChar.head.hair.visible = true;
         }
         else
         {
            mcChar.head.hair.visible = false;
         }
         _loc2_ = world.getClass(pAV.objData.strHairName + pAV.objData.strGender + "HairBack") as Class;
         if(_loc2_ != null)
         {
            if(mcChar.backhair.numChildren > 0)
            {
               mcChar.backhair.removeChildAt(0);
            }
            mcChar.backhair.addChild(new _loc2_());
            mcChar.backhair.visible = true;
         }
         else
         {
            mcChar.backhair.visible = false;
         }
      }
      
      public function loadWeapon(param1:*, param2:*) : void
      {
         world.queueLoad({
            "strFile":world.rootClass.getFilePath() + param1,
            "callBackA":onLoadWeaponComplete,
            "avt":pAV,
            "sES":"weapon"
         });
      }
      
      public function onLoadWeaponComplete(param1:Event) : void
      {
         var AssetClass:Class = null;
         var e:Event = param1;
         mcChar.weapon.removeChildAt(0);
         try
         {
            AssetClass = world.getClass(pAV.objData.eqp.Weapon.sLink) as Class;
            if(pAV.objData.eqp.Weapon.sType == "Gauntlet")
            {
               mcChar.fronthand.addChildAt(new AssetClass(),1);
               mcChar.fronthand.getChildAt(1).scaleX = 0.8;
               mcChar.fronthand.getChildAt(1).scaleY = 0.8;
               mcChar.fronthand.getChildAt(1).scaleX = mcChar.fronthand.getChildAt(1).scaleX * -1;
               mcChar.weapon.mcWeapon = new MovieClip();
            }
            else
            {
               mcChar.weapon.addChild(new AssetClass());
            }
         }
         catch(err:Error)
         {
            mcChar.weapon.addChild(e.target.content);
         }
         mcChar.weapon.visible = true;
         if("eventTrigger" in MovieClip(world.map))
         {
            world.map.eventTrigger({"cmd":"copyAvatarMCCompleted"});
         }
      }
      
      public function onLoadCapeComplete(param1:Event) : void
      {
         var _loc2_:Class = world.getClass(pAV.objData.eqp.ba.sLink) as Class;
         mcChar.cape.removeChildAt(0);
         mcChar.cape.cape = new _loc2_();
         mcChar.cape.addChild(mcChar.cape.cape);
         mcChar.cape.visible = true;
      }
      
      public function onLoadHelmComplete(param1:Event) : void
      {
         var _loc2_:Class = world.getClass(pAV.objData.eqp.he.sLink) as Class;
         var _loc3_:Class = world.getClass(pAV.objData.eqp.he.sLink + "_backhair") as Class;
         if(_loc2_ != null)
         {
            if(mcChar.head.helm.numChildren > 0)
            {
               mcChar.head.helm.removeChildAt(0);
            }
            mcChar.head.helm.visible = pAV.dataLeaf.showHelm;
            mcChar.head.hair.visible = !mcChar.head.helm.visible;
            if(_loc3_ != null)
            {
               if(pAV.dataLeaf.showHelm)
               {
                  mcChar.backhair.visible = true;
                  mcChar.backhair.addChild(new _loc3_());
               }
               else
               {
                  mcChar.backhair.visible = mcChar.head.hair.visible && pAV.pMC.bBackHair;
               }
            }
            else
            {
               mcChar.backhair.visible = mcChar.head.hair.visible && pAV.pMC.bBackHair;
            }
            mcChar.head.helm.addChild(new _loc2_());
            helmEquipped = true;
         }
         else
         {
            world.rootClass.chatF.pushMsg("warning","Could not resolve Helm definition.","SERVER","",0);
         }
      }
   }
}

