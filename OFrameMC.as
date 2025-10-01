package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.*;
   import flash.utils.getDefinitionByName;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2495")]
   public class OFrameMC extends MovieClip
   {
      
      public var t1:MovieClip;
      
      public var cntMask:MovieClip;
      
      public var bg:MovieClip;
      
      internal var world:MovieClip;
      
      internal var rootClass:MovieClip;
      
      public var fData:Object = null;
      
      internal var uli:int;
      
      internal var isOpen:Boolean = false;
      
      internal var mc:MovieClip;
      
      internal var tcnt:MovieClip;
      
      internal var mDown:Boolean = false;
      
      internal var hRun:int = 0;
      
      internal var dRun:int = 0;
      
      internal var mbY:int = 0;
      
      internal var mhY:int = 0;
      
      internal var mbD:int = 0;
      
      public function OFrameMC()
      {
         super();
         addFrameScript(0,frame1,4,frame5,9,frame10);
         mc = MovieClip(this);
         rootClass = MovieClip(stage.getChildAt(0));
      }
      
      public function fOpenWith(param1:*) : *
      {
         fData = param1;
         isOpen = true;
         clearCnt();
         if(mc.currentLabel != "Idle")
         {
            mc.gotoAndPlay("Open");
         }
         else
         {
            update();
         }
      }
      
      public function fClose() : *
      {
         isOpen = false;
         fData = {};
         clearCnt();
         if(mc.currentLabel != "Init")
         {
            if(mc.currentLabel == "Idle")
            {
               mc.gotoAndPlay("Close");
            }
            else
            {
               mc.gotoAndStop("Init");
            }
         }
      }
      
      public function update() : *
      {
         var _loc1_:String = null;
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:Object = null;
         var _loc8_:String = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         mc.bg.btnPin.visible = false;
         mc.bg.btnTry.visible = false;
         mc.bg.btnWiki.visible = false;
         clearCnt();
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         switch(fData.typ)
         {
            case "userListA":
               _loc1_ = "mcUListA";
               _loc2_ = getDefinitionByName(_loc1_) as Class;
               _loc3_ = mc.addChild(new _loc2_()) as MovieClip;
               _loc3_.name = "cnt";
               _loc3_.x = 10;
               _loc3_.y = t1.y + t1.height + 4;
               _loc3_.mask = cntMask;
               _loc3_.scr.buttonMode = true;
               t1.txtTitle.text = "Users in your area";
               t1.txtSubTitle.text = "/who";
               _loc6_ = 0;
               tcnt = MovieClip(mc.getChildByName("cnt"));
               tcnt.strMeta.text = "Class";
               for(_loc8_ in fData.ul)
               {
                  _loc5_ = tcnt.cnt.addChild(new mcUListAItem());
                  _loc5_.ID = fData.ul[_loc8_].ID;
                  _loc5_.txtName.text = fData.ul[_loc8_].sName;
                  _loc5_.txtMeta.text = fData.ul[_loc8_].sClass;
                  _loc5_.txtLevel.text = fData.ul[_loc8_].iLvl;
                  _loc5_.addEventListener(MouseEvent.CLICK,uNameClick,false,0,true);
                  _loc5_.buttonMode = true;
                  _loc5_.y = _loc6_ * 20;
                  _loc6_++;
               }
               _loc9_ = tcnt.scr;
               if(tcnt.cnt.height < tcnt.cntMask.height)
               {
                  _loc9_.visible = false;
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.cntMask.width / 2);
               }
               else
               {
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.width / 2);
                  _loc10_ = tcnt.cntMask;
                  _loc11_ = tcnt.cnt;
                  _loc9_.visible = true;
                  _loc9_.h.height = int(_loc10_.height / _loc11_.height * _loc9_.b.height);
                  hRun = _loc9_.b.height - _loc9_.h.height;
                  dRun = _loc11_.height - _loc10_.height + 5;
                  _loc9_.h.y = 0;
                  _loc11_.oy = _loc11_.y = _loc9_.y;
                  _loc9_.visible = false;
                  _loc9_.hit.alpha = 0;
                  mDown = false;
                  if(_loc11_.height > _loc9_.b.height)
                  {
                     _loc9_.visible = true;
                     _loc9_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
                     _loc9_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
                     _loc11_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
                  }
               }
               tcnt.cnt.iproto.visible = false;
               break;
            case "userListFriends":
               _loc1_ = "mcUListA";
               _loc2_ = getDefinitionByName(_loc1_) as Class;
               _loc3_ = mc.addChild(new _loc2_()) as MovieClip;
               _loc3_.name = "cnt";
               _loc3_.x = 10;
               _loc3_.y = t1.y + t1.height + 4;
               _loc3_.mask = cntMask;
               _loc3_.scr.buttonMode = true;
               t1.txtTitle.text = "Friends List - " + fData.ul.length + "/" + String(rootClass.iMaxFriends);
               t1.txtSubTitle.text = "/friends";
               _loc6_ = 0;
               tcnt = MovieClip(mc.getChildByName("cnt"));
               tcnt.strMeta.text = "Server";
               _loc7_ = 0;
               while(_loc7_ < fData.ul.length)
               {
                  _loc5_ = tcnt.cnt.addChild(new mcUListAItem());
                  _loc5_.ID = fData.ul[_loc7_].ID;
                  _loc5_.txtName.text = fData.ul[_loc7_].sName;
                  _loc5_.txtMeta.text = fData.ul[_loc7_].sServer;
                  _loc5_.txtLevel.text = fData.ul[_loc7_].iLvl;
                  _loc5_.addEventListener(MouseEvent.CLICK,uNameClick,false,0,true);
                  _loc5_.buttonMode = true;
                  _loc5_.y = _loc6_ * 20;
                  _loc6_++;
                  if(fData.ul[_loc7_].sServer == "Offline")
                  {
                     _loc5_.transform.colorTransform = new ColorTransform(1,1,1,1,-100,-100,-100,0);
                  }
                  _loc7_++;
               }
               _loc9_ = tcnt.scr;
               if(tcnt.cnt.height < tcnt.cntMask.height)
               {
                  _loc9_.visible = false;
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.cntMask.width / 2);
               }
               else
               {
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.width / 2);
                  _loc10_ = tcnt.cntMask;
                  _loc11_ = tcnt.cnt;
                  _loc9_.visible = true;
                  _loc9_.h.height = int(_loc10_.height / _loc11_.height * _loc9_.b.height);
                  hRun = _loc9_.b.height - _loc9_.h.height;
                  dRun = _loc11_.height - _loc10_.height + 5;
                  _loc9_.h.y = 0;
                  _loc11_.oy = _loc11_.y = _loc9_.y;
                  _loc9_.visible = false;
                  _loc9_.hit.alpha = 0;
                  mDown = false;
                  if(_loc11_.height > _loc9_.b.height)
                  {
                     _loc9_.visible = true;
                     _loc9_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
                     _loc9_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
                     _loc11_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
                  }
               }
               tcnt.cnt.iproto.visible = false;
               break;
            case "userListGuild":
               _loc1_ = "mcUListA";
               _loc2_ = getDefinitionByName(_loc1_) as Class;
               _loc3_ = mc.addChild(new _loc2_()) as MovieClip;
               _loc3_.name = "cnt";
               _loc3_.x = 10;
               _loc3_.y = t1.y + t1.height + 4;
               _loc3_.mask = cntMask;
               _loc3_.scr.buttonMode = true;
               t1.txtTitle.text = "Guild Members";
               t1.txtSubTitle.text = "/guild";
               _loc6_ = 0;
               tcnt = MovieClip(mc.getChildByName("cnt"));
               tcnt.strMeta.text = "Server";
               _loc7_ = 0;
               while(_loc7_ < fData.ul.length)
               {
                  _loc5_ = tcnt.cnt.addChild(new mcUListAItem());
                  _loc5_.ID = fData.ul[_loc7_].ID;
                  _loc5_.txtName.text = fData.ul[_loc7_].userName;
                  _loc5_.txtMeta.text = fData.ul[_loc7_].Server;
                  _loc5_.txtLevel.text = fData.ul[_loc7_].Level;
                  _loc5_.addEventListener(MouseEvent.CLICK,uNameClick,false,0,true);
                  _loc5_.buttonMode = true;
                  _loc5_.y = _loc6_ * 20;
                  _loc6_++;
                  if(fData.ul[_loc7_].sServer == "Offline")
                  {
                     _loc5_.transform.colorTransform = new ColorTransform(1,1,1,1,-100,-100,-100,0);
                  }
                  _loc7_++;
               }
               _loc9_ = tcnt.scr;
               if(tcnt.cnt.height < tcnt.cntMask.height)
               {
                  _loc9_.visible = false;
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.cntMask.width / 2);
               }
               else
               {
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.width / 2);
                  _loc10_ = tcnt.cntMask;
                  _loc11_ = tcnt.cnt;
                  _loc9_.visible = true;
                  _loc9_.h.height = int(_loc10_.height / _loc11_.height * _loc9_.b.height);
                  hRun = _loc9_.b.height - _loc9_.h.height;
                  dRun = _loc11_.height - _loc10_.height + 5;
                  _loc9_.h.y = 0;
                  _loc11_.oy = _loc11_.y = _loc9_.y;
                  _loc9_.visible = false;
                  _loc9_.hit.alpha = 0;
                  mDown = false;
                  if(_loc11_.height > _loc9_.b.height)
                  {
                     _loc9_.visible = true;
                     _loc9_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
                     _loc9_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
                     _loc11_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
                  }
               }
               tcnt.cnt.iproto.visible = false;
               break;
            case "userListIgnore":
               _loc1_ = "mcUListB";
               _loc2_ = getDefinitionByName(_loc1_) as Class;
               _loc3_ = mc.addChild(new _loc2_()) as MovieClip;
               _loc3_.name = "cnt";
               _loc3_.x = 10;
               _loc3_.y = t1.y + t1.height + 4;
               _loc3_.mask = cntMask;
               _loc3_.scr.buttonMode = true;
               t1.txtTitle.text = "Ignore List";
               t1.txtSubTitle.text = "";
               _loc6_ = 0;
               tcnt = MovieClip(mc.getChildByName("cnt"));
               fData.ul = [];
               for each(_loc8_ in rootClass.chatF.ignoreList.data.users)
               {
                  fData.ul.push({"sName":_loc8_});
               }
               _loc7_ = 0;
               while(_loc7_ < fData.ul.length)
               {
                  _loc5_ = tcnt.cnt.addChild(new mcUListBItem());
                  _loc5_.txtName.text = fData.ul[_loc7_].sName;
                  _loc5_.addEventListener(MouseEvent.CLICK,uNameClick,false,0,true);
                  _loc5_.buttonMode = true;
                  _loc5_.y = _loc6_ * 20;
                  _loc6_++;
                  _loc7_++;
               }
               _loc9_ = tcnt.scr;
               if(tcnt.cnt.height < tcnt.cntMask.height)
               {
                  _loc9_.visible = false;
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.cntMask.width / 2);
               }
               else
               {
                  _loc3_.x = int(mc.bg.x + mc.bg.width / 2 - _loc3_.width / 2);
                  _loc10_ = tcnt.cntMask;
                  _loc11_ = tcnt.cnt;
                  _loc9_.visible = true;
                  _loc9_.h.height = int(_loc10_.height / _loc11_.height * _loc9_.b.height);
                  hRun = _loc9_.b.height - _loc9_.h.height;
                  dRun = _loc11_.height - _loc10_.height + 5;
                  _loc9_.h.y = 0;
                  _loc11_.oy = _loc11_.y = _loc9_.y;
                  _loc9_.visible = false;
                  _loc9_.hit.alpha = 0;
                  mDown = false;
                  if(_loc11_.height > _loc9_.b.height)
                  {
                     _loc9_.visible = true;
                     _loc9_.hit.addEventListener(MouseEvent.MOUSE_DOWN,scrDown,false,0,true);
                     _loc9_.h.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
                     _loc11_.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
                  }
               }
               tcnt.cnt.iproto.visible = false;
         }
         mc.bg.btnClose.addEventListener(MouseEvent.CLICK,closeClick,false,0,true);
         mc.bg.fx.visible = false;
      }
      
      private function clearCnt() : *
      {
         var _loc1_:* = mc.getChildByName("cnt");
         if(_loc1_ != null)
         {
            mc.removeChild(_loc1_);
         }
      }
      
      private function closeClick(param1:MouseEvent) : *
      {
         fClose();
      }
      
      private function uNameClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         rootClass.debugMessage("User clicked: " + _loc2_.txtName.text);
         var _loc3_:* = {};
         if("ID" in _loc2_)
         {
            _loc3_.ID = _loc2_.ID;
         }
         _loc3_.strUsername = _loc2_.txtName.text;
         if(fData.typ == "userListFriends" && _loc2_.txtMeta.text != rootClass.objServerInfo.sName)
         {
            rootClass.ui.cMenu.fOpenWith("offline",_loc3_);
         }
         else if(fData.typ == "userListFriends" && _loc2_.txtMeta.text == rootClass.objServerInfo.sName)
         {
            rootClass.ui.cMenu.fOpenWith("friend",_loc3_);
         }
         else if(fData.typ == "userListIgnore")
         {
            rootClass.ui.cMenu.fOpenWith("ignored",_loc3_);
         }
         else
         {
            rootClass.ui.cMenu.fOpenWith("user",_loc3_);
         }
      }
      
      private function scrUp(param1:MouseEvent) : *
      {
         mDown = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,scrUp);
      }
      
      private function scrDown(param1:MouseEvent) : *
      {
         mbY = int(mouseY);
         mhY = int(tcnt.scr.h.y);
         mDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,scrUp);
      }
      
      private function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = tcnt.scr;
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
         var _loc2_:* = tcnt.scr;
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
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame5() : *
      {
         update();
      }
      
      internal function frame10() : *
      {
         stop();
      }
   }
}

