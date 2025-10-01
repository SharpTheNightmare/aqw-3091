package liteAssets.draw
{
   import com.adobe.utils.StringUtil;
   import fl.controls.List;
   import fl.controls.TextInput;
   import fl.data.*;
   import fl.events.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol109")]
   public class travelMenu extends MovieClip
   {
      
      public var btnAdd:SimpleButton;
      
      public var btnDel:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var listTravel:List;
      
      public var txtInfo:TextField;
      
      public var btnUp:SimpleButton;
      
      public var txtExpand:TextField;
      
      public var btnTravel:SimpleButton;
      
      public var txtTravel:TextInput;
      
      public var btnExpand:SimpleButton;
      
      public var btnDown:SimpleButton;
      
      public var frame:MovieClip;
      
      internal var mapRegex:RegExp = /^[a-z0-9]{2,25}(-[1-9][0-9]{0,14})?$/i;
      
      internal var rootClass:MovieClip;
      
      private var lObj:Object;
      
      private var lIndex:int;
      
      public function travelMenu(param1:MovieClip)
      {
         super();
         rootClass = param1;
         this.txtExpand.mouseEnabled = false;
         this.frame.addEventListener(MouseEvent.MOUSE_DOWN,onDrag,false,0,true);
         this.frame.addEventListener(MouseEvent.MOUSE_UP,onStopDrag,false,0,true);
         this.btnAdd.addEventListener(MouseEvent.CLICK,onBtnAdd,false,0,true);
         this.btnDel.addEventListener(MouseEvent.CLICK,onBtnDel,false,0,true);
         this.btnUp.addEventListener(MouseEvent.CLICK,onBtnUp,false,0,true);
         this.btnDown.addEventListener(MouseEvent.CLICK,onBtnDown,false,0,true);
         this.btnTravel.addEventListener(MouseEvent.CLICK,onBtnTravel,false,0,true);
         this.btnExpand.addEventListener(MouseEvent.CLICK,onBtnExpand,false,0,true);
         this.btnClose.addEventListener(MouseEvent.CLICK,onBtnClose,false,0,true);
         if(rootClass.litePreference.data.travelList)
         {
            this.listTravel.dataProvider = new DataProvider(rootClass.litePreference.data.travelList);
         }
         var _loc2_:* = rootClass.litePreference.data.keys["Travel Menu\'s Travel"] == null ? "" : rootClass.keyDict[rootClass.litePreference.data.keys["Travel Menu\'s Travel"]];
         this.txtInfo.text = "\"" + _loc2_ + "\" to travel to the next map in the list!";
         __setProp_txtTravel_mcTravel_Layer1_0();
      }
      
      public function onBtnClear(param1:MouseEvent) : void
      {
         this.listTravel.dataProvider.removeAll();
         rootClass.litePreference.data.travelList = this.listTravel.dataProvider.toArray();
         rootClass.litePreference.flush();
         rootClass.stage.focus = null;
      }
      
      public function onBtnExpand(param1:MouseEvent) : void
      {
         this.txtExpand.text = this.txtExpand.text == "+" ? "-" : "+";
         var _loc2_:int = 0;
         if(this.frame.visible)
         {
            while(_loc2_ < this.numChildren)
            {
               if(this.getChildAt(_loc2_).name != "btnExpand" && this.getChildAt(_loc2_).name != "txtExpand")
               {
                  this.getChildAt(_loc2_).visible = false;
               }
               _loc2_++;
            }
         }
         else
         {
            while(_loc2_ < this.numChildren)
            {
               this.getChildAt(_loc2_).visible = true;
               _loc2_++;
            }
         }
         rootClass.stage.focus = null;
      }
      
      public function onDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function onBtnClose(param1:MouseEvent) : void
      {
         parent.removeChild(this);
         rootClass.stage.focus = null;
      }
      
      public function onBtnAdd(param1:MouseEvent) : void
      {
         if(this.txtTravel.text != "" && Boolean(mapRegex.test(this.txtTravel.text)))
         {
            this.listTravel.dataProvider.addItem({"label":StringUtil.trim(this.txtTravel.text)});
            rootClass.litePreference.data.travelList = this.listTravel.dataProvider.toArray();
            rootClass.litePreference.flush();
         }
         this.txtTravel.text = "";
         rootClass.stage.focus = null;
      }
      
      public function onBtnDel(param1:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex > -1)
         {
            this.listTravel.dataProvider.removeItemAt(this.listTravel.selectedIndex);
            rootClass.litePreference.data.travelList = this.listTravel.dataProvider.toArray();
            rootClass.litePreference.flush();
         }
         this.listTravel.selectedIndex = 0;
         rootClass.stage.focus = null;
      }
      
      public function onBtnUp(param1:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex == -1)
         {
            return;
         }
         if(this.listTravel.selectedIndex != -1 && this.listTravel.selectedIndex != 0)
         {
            lObj = this.listTravel.selectedItem;
            lIndex = this.listTravel.selectedIndex - 1;
            this.listTravel.dataProvider.removeItem(this.listTravel.selectedItem);
            this.listTravel.dataProvider.addItemAt(lObj,lIndex);
            this.listTravel.selectedIndex = lIndex;
         }
         rootClass.stage.focus = null;
      }
      
      public function onBtnDown(param1:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex == -1)
         {
            return;
         }
         if(this.listTravel.selectedIndex < this.listTravel.length - 1)
         {
            lObj = this.listTravel.selectedItem;
            lIndex = this.listTravel.selectedIndex + 1;
            this.listTravel.dataProvider.removeItem(this.listTravel.selectedItem);
            this.listTravel.dataProvider.addItemAt(lObj,lIndex);
            this.listTravel.selectedIndex = lIndex;
         }
         rootClass.stage.focus = null;
      }
      
      public function dispatchTravel() : void
      {
         this.btnTravel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onBtnTravel(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(this.listTravel.length < 1)
         {
            return;
         }
         if(this.listTravel.selectedIndex == -1)
         {
            this.listTravel.selectedIndex = 0;
         }
         if(rootClass.world.myAvatar.dataLeaf.intState == 0)
         {
            rootClass.MsgBox.notify("You are dead!");
         }
         else if(!rootClass.world.myAvatar.invLoaded || !rootClass.world.myAvatar.pMC.artLoaded())
         {
            rootClass.MsgBox.notify("Character still being loaded.");
         }
         else if(rootClass.world.coolDown("tfer"))
         {
            _loc2_ = this.listTravel.selectedItem.label;
            rootClass.MsgBox.notify("Joining " + _loc2_);
            _loc3_ = "Enter";
            _loc4_ = "Spawn";
            rootClass.world.setReturnInfo(_loc2_,_loc3_,_loc4_);
            rootClass.sfc.sendXtMessage("zm","cmd",["tfer",rootClass.sfc.myUserName,_loc2_,_loc3_,_loc4_],"str",rootClass.world.curRoom);
            if(rootClass.world.strAreaName.indexOf("battleon") < 0 || rootClass.world.strAreaName.indexOf("battleontown") > -1)
            {
               rootClass.menuClose();
            }
            ++this.listTravel.selectedIndex;
            if(this.listTravel.selectedIndex > this.listTravel.length - 1)
            {
               this.listTravel.selectedIndex = 0;
            }
         }
         else
         {
            rootClass.MsgBox.notify("Not able to travel yet, please wait.");
         }
         rootClass.stage.focus = null;
      }
      
      internal function __setProp_txtTravel_mcTravel_Layer1_0() : *
      {
         try
         {
            txtTravel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         txtTravel.displayAsPassword = false;
         txtTravel.editable = true;
         txtTravel.enabled = true;
         txtTravel.maxChars = 50;
         txtTravel.restrict = "";
         txtTravel.text = "";
         txtTravel.visible = true;
         try
         {
            txtTravel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

