package
{
   import flash.events.EventDispatcher;
   import flash.media.SoundTransform;
   import flash.system.ApplicationDomain;
   
   public class SoundFX extends EventDispatcher
   {
      
      private var sfx:Object = {};
      
      private var assetsDomain:ApplicationDomain;
      
      public var stf:SoundTransform = new SoundTransform(0.7,0);
      
      public var bSoundOn:Boolean = true;
      
      public function SoundFX(param1:ApplicationDomain)
      {
         super();
         this.assetsDomain = param1;
         var _loc2_:Array = ["Achievement","Bad","Click","ClickBig","ClickMagic","Coins","Energy","Evil","Fire","Good","Heal","Hit1","Hit2","Hit3","Miss","VeryGood","Water","Wind"];
      }
      
      public function playSound(param1:String) : void
      {
         var AssetClass:Class = null;
         var strSound:String = param1;
         if(bSoundOn)
         {
            if(sfx[strSound] != null)
            {
               sfx[strSound].play(0,0,stf);
            }
            else
            {
               try
               {
                  if(assetsDomain.hasDefinition(strSound))
                  {
                     AssetClass = assetsDomain.getDefinition(strSound) as Class;
                     sfx[strSound] = new AssetClass();
                     sfx[strSound].play(0,0,stf);
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      public function soundOn() : void
      {
         bSoundOn = true;
      }
      
      public function soundOff() : void
      {
         bSoundOn = false;
      }
   }
}

