package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.*;
   import liteAssets.draw.charPage;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2487")]
   public class cMenuMC extends MovieClip
   {
      
      public var cnt:MovieClip;
      
      internal var world:MovieClip;
      
      internal var fData:Object = null;
      
      internal var isOpen:Boolean = false;
      
      internal var fMode:String;
      
      internal var mc:MovieClip;
      
      internal var rootClass:MovieClip;
      
      internal var iHi:Number = -1;
      
      internal var iSel:Number = -1;
      
      internal var iCT:ColorTransform;
      
      public function cMenuMC()
      {
         super();
         addFrameScript(0,frame1,4,frame5,9,frame10);
         mc = MovieClip(this);
         rootClass = MovieClip(stage.getChildAt(0));
         mc.cnt.iproto.visible = false;
         mc.addEventListener(MouseEvent.MOUSE_OVER,mouseOn);
         mc.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
         fData = {};
         fData.params = {};
         fData.user = ["Char Page","Is Staff?","Hide Helm","Hide Cape","Hide Weapon","Hide Player","Whisper","Add Friend","Go To","Invite","Report","Delete Friend","Ignore","Close"];
         fData.friend = ["Char Page","Is Staff?","Whisper","Add Friend","Go To","Invite","Report","Delete Friend","Ignore","Close"];
         fData.party = ["Char Page","Whisper","Add Friend","Go To","Remove","Summon","Promote","Report","Delete Friend","Ignore","Close"];
         fData.self = ["Char Page","Reputation","Leave Party","Close"];
         fData.pvpqueue = ["Leave Queue","Close"];
         fData.offline = ["Char Page","Delete Friend","Close"];
         fData.ignored = ["Unignore","Close"];
         fData.mons = ["Wiki Monster","Hide Monster","Close"];
         fData.cl = [];
         fData.clc = [];
      }
      
      public function fOpenWith(param1:*, param2:*) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         isOpen = true;
         fMode = param1.toLowerCase();
         fData.params = param2;
         mc.cnt.mHi.visible = false;
         iCT = mc.cnt.mHi.transform.colorTransform;
         iCT.color = 13434675;
         mc.cnt.mHi.transform.colorTransform = iCT;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 13)
         {
            _loc7_ = mc.cnt.getChildByName("i" + _loc3_);
            if(_loc7_ != null)
            {
               _loc7_.removeEventListener(MouseEvent.CLICK,itemClick);
               _loc7_.removeEventListener(MouseEvent.MOUSE_OVER,itemMouseOver);
               mc.cnt.removeChild(_loc7_);
            }
            _loc3_++;
         }
         var _loc4_:* = 0;
         delete fData.cl;
         delete fData.clc;
         var _loc5_:* = fData.params.strUsername.toLowerCase();
         var _loc6_:* = rootClass.world.uoTree[_loc5_];
         fData.cl = rootClass.copyObj(fData[fMode]);
         fData.clc = [];
         _loc3_ = 0;
         while(_loc3_ < fData.cl.length)
         {
            if(fData.cl[_loc3_] == "Add Friend" && Boolean(rootClass.world.myAvatar.isFriend(fData.params.ID)))
            {
               fData.cl.splice(_loc3_,1);
               _loc3_--;
            }
            if(fData.cl[_loc3_] == "Delete Friend" && !rootClass.world.myAvatar.isFriend(fData.params.ID))
            {
               fData.cl.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < fData.cl.length)
         {
            if(_loc5_ == rootClass.sfc.myUserName)
            {
            }
            if(rootClass.world.getAvatarByUserName(_loc5_))
            {
               if(fData.cl[_loc3_] == "Ignore" && Boolean(rootClass.chatF.isIgnored(_loc5_)))
               {
                  fData.cl[_loc3_] = "Unignore";
               }
               if(fData.cl[_loc3_] == "Hide Helm" && !rootClass.world.getAvatarByUserName(_loc5_).pMC.mcChar.head.helm.visible)
               {
                  fData.cl[_loc3_] = "Show Helm";
               }
               if(fData.cl[_loc3_] == "Hide Cape" && !rootClass.world.getAvatarByUserName(_loc5_).pMC.mcChar.cape.visible)
               {
                  fData.cl[_loc3_] = "Show Cape";
               }
               if(fData.cl[_loc3_] == "Hide Player" && !rootClass.world.getAvatarByUserName(_loc5_).pMC.mcChar.visible)
               {
                  fData.cl[_loc3_] = "Show Player";
               }
               if(fData.cl[_loc3_] == "Hide Weapon" && !rootClass.world.getAvatarByUserName(_loc5_).pMC.mcChar.weapon.visible)
               {
                  fData.cl[_loc3_] = "Show Weapon";
               }
            }
            if(fData.params.target)
            {
               if(fData.cl[_loc3_] == "Freeze Monster" && Boolean(fData.params.target.noMove))
               {
                  fData.cl[_loc3_] = "UnFreeze Monster";
               }
               if(fData.cl[_loc3_] == "Hide Monster" && !fData.params.target.getChildAt(1).visible)
               {
                  fData.cl[_loc3_] = "Show Monster";
               }
            }
            _loc8_ = mc.cnt.addChild(new cProto());
            _loc8_.name = "i" + _loc3_;
            _loc8_.y = mc.cnt.iproto.y + _loc3_ * 14;
            iCT = _loc8_.transform.colorTransform;
            _loc9_ = true;
            switch(fData.cl[_loc3_].toLowerCase())
            {
               case "add friend":
                  if(rootClass.world.getAvatarByUserName(_loc5_) != null && rootClass.world.getAvatarByUserName(_loc5_).objData != null && (rootClass.world.getAvatarByUserName(_loc5_).isStaff() && !rootClass.world.myAvatar.isStaff()))
                  {
                     _loc9_ = false;
                  }
                  break;
               case "go to":
                  if(!(Boolean(rootClass.world.isPartyMember(_loc5_)) || Boolean(rootClass.world.myAvatar.isFriend(fData.params.ID))))
                  {
                     _loc9_ = false;
                  }
                  break;
               case "ignore":
                  if(_loc5_ == rootClass.sfc.myUserName)
                  {
                     _loc9_ = false;
                  }
                  break;
               case "invite":
                  if(_loc5_ == rootClass.sfc.myUserName || _loc6_ == null || rootClass.world.getAvatarByUserName(_loc5_) != null && rootClass.world.getAvatarByUserName(_loc5_).objData != null && (rootClass.world.getAvatarByUserName(_loc5_).isStaff() && !rootClass.world.myAvatar.isStaff()) || rootClass.world.partyMembers.length > 4 || Boolean(rootClass.world.isPartyMember(fData.params.strUsername)) || rootClass.world.bPvP && _loc6_.pvpTeam != rootClass.world.myAvatar.dataLeaf.pvpTeam || rootClass.world.partyMembers.length > 0 && rootClass.world.partyOwner.toLowerCase() != rootClass.sfc.myUserName)
                  {
                     _loc9_ = false;
                  }
                  break;
               case "leave party":
                  if(rootClass.world.partyMembers.length == 0)
                  {
                     _loc9_ = false;
                  }
                  break;
               case "remove":
                  if(rootClass.world.partyOwner.toLowerCase() != rootClass.sfc.myUserName)
                  {
                     fData.cl[_loc3_] = "Leave Party";
                  }
                  break;
               case "private: on":
               case "private: off":
               case "promote":
                  if(rootClass.world.partyOwner != rootClass.world.myAvatar.objData.strUsername)
                  {
                     _loc9_ = false;
                  }
                  break;
               case "inspect":
                  if(_loc6_ == null || _loc6_.strFrame != rootClass.world.strFrame)
                  {
                     _loc9_ = false;
                  }
            }
            if(_loc9_)
            {
               iCT.color = 10066329;
               _loc8_.addEventListener(MouseEvent.CLICK,itemClick,false,0,true);
               _loc8_.buttonMode = true;
            }
            else
            {
               iCT.color = 6710886;
            }
            _loc8_.addEventListener(MouseEvent.MOUSE_OVER,itemMouseOver,false,0,true);
            fData.clc.push(iCT.color);
            _loc8_.ti.text = fData.cl[_loc3_];
            if(_loc8_.ti.textWidth > _loc4_)
            {
               _loc4_ = _loc8_.ti.textWidth;
            }
            _loc8_.transform.colorTransform = iCT;
            _loc8_.ti.width = _loc8_.ti.textWidth + 5;
            _loc8_.hit.width = _loc8_.ti.x + _loc8_.ti.textWidth + 2;
            _loc3_++;
         }
         mc.cnt.bg.height = mc.cnt.getChildByName(String("i" + (fData.cl.length - 1))).y + 26;
         mc.cnt.bg.width = _loc4_ + 20;
         mc.x = MovieClip(parent).mouseX - 5;
         mc.y = MovieClip(parent).mouseY - 5;
         if(mc.x + mc.cnt.bg.width > 960)
         {
            mc.x = MovieClip(parent).mouseX - mc.cnt.bg.width;
         }
         if(mc.y + mc.cnt.bg.height > 500)
         {
            mc.y = 500 - mc.cnt.bg.height;
         }
         mc.gotoAndPlay("in");
      }
      
      public function fClose() : *
      {
         isOpen = false;
         if(mc.currentFrame != 1)
         {
            if(mc.currentFrame == 10)
            {
               mc.gotoAndPlay("out");
            }
            else
            {
               mc.gotoAndStop("hold");
            }
         }
      }
      
      private function itemMouseOver(param1:MouseEvent) : *
      {
         var _loc4_:* = undefined;
         var _loc2_:* = MovieClip(param1.currentTarget);
         iHi = int(_loc2_.name.substr(1));
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < fData.cl.length)
         {
            _loc4_ = mc.cnt.getChildByName("i" + _loc3_);
            iCT = _loc4_.transform.colorTransform;
            if(_loc3_ == iHi)
            {
               if(_loc2_.hasEventListener(MouseEvent.CLICK))
               {
                  iCT.color = 16777215;
                  cnt.mHi.visible = true;
                  cnt.mHi.y = _loc4_.y + 3;
               }
               else
               {
                  cnt.mHi.visible = false;
               }
            }
            else
            {
               iCT.color = fData.clc[_loc3_];
            }
            _loc4_.transform.colorTransform = iCT;
            _loc3_++;
         }
      }
      
      private function itemClick(param1:MouseEvent) : *
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:charPage = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc2_:* = MovieClip(param1.currentTarget);
         iSel = int(_loc2_.name.substr(1));
         iCT = mc.cnt.mHi.transform.colorTransform;
         iCT.color = 16763955;
         mc.cnt.mHi.transform.colorTransform = iCT;
         fClose();
         _loc3_ = fData.cl[iSel];
         _loc4_ = fData.params.strUsername;
         switch(_loc3_.toLowerCase())
         {
            case "wiki monster":
               navigateToURL(new URLRequest("http://aqwwiki.wikidot.com/" + fData.params.target.pname.ti.text),"_blank");
               break;
            case "freeze monster":
               fData.params.target.noMove = true;
               break;
            case "unfreeze monster":
               fData.params.target.noMove = false;
               break;
            case "hide helm":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.head.helm.visible = false;
               _loc5_.pMC.mcChar.head.hair.visible = true;
               _loc5_.pMC.mcChar.backhair.visible = _loc5_.pMC.bBackHair;
               break;
            case "show helm":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.head.helm.visible = true;
               _loc5_.pMC.mcChar.head.hair.visible = false;
               _loc5_.pMC.mcChar.backhair.visible = false;
               break;
            case "hide cape":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.cape.visible = false;
               break;
            case "show cape":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.cape.visible = true;
               break;
            case "hide monster":
               fData.params.target.getChildAt(1).visible = false;
               break;
            case "show monster":
               fData.params.target.getChildAt(1).visible = true;
               break;
            case "show weapon":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.weapon.visible = true;
               if(_loc5_.pMC.pAV.getItemByEquipSlot("Weapon").sType == "Dagger")
               {
                  _loc5_.pMC.mcChar.weaponOff.visible = true;
               }
               break;
            case "show player":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.visible = true;
               _loc5_.pMC.pname.visible = true;
               _loc5_.pMC.shadow.visible = true;
               break;
            case "hide weapon":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.weapon.visible = false;
               _loc5_.pMC.mcChar.weaponOff.visible = false;
               break;
            case "hide player":
               _loc5_ = rootClass.world.getAvatarByUserName(_loc4_);
               _loc5_.pMC.mcChar.visible = false;
               _loc5_.pMC.pname.visible = false;
               _loc5_.pMC.shadow.visible = false;
               break;
            case "char page":
               rootClass.mixer.playSound("Click");
               _loc6_ = new charPage(rootClass,_loc4_);
               rootClass.ui.addChild(_loc6_);
               break;
            case "is staff?":
               rootClass.world.isModerator(_loc4_);
               break;
            case "reputation":
               rootClass.mixer.playSound("Click");
               rootClass.showFactionInterface();
               break;
            case "whisper":
               rootClass.chatF.openPMsg(_loc4_);
               break;
            case "ignore":
               rootClass.chatF.ignore(_loc4_);
               rootClass.chatF.pushMsg("server","You are now ignoring user " + _loc4_ + ".","SERVER","",0);
               break;
            case "unignore":
               rootClass.chatF.unignore(_loc4_);
               rootClass.chatF.pushMsg("server","User " + _loc4_ + " is no longer being ignored.","SERVER","",0);
               break;
            case "report":
               rootClass.ui.mcPopup.fOpen("Report",{"unm":_loc4_});
               break;
            case "close":
               if(fMode == "user" || fMode == "party")
               {
                  rootClass.world.cancelTarget();
               }
               break;
            case "add friend":
               if(rootClass.world.myAvatar.friends.length >= rootClass.iMaxFriends)
               {
                  rootClass.chatF.pushMsg("server","You are too popular! (" + String(rootClass.iMaxFriends) + " friends max)","SERVER","",0);
               }
               else
               {
                  rootClass.world.requestFriend(_loc4_);
               }
               break;
            case "delete friend":
               _loc7_ = new ModalMC();
               _loc8_ = {};
               _loc8_.strBody = "Are you sure you want to delete " + _loc4_ + " from your friends list?";
               _loc8_.params = {
                  "id":fData.params.ID,
                  "unm":_loc4_
               };
               _loc8_.callback = confirmDeleteFriend;
               _loc8_.glow = "red,medium";
               rootClass.ui.ModalStack.addChild(_loc7_);
               _loc7_.init(_loc8_);
               break;
            case "go to":
               rootClass.world.goto(_loc4_);
               break;
            case "invite":
               rootClass.world.partyInvite(_loc4_);
               break;
            case "remove":
               rootClass.world.partyKick(_loc4_);
               break;
            case "leave party":
               rootClass.world.partyLeave();
               break;
            case "private: on":
            case "private: off":
               _loc9_ = _loc3_.toLowerCase().split(": ")[0];
               _loc10_ = _loc3_.toLowerCase().split(": ")[1] == "on" ? 1 : 0;
               rootClass.world.partyUpdate(_loc9_,_loc10_);
               break;
            case "promote":
               rootClass.world.partyPromote(_loc4_);
               break;
            case "summon":
               rootClass.world.partySummon(_loc4_);
               break;
            case "leave queue":
               rootClass.world.requestPVPQueue("none");
         }
      }
      
      private function confirmDeleteFriend(param1:Object) : *
      {
         if(param1.accept)
         {
            rootClass.world.deleteFriend(param1.id,param1.unm);
         }
      }
      
      private function mouseOn(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).cnt.gotoAndStop("hold");
      }
      
      private function mouseOut(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).cnt.gotoAndPlay("out");
      }
      
      internal function frame1() : *
      {
         visible = false;
         stop();
      }
      
      internal function frame5() : *
      {
         visible = true;
      }
      
      internal function frame10() : *
      {
         stop();
      }
   }
}

