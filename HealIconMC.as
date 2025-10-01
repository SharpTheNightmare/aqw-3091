package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3375")]
   public class HealIconMC extends MovieClip
   {
      
      public var shp:MovieClip;
      
      public var hit:MovieClip;
      
      private var world:MovieClip;
      
      private var avt:Avatar;
      
      public function HealIconMC(param1:Avatar, param2:MovieClip)
      {
         super();
         addFrameScript(35,this.frame36);
         this.world = param2;
         this.avt = param1;
         this.hit.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         this.hit.buttonMode = true;
         this.hit.alpha = 0;
         this.shp.mouseEnabled = false;
         this.shp.mouseChildren = false;
         y = this.avt.pMC.pname.y - height - 5;
         x -= int(width / 2);
      }
      
      public function onClick(param1:MouseEvent) : void
      {
         this.world.healByIcon(this.avt);
         this.fClose();
      }
      
      public function fClose() : void
      {
         stop();
         this.hit.removeEventListener(MouseEvent.CLICK,this.onClick);
         parent.removeChild(this);
      }
      
      internal function frame36() : *
      {
         gotoAndPlay("loop");
      }
   }
}

