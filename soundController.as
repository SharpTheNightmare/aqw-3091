package
{
   import flash.display.MovieClip;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class soundController
   {
      
      private var rootClass:MovieClip;
      
      private var bSong:Boolean;
      
      private var songOn:Boolean;
      
      public var mChannel:SoundChannel;
      
      private var btnSong:MovieClip;
      
      private var songClass:Sound;
      
      public function soundController(param1:Sound, param2:MovieClip)
      {
         super();
         rootClass = param2;
         mChannel = new SoundChannel();
         mChannel.soundTransform = new SoundTransform(param2.litePreference.data.dOptions["iSoundMusic"] != null ? Number(param2.litePreference.data.dOptions["iSoundMusic"]) : 0.35);
         bSong = false;
         songClass = param1;
         songOn = true;
      }
      
      public function checkSound(param1:MovieClip = null) : void
      {
         if(rootClass.mixer.bSoundOn)
         {
            if(songOn)
            {
               if(!bSong)
               {
                  mChannel = songClass.play(0,9999,mChannel.soundTransform);
                  bSong = true;
                  if(param1 != null)
                  {
                     param1.txtMusic.text = "Music On";
                  }
               }
            }
            else if(param1 != null)
            {
               param1.txtMusic.text = "Music Off";
            }
         }
         else if(param1 != null)
         {
            param1.txtMusic.text = "Music Off";
         }
      }
      
      public function stopMusic(param1:MovieClip = null) : void
      {
         SoundMixer.stopAll();
         songOn = false;
         if(param1 != null)
         {
            param1.txtMusic.text = "Music Off";
         }
      }
      
      public function buttonClick(param1:MovieClip) : void
      {
         if(bSong)
         {
            SoundMixer.stopAll();
            songOn = false;
            param1.txtMusic.text = "Music Off";
         }
         else if(rootClass.mixer.bSoundOn)
         {
            mChannel = songClass.play(0,9999,mChannel.soundTransform);
            songOn = true;
            param1.txtMusic.text = "Music On";
         }
         bSong = !bSong;
      }
   }
}

