package
{
   import com.adobe.serialization.json.JSON;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2880")]
   public class ServerList extends MovieClip
   {
      
      public var uCount:MovieClip;
      
      public var l1:MovieClip;
      
      public var bg:MovieClip;
      
      public var l2:MovieClip;
      
      public var iList:MovieClip;
      
      public var txtServerSelect:TextField;
      
      public var legend:MovieClip;
      
      public var liveLink:MovieClip;
      
      private var objLogin:Object;
      
      private var rootClass:MovieClip;
      
      private var arrServers:Array;
      
      private var blackCT:ColorTransform;
      
      private var iCap:int = 0;
      
      private var mDown:Boolean = false;
      
      private var hRun:int = 0;
      
      private var dRun:int = 0;
      
      private var mbY:int = 0;
      
      private var mhY:int = 0;
      
      private var mbD:int = 0;
      
      private var ox:int = 0;
      
      private var oy:int = 0;
      
      private var mox:int = 0;
      
      private var moy:int = 0;
      
      private var scrTgt:MovieClip;
      
      private var whiteListA:Array;
      
      private var whiteListB:Array;
      
      private var langMap:Object;
      
      private var iTotal:int = 0;
      
      internal var tRefresh:Timer;
      
      public function ServerList()
      {
         var drawnItems:int;
         var i:*;
         var bgh:int;
         var ts:String;
         var itemClass:Class = null;
         var server:MovieClip = null;
         var n:int = 0;
         blackCT = new ColorTransform();
         whiteListA = ["74.53.22.26","74.53.7.201"];
         whiteListB = ["74.53.7.201"];
         langMap = {
            "xx":"Canned-Chat",
            "en":"English",
            "pt":"Portuguese",
            "ph":"Philippines",
            "it":"Global"
         };
         tRefresh = new Timer(1000,5);
         super();
         addFrameScript(0,frame1,1,frame2);
         visible = false;
         objLogin = Game.objLogin;
         rootClass = MovieClip(root);
         legend.fbWindow.btnFBID.visible = false;
         if(FacebookConnect.isLoggedIn)
         {
            legend.fbNoLink.visible = false;
            legend.fbWindow.visible = true;
            legend.fbWindow.fbImg.visible = true;
            legend.fbWindow.btnFBLogout.visible = true;
            try
            {
               legend.fbWindow.txtFBName.text = FacebookConnect.Me.name;
            }
            catch(e:*)
            {
            }
         }
         else
         {
            legend.fbWindow.visible = false;
            legend.fbNoLink.visible = true;
            legend.fbWindow.addEventListener(MouseEvent.CLICK,onBackClick,false,0,true);
         }
         txtServerSelect.text = Game.loginInfo.strUsername + ", please select a server.";
         if(objLogin.iAccess >= 70)
         {
            arrServers = whiteList(objLogin.servers,[]);
         }
         else if(Game.bPTR)
         {
            if(objLogin.iAccess >= 40)
            {
               arrServers = whiteList(objLogin.servers,whiteListA);
            }
            else
            {
               arrServers = whiteList(objLogin.servers,whiteListB);
            }
            liveLink.alpha = 100;
         }
         else
         {
            arrServers = whiteList(objLogin.servers,[]);
         }
         rootClass.serialCmd.servers = objLogin.servers;
         blackCT.color = 0;
         drawnItems = 0;
         i = 0;
         while(i < arrServers.length)
         {
            itemClass = iList.iProto.constructor as Class;
            server = iList.addChildAt(new itemClass(),0) as MovieClip;
            if(objLogin.iLevel >= arrServers[i].iLevel)
            {
               server.ttStr = "";
               if(drawnItems % 2 > 0)
               {
                  server.x = 286;
               }
               else
               {
                  server.x = 0;
               }
               server.y = Math.floor(drawnItems / 2) * 32;
               server.obj = arrServers[i];
               server.tName.ti.text = arrServers[i].sName;
               try
               {
                  server.mcPop.txtLang.text = langMap[arrServers[i].sLang];
               }
               catch(e:*)
               {
                  server.mcPop.txtLang.text = "English";
               }
               if(arrServers[i].bUpg == 1)
               {
                  server.mcPop.txtLang.text = "Member";
               }
               iTotal += int(arrServers[i].iCount);
               if(objLogin.iAccess >= 40)
               {
                  iCap = parseInt(arrServers[i].iMax) + 10000;
               }
               else if(objLogin.iUpgDays >= 0)
               {
                  iCap = parseInt(arrServers[i].iMax) + 1000;
               }
               else
               {
                  iCap = parseInt(arrServers[i].iMax);
               }
               arrServers[i].iMax = iCap;
               server.iconStandard.visible = false;
               server.iconSafe.visible = false;
               server.iconLegen.visible = false;
               server.iconChat.visible = true;
               server.iconChat.nullset.visible = false;
               server.iconTest.visible = false;
               if(arrServers[i].bUpg == 0)
               {
                  server.ttStr += "This is a free server. ";
               }
               else
               {
                  server.ttStr += "This is an upgrade-only server. ";
                  server.tName.ti.textColor = 16763955;
               }
               if(arrServers[i].iChat == 0)
               {
                  server.iconSafe.visible = true;
                  server.iconChat.nullset.visible = true;
                  server.ttStr += "Only Canned Chat enabled.";
               }
               else
               {
                  if(arrServers[i].iChat == 1)
                  {
                     server.iconChat.alpha = 0.5;
                     server.ttStr += "Chat is limited.";
                  }
                  else
                  {
                     server.ttStr += "Chat is enabled.";
                  }
                  if(arrServers[i].bUpg == 1)
                  {
                     server.iconLegen.visible = true;
                  }
                  else
                  {
                     server.iconStandard.visible = true;
                  }
                  server.iconChat.visible = true;
               }
               if(arrServers[i].sName == "Class Test Realm")
               {
                  server.iconStandard.visible = false;
                  server.iconTest.visible = true;
               }
               n = int(arrServers[i].iCount);
               server.mcPop.visible = true;
               server.iconFull.visible = false;
               if(n < iCap)
               {
                  server.mcPop.txtPopulation.text = n;
               }
               else
               {
                  server.mcPop.visible = false;
                  server.iconFull.visible = true;
                  server.ttStr = "Server is full.";
               }
               if(arrServers[i].bOnline == 1)
               {
                  if(langMap[rootClass.params.sLang] == null)
                  {
                     rootClass.params.sLang = "en";
                  }
                  server.bgOn.gotoAndStop("Online");
                  server.mcNonPreferred.visible = false;
                  server.iconOffline.visible = false;
               }
               else
               {
                  server.bgOn.gotoAndStop("Offline");
                  server.iconOffline.visible = true;
                  server.iconStandard.visible = false;
                  server.iconSafe.visible = false;
                  server.iconLegen.visible = false;
                  server.iconChat.visible = false;
                  server.iconTest.visible = false;
                  server.mcPop.visible = false;
                  server.tName.alpha = 0.8;
                  server.ttStr = "Server is temporarily offline.";
               }
               server.mouseChildren = false;
               server.addEventListener(MouseEvent.CLICK,onServerClick,false,0,true);
               server.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
               server.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut,false,0,true);
               if(arrServers[i].bOnline == 0 || n >= iCap || arrServers[i].bUpg == 1 && objLogin.iUpgDays < 0 || arrServers[i].iChat > 0 && objLogin.iAge < 13 && objLogin.iUpgDays < 0 || arrServers[i].iChat > 0 && objLogin.bCCOnly == 1)
               {
                  server.buttonMode = true;
               }
               else
               {
                  server.mouseChildren = false;
                  server.buttonMode = true;
               }
               drawnItems++;
            }
            i++;
         }
         iList.iProto.visible = false;
         l2.y = iList.y + iList.height + 10;
         legend.y = l2.y + 8;
         bgh = int(bg.height);
         bg.height = int(legend.y + legend.height + 7);
         bg.y += int((bg.height - bgh) / 2);
         ts = "";
         if(iTotal > 0)
         {
            uCount.ti.htmlText = "<font color=\"#FFBB3E\">";
            uCount.ti.htmlText += rootClass.strNumWithCommas(iTotal);
            uCount.ti.htmlText += "</font>";
            uCount.t2.x = uCount.ti.textWidth + 7;
         }
         else
         {
            uCount.visible = false;
         }
         MovieClip(this).y = int(275 - MovieClip(this).height / 2);
         legend.btnRefresh.addEventListener(MouseEvent.CLICK,onRefreshClick,false,0,true);
         legend.txtRefresh.mouseEnabled = false;
         tRefresh.addEventListener(TimerEvent.TIMER,onRefreshCooldown,false,0,true);
         tRefresh.start();
         legend.btnBack.addEventListener(MouseEvent.CLICK,onBackClick,false,0,true);
         legend.btnHelp.addEventListener(MouseEvent.CLICK,onHelpClick,false,0,true);
         legend.btnManage.addEventListener(MouseEvent.CLICK,onManageClick,false,0,true);
         legend.fbWindow.btnFBLogout.addEventListener(MouseEvent.CLICK,onFBLogoutClick,false,0,true);
         legend.fbWindow.btnFBLogout.buttonMode = true;
         if(FacebookConnect.isLoggedIn)
         {
            try
            {
               if(rootClass.FBApi.FBImage != null)
               {
                  legend.fbImg.removeChildAt(0);
                  legend.fbWindow.fbImg.addChildAt(rootClass.FBApi.FBImage,1);
               }
            }
            catch(e:*)
            {
            }
         }
      }
      
      private function onRefreshCooldown(param1:TimerEvent) : void
      {
         legend.txtRefresh.text = tRefresh.currentCount > 4 ? "Refresh" : "Refresh (" + (5 - tRefresh.currentCount) + ")";
         if(tRefresh.currentCount > 4)
         {
            tRefresh.removeEventListener(TimerEvent.TIMER,onRefreshClick);
         }
      }
      
      private function onRefreshClick(param1:MouseEvent) : *
      {
         var _loc5_:URLVariables = null;
         if(tRefresh.running)
         {
            return;
         }
         rootClass.mcLogin.gotoAndStop("Init");
         var _loc2_:URLLoader = new URLLoader();
         var _loc3_:String = Game.serverGamePath + (Game.objLogin.iAccess >= 24 ? "api/data/serversext" : "api/data/servers") + "?v=" + Math.random();
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc2_.addEventListener(Event.COMPLETE,onServerListComplete,false,0,true);
         if(Game.objLogin.iAccess >= 24)
         {
            _loc5_ = new URLVariables();
            _loc5_.uid = Game.objLogin.userid;
            _loc5_.token = Game.objLogin.sToken;
            _loc4_.data = _loc5_;
            _loc4_.method = URLRequestMethod.POST;
         }
         else
         {
            _loc4_.method = URLRequestMethod.GET;
         }
         _loc2_.load(_loc4_);
      }
      
      private function onServerListComplete(param1:Event) : void
      {
         if(param1.target.data.indexOf("{notused}") == -1)
         {
            Game.objLogin.servers = com.adobe.serialization.json.JSON.decode(param1.target.data);
         }
         rootClass.mcLogin.gotoAndStop("Servers");
      }
      
      private function onIDClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.facebook.com/profile.php?id=" + objLogin.FBID),"_blank");
      }
      
      private function onFBLogoutClick(param1:MouseEvent) : void
      {
         FacebookConnect.Logout();
         MovieClip(parent).gotoAndPlay("Login");
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.aq.com/help/"),"_blank");
      }
      
      private function onManageClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://account.aq.com/"),"_blank");
      }
      
      private function onBackClick(param1:MouseEvent) : *
      {
         MovieClip(parent).gotoAndPlay("Login");
      }
      
      private function onServerClick(param1:MouseEvent) : *
      {
         var _loc2_:ModalMC = null;
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         rootClass.showTracking("4");
         if(!rootClass.serialCmdMode)
         {
            _loc4_ = MovieClip(param1.currentTarget);
            if(_loc4_.obj.bOnline == 0)
            {
               rootClass.MsgBox.notify("Server currently offline!");
            }
            else if(_loc4_.obj.iCount >= _loc4_.obj.iMax)
            {
               rootClass.MsgBox.notify("Server is Full!");
            }
            else if(_loc4_.obj.iChat > 0 && objLogin.bCCOnly == 1)
            {
               rootClass.MsgBox.notify("Account Restricted to Moglin Sage Server Only.");
            }
            else if(_loc4_.obj.iChat > 0 && objLogin.iAge < 13 && objLogin.iUpgDays < 0)
            {
               rootClass.MsgBox.notify("Ask your parent to upgrade your account in order to play on chat enabled servers.");
            }
            else if(_loc4_.obj.bUpg == 1 && objLogin.iUpgDays < 0)
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Member Server! Do you want to upgrade your account to access this premium server now?";
               _loc3_.params = {};
               _loc3_.callback = onModalClickUpgrade;
               _loc3_.glow = "white,medium";
               _loc3_.btns = "dual";
               rootClass.mcLogin.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
            else if(_loc4_.obj.iMax % 2 > 0)
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Testing Server! Do you want to switch to the testing game client?";
               _loc3_.params = {};
               _loc3_.callback = onModalClickTest;
               _loc3_.glow = "white,medium";
               _loc3_.btns = "dual";
               rootClass.mcLogin.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
            else if(_loc4_.obj.iLevel > 0 && objLogin.iEmailStatus <= 2)
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "This server requires a confirmed email address.";
               _loc3_.params = {};
               _loc3_.glow = "red,medium";
               _loc3_.btns = "mono";
               rootClass.mcLogin.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
            else
            {
               rootClass.objServerInfo = _loc4_.obj;
               rootClass.chatF.iChat = _loc4_.obj.iChat;
               fClose();
               rootClass.connectTo(_loc4_.obj.sIP,_loc4_.obj.iPort);
            }
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         if(_loc2_.obj.bOnline > 0 && _loc2_.frame.currentLabel != "in")
         {
            _loc2_.frame.gotoAndPlay("in");
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         if(_loc2_.obj.bOnline > 0 && _loc2_.frame.currentLabel == "in")
         {
            _loc2_.frame.gotoAndPlay("out");
         }
      }
      
      private function onModalClickUpgrade(param1:Object) : void
      {
         if(param1.accept)
         {
            navigateToURL(new URLRequest("https://aq.com/order-now/direct"),"_blank");
         }
      }
      
      private function onModalClickPTR(param1:Object) : void
      {
         if(param1.accept)
         {
            fClose();
         }
      }
      
      private function onModalClickTest(param1:Object) : void
      {
      }
      
      private function onLiveLinkClick(param1:MouseEvent) : *
      {
         fClose();
      }
      
      public function fClose() : void
      {
         killModals();
      }
      
      private function killModals() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:MovieClip = rootClass.mcLogin.ModalStack;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.numChildren)
         {
            _loc2_ = _loc1_.getChildAt(_loc3_) as MovieClip;
            if("fClose" in _loc2_)
            {
               _loc2_.fClose();
            }
            _loc3_++;
         }
      }
      
      public function getServerTabByIP(param1:String) : MovieClip
      {
         var _loc2_:* = numChildren;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc4_);
            if(_loc3_.constructor.toString().indexOf("MCServerItem") > -1 && MovieClip(_loc3_).obj != null && _loc3_.obj.sIP == param1)
            {
               return MovieClip(_loc3_);
            }
            _loc4_++;
         }
         return null;
      }
      
      private function whiteList(param1:Array, param2:Array, param3:Boolean = false) : Array
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc4_:Array = [];
         if(param1.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc5_ = false;
               if(param2.length == 0 || param2.indexOf(param1[_loc6_].sIP) > -1)
               {
                  _loc5_ = true;
                  if(param3 && rootClass.objLogin.iUpgDays < 1)
                  {
                     _loc5_ = false;
                  }
               }
               if(_loc5_)
               {
                  _loc4_.push(param1[_loc6_]);
               }
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      private function ccWhiteList(param1:Array, param2:String) : Array
      {
         if(param2 == "")
         {
            return param1;
         }
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].sLang == param2 || param1[_loc4_].bUpg == 1 || param1[_loc4_].sLang == "it")
            {
               _loc3_.push(param1[_loc4_]);
            }
            else
            {
               iTotal += int(arrServers[_loc4_].iCount);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function sortServers(param1:Array, param2:String) : Array
      {
         var _loc3_:Object = {
            "upg":[],
            "it":[]
         };
         _loc3_[param2] = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            switch(param1[_loc4_].sLang)
            {
               case "ph":
               case "pt":
               case "it":
                  _loc3_[param1[_loc4_].sLang].push(param1[_loc4_]);
                  break;
               default:
                  _loc3_["upg"].push(param1[_loc4_]);
                  break;
            }
            _loc4_++;
         }
         var _loc5_:Array = new Array();
         _loc5_ = pushServers(_loc5_,"it",_loc3_);
         _loc5_ = pushServers(_loc5_,"upg",_loc3_);
         return pushServers(_loc5_,param2,_loc3_);
      }
      
      private function pushServers(param1:Array, param2:String, param3:Object) : Array
      {
         var _loc4_:uint = 0;
         while(_loc4_ < param3[param2].length)
         {
            param1.push(param3[param2][_loc4_]);
            _loc4_++;
         }
         return param1;
      }
      
      internal function frame1() : *
      {
         visible = false;
      }
      
      internal function frame2() : *
      {
         visible = true;
         stop();
      }
   }
}

