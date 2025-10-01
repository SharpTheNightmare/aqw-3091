package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.*;
   import liteAssets.draw.invSearch;
   
   public class LPFPanel extends MovieClip
   {
      
      public var frames:Array;
      
      public var w:int;
      
      public var h:int;
      
      public var xo:int;
      
      public var yo:int;
      
      public var xBuffer:int;
      
      public var yBuffer:int;
      
      public var frameID:int = 0;
      
      public var fParent:LPFLayout;
      
      public var bg:MovieClip;
      
      public var isOpen:Boolean = false;
      
      protected var fData:Object;
      
      protected var sMode:String;
      
      protected var closeType:String;
      
      protected var hideDir:String = "";
      
      protected var hidePad:int = 0;
      
      public var mcSearch:*;
      
      public function LPFPanel()
      {
         super();
      }
      
      public function notify(param1:Object) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < frames.length)
         {
            frames[_loc2_].mc.notify(param1);
            _loc2_++;
         }
      }
      
      public function addFrame(param1:Object) : void
      {
         var _loc2_:LPFFrame = addChild(param1.frame) as LPFFrame;
         _loc2_.subscribeTo(this);
         frames.push({
            "mc":_loc2_,
            "id":frameID++
         });
         _loc2_.fOpen(param1);
      }
      
      public function delFrame(param1:LPFFrame) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < frames.length)
         {
            if(frames[_loc2_].mc == param1)
            {
               frames[_loc2_].fClose();
               frames.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function subscribeTo(param1:LPFLayout) : void
      {
         fParent = param1;
      }
      
      public function fOpen(param1:Object) : void
      {
         var _loc3_:int = 0;
         fData = param1.fData;
         var _loc2_:Object = param1.r;
         x = _loc2_.x;
         if(_loc2_.y > -1)
         {
            y = _loc2_.y;
         }
         else
         {
            _loc3_ = fParent.numChildren;
            if(_loc3_ > 1)
            {
               y = fParent.getChildAt(_loc3_ - 2).y + fParent.getChildAt(_loc3_ - 2).height + 10;
            }
            else
            {
               y = 10;
            }
         }
         w = _loc2_.w;
         h = _loc2_.h;
         xo = x;
         yo = y;
      }
      
      public function fClose() : void
      {
         if(bg != null && bg.btnClose != null)
         {
            bg.btnClose.removeEventListener(MouseEvent.CLICK,onCloseClick);
         }
         while(frames.length > 0)
         {
            frames[0].mc.fClose();
            frames.shift();
         }
         if(mcSearch)
         {
            mcSearch.reset();
         }
         mcSearch = null;
         MovieClip(fParent).delPanel(this);
      }
      
      public function fHide() : void
      {
         isOpen = false;
         visible = false;
         switch(hideDir.toLowerCase())
         {
            case "left":
               x = xo - w - hidePad;
               break;
            case "right":
               x = xo + w + hidePad;
               break;
            case "top":
               y = yo - h - hidePad;
               break;
            case "bottom":
               y = yo + h + hidePad;
               break;
            case "":
         }
      }
      
      public function fShow(param1:int = -1) : void
      {
         isOpen = true;
         visible = true;
         if(param1 > -1)
         {
            x = param1;
         }
         else
         {
            x = xo;
         }
      }
      
      protected function drawBG(param1:* = null) : void
      {
         var _loc2_:* = undefined;
         if(param1 == null)
         {
            bg = addChildAt(new LPFPanelBg(),0) as MovieClip;
            bg.frame.width = w;
            bg.frame.height = h;
            bg.bg.width = w - 6 * 2;
            bg.bg.height = h - 5 * 2;
            bg.btnClose.x = w - 31;
            bg.dragonRight.x = bg.frame.width + 21;
            bg.tTitle.x = int(w / 2 - bg.tTitle.width / 2);
         }
         else
         {
            bg = addChildAt(new param1(),0) as MovieClip;
         }
         if("sName" in fData)
         {
            bg.tTitle.text = fData.sName;
            bg.tTitle.textColor = 16777215;
            _loc2_ = MovieClip(stage.getChildAt(0)).world.shopinfo;
            if(_loc2_)
            {
               bg.tTitle.textColor = Number(_loc2_.bUpgrd) == 1 ? 16566089 : 16777215;
               if(Number(_loc2_.bStaff) == 1)
               {
                  bg.tTitle.textColor = 16776960;
               }
            }
         }
         if(MovieClip(stage.getChildAt(0)).ui.mcPopup.currentLabel.indexOf("Bank") > -1 || fData.sName.toLowerCase() == "inventory" || fData.sName.toLowerCase() == "house inventory")
         {
            if(!bg.getChildByName("mcInvSearch"))
            {
               mcSearch = bg.addChild(new invSearch(MovieClip(stage.getChildAt(0))));
               mcSearch.name = "mcInvSearch";
               if(MovieClip(stage.getChildAt(0)).ui.mcPopup.currentLabel.indexOf("Bank") == -1)
               {
                  mcSearch.x = 156;
                  mcSearch.y = 26;
               }
               else
               {
                  mcSearch.x = 737;
                  mcSearch.y = 24;
               }
               bg.tTitle.visible = false;
            }
         }
      }
      
      protected function onCloseClick(param1:MouseEvent = null) : void
      {
         switch(closeType)
         {
            case "hide":
               fHide();
               break;
            case "close":
            default:
               mcSearch = null;
               bg.btnClose.removeEventListener(MouseEvent.CLICK,onCloseClick);
               fParent.fClose();
         }
      }
   }
}

