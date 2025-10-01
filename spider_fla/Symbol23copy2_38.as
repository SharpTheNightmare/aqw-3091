package spider_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3562")]
   public dynamic class Symbol23copy2_38 extends MovieClip
   {
      
      public var buttons:Array;
      
      public function Symbol23copy2_38()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         buttons = new Array({
            "txt":"Stats & Class",
            "fct":"rootClass.toggleCharpanel"
         },{
            "txt":"Reputations",
            "fct":"rootClass.showFactionInterface"
         },{
            "txt":"Friends",
            "fct":"rootClass.world.showFriendsList"
         },{
            "txt":"Guild",
            "fct":"rootClass.world.showGuildList"
         },{
            "txt":"Character Page",
            "fct":"charPage"
         },{"txt":"Your Hero"});
      }
   }
}

