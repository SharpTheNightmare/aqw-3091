package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class interfaceMenu extends MovieClip
   {
      
      public var mcMenu:MovieClip;
      
      private var currentPos:Number;
      
      private var h:Number = 25.2;
      
      private var w:Number = 118.25;
      
      public var btnOpen:String = "";
      
      private var rootClass:MovieClip;
      
      public function interfaceMenu(param1:Array, param2:String, param3:MovieClip)
      {
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         super();
         btnOpen = param2;
         rootClass = param3;
         mcMenu = new MovieClip();
         _loc4_ = new menuBottom() as MovieClip;
         --_loc4_.height;
         --_loc4_.width;
         _loc4_.x -= 43;
         _loc4_.y -= 10.7;
         currentPos = _loc4_.y - 2;
         mcMenu.addChild(_loc4_);
         _loc4_ = new menuListItem() as MovieClip;
         _loc4_.x += 17;
         _loc4_.height = h;
         _loc4_.width = w;
         _loc4_.mTxt.text = param1[0].txt;
         _loc4_.y = currentPos - (h >> 1) + 1;
         _loc4_.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
         _loc4_.buttonMode = true;
         _loc4_.mouseChildren = false;
         _loc4_.name = param1[0].fct;
         currentPos = _loc4_.y;
         mcMenu.addChild(_loc4_);
         _loc5_ = 1;
         while(_loc5_ < param1.length - 1)
         {
            _loc4_ = new menuListItem() as MovieClip;
            _loc4_.x += 17;
            _loc4_.height = h;
            _loc4_.width = w;
            _loc4_.y = currentPos - h + 1;
            currentPos = _loc4_.y;
            _loc4_.mTxt.text = param1[_loc5_].txt;
            _loc4_.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
            _loc4_.buttonMode = true;
            _loc4_.mouseChildren = false;
            _loc4_.name = param1[_loc5_].fct;
            mcMenu.addChild(_loc4_);
            _loc5_++;
         }
         _loc4_ = new menuTop() as MovieClip;
         --_loc4_.height;
         --_loc4_.width;
         _loc4_.y = currentPos - _loc4_.height;
         _loc4_.txt.text = param1[param1.length - 1].txt;
         _loc4_.x += 17;
         mcMenu.addChild(_loc4_);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc3_:Function = null;
         var _loc2_:Array = param1.currentTarget.name.split(".");
         switch(_loc2_.length)
         {
            case 1:
               _loc3_ = this[param1.currentTarget.name];
               break;
            case 2:
               _loc3_ = rootClass[_loc2_[1]];
               break;
            case 3:
               _loc3_ = rootClass.world[_loc2_[2]];
         }
         _loc3_();
      }
      
      private function gotoMyHouse() : void
      {
         if(rootClass.world.strMapName.toLowerCase() == "house" && Boolean(rootClass.world.isMyHouse()))
         {
            rootClass.world.moveToCell("Enter","Spawn");
         }
         if(rootClass.world.isHouseEquipped())
         {
            rootClass.world.gotoHouse(rootClass.sfc.myUserName);
         }
         else
         {
            rootClass.world.gotoTown("buyhouse","Enter","Spawn");
         }
      }
      
      private function gotoCentaur() : void
      {
         rootClass.world.gotoTown("buyhouse","Enter","Spawn");
      }
      
      private function toggleHouseInventory() : void
      {
         if(!rootClass.world.uiLock)
         {
            if(rootClass.ui.mcPopup.currentLabel == "HouseInventory")
            {
               MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).fClose();
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("HouseInventory");
            }
         }
      }
      
      private function charPage() : void
      {
         var _loc1_:String = rootClass.world.myAvatar.objData.strUsername;
         if(rootClass.params.strSourceID == "BBGames")
         {
            navigateToURL(new URLRequest("https://www.aq.com/embed/bbgames/aw-character.asp?id=" + _loc1_),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("https://www.aq.com/aw-character.asp?id=" + _loc1_),"_blank");
         }
      }
      
      private function toggleTempInventory() : void
      {
         if(!rootClass.world.uiLock)
         {
            if(rootClass.ui.mcPopup.currentLabel == "Temp")
            {
               rootClass.ui.mcPopup.onClose();
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("Temp");
            }
         }
      }
      
      private function toggleInventory() : void
      {
         if(!rootClass.world.uiLock)
         {
            if(rootClass.ui.mcPopup.currentLabel == "Inventory" || rootClass.ui.mcPopup.currentLabel == "HouseInventory")
            {
               MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).fClose();
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("Inventory");
            }
         }
      }
   }
}

