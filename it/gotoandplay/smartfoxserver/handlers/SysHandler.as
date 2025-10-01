package it.gotoandplay.smartfoxserver.handlers
{
   import flash.utils.getTimer;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import it.gotoandplay.smartfoxserver.SmartFoxClient;
   import it.gotoandplay.smartfoxserver.data.Room;
   import it.gotoandplay.smartfoxserver.data.User;
   import it.gotoandplay.smartfoxserver.util.Entities;
   import it.gotoandplay.smartfoxserver.util.ObjectSerializer;
   
   public class SysHandler implements IMessageHandler
   {
      
      private var sfs:SmartFoxClient;
      
      private var handlersTable:Array;
      
      public function SysHandler(param1:SmartFoxClient)
      {
         super();
         this.sfs = param1;
         handlersTable = [];
         handlersTable["apiOK"] = this.handleApiOK;
         handlersTable["apiKO"] = this.handleApiKO;
         handlersTable["logOK"] = this.handleLoginOk;
         handlersTable["logKO"] = this.handleLoginKo;
         handlersTable["logout"] = this.handleLogout;
         handlersTable["rmList"] = this.handleRoomList;
         handlersTable["uCount"] = this.handleUserCountChange;
         handlersTable["joinOK"] = this.handleJoinOk;
         handlersTable["joinKO"] = this.handleJoinKo;
         handlersTable["uER"] = this.handleUserEnterRoom;
         handlersTable["userGone"] = this.handleUserLeaveRoom;
         handlersTable["pubMsg"] = this.handlePublicMessage;
         handlersTable["prvMsg"] = this.handlePrivateMessage;
         handlersTable["dmnMsg"] = this.handleAdminMessage;
         handlersTable["modMsg"] = this.handleModMessage;
         handlersTable["dataObj"] = this.handleASObject;
         handlersTable["rVarsUpdate"] = this.handleRoomVarsUpdate;
         handlersTable["roomAdd"] = this.handleRoomAdded;
         handlersTable["roomDel"] = this.handleRoomDeleted;
         handlersTable["rndK"] = this.handleRandomKey;
         handlersTable["roundTripRes"] = this.handleRoundTripBench;
         handlersTable["uVarsUpdate"] = this.handleUserVarsUpdate;
         handlersTable["createRmKO"] = this.handleCreateRoomError;
         handlersTable["bList"] = this.handleBuddyList;
         handlersTable["bUpd"] = this.handleBuddyListUpdate;
         handlersTable["bAdd"] = this.handleBuddyAdded;
         handlersTable["roomB"] = this.handleBuddyRoom;
         handlersTable["leaveRoom"] = this.handleLeaveRoom;
         handlersTable["swSpec"] = this.handleSpectatorSwitched;
         handlersTable["bPrm"] = this.handleAddBuddyPermission;
         handlersTable["remB"] = this.handleRemoveBuddy;
      }
      
      public function handleMessage(param1:Object, param2:String) : void
      {
         var _loc3_:XML = param1 as XML;
         var _loc4_:String = _loc3_.body.@action;
         var _loc5_:Function = handlersTable[_loc4_];
         if(_loc5_ != null)
         {
            _loc5_.apply(this,[param1]);
         }
      }
      
      public function handleApiOK(param1:Object) : void
      {
         sfs.isConnected = true;
         var _loc2_:SFSEvent = new SFSEvent(SFSEvent.onConnection,{"success":true});
         sfs.dispatchEvent(_loc2_);
      }
      
      public function handleApiKO(param1:Object) : void
      {
         var _loc2_:Object = {};
         _loc2_.success = false;
         _loc2_.error = "API are obsolete, please upgrade";
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.onConnection,_loc2_);
         sfs.dispatchEvent(_loc3_);
      }
      
      public function handleLoginOk(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.login.@id);
         var _loc3_:int = int(param1.body.login.@mod);
         var _loc4_:String = param1.body.login.@n;
         sfs.amIModerator = _loc3_ == 1;
         sfs.myUserId = _loc2_;
         sfs.myUserName = _loc4_;
         sfs.playerId = -1;
         var _loc5_:Object = {};
         _loc5_.success = true;
         _loc5_.name = _loc4_;
         _loc5_.error = "";
         var _loc6_:SFSEvent = new SFSEvent(SFSEvent.onLogin,_loc5_);
         sfs.dispatchEvent(_loc6_);
         sfs.getRoomList();
      }
      
      public function handleLoginKo(param1:Object) : void
      {
         var _loc2_:Object = {};
         _loc2_.success = false;
         _loc2_.error = param1.body.login.@e;
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.onLogin,_loc2_);
         sfs.dispatchEvent(_loc3_);
      }
      
      public function handleLogout(param1:Object) : void
      {
         sfs.__logout();
         var _loc2_:SFSEvent = new SFSEvent(SFSEvent.onLogout,{});
         sfs.dispatchEvent(_loc2_);
      }
      
      public function handleRoomList(param1:Object) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Object = null;
         var _loc5_:SFSEvent = null;
         var _loc6_:int = 0;
         var _loc7_:Room = null;
         sfs.clearRoomList();
         var _loc2_:Array = sfs.getAllRooms();
         for each(_loc3_ in param1.body.rmList.rm)
         {
            _loc6_ = int(_loc3_.@id);
            _loc7_ = new Room(_loc6_,_loc3_.n,int(_loc3_.@maxu),int(_loc3_.@maxs),_loc3_.@temp == "1",_loc3_.@game == "1",_loc3_.@priv == "1",_loc3_.@lmb == "1",int(_loc3_.@ucnt),int(_loc3_.@scnt));
            if(_loc3_.vars.toString().length > 0)
            {
               populateVariables(_loc7_.getVariables(),_loc3_);
            }
            _loc2_[_loc6_] = _loc7_;
         }
         _loc4_ = {};
         _loc4_.roomList = _loc2_;
         _loc5_ = new SFSEvent(SFSEvent.onRoomListUpdate,_loc4_);
         sfs.dispatchEvent(_loc5_);
      }
      
      public function handleUserCountChange(param1:Object) : void
      {
         var _loc6_:Object = null;
         var _loc7_:SFSEvent = null;
         var _loc2_:int = int(param1.body.@u);
         var _loc3_:int = int(param1.body.@s);
         var _loc4_:int = int(param1.body.@r);
         var _loc5_:Room = sfs.getAllRooms()[_loc4_];
         if(_loc5_ != null)
         {
            _loc5_.setUserCount(_loc2_);
            _loc5_.setSpectatorCount(_loc3_);
            _loc6_ = {};
            _loc6_.room = _loc5_;
            _loc7_ = new SFSEvent(SFSEvent.onUserCountChange,_loc6_);
            sfs.dispatchEvent(_loc7_);
         }
      }
      
      private function fakeRoomAdd(param1:int) : void
      {
         var _loc2_:int = int(param1);
         var _loc3_:String = String(param1);
         var _loc4_:int = 20;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = true;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Room = new Room(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         var _loc11_:Array = sfs.getAllRooms();
         _loc11_[_loc2_] = _loc10_;
      }
      
      public function handleJoinOk(param1:Object) : void
      {
         var _loc7_:XML = null;
         var _loc8_:Object = null;
         var _loc9_:SFSEvent = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:int = 0;
         var _loc15_:User = null;
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:XMLList = param1.body;
         var _loc4_:XMLList = param1.body.uLs.u;
         var _loc5_:int = int(param1.body.pid.@id);
         if(_loc2_ != 1)
         {
            fakeRoomAdd(_loc2_);
         }
         sfs.activeRoomId = _loc2_;
         var _loc6_:Room = sfs.getRoom(_loc2_);
         _loc6_.clearUserList();
         sfs.playerId = _loc5_;
         _loc6_.setMyPlayerIndex(_loc5_);
         if(_loc3_.vars.toString().length > 0)
         {
            _loc6_.clearVariables();
            populateVariables(_loc6_.getVariables(),_loc3_);
         }
         for each(_loc7_ in _loc4_)
         {
            _loc10_ = _loc7_.n;
            _loc11_ = int(_loc7_.@i);
            _loc12_ = _loc7_.@m == "1" ? true : false;
            _loc13_ = _loc7_.@s == "1" ? true : false;
            _loc14_ = _loc7_.@p == null ? -1 : int(_loc7_.@p);
            _loc15_ = new User(_loc11_,_loc10_);
            _loc15_.setModerator(_loc12_);
            _loc15_.setIsSpectator(_loc13_);
            _loc15_.setPlayerId(_loc14_);
            if(_loc7_.vars.toString().length > 0)
            {
               populateVariables(_loc15_.getVariables(),_loc7_);
            }
            _loc6_.addUser(_loc15_,_loc11_);
         }
         sfs.changingRoom = false;
         _loc8_ = {};
         _loc8_.room = _loc6_;
         _loc9_ = new SFSEvent(SFSEvent.onJoinRoom,_loc8_);
         sfs.dispatchEvent(_loc9_);
      }
      
      public function handleJoinKo(param1:Object) : void
      {
         sfs.changingRoom = false;
         var _loc2_:Object = {};
         _loc2_.error = param1.body.error.@msg;
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.onJoinRoomError,_loc2_);
         sfs.dispatchEvent(_loc3_);
      }
      
      public function handleUserEnterRoom(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.u.@i);
         var _loc4_:String = param1.body.u.n;
         var _loc5_:* = param1.body.u.@m == "1";
         var _loc6_:* = param1.body.u.@s == "1";
         var _loc7_:int = param1.body.u.@p != null ? int(param1.body.u.@p) : -1;
         var _loc8_:XMLList = param1.body.u.vars["var"];
         var _loc9_:Room = sfs.getRoom(_loc2_);
         var _loc10_:User = new User(_loc3_,_loc4_);
         _loc10_.setModerator(_loc5_);
         _loc10_.setIsSpectator(_loc6_);
         _loc10_.setPlayerId(_loc7_);
         _loc9_.addUser(_loc10_,_loc3_);
         if(param1.body.u.vars.toString().length > 0)
         {
            populateVariables(_loc10_.getVariables(),param1.body.u);
         }
         var _loc11_:Object = {};
         _loc11_.roomId = _loc2_;
         _loc11_.user = _loc10_;
         var _loc12_:SFSEvent = new SFSEvent(SFSEvent.onUserEnterRoom,_loc11_);
         sfs.dispatchEvent(_loc12_);
      }
      
      public function handleUserLeaveRoom(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.user.@id);
         var _loc3_:int = int(param1.body.@r);
         var _loc4_:Room = sfs.getRoom(_loc3_);
         var _loc5_:String = _loc4_.getUser(_loc2_).getName();
         _loc4_.removeUser(_loc2_);
         var _loc6_:Object = {};
         _loc6_.roomId = _loc3_;
         _loc6_.userId = _loc2_;
         _loc6_.userName = _loc5_;
         var _loc7_:SFSEvent = new SFSEvent(SFSEvent.onUserLeaveRoom,_loc6_);
         sfs.dispatchEvent(_loc7_);
      }
      
      public function handlePublicMessage(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:String = param1.body.txt;
         var _loc5_:User = sfs.getRoom(_loc2_).getUser(_loc3_);
         var _loc6_:Object = {};
         _loc6_.message = Entities.decodeEntities(_loc4_);
         _loc6_.sender = _loc5_;
         _loc6_.roomId = _loc2_;
         var _loc7_:SFSEvent = new SFSEvent(SFSEvent.onPublicMessage,_loc6_);
         sfs.dispatchEvent(_loc7_);
      }
      
      public function handlePrivateMessage(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:String = param1.body.txt;
         var _loc5_:User = sfs.getRoom(_loc2_).getUser(_loc3_);
         var _loc6_:Object = {};
         _loc6_.message = Entities.decodeEntities(_loc4_);
         _loc6_.sender = _loc5_;
         _loc6_.roomId = _loc2_;
         _loc6_.userId = _loc3_;
         var _loc7_:SFSEvent = new SFSEvent(SFSEvent.onPrivateMessage,_loc6_);
         sfs.dispatchEvent(_loc7_);
      }
      
      public function handleAdminMessage(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:String = param1.body.txt;
         var _loc5_:Object = {};
         _loc5_.message = Entities.decodeEntities(_loc4_);
         var _loc6_:SFSEvent = new SFSEvent(SFSEvent.onAdminMessage,_loc5_);
         sfs.dispatchEvent(_loc6_);
      }
      
      public function handleModMessage(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:String = param1.body.txt;
         var _loc5_:User = null;
         var _loc6_:Room = sfs.getRoom(_loc2_);
         if(_loc6_ != null)
         {
            _loc5_ = sfs.getRoom(_loc2_).getUser(_loc3_);
         }
         var _loc7_:Object = {};
         _loc7_.message = Entities.decodeEntities(_loc4_);
         _loc7_.sender = _loc5_;
         var _loc8_:SFSEvent = new SFSEvent(SFSEvent.onModeratorMessage,_loc7_);
         sfs.dispatchEvent(_loc8_);
      }
      
      public function handleASObject(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:String = param1.body.dataObj;
         var _loc5_:User = sfs.getRoom(_loc2_).getUser(_loc3_);
         var _loc6_:Object = ObjectSerializer.getInstance().deserialize(new XML(_loc4_));
         var _loc7_:Object = {};
         _loc7_.obj = _loc6_;
         _loc7_.sender = _loc5_;
         var _loc8_:SFSEvent = new SFSEvent(SFSEvent.onObjectReceived,_loc7_);
         sfs.dispatchEvent(_loc8_);
      }
      
      public function handleRoomVarsUpdate(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.user.@id);
         var _loc4_:Room = sfs.getRoom(_loc2_);
         var _loc5_:Array = [];
         if(param1.body.vars.toString().length > 0)
         {
            populateVariables(_loc4_.getVariables(),param1.body,_loc5_);
         }
         var _loc6_:Object = {};
         _loc6_.room = _loc4_;
         _loc6_.changedVars = _loc5_;
         var _loc7_:SFSEvent = new SFSEvent(SFSEvent.onRoomVariablesUpdate,_loc6_);
         sfs.dispatchEvent(_loc7_);
      }
      
      public function handleUserVarsUpdate(param1:Object) : void
      {
         var _loc3_:Array = null;
         var _loc6_:Room = null;
         var _loc7_:Object = null;
         var _loc8_:SFSEvent = null;
         var _loc2_:int = int(param1.body.user.@id);
         var _loc4_:User = null;
         var _loc5_:User = null;
         if(param1.body.vars.toString().length > 0)
         {
            for each(_loc6_ in sfs.getAllRooms())
            {
               _loc4_ = _loc6_.getUser(_loc2_);
               if(_loc4_ != null)
               {
                  if(_loc5_ == null)
                  {
                     _loc5_ = _loc4_;
                  }
                  _loc3_ = [];
                  populateVariables(_loc4_.getVariables(),param1.body,_loc3_);
               }
            }
            _loc7_ = {};
            _loc7_.user = _loc5_;
            _loc7_.changedVars = _loc3_;
            _loc8_ = new SFSEvent(SFSEvent.onUserVariablesUpdate,_loc7_);
            sfs.dispatchEvent(_loc8_);
         }
      }
      
      private function handleRoomAdded(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.rm.@id);
         var _loc3_:String = param1.body.rm.name;
         var _loc4_:int = int(param1.body.rm.@max);
         var _loc5_:int = int(param1.body.rm.@spec);
         var _loc6_:Boolean = param1.body.rm.@temp == "1" ? true : false;
         var _loc7_:Boolean = param1.body.rm.@game == "1" ? true : false;
         var _loc8_:Boolean = param1.body.rm.@priv == "1" ? true : false;
         var _loc9_:Boolean = param1.body.rm.@limbo == "1" ? true : false;
         var _loc10_:Room = new Room(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
         var _loc11_:Array = sfs.getAllRooms();
         _loc11_[_loc2_] = _loc10_;
         if(param1.body.rm.vars.toString().length > 0)
         {
            populateVariables(_loc10_.getVariables(),param1.body.rm);
         }
         var _loc12_:Object = {};
         _loc12_.room = _loc10_;
         var _loc13_:SFSEvent = new SFSEvent(SFSEvent.onRoomAdded,_loc12_);
         sfs.dispatchEvent(_loc13_);
      }
      
      private function handleRoomDeleted(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.rm.@id);
         var _loc3_:Array = sfs.getAllRooms();
         var _loc4_:Object = {};
         _loc4_.room = _loc3_[_loc2_];
         delete _loc3_[_loc2_];
         var _loc5_:SFSEvent = new SFSEvent(SFSEvent.onRoomDeleted,_loc4_);
         sfs.dispatchEvent(_loc5_);
      }
      
      private function handleRandomKey(param1:Object) : void
      {
         var _loc2_:String = param1.body.k.toString();
         var _loc3_:Object = {};
         _loc3_.key = _loc2_;
         var _loc4_:SFSEvent = new SFSEvent(SFSEvent.onRandomKey,_loc3_);
         sfs.dispatchEvent(_loc4_);
      }
      
      private function handleRoundTripBench(param1:Object) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - sfs.getBenchStartTime();
         var _loc4_:Object = {};
         _loc4_.elapsed = _loc3_;
         var _loc5_:SFSEvent = new SFSEvent(SFSEvent.onRoundTripResponse,_loc4_);
         sfs.dispatchEvent(_loc5_);
      }
      
      private function handleCreateRoomError(param1:Object) : void
      {
         var _loc2_:String = param1.body.room.@e;
         var _loc3_:Object = {};
         _loc3_.error = _loc2_;
         var _loc4_:SFSEvent = new SFSEvent(SFSEvent.onCreateRoomError,_loc3_);
         sfs.dispatchEvent(_loc4_);
      }
      
      private function handleBuddyList(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         var _loc9_:XMLList = null;
         var _loc10_:XML = null;
         var _loc2_:XMLList = param1.body.bList;
         var _loc3_:XMLList = param1.body.mv;
         var _loc5_:Object = {};
         var _loc6_:SFSEvent = null;
         if(_loc3_ != null && _loc3_.toString().length > 0)
         {
            for each(_loc7_ in _loc3_.v)
            {
               sfs.myBuddyVars[_loc7_.@n.toString()] = _loc7_.toString();
            }
         }
         if(_loc2_ != null && _loc2_.b.length != null)
         {
            if(_loc2_.toString().length > 0)
            {
               for each(_loc8_ in _loc2_.b)
               {
                  _loc4_ = {};
                  _loc4_.isOnline = _loc8_.@s == "1" ? true : false;
                  _loc4_.name = _loc8_.n.toString();
                  _loc4_.id = _loc8_.@i;
                  _loc4_.isBlocked = _loc8_.@x == "1" ? true : false;
                  _loc4_.variables = {};
                  _loc9_ = _loc8_.vs;
                  if(_loc9_.toString().length > 0)
                  {
                     for each(_loc10_ in _loc9_.v)
                     {
                        _loc4_.variables[_loc10_.@n.toString()] = _loc10_.toString();
                     }
                  }
                  sfs.buddyList.push(_loc4_);
               }
            }
            _loc5_.list = sfs.buddyList;
            _loc6_ = new SFSEvent(SFSEvent.onBuddyList,_loc5_);
            sfs.dispatchEvent(_loc6_);
         }
         else
         {
            _loc5_.error = param1.body.err.toString();
            _loc6_ = new SFSEvent(SFSEvent.onBuddyListError,_loc5_);
            sfs.dispatchEvent(_loc6_);
         }
      }
      
      private function handleBuddyListUpdate(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:XMLList = null;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc8_:String = null;
         var _loc9_:XML = null;
         var _loc2_:Object = {};
         var _loc3_:SFSEvent = null;
         if(param1.body.b != null)
         {
            _loc4_ = {};
            _loc4_.isOnline = param1.body.b.@s == "1" ? true : false;
            _loc4_.name = param1.body.b.n.toString();
            _loc4_.id = param1.body.b.@i;
            _loc4_.isBlocked = param1.body.b.@x == "1" ? true : false;
            _loc5_ = param1.body.b.vs;
            _loc6_ = null;
            _loc7_ = false;
            for(_loc8_ in sfs.buddyList)
            {
               _loc6_ = sfs.buddyList[_loc8_];
               if(_loc6_.name == _loc4_.name)
               {
                  sfs.buddyList[_loc8_] = _loc4_;
                  _loc4_.isBlocked = _loc6_.isBlocked;
                  _loc4_.variables = _loc6_.variables;
                  if(_loc5_.toString().length > 0)
                  {
                     for each(_loc9_ in _loc5_.v)
                     {
                        _loc4_.variables[_loc9_.@n.toString()] = _loc9_.toString();
                     }
                  }
                  _loc7_ = true;
                  break;
               }
            }
            if(_loc7_)
            {
               _loc2_.buddy = _loc4_;
               _loc3_ = new SFSEvent(SFSEvent.onBuddyListUpdate,_loc2_);
               sfs.dispatchEvent(_loc3_);
            }
         }
         else
         {
            _loc2_.error = param1.body.err.toString();
            _loc3_ = new SFSEvent(SFSEvent.onBuddyListError,_loc2_);
            sfs.dispatchEvent(_loc3_);
         }
      }
      
      private function handleAddBuddyPermission(param1:Object) : void
      {
         var _loc2_:Object = {};
         _loc2_.sender = param1.body.n.toString();
         _loc2_.message = "";
         if(param1.body.txt != undefined)
         {
            _loc2_.message = Entities.decodeEntities(param1.body.txt);
         }
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.onBuddyPermissionRequest,_loc2_);
         sfs.dispatchEvent(_loc3_);
      }
      
      private function handleBuddyAdded(param1:Object) : void
      {
         var _loc6_:XML = null;
         var _loc2_:Object = {};
         _loc2_.isOnline = param1.body.b.@s == "1" ? true : false;
         _loc2_.name = param1.body.b.n.toString();
         _loc2_.id = param1.body.b.@i;
         _loc2_.isBlocked = param1.body.b.@x == "1" ? true : false;
         _loc2_.variables = {};
         var _loc3_:XMLList = param1.body.b.vs;
         if(_loc3_.toString().length > 0)
         {
            for each(_loc6_ in _loc3_.v)
            {
               _loc2_.variables[_loc6_.@n.toString()] = _loc6_.toString();
            }
         }
         sfs.buddyList.push(_loc2_);
         var _loc4_:Object = {};
         _loc4_.list = sfs.buddyList;
         var _loc5_:SFSEvent = new SFSEvent(SFSEvent.onBuddyList,_loc4_);
         sfs.dispatchEvent(_loc5_);
      }
      
      private function handleRemoveBuddy(param1:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:SFSEvent = null;
         var _loc2_:String = param1.body.n.toString();
         var _loc3_:Object = null;
         for(_loc4_ in sfs.buddyList)
         {
            _loc3_ = sfs.buddyList[_loc4_];
            if(_loc3_.name == _loc2_)
            {
               delete sfs.buddyList[_loc4_];
               _loc5_ = {};
               _loc5_.list = sfs.buddyList;
               _loc6_ = new SFSEvent(SFSEvent.onBuddyList,_loc5_);
               sfs.dispatchEvent(_loc6_);
               break;
            }
         }
      }
      
      private function handleBuddyRoom(param1:Object) : void
      {
         var _loc2_:String = param1.body.br.@r;
         var _loc3_:Array = _loc2_.split(",");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_] = int(_loc3_[_loc4_]);
            _loc4_++;
         }
         var _loc5_:Object = {};
         _loc5_.idList = _loc3_;
         var _loc6_:SFSEvent = new SFSEvent(SFSEvent.onBuddyRoom,_loc5_);
         sfs.dispatchEvent(_loc6_);
      }
      
      private function handleLeaveRoom(param1:Object) : void
      {
         var _loc2_:int = int(param1.body.rm.@id);
         var _loc3_:Object = {};
         _loc3_.roomId = _loc2_;
         var _loc4_:SFSEvent = new SFSEvent(SFSEvent.onRoomLeft,_loc3_);
         sfs.dispatchEvent(_loc4_);
      }
      
      private function handleSpectatorSwitched(param1:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:User = null;
         var _loc7_:Object = null;
         var _loc8_:SFSEvent = null;
         var _loc2_:int = int(param1.body.@r);
         var _loc3_:int = int(param1.body.pid.@id);
         var _loc4_:Room = sfs.getRoom(_loc2_);
         if(_loc3_ > 0)
         {
            _loc4_.setUserCount(_loc4_.getUserCount() + 1);
            _loc4_.setSpectatorCount(_loc4_.getSpectatorCount() - 1);
         }
         if(param1.body.pid.@u != undefined)
         {
            _loc5_ = int(param1.body.pid.@u);
            _loc6_ = _loc4_.getUser(_loc5_);
            if(_loc6_ != null)
            {
               _loc6_.setIsSpectator(false);
               _loc6_.setPlayerId(_loc3_);
            }
         }
         else
         {
            sfs.playerId = _loc3_;
            _loc7_ = {};
            _loc7_.success = sfs.playerId > 0;
            _loc7_.newId = sfs.playerId;
            _loc7_.room = _loc4_;
            _loc8_ = new SFSEvent(SFSEvent.onSpectatorSwitched,_loc7_);
            sfs.dispatchEvent(_loc8_);
         }
      }
      
      private function populateVariables(param1:Array, param2:Object, param3:Array = null) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         for each(_loc4_ in param2.vars["var"])
         {
            _loc5_ = _loc4_.@n;
            _loc6_ = _loc4_.@t;
            _loc7_ = _loc4_;
            if(param3 != null)
            {
               param3.push(_loc5_);
               param3[_loc5_] = true;
            }
            if(_loc6_ == "b")
            {
               param1[_loc5_] = _loc7_ == "1" ? true : false;
            }
            else if(_loc6_ == "n")
            {
               param1[_loc5_] = Number(_loc7_);
            }
            else if(_loc6_ == "s")
            {
               param1[_loc5_] = _loc7_;
            }
            else if(_loc6_ == "x")
            {
               delete param1[_loc5_];
            }
         }
      }
      
      public function dispatchDisconnection() : void
      {
         var _loc1_:SFSEvent = new SFSEvent(SFSEvent.onConnectionLost,null);
         sfs.dispatchEvent(_loc1_);
      }
   }
}

