package
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2193")]
   public dynamic class InventoryItem extends MovieClip
   {
      
      public var icon:MovieClip;
      
      public var strLevel:TextField;
      
      public var bg:MovieClip;
      
      public var strName:TextField;
      
      public var strIndex:TextField;
      
      public var btnSelect:SimpleButton;
      
      public var isEq:Boolean;
      
      public var isSel:Boolean;
      
      public function InventoryItem()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function onItemSelect(param1:Event) : void
      {
         MovieClip(parent).selectItem(param1.target.parent.intIndex);
      }
      
      public function select() : void
      {
         bg.b.visible = true;
         isSel = true;
      }
      
      public function equip() : void
      {
         isEq = true;
         bg.transform.colorTransform = new ColorTransform(1,1,1,1,0,30,50,0);
         bg.b.visible = false;
         bg.c.visible = true;
      }
      
      public function unequip() : void
      {
         isEq = false;
         bg.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         bg.c.visible = false;
         if(!isSel)
         {
            bg.b.visible = false;
         }
      }
      
      public function reset() : void
      {
         if(!isEq)
         {
            bg.b.visible = false;
         }
         isSel = false;
      }
      
      public function clearText() : void
      {
         strName.text = "";
         strLevel.text = "";
         icon.visible = false;
      }
      
      internal function frame1() : *
      {
         isEq = false;
         isSel = false;
         btnSelect.addEventListener(MouseEvent.CLICK,onItemSelect);
         stop();
      }
   }
}

