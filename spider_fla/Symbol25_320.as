package spider_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3969")]
   public dynamic class Symbol25_320 extends MovieClip
   {
      
      public var buttons:Array;
      
      public function Symbol25_320()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         buttons = new Array({
            "txt":"Temp Inventory",
            "fct":"toggleTempInventory"
         },{
            "txt":"Quests",
            "fct":"rootClass.world.toggleQuestLog"
         },{"txt":"Quests"});
      }
   }
}

