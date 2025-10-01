package spider_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3977")]
   public dynamic class mcMenu_299 extends MovieClip
   {
      
      public var btnQuest:MovieClip;
      
      public var btnRest:SimpleButton;
      
      public var btnHouse:MovieClip;
      
      public var btnChar:MovieClip;
      
      public var btnMenu:SimpleButton;
      
      public var btnBook:SimpleButton;
      
      public var btnBag:SimpleButton;
      
      public var btnMap:SimpleButton;
      
      public var btnOption:SimpleButton;
      
      public var menu:*;
      
      public function mcMenu_299()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function onMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(stage.getChildAt(0));
         var _loc3_:* = MovieClip(stage.getChildAt(0)).ui.ToolTip;
         switch(param1.currentTarget.name)
         {
            case "btnRest":
               _loc3_.openWith({"str":"Rest"});
               break;
            case "btnBag":
               _loc3_.openWith({"str":"Inventory"});
               break;
            case "btnTemp":
               _loc3_.openWith({"str":"Temp Inventory"});
               break;
            case "btnMenu":
               _loc3_.openWith({"str":"Game Menu"});
               break;
            case "btnMap":
               _loc3_.openWith({"str":"Map"});
               break;
            case "btnOption":
               _loc3_.openWith({"str":"Options"});
               break;
            case "btnQuest":
               _loc3_.openWith({"str":"Quests"});
               break;
            case "btnBook":
               _loc3_.openWith({"str":"Book of Lore"});
               break;
            case "btnHouse":
               _loc3_.openWith({"str":"House"});
               break;
            case "btnChar":
               if(menu == null)
               {
                  _loc3_.openWith({"str":"Character"});
               }
         }
      }
      
      public function onMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(stage.getChildAt(0));
         var _loc3_:* = MovieClip(stage.getChildAt(0)).ui.ToolTip;
         _loc3_.close();
      }
      
      public function onMouseClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(stage.getChildAt(0));
         MovieClip(Game.root).mixer.playSound("Click");
         if(param1.currentTarget.name != "btnMenu")
         {
            _loc2_.menuClose();
         }
         switch(param1.currentTarget.name)
         {
            case "btnRest":
               handleMenu(null);
               MovieClip(parent.parent.parent).world.rest();
               break;
            case "btnBag":
               handleMenu(null);
               toggleInventory();
               break;
            case "btnMenu":
               handleMenu(null);
               _loc2_.MenuShow();
               break;
            case "btnMap":
               if(_loc2_.ui.mcPopup.currentLabel == "Map")
               {
                  _loc2_.ui.mcPopup.onClose();
               }
               else
               {
                  handleMenu(null);
                  _loc2_.ui.mcPopup.fOpen("Map");
               }
               break;
            case "btnBook":
               if(_loc2_.ui.mcPopup.currentLabel == "Book")
               {
                  _loc2_.ui.mcPopup.onClose();
               }
               else
               {
                  handleMenu(null);
                  _loc2_.ui.mcPopup.fOpen("Book");
               }
               break;
            case "btnOption":
               if(_loc2_.ui.mcPopup.currentLabel == "Option")
               {
                  _loc2_.ui.mcPopup.onClose();
               }
               else
               {
                  handleMenu(null);
                  _loc2_.ui.mcPopup.fOpen("Option");
               }
               break;
            case "btnQuest":
               handleMenu(MovieClip(param1.currentTarget));
               break;
            case "btnHouse":
               if(_loc2_.world.strMapName.toLowerCase() == "house" && Boolean(_loc2_.world.isMyHouse()))
               {
                  _loc2_.world.moveToCell("Enter","Spawn");
                  break;
               }
               if(_loc2_.world.isHouseEquipped())
               {
                  _loc2_.world.gotoHouse(_loc2_.sfc.myUserName);
               }
               else
               {
                  _loc2_.world.gotoTown("buyhouse","Enter","Spawn");
               }
               break;
            case "btnChar":
               handleMenu(MovieClip(param1.currentTarget));
         }
      }
      
      public function handleMenu(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 == null)
         {
            if(menu == null)
            {
               return;
            }
            _loc2_ = MovieClip(this.getChildByName(menu.btnOpen));
            _loc2_.removeChild(menu.mcMenu);
            menu = null;
            return;
         }
         if(menu == null)
         {
            menu = new interfaceMenu(param1.buttons,param1.name,MovieClip(stage.getChildAt(0)));
            param1.addChild(menu.mcMenu);
         }
         else if(param1 == null || menu.btnOpen == param1.name)
         {
            param1.removeChild(menu.mcMenu);
            menu = null;
         }
         else
         {
            _loc2_ = MovieClip(this.getChildByName(menu.btnOpen));
            _loc2_.removeChild(menu.mcMenu);
            menu = null;
            menu = new interfaceMenu(param1.buttons,param1.name,MovieClip(stage.getChildAt(0)));
            param1.addChild(menu.mcMenu);
         }
      }
      
      public function toggleTempInventory() : void
      {
         var _loc1_:* = MovieClip(stage.getChildAt(0));
         if(!_loc1_.world.uiLock)
         {
            if(_loc1_.ui.mcPopup.currentLabel == "Temp")
            {
               _loc1_.ui.mcPopup.onClose();
            }
            else
            {
               _loc1_.ui.mcPopup.fOpen("Temp");
            }
         }
      }
      
      public function toggleInventory() : void
      {
         var _loc1_:* = MovieClip(stage.getChildAt(0));
         if(!_loc1_.world.uiLock)
         {
            if(_loc1_.ui.mcPopup.currentLabel == "Inventory" || _loc1_.ui.mcPopup.currentLabel == "HouseInventory")
            {
               MovieClip(_loc1_.ui.mcPopup.getChildByName("mcInventory")).fClose();
            }
            else
            {
               _loc1_.ui.mcPopup.fOpen("Inventory");
            }
         }
      }
      
      internal function frame1() : *
      {
         btnRest.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnRest.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnBag.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnBag.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnMenu.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnMenu.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnMap.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnMap.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnOption.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnOption.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnQuest.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnQuest.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnRest.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnBag.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnMenu.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnOption.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnMap.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnQuest.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnBook.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnBook.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnBook.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnHouse.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnHouse.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnHouse.addEventListener(MouseEvent.CLICK,onMouseClick);
         btnChar.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
         btnChar.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
         btnChar.addEventListener(MouseEvent.CLICK,onMouseClick);
      }
   }
}

