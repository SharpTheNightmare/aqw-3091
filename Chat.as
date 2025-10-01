package
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.filters.BevelFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.*;
   import flash.utils.Timer;
   import liteAssets.handlers.optionHandler;
   
   public class Chat
   {
      
      public var rootClass:*;
      
      public var iChat:int = 0;
      
      internal var pmMode:* = 0;
      
      private var chatArray:Array = [];
      
      private var t1Arr:* = [];
      
      private var t2Arr:* = [];
      
      private var tl:MovieClip;
      
      private var silentMute:* = 0;
      
      private var lineLimit:int = 100;
      
      private var mci:MovieClip;
      
      public var pmSourceA:* = [];
      
      public var pmI:int = 0;
      
      public var pmNm:String = "";
      
      public var ignoreList:SharedObject = SharedObject.getLocal("ignoreList","/");
      
      public var mute:* = {
         "ts":0,
         "cd":0,
         "timer":new Timer(0,1)
      };
      
      public var myMsgs:* = [];
      
      public var myMsgsI:int = 0;
      
      public var chn:* = new Object();
      
      public var emailWarning:String = "WARNING: Never give your email or password to anyone else. Moderators have gold names. If a player does not have a gold name they are NOT a moderator or staff member.";
      
      public var legalChars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*_+-=:\"?,./;\'\\|<>() ";
      
      public var legalCharsStrict:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      
      public var markChars:* = "~!@#$%^&*()_+-=:\"<>?,.;\'\\";
      
      public var strictComparisonChars:* = "~!@#$%^&*()_+-=:\"<>?,.;\'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
      
      public var strictComparisonCharsB:* = "~!#%^&()_+-=:\"<>?,.;\'\\ÇüéâäåçêëèïîìÄÅæÆôöòûùÿ֣¥áíóúñ?£ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝß";
      
      public var illegalStrings:* = ["&#","www","http","https","ftp",".com",".c0m",".net",".org",".de",".ru",".sg",".ph",".tk","dotcom","freegold","freecoins","freeadventurecoins","freelevels","freeitems","freeupgrades","gmail","yahoo","hotmail","aol","formfacil","email","password"];
      
      public var modWhisperCheckList:Array = ["trade","free","acs","member","pass","login","user","imamod","iamamod","i\'mamod","account"];
      
      public var regExpA:RegExp = /(a{2,})/gi;
      
      public var regExpE:RegExp = /(e{2,})/gi;
      
      public var regExpI:RegExp = /(i{2,})/gi;
      
      public var regExpO:RegExp = /(o{2,})/gi;
      
      public var regExpU:RegExp = /(u{2,})/gi;
      
      public var regExpSPACE:RegExp = /(\s{2,})/gi;
      
      internal var regExpMod:RegExp = /(\(|<)mod(era(t|d)or)?(>|\))/gi;
      
      public var regExpURL:RegExp = new RegExp("\\bhttps://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]","i");
      
      public var unsendable:* = ["@"];
      
      private var whichField:* = 0;
      
      private var msgFields:* = ["t1:","t2:say,zone,trade,moderator"];
      
      private var drawnA:Array = [];
      
      private var tfHeight:int = 126;
      
      private var t1Shorty:int = -137;
      
      private var t1Tally:int = -378;
      
      private var tfdH:int = Math.abs(t1Tally - t1Shorty);
      
      public var panelIndex:int = 0;
      
      private var msgID:int = 0;
      
      internal var xmlCannedOptions:XML = <CannedChat>
	<l1 display="Emotes">
		<l2 id="emote" display="Dance" text="dance"/>
		<l2 id="emote" display="Dance2" text="dance2"/>
		<l2 id="emote" display="Laugh" text="laugh"/>
		<l2 id="emote" display="Cry" text="cry"/>
		<l2 id="emote" display="Cheer" text="cheer"/>
		<l2 id="emote" display="Point" text="point"/>
		<l2 id="emote" display="Use" text="use"/>
		<l2 id="emote" display="Feign" text="feign"/>
		<l2 id="emote" display="Sleep" text="sleep"/>
		<l2 id="emote" display="Jump" text="jump"/>
		<l2 id="emote" display="Punt" text="punt"/>
		<l2 id="emote" display="Wave" text="wave"/>
		<l2 id="emote" display="Bow" text="bow"/>
		<l2 id="emote" display="Salute" text="Salute"/>
		<l2 id="emote" display="Backflip" text="backflip"/>
		<l2 id="emote" display="Swordplay" text="swordplay"/>
		<l2 id="emote" display="Unsheath" text="unsheath"/>
		<l2 id="emote" display="Facepalm" text="facepalm"/>
		<l2 id="emote" display="Air Guitar" text="airguitar"/>
		<l2 id="emote" display="Stern" text="stern"/>
	</l1>
	<l1 display="Member Emotes">
		<l2 id="emote" display="Powerup" text="powerup"/>
		<l2 id="emote" display="Kneel" text="kneel"/>
		<l2 id="emote" display="Jumpcheer" text="jumpcheer"/>
		<l2 id="emote" display="Salute2" text="salute2"/>
		<l2 id="emote" display="Cry2" text="cry2"/>
		<l2 id="emote" display="Spar" text="spar"/>
		<l2 id="emote" display="Stepdance" text="stepdance"/>
		<l2 id="emote" display="Headbang" text="headbang"/>
		<l2 id="emote" display="Dazed" text="dazed"/>
		<l2 id="emote" display="DanceWeapon" text="danceweapon"/>
	</l1>
	<l1 display="Greetings">
		<l2 id="ba" display="Hello!" text="Hello!"/>
		<l2 id="bb" display="Hi!" text="Hi!"/>
		<l2 id="bc" display="Well met!" text="Well met!"/>
		<l2 id="bd" display="Welcome!" text="Welcome!"/>
		<l2 id="be" display="Welcome back!" text="Welcome back!"/>
		<l2 id="bf" display="How are you today?" text="How are you today?"/>
	</l1>
	<l1 display="Farewells">
		<l2 id="ca" display="Bye!" text="Bye!"/>
		<l2 id="cb" display="See you later." text="See you later."/>
		<l2 id="cc" display="AFK" text="I'm going AFK"/>
		<l2 id="cd" display="I have to go now." text="I have to go now."/>
		<l2 id="ce" display="Logging out now" text="Logging out now."/>
		<l2 id="cf" display="brb" text="brb"/>
		<l2 id="cg" display="Farewell" text="Farewell"/>
	</l1>
	<l1 display="Questions">
		<l2 id="da" display="Can I add you">
			<l3 id="ea" display="to my Friends list" text="Can I add you to my Friends list?"/>
			<l3 id="eb" display="to my Party" text="Can I add you to my Party?"/>
		</l2>
		<l2 id="db" display="Do you want to battle together?" text="Do you want to battle together?"/>
	    <l2 id="dc" display="Is that a Member only...">
			<l3 id="fa" display="Helm" text=" Is that a Member only helm?"/>
			<l3 id="fb" display="Cape" text=" Is that a Member only cape?"/>
			<l3 id="fc" display="Armor" text=" Is that a Member only armor?"/>
			<l3 id="fd" display="Weapon" text=" Is that a Member only weapon?"/>
		</l2>
		<l2 id="dd" display="Where are you?" text="Where are you?"/>
		<l2 id="de" display="Are you sure?" text="Are you sure?"/>
		<l2 id="df" display="Can I help you?" text="Can I help you?"/>
		<l2 id="dg" display="What is your alignment?" text="What is your alignment?"/>
		<l2 id="dh" display="Where did you get that ...">
			<l3 id="ga" display="Helm" text="Where did you get that helm?"/>
			<l3 id="gb" display="Cape" text="Where did you get that cape?"/>
			<l3 id="gc" display="Armor" text="Where did you get that armor?"/>
			<l3 id="gd" display="Weapon" text="Where did you get that weapon?"/>
			<l3 id="ge" display="Pet" text="Where did you get that pet?"/>
			<l3 id="ge" display="Class" text="Where did you get that class?"/>
		</l2>
		<l2 id="di" display="Are you a...">
			<l3 id="ha" display="Guardian" text="Are you a Guardian?"/>
			<l3 id="hb" display="DragonLord" text="Are you a DragonLord?"/>
			<l3 id="hc" display="StarCaptain" text="Are you a StarCaptain?"/>
		</l2>
		<l2 id="dj" display="Do you play...">
			<l3 id="ia" display="AdventureQuest" text="Do you play AdventureQuest?"/>
			<l3 id="ib" display="DragonFable" text="Do you play DragonFable?"/>
			<l3 id="ic" display="MechQuest" text="Do you play MechQuest?"/>
		</l2>
		<l2 id="dl" display="What are you doing?" text="What are you doing?"/>
	</l1>
	<l1 display="Answers">
		<l2 id="ja" display="thanks/welcome">
			<l3 id="ka" display="Thanks!" text="Thanks!"/>
			<l3 id="kb" display="Thank you!" text="Thank you!"/>
			<l3 id="kc" display="Thanks for helping me." text="Thanks for helping me."/>
			<l3 id="kd" display="I owe you one." text="I owe you one.."/>
			<l3 id="ke" display="No problem!" text="No problem!"/>
			<l3 id="kf" display="You're welcome!" text="You're welcome!"/>
		</l2>
		<l2 id="jn" display="I am doing/trying to..">
			<l3 id="ma" display="Quest" text="I am doing a quest."/>
			<l3 id="mb" display="Farming" text="I am farming."/>
			<l3 id="mc" display="New" text="I am playing the new release."/>
			<l3 id="md" display="Level up." text="I am trying to level up."/>
			<l3 id="me" display="Rank up." text="I am trying to rank up."/>
		</l2>
		<l2 id="jb" display="I'm fine, thanks." text="I'm fine, thanks."/>	
		<l2 id="jc" display="Could be better." text="Could be better."/>
		<l2 id="jd" display="I don't think so." text="I don't think so."/>
		<l2 id="je" display="I don't know." text="I don't know."/>
		<l2 id="jf" display="Indeed." text="Indeed."/>
		<l2 id="jg" display="Pleased to meet you." text="Pleased to meet you."/>
		<l2 id="jh" display="Good." text="I am Good."/>
		<l2 id="ji" display="Evil." text="I am Evil."/>
		<l2 id="jj" display="Me too!" text="Me too!"/>
		<l2 id="jk" display="I got it...">
			<l3 id="la" display="as a drop." text="I got it as a drop."/>
			<l3 id="lb" display="from a shop." text="I got it from a shop."/>
		</l2>
		<l2 id="jl" display="Check the Wiki..." text="You can check the Wiki for the location."/>
		<l2 id="jm" display="Your Book of Lore will know that" text="Your Book of Lore will know that."/>
		<l2 id="jo" display="I can only use Canned Chat." text="I can only use Canned Chat."/>
	</l1>
	<l1 display="Meeting up">
		<l2 id="na" display="Follow me!" text="Follow me!"/>
		<l2 id="nb" display="Over here!" text="Over here!"/>
		<l2 id="nc" display="Goto me." text="Goto me."/>
		<l2 id="nd" display="I'll follow you." text="I'll follow you."/>
		<l2 id="ne" display="Maybe some other time." text="Maybe some other time."/>
		<l2 id="nf" display="Ok, let's go." text="Ok, let's go."/>
		<l2 id="ng" display="Come back here." text="Come back here."/>
		<l2 id="nh" display="I need to finish this first." text="I need to finish this first."/>
		<l2 id="ni" display="Seriously?" text="Seriously?"/>
		<l2 id="nj" display="*I'm going to...">
			<l3 id="oa" display="Artix" text="I'm going to the Artix Server."/>
			<l3 id="ob" display="Galanoth" text="I'm going to the Galanoth Server."/>	
			<l3 id="oh" display="Sir Ver" text="I'm going to Sir Ver."/>
			<l3 id="oi" display="Twig" text="I'm going to the Twig server."/>
			<l3 id="oj" display="Twilly" text="I'm going to the Twilly server."/>
			<l3 id="ok" display="Yorumi" text="I'm going to the Yorumi server."/>
			<l3 id="oj" display="TestingServer" text="I'm going to the TestingServer server."/>
			<l3 id="ok" display="TestingServer2" text="I'm going to the TestingServer2 server."/>
		</l2>
		<l2 id="nk" display="Sorry, I'm busy." text="Sorry, I'm busy."/>
	</l1>
	<l1 display="In Battle">
		<l2 id="pa" display="Can you..">
			<l3 id="qa" display="help with battle" text="Can you help me with this battle?"/>
			<l3 id="qb" display="help with Boss" text="Can you help me with the Boss?"/>
		</l2>
		<l2 id="pb" display="Planning...">
			<l3 id="ra" display="Let's attack now!" text="Let's attack now!"/>
			<l3 id="rb" display="I'll attack first." text="I'll attack first."/>
			<l3 id="rc" display="You go first." text="You go first."/>
			<l3 id="rd" display="I need to rest." text="I need to rest."/>
		</l2>
		<l2 id="pc" display="During the battle">
			<l3 id="sa" display="Heal, please!" text="Heal, please!"/>
			<l3 id="sb" display="MEDIC!" text="MEDIC!"/>
			<l3 id="sc" display="Help!" text="Help!"/>
			<l3 id="sd" display="I'm out of Mana." text="I'm out of Mana."/>
			<l3 id="se" display="Use your special attacks!" text="Use your special attacks!"/>
			<l3 id="sf" display="This monster is strong!" text="This monster is strong!"/>
			<l3 id="sg" display="Slay that monster!" text="Slay that monster!"/>
			<l3 id="sh" display="This is hard." text="This hard."/>
			<l3 id="si" display="This is easy." text="This easy."/>
			<l3 id="sj" display="Run away!" text="Run away!"/>
		</l2>
		<l2 id="pd" display="After battle">
			<l3 id="ta" display="Yes! I got the drop!" text="Yes! I got the drop!"/>
			<l3 id="tb" display="We did it!" text="We did it!"/>
			<l3 id="tc" display="You fight well." text="You fight well."/>
			<l3 id="td" display="Nooo! I died!" text="Nooo! I died!"/>
			<l3 id="tf" display="Let's try again!" text="Let's try again!"/>
		</l2>
	</l1>
	<l1 display="Exclamations">
		<l2 id="ua" display="Battle on!" text="Battle on!"/>
		<l2 id="uc" display="OMG!" text="OMG!"/>
		<l2 id="ud" display="lol" text="lol"/>
		<l2 id="uf" display="Woot!" text="Woot!"/>
		<l2 id="ug" display="Wow!" text="Wow"/>
		<l2 id="uh" display="High Five!" text="High Five!"/>
		<l2 id="ui" display="Congrats!" text="Congrats!"/>
		<l2 id="uj" display="Level up!" text="Level up!"/>
		<l2 id="uk" display="Rank up!" text="Rank up!"/>
		<l2 id="ul" display="LONG UN-LIVE THE SHADOWSCYTHE!!" text="LONG UN-LIVE THE SHADOWSCYTHE!!"/>
		<l2 id="um" display="Long live King Alteon the Good!!" text="Long live King Alteon the Good!!"/>
		<l2 id="un" display="This rocks!" text="This rocks!"/>
		<l2 id="uo" display="This is awesome!" text="This is awesome!"/>
		<l2 id="up" display="This is fun." text="This is fun."/>
		<l2 id="uq" display="That is really cool." text="That is really cool."/>
		<l2 id="ur" display="Cheer up!" text="Cheer up!"/>
		<l2 id="ut" display="Great!" text="Great!"/>
		<l2 id="uu" display="HaHa" text="HaHa"/>
	</l1>
	<l1 display="Stop">
		<l2 id="va" display="following me" text="Please stop following me."/>
		<l2 id="vb" display="doing that" text="Please stop doing that."/>
		<l2 id="vc" display="PMing me" text="Please stop PMing me."/>
	</l1>
	<l1 display="Smilies">
		<l2 id="wa" display=":)" text=":)"/>
		<l2 id="wb" display=":(" text=":("/>
		<l2 id="wc" display=":/" text=":/"/>
		<l2 id="wd" display=":|" text=":|"/>
		<l2 id="we" display=":O" text=":O"/>
		<l2 id="wf" display="D:" text="D:"/>
	</l1>
	<l1 id="x" display="Yes." text="Yes."/>
	<l1 id="y" display="No." text="No."/>
	<l1 id="z" display="OK." text="OK."/>
</CannedChat>;
      
      private var profanityA:Array = new Array("@$$","&&##","anal","arse","ass","a55","a5s","as5","a$$","a$s","as$","a5$","a$5","a*s","*ss","a**","as*","assclown","assface","asshole","asswipe","bastard","beating the meat","beef curtains","beef flaps","betch","biatch","bich","bish","b1ch","b!ch","blch","b|ch","bitch","b1tch","b!tch","bltch","b|tch","bizzach","blowjob","boobies","boobs","b00bs","buggery","bullshit","buttsex","carpet muncher","carpet munchers","carpetlicker","carpetlickers","ch1nk","chink","chode","clit","cocaine","cock","cocks","c0ck","co*k","c*ck","cocksucker","condom","cracka","cum","cumming","cums","cummies","cumguzzler","cumlicker","cuck","cumsucker","cumdrinker","cunt","cunts","c*nt","cu*t","*unt","cun*","cumslut","dicksucker","damn","d1ck","dick","di*k","d*ck","d**k","d|ck","dildo","d1ldo","dumbass","dumb4ss","dyke","ejaculate","f*ck","feck","f@g","fag","f4ggot","f4gg0t","faggot","fap","f4p","fapping","f4pping","fatass","fack","feck","felcher","foreskin","fhuck","fking","fuk"
      ,"fck","fuck","fuc","fu*k","fuuck","fuuk","fcuk","fvck","fvk","fvvck","fvvk","fock","fux0r","fucken","fucker","fucking","fudgepacker","ganja","gook","h0r","h*re","hentai","heroin","h0mo","h0m0","homo","horny","injun","jack off","jerk off","jackass","j1sm","jism","j1zz","jizz","kawk","kike","klootzak","knulle","kraut","kuk","kunt","kuksuger","kurac","kurwa","kusi","kyrpa","l3+ch","lesbo","lez","marijuana","masturbate","masturbation","meat puppet","merd","milf","molester","m0lester","m0l3ster","m0l3st3r","motherfucker","muie","mulkku","nads","nazi","n1gga","nigga","nigger","nutsack","orospu","orgasm","orgy","p0rn","paska","penis","phuck","pierdol","pillu","pimmel","pimp","piss","poontsee","porn","p0rno","p0rn0","porno","pr0n","preteen","pron","prostitute","pussy","pussie","pu$$y","puta","puto","queef","r4pe","rape","r4ped","raped","rapist","retard","rimjob","schaffer","schiess","schlampe","screw","scrotum","secks","s3x","sex","s*x","se*","sharmuta","sharmute","shipal","shit","sh1t","sh!t"
      ,"shlt","sh|t","shiz","sh1z","sh!z","shlz","sh|z","shiit","shi!t","sh!it","shilt","shlit","sh||t","shi|t","sh|it","shiiz","shi t","shyt","sh*t","s*it","s**t","s***","shlong","skank","skurwysyn","slut","sl*t","s**t","smartass","smut","spierdalaj","splooge","threesome","tit","tits","titties","twat","vagina","wank","weed","wetback","whack off","wh0re","whore","whoring","wichser","yolasite","zabourah","yolas1te","y0lasite","y0las1te","webly","w33bly","web1y","w33b1y","anus","4nus","rectum","r3ctum","foda","fodao","phoda","phodao","Azzhole","A$$hole","AsshoIe","Azzhole","Asswipe","Btch","B!tch","BItch","BItch","D!ck","Dlck","D!ldo","Dumbass","Dyke","Fgt","Faggot","Fagget","Fegget","Feggit","Feget","Fggot","Fggt","Fhaggot","F4g","Fken","Fkking","fu/ck","H#mo","Nigga","N|gger","Niga","Ngga","Pen1s","Rape","Rhape","Raep","Buceta","Xoxota","Cachorra","Cagada","puta","Foda-se","Macaco","Negrinho","Merda","Porra","Merdimbuca","Mijada","Mijão","Ninfeta","Sapatao","Cagada","Cerote","Chichis","Cojer"
      ,"Cojido","Culera","Culero","Culona","Joto","Mamahuevo","Maricon","Mierda","Nachas","Nalgas","Nalgona","Pendeja","Pendejo","Perra","Pito","Puta","Puto","Putas","Retardado","Tetas","Verga","Vergisima");
      
      private var profanityB:Array = ["porn","nigger","slut","dick"];
      
      private var profanityD:Array = ["chink","puto","puta","oten"];
      
      private var profanityF:Array = ["nigga","nigger","cunt","fag","tranny","shemale","kontol","vagina","penis","clitoris","kike","slut","dick"];
      
      private var profanityC:Array = ["bitch","b1tch","b!tch","bltch","b|tch","damn","dick","fag","fuk","fvk","fvck","fuck","pussy","shit","sh1t","sh!t","shlt","sh|t"];
      
      private var mcCannedChat:MovieClip;
      
      public var t:Timer = new Timer(500,1);
      
      public var windowTimer:Timer = new Timer(60000,1);
      
      public var regExpMultiG:RegExp = /(gg{2,})/gi;
      
      internal var regexEscapes:String = "[]{}()*+?|^$.\\";
      
      public function Chat()
      {
         super();
         chn.cur = {};
         chn.lastPublic = {};
         chn.xt = "zm";
         chn.zone = {};
         chn.trade = {};
         chn.moderator = {};
         chn.warning = {};
         chn.server = {};
         chn.event = {};
         chn.whisper = {};
         chn.party = {};
         chn.guild = {};
         chn.wheel = {};
         chn.zone.col = "9CCAFD";
         chn.trade.col = "D2FD94";
         chn.moderator.col = "FFCC33";
         chn.warning.col = "A80000";
         chn.server.col = "00FFFF";
         chn.event.col = "00FF00";
         chn.whisper.col = "FF00FF";
         chn.party.col = "00CCFF";
         chn.guild.col = "99FF00";
         chn.wheel.col = "FFCC33";
         chn.zone.str = "zone";
         chn.trade.str = "trade";
         chn.moderator.str = "moderator";
         chn.warning.str = "warning";
         chn.server.str = "server";
         chn.event.str = "event";
         chn.whisper.str = "whisper";
         chn.party.str = "party";
         chn.guild.str = "guild";
         chn.wheel.str = "wheel";
         chn.zone.typ = "message";
         chn.trade.typ = "message";
         chn.moderator.typ = "whisper";
         chn.warning.typ = "server";
         chn.server.typ = "server";
         chn.event.typ = "event";
         chn.whisper.typ = "whisper";
         chn.party.typ = "message";
         chn.guild.typ = "message";
         chn.wheel.typ = "whisper";
         chn.zone.tag = "";
         chn.trade.tag = "";
         chn.moderator.tag = "Moderator";
         chn.warning.tag = "";
         chn.server.tag = "";
         chn.whisper.tag = "Whisper";
         chn.event.tag = "";
         chn.party.tag = "Party";
         chn.guild.tag = "Guild";
         chn.wheel.tag = "Wheel of Doom";
         chn.zone.rid = 0;
         chn.trade.rid = 0;
         chn.moderator.rid = 0;
         chn.warning.rid = 0;
         chn.server.rid = 0;
         chn.event.rid = 0;
         chn.whisper.rid = 0;
         chn.party.rid = 32123;
         chn.guild.rid = 0;
         chn.wheel.rid = 0;
         chn.zone.act = 1;
         chn.trade.act = 0;
         chn.moderator.act = 1;
         chn.warning.act = 1;
         chn.server.act = 1;
         chn.event.act = 1;
         chn.whisper.act = 1;
         chn.party.act = 0;
         chn.guild.act = 0;
         chn.wheel.act = 1;
         chn.cur = chn.zone;
         chn.lastPublic = chn.cur;
         if(ignoreList.data.users == undefined)
         {
            ignoreList.data.users = new Array();
         }
      }
      
      private function initProfanity() : void
      {
         var _loc4_:String = null;
         var _loc1_:Array = new Array("butt","pron","rape","tits","shi t","shi t");
         var _loc2_:Array = new Array("as5","a5s","a$$","a5$","a$5","as$","fck","fkc","fvk","fuck","fvck","fukk","fvkk","sh!t","sh|t","sh1t","shiz");
         var _loc3_:int = 0;
         while(_loc3_ < profanityA.length)
         {
            _loc4_ = rootClass.stripWhiteStrict(profanityA[_loc3_]);
            if(_loc1_.indexOf(_loc4_) == -1 && (_loc4_.length > 4 || _loc2_.indexOf(_loc4_) > -1))
            {
               profanityB.push(_loc4_);
            }
            else if(profanityA[_loc3_].indexOf("*") > -1)
            {
               profanityB.push(profanityA[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      internal function init() : *
      {
         mci = rootClass.ui.mcInterface;
         chatArray = [];
         t1Arr = [];
         drawnA = [];
         msgID = 0;
         panelIndex = 0;
         tfHeight = 126;
         t1Shorty = -137;
         t1Tally = -378;
         tfdH = Math.abs(t1Tally - t1Shorty);
         initProfanity();
         mute.timer.addEventListener(TimerEvent.TIMER,unmuteMe,false,0,true);
         if(mcCannedChat == null)
         {
            mcCannedChat = initCannedChat(xmlCannedOptions.children());
         }
         mci.tt.mouseEnabled = false;
         tl = mci.textLine as MovieClip;
         tl.ti.htmlText = "";
         tl.ti.autoSize = "left";
         tl.visible = false;
         mci.bMinMax.buttonMode = true;
         mci.bMinMax.a2.visible = false;
         mci.bShortTall.buttonMode = true;
         mci.bShortTall.a2.visible = false;
         mci.te.text = "";
         mci.te.visible = false;
         mci.tt.text = "";
         mci.tt.visible = false;
         mci.te.maxChars = 150;
         mci.bCannedChat.removeEventListener(MouseEvent.CLICK,onCannedChatClick);
         mci.bsend.removeEventListener(MouseEvent.CLICK,chat_btnSend);
         mci.tebg.removeEventListener(MouseEvent.CLICK,chat_tebgClick);
         mci.bMinMax.removeEventListener(MouseEvent.CLICK,bMinMaxClick);
         mci.bMinMax.removeEventListener(MouseEvent.MOUSE_OVER,bMinMaxMouseOver);
         mci.bMinMax.removeEventListener(MouseEvent.MOUSE_OUT,bMinMaxMouseOut);
         mci.bShortTall.removeEventListener(MouseEvent.CLICK,bShortTallClick);
         mci.bShortTall.removeEventListener(MouseEvent.MOUSE_OVER,bShortTallMouseOver);
         mci.bShortTall.removeEventListener(MouseEvent.MOUSE_OUT,bShortTallMouseOut);
         rootClass.stage.removeEventListener(KeyboardEvent.KEY_DOWN,rootClass.key_StageLogin);
         rootClass.stage.removeEventListener(KeyboardEvent.KEY_DOWN,rootClass.key_StageGame);
         mci.te.removeEventListener(KeyboardEvent.KEY_DOWN,rootClass.key_ChatEntry);
         mci.te.removeEventListener(Event.CHANGE,checkMsgType);
         rootClass.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelEvent);
         mcCannedChat.removeEventListener(MouseEvent.MOUSE_OVER,onCannedChatOver);
         mcCannedChat.removeEventListener(MouseEvent.MOUSE_OUT,onCannedChatOut);
         t.removeEventListener(TimerEvent.TIMER,closeCannedChatTimer);
         windowTimer.removeEventListener(TimerEvent.TIMER,timedWindowHide);
         mci.bCannedChat.addEventListener(MouseEvent.CLICK,onCannedChatClick);
         mci.bsend.addEventListener(MouseEvent.CLICK,chat_btnSend);
         mci.tebg.addEventListener(MouseEvent.CLICK,chat_tebgClick);
         mci.bMinMax.addEventListener(MouseEvent.CLICK,bMinMaxClick);
         mci.bMinMax.addEventListener(MouseEvent.MOUSE_OVER,bMinMaxMouseOver);
         mci.bMinMax.addEventListener(MouseEvent.MOUSE_OUT,bMinMaxMouseOut);
         mci.bShortTall.addEventListener(MouseEvent.CLICK,bShortTallClick);
         mci.bShortTall.addEventListener(MouseEvent.MOUSE_OVER,bShortTallMouseOver);
         mci.bShortTall.addEventListener(MouseEvent.MOUSE_OUT,bShortTallMouseOut);
         rootClass.stage.addEventListener(KeyboardEvent.KEY_DOWN,rootClass.key_StageGame);
         mci.te.addEventListener(KeyboardEvent.KEY_DOWN,rootClass.key_ChatEntry);
         mci.te.addEventListener(Event.CHANGE,checkMsgType);
         rootClass.stage.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelEvent);
         rootClass.ui.mouseEnabled = false;
         mci.mouseEnabled = false;
         mci.t1.mouseEnabled = false;
         mci.addChild(mcCannedChat);
         mcCannedChat.addEventListener(MouseEvent.MOUSE_OVER,onCannedChatOver);
         mcCannedChat.addEventListener(MouseEvent.MOUSE_OUT,onCannedChatOut);
         mcCannedChat.y = -mcCannedChat.numChildren * 23;
         mcCannedChat.visible = false;
         t.addEventListener(TimerEvent.TIMER,closeCannedChatTimer);
         windowTimer.addEventListener(TimerEvent.TIMER,timedWindowHide);
      }
      
      private function timedWindowHide(param1:Event) : void
      {
         mci.t1.visible = false;
      }
      
      private function startWindowTimer() : void
      {
         var _loc1_:MovieClip = mci.bMinMax;
         if(mci.t1.visible)
         {
         }
      }
      
      private function bMinMaxMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!mci.t1.visible)
         {
            rootClass.ui.ToolTip.openWith({"str":"Show the chat pane"});
         }
         else
         {
            rootClass.ui.ToolTip.openWith({"str":"Hide the chat pane"});
         }
      }
      
      private function bMinMaxMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         rootClass.closeToolTip();
      }
      
      private function bMinMaxClick(param1:MouseEvent) : void
      {
         toggleChatPane();
      }
      
      public function toggleChatPane(param1:Boolean = true) : *
      {
         var _loc2_:MovieClip = mci.bMinMax;
         if(!mci.t1.visible)
         {
            mci.t1.visible = true;
            _loc2_.a1.visible = true;
            _loc2_.a2.visible = false;
            if(param1)
            {
               rootClass.ui.ToolTip.openWith({"str":"Hide the chat pane"});
            }
         }
         else
         {
            mci.t1.visible = false;
            _loc2_.a1.visible = false;
            _loc2_.a2.visible = true;
            if(param1)
            {
               rootClass.ui.ToolTip.openWith({"str":"Show the chat pane"});
            }
         }
      }
      
      private function bShortTallMouseOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(mci.t1.y == t1Shorty)
         {
            rootClass.ui.ToolTip.openWith({"str":"Set the chat pane to full height"});
         }
         else
         {
            rootClass.ui.ToolTip.openWith({"str":"Return the chat pane to normal height"});
         }
      }
      
      private function bShortTallMouseOut(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         rootClass.closeToolTip();
      }
      
      public function bShortTallClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = mci.bShortTall;
         if(mci.t1.y == t1Tally)
         {
            mci.t1.y = t1Shorty;
            tfHeight -= tfdH;
            _loc2_.a1.visible = true;
            _loc2_.a2.visible = false;
            rootClass.ui.ToolTip.openWith({"str":"Set the chat pane to full height"});
         }
         else
         {
            mci.t1.y = t1Tally;
            tfHeight += tfdH;
            _loc2_.a1.visible = false;
            _loc2_.a2.visible = true;
            rootClass.ui.ToolTip.openWith({"str":"Return the chat pane to normal height"});
         }
         writeText(panelIndex);
      }
      
      private function onCannedChatClick(param1:MouseEvent) : void
      {
         mcCannedChat.visible = !mcCannedChat.visible;
      }
      
      public function closeCannedChat() : void
      {
         mcCannedChat.visible = false;
      }
      
      private function initCannedChat(param1:XMLList) : MovieClip
      {
         var _loc7_:XML = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:MovieClip = null;
         var _loc2_:MovieClip = new MovieClip();
         var _loc3_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length())
         {
            _loc7_ = param1[_loc4_];
            _loc8_ = new CannedOption();
            _loc8_.y = _loc4_ * 23;
            _loc8_.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
            _loc8_.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
            _loc8_.txtChat.text = _loc7_.attribute("display").toString();
            if(_loc8_.txtChat.textWidth > _loc3_)
            {
               _loc3_ = Number(_loc8_.txtChat.textWidth);
            }
            _loc8_.strMsg = _loc7_.attribute("text").toString();
            _loc8_.id = _loc7_.attribute("id").toString();
            _loc2_.addChild(_loc8_);
            if(_loc7_.children().length() > 0)
            {
               _loc8_.mcMoreOptions = initCannedChat(_loc7_.children());
               _loc8_.addChild(_loc8_.mcMoreOptions);
               _loc8_.mcMoreOptions.visible = false;
               _loc9_ = _loc8_.txtChat.text;
               if(_loc9_ == "During the battle" || _loc9_ == "*I\'m going to...")
               {
                  _loc8_.mcMoreOptions.y -= 100;
               }
            }
            else
            {
               _loc8_.mcMore.visible = false;
               _loc8_.addEventListener(MouseEvent.CLICK,onMouseClick);
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.numChildren)
         {
            _loc10_ = MovieClip(_loc2_.getChildAt(_loc5_));
            _loc10_.txtChat.width = _loc3_ + 6;
            _loc10_.bg.width = _loc3_ + 20;
            _loc10_.mcMore.x = _loc10_.bg.width - 10;
            if(_loc10_.mcMoreOptions != null)
            {
               _loc10_.mcMoreOptions.x = _loc10_.bg.width;
            }
            _loc5_++;
         }
         var _loc6_:BevelFilter = new BevelFilter(1,45,0,1,0,1,0,0,1,3);
         _loc2_.filters = [_loc6_];
         return _loc2_;
      }
      
      private function onRollOver(param1:MouseEvent) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.bg.transform.colorTransform = new ColorTransform(1,1,1,1,25,25,25,0);
         if(param1.currentTarget.mcMoreOptions != null)
         {
            param1.currentTarget.mcMoreOptions.visible = true;
            _loc3_ = param1.currentTarget;
            _loc4_ = new Point(_loc3_.x,_loc3_.y + _loc3_.mcMoreOptions.y + _loc3_.mcMoreOptions.numChildren * 23);
            _loc5_ = mcCannedChat.localToGlobal(_loc4_);
            if(_loc5_.y > 500)
            {
               _loc3_.mcMoreOptions.y -= _loc5_.y - 500;
            }
         }
      }
      
      private function onRollOut(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         _loc2_.bg.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         if(param1.currentTarget.mcMoreOptions != null)
         {
            param1.currentTarget.mcMoreOptions.visible = false;
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : *
      {
         var _loc2_:* = MovieClip(param1.currentTarget);
         if(_loc2_.id == "emote")
         {
            submitMsg("/" + _loc2_.strMsg,"emote",rootClass.sfc.myUserName);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","cc",[_loc2_.id],"str",1);
         }
         closeCannedChat();
      }
      
      private function onCannedChatOver(param1:MouseEvent) : *
      {
         if(t != null)
         {
            t.reset();
         }
      }
      
      private function onCannedChatOut(param1:MouseEvent) : *
      {
         t.start();
      }
      
      private function closeCannedChatTimer(param1:TimerEvent) : *
      {
         closeCannedChat();
      }
      
      public function getCCText(param1:String) : String
      {
         var _loc2_:XML = getCCOption(param1,xmlCannedOptions.children());
         if(_loc2_ != null)
         {
            return _loc2_.attribute("text").toString();
         }
         return "";
      }
      
      private function getCCOption(param1:String, param2:XMLList) : XML
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc3_:int = 0;
         while(_loc3_ < param2.length())
         {
            _loc4_ = param2[_loc3_];
            if(_loc4_.children().length() == 0)
            {
               if(_loc4_.attribute("id").toString() == param1)
               {
                  return _loc4_;
               }
            }
            else
            {
               _loc5_ = getCCOption(param1,_loc4_.children());
               if(_loc5_ != null)
               {
                  return _loc5_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      private function chat_btnSend(param1:MouseEvent) : *
      {
         submitMsg(mci.te.text,chn.cur.typ,pmNm);
         rootClass.stage.focus = null;
      }
      
      private function chat_tebgClick(param1:MouseEvent) : *
      {
         if(rootClass.stage.focus != mci.te)
         {
            openMsgEntry();
         }
      }
      
      private function chat_linkHandler(param1:TextEvent) : *
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc2_ = String(param1.text.split(",")[0]);
         switch(_loc2_)
         {
            case "openPMsg":
               pmMode = 1;
               _loc3_ = String(param1.text.split(",")[1]);
               openPMsg(_loc3_);
         }
      }
      
      internal function onMouseWheelEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         if(rootClass.litePreference.data.bDisChatScroll)
         {
            return;
         }
         if(mci.t1.hitTestPoint(param1.stageX,param1.stageY))
         {
            _loc2_ = t1Arr.length;
            if(param1.delta > 0)
            {
               if(panelIndex > 0)
               {
                  --panelIndex;
               }
            }
            else if(panelIndex < t1Arr.length - 1)
            {
               ++panelIndex;
            }
            writeText(panelIndex);
         }
      }
      
      internal function resetAreaChannels() : *
      {
         chn.zone.act = 0;
         chn.trade.act = 0;
      }
      
      public function mapChannels(param1:*) : *
      {
         var _loc3_:* = undefined;
         resetAreaChannels();
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_].split(",")[0].toString();
            if(_loc3_.indexOf("trade") > -1)
            {
               chn.trade.rid = rootClass.sfc.getRoom(_loc3_).getId();
               chn.trade.act = 1;
            }
            _loc2_++;
         }
         chn.zone.act = 1;
      }
      
      internal function popBubble(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = null;
         var _loc5_:* = param1.split(":")[0];
         param1 = param1.substr(2);
         switch(_loc5_)
         {
            case "u":
               _loc4_ = rootClass.world.getMCByUserName(param1);
         }
         if(_loc4_ != null)
         {
            _loc4_.bubble.ti.autoSize = TextFieldAutoSize.CENTER;
            _loc4_.bubble.ti.wordWrap = true;
            _loc4_.bubble.ti.htmlText = param2;
            _loc4_.bubble.bg.width = int(_loc4_.bubble.ti.textWidth + 12);
            _loc4_.bubble.bg.height = int(_loc4_.bubble.ti.textHeight + 8);
            _loc4_.bubble.y = _loc4_.pname.y - _loc4_.bubble.bg.height - 4;
            _loc4_.bubble.bg.x = 0 - _loc4_.bubble.bg.width / 2;
            _loc4_.bubble.arrow.y = _loc4_.bubble.bg.y + _loc4_.bubble.bg.height - 2;
            _loc4_.bubble.visible = true;
            _loc4_.bubble.alpha = 100;
            if(_loc4_.kv == null)
            {
               _loc4_.kv = new Killvis();
               _loc4_.kv.kill(_loc4_.bubble,3000);
            }
            else
            {
               _loc4_.kv.resetkill();
            }
         }
      }
      
      private function getRoomType(param1:*) : *
      {
         if(param1.indexOf("trade") > -1)
         {
            return "trade";
         }
         if(param1.indexOf("party") > -1)
         {
            return "party";
         }
         return "zone";
      }
      
      public function formatMsgEntry(param1:*) : *
      {
         mci.te.setSelection(0,0);
         if(chn.cur != chn.whisper)
         {
            if(chn.cur == chn.zone)
            {
               mci.tt.text = "";
               mci.tt.visible = false;
            }
            else
            {
               mci.tt.text = chn.cur.tag + ": ";
               mci.tt.visible = true;
            }
         }
         else if(typeof param1 == "undefined" || param1 == "")
         {
            mci.tt.text = "";
            mci.tt.visible = false;
         }
         else
         {
            pmNm = param1;
            mci.tt.text = "To " + param1 + ": ";
            mci.tt.visible = true;
         }
      }
      
      public function updateMsgEntry() : *
      {
         mci.te.x = mci.tt.x + mci.tt.textWidth + (mci.tt.text.length ? 1 : 0);
         mci.te.width = mci.bsend.x - mci.te.x - 3;
         mci.te.textColor = "0xFFFFFF";
         mci.tt.textColor = "0xFFFFFF";
      }
      
      private function checkMsgType(param1:Event) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = mci.te.text;
         var _loc3_:* = _loc2_.split(" ");
         if(_loc3_.length > 1)
         {
            _loc4_ = _loc3_[0];
            _loc5_ = "";
            if(_loc4_.charAt(0) == "/")
            {
               switch(_loc4_.substr(1))
               {
                  case "1":
                  case "s":
                  case "say":
                     if(chn.zone.act)
                     {
                        chn.cur = chn.zone;
                        chn.lastPublic = chn.zone;
                        mci.te.text = mci.te.text.substr(_loc4_.substr(1).length + 2);
                     }
                     formatMsgEntry("");
                     updateMsgEntry();
                     break;
                  case "2":
                     if(chn.trade.act)
                     {
                        chn.cur = chn.trade;
                        chn.lastPublic = chn.trade;
                        mci.te.text = mci.te.text.substr(3);
                     }
                     formatMsgEntry("");
                     updateMsgEntry();
                     break;
                  case "p":
                     if(chn.party.act)
                     {
                        chn.cur = chn.party;
                        chn.lastPublic = chn.party;
                        mci.te.text = mci.te.text.substr(3);
                     }
                     formatMsgEntry("");
                     updateMsgEntry();
                     break;
                  case "r":
                     if(pmSourceA.length)
                     {
                        pmMode = 1;
                        chn.cur = chn.whisper;
                        mci.te.text = mci.te.text.substr(3);
                        formatMsgEntry(pmSourceA[0]);
                        updateMsgEntry();
                     }
                     break;
                  case "tell":
                  case "w":
                     if(_loc3_.length > 2)
                     {
                        pmMode = 1;
                        chn.cur = chn.whisper;
                        mci.te.text = mci.te.text.substr(_loc3_[0].length + _loc3_[1].length + 1);
                        formatMsgEntry(_loc3_[1]);
                        updateMsgEntry();
                     }
                     break;
                  case "c":
                     pmMode = 2;
                     chn.cur = chn.whisper;
                     mci.te.text = mci.te.text.substr(_loc3_[0].length + _loc3_[1].length + 1);
                     formatMsgEntry(pmSourceA[0]);
                     updateMsgEntry();
                     break;
                  case "g":
                     if(chn.guild.act)
                     {
                        chn.cur = chn.guild;
                        chn.lastPublic = chn.guild;
                        mci.te.text = mci.te.text.substr(3);
                     }
                     formatMsgEntry("");
                     updateMsgEntry();
               }
            }
            if(_loc4_.charAt(0) == ">")
            {
               if(pmSourceA.length)
               {
                  pmMode = 1;
                  chn.cur = chn.whisper;
                  mci.te.text = mci.te.text.substr(2);
                  formatMsgEntry(pmSourceA[0]);
                  updateMsgEntry();
               }
            }
            _loc6_ = [];
            if(_loc2_.indexOf(" > ") > 1 && (_loc2_.indexOf("<") == -1 || _loc2_.indexOf(" > ") < _loc2_.indexOf("<")))
            {
               _loc7_ = _loc2_.split(">");
               while(_loc7_[0].charAt(_loc7_[0].length - 1) == " ")
               {
                  _loc7_[0] = _loc7_[0].substr(0,_loc7_[0].length - 1);
               }
               pmMode = 1;
               chn.cur = chn.whisper;
               mci.te.text = _loc7_[1];
               formatMsgEntry(_loc7_[0]);
               updateMsgEntry();
            }
         }
      }
      
      internal function openMsgEntry() : *
      {
         pmI = 0;
         myMsgsI = 0;
         mci.tebg.addEventListener(MouseEvent.CLICK,chat_tebgClick);
         mci.te.visible = true;
         mci.te.type = TextFieldType.INPUT;
         rootClass.stage.focus = null;
         rootClass.stage.focus = mci.te;
         formatMsgEntry(pmNm);
         updateMsgEntry();
      }
      
      internal function openPMsg(param1:*) : *
      {
         pmNm = param1;
         chn.cur = chn.whisper;
         openMsgEntry();
      }
      
      internal function closeMsgEntry() : *
      {
         mci.tebg.addEventListener(MouseEvent.CLICK,chat_tebgClick);
         mci.te.text = "";
         mci.tt.text = "";
         mci.te.visible = false;
         mci.tt.visible = false;
         if(pmMode != 2)
         {
            chn.cur = chn.lastPublic;
         }
         mci.te.type = TextFieldType.DYNAMIC;
         rootClass.stage.focus = null;
      }
      
      public function cleanStr(param1:String, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : *
      {
         param1 = param1.split("&#").join("");
         if(!param4)
         {
            param1 = param1.split("#038:").join("");
         }
         else
         {
            param1 = param1.split("#038:#").join("");
         }
         if(param3)
         {
            param1 = removeHTML(param1);
         }
         if(param1.indexOf("%") > -1)
         {
            param1 = param1.split("%").join("#037:");
         }
         if(param2 && param1.indexOf("#037:") > -1)
         {
            param1 = param1.split("#037:").join("%");
         }
         if(param1.indexOf("&") > -1)
         {
            param1 = param1.split("&").join("#038:");
         }
         if(param2 && param1.indexOf("#038:") > -1)
         {
            param1 = param1.split("#038:").join("&");
         }
         if(param1.indexOf("<") > -1)
         {
            param1 = param1.split("<").join("#060:");
         }
         if(param2 && param1.indexOf("#060:") > -1)
         {
            param1 = param1.split("#060:").join("&lt;");
         }
         if(param1.indexOf(">") > -1)
         {
            param1 = param1.split(">").join("#062:");
         }
         if(param2 && param1.indexOf("#062:") > -1)
         {
            param1 = param1.split("#062:").join("&gt;");
         }
         if(param2)
         {
            param1 = removeHTML(param1);
         }
         return param1;
      }
      
      public function cleanChars(param1:String) : String
      {
         param1 = param1.replace(regExpMod,"");
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(legalChars.indexOf(param1.charAt(_loc2_)) < 0)
            {
               param1 = param1.replace(param1.charAt(_loc2_),"?");
            }
            _loc2_++;
         }
         return param1;
      }
      
      public function strContains(param1:String, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            if(param1.indexOf(param2[_loc3_]) > -1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function submitMsg(param1:String, param2:*, param3:*, param4:Boolean = false) : *
      {
         var str:*;
         var tuo:* = undefined;
         var uName:String = null;
         var rmId:int = 0;
         var tuoNm:String = null;
         var parta:* = undefined;
         var partb:String = null;
         var i:int = 0;
         var multiO:Object = null;
         var strPassword:* = undefined;
         var uoData:* = undefined;
         var modal:MovieClip = null;
         var modalO:* = undefined;
         var strA:String = null;
         var ei:int = 0;
         var xtArr:* = undefined;
         var cmd:* = undefined;
         var params:* = undefined;
         var paramStr:* = undefined;
         var s:* = undefined;
         var bAch:* = undefined;
         var uVars:* = undefined;
         var isCellOK:Boolean = false;
         var cell:* = undefined;
         var avt:* = undefined;
         var guildName:String = null;
         var strMap:String = null;
         var m:uint = 0;
         var emStr:* = undefined;
         var index:int = 0;
         var myAvatar:Avatar = null;
         var profanityResult:Object = null;
         var iDiff:Number = NaN;
         var iHrs:int = 0;
         var iMins:int = 0;
         var msg:String = param1;
         var typ:* = param2;
         var unm:* = param3;
         var isMulti:Boolean = param4;
         msg = cleanChars(msg);
         var msgOK:Boolean = true;
         var warningModal:Boolean = true;
         var strEmail:String = null;
         if(Game.loginInfo.strPassword != null)
         {
            strPassword = Game.loginInfo.strPassword.toLowerCase();
            if(msg.toLowerCase().indexOf(strPassword) > -1)
            {
               msgOK = false;
            }
         }
         if(rootClass.world != null && rootClass.world.myAvatar != null)
         {
            if(rootClass.world.myAvatar.items == null || rootClass.world.myAvatar.items.length < 1)
            {
               msgOK = false;
               warningModal = false;
               pushMsg("warning","Character is still being loaded, please wait a moment.","SERVER","",0);
            }
            if(rootClass.world.myAvatar.objData != null)
            {
               uoData = rootClass.world.myAvatar.objData;
               if(uoData.strEmail != null)
               {
                  strEmail = uoData.strEmail.toLowerCase();
               }
               if(strEmail != null && strEmail.length > 5)
               {
                  if(msg.toLowerCase().indexOf(strEmail) > -1)
                  {
                     msgOK = false;
                  }
               }
            }
         }
         if(!msgOK && warningModal)
         {
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = "Never give your password or email to anyone. Please note that AQWorlds staff will never ask for your password or email. We do not need that information to look up your account.";
            modalO.callback = null;
            modalO.btns = "mono";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
            strA = "";
            ei = 0;
            if(strEmail != null)
            {
               if(msg.indexOf(strEmail) > -1)
               {
                  ei = 0;
                  while(ei < strEmail.length)
                  {
                     strA += ei == 0 ? strEmail.charAt(0) : "*";
                     ei++;
                  }
                  msg = msg.split(strEmail).join(strA);
               }
            }
            ei = 0;
            strA = "";
            if(msg.indexOf(strPassword) > -1)
            {
               ei = 0;
               while(ei < strPassword.length)
               {
                  strA += ei == 0 ? strPassword.charAt(0) : "*";
                  ei++;
               }
               msg = msg.split(strPassword).join(strA);
            }
            pushMsg("warning",msg,"SERVER","",0);
            closeMsgEntry();
            return;
         }
         i = 0;
         str = rootClass.stripWhite(msg);
         if(str.length)
         {
            myMsgs.push(msg);
            xtArr = [];
            cmd = "";
            if(msg.substr(0,1) == "/")
            {
               params = msg.substr(1).split(" ");
               paramStr = params[0].toLowerCase();
               switch(paramStr)
               {
                  case "qv":
                     if(Game.objLogin.iAccess >= 30)
                     {
                        if(isNaN(parseInt(params[1])))
                        {
                           break;
                        }
                        pushMsg("server","QV " + params[1] + ": " + rootClass.world.getQuestValue(parseInt(params[1])),"SERVER","",0);
                     }
                     break;
                  case "debug":
                     if(Game.objLogin.iAccess >= 30)
                     {
                        optionHandler.cmd(rootClass,"@ Debugger");
                     }
                     break;
                  case "captest":
                     if(rootClass.world.myAvatar.isStaff())
                     {
                        rootClass.sfc.sendString(msg.substr(msg.indexOf(" ") + 1));
                        pushMsg("server","Sent " + msg.substr(msg.indexOf(" ") + 1),"SERVER","",0);
                     }
                     break;
                  case "multi":
                     msg = "/" + msg.substr(7);
                     submitMsg(msg,typ,unm,true);
                     return;
                  case "reload":
                     cmd = null;
                     if(rootClass.world.myAvatar.isStaff())
                     {
                        rootClass.world.reloadCurrentMap();
                     }
                     break;
                  case "cell":
                     cmd = null;
                     if(rootClass.world.myAvatar.objData.intAccessLevel >= 40)
                     {
                        if(params.length > 1)
                        {
                           parta = params[1];
                        }
                        else
                        {
                           parta = "none";
                        }
                        if(params.length > 2)
                        {
                           partb = params[2];
                        }
                        else
                        {
                           partb = "none";
                        }
                        isCellOK = false;
                        for each(cell in rootClass.world.map.currentScene.labels)
                        {
                           if(cell.name == parta)
                           {
                              isCellOK = true;
                              break;
                           }
                        }
                        if(isCellOK)
                        {
                           rootClass.world.moveToCell(parta,partb);
                        }
                        else
                        {
                           rootClass.chatF.pushMsg("warning","Frame \'" + parta + "\' does not exist.","SERVER","",0);
                        }
                     }
                     break;
                  case "shop":
                     cmd = null;
                     if(rootClass.world.myAvatar.objData.intAccessLevel >= 40)
                     {
                        if(params.length > 1)
                        {
                           parta = int(params[1]);
                        }
                        else
                        {
                           parta = 1;
                        }
                        rootClass.world.sendLoadShopRequest(parta);
                     }
                     break;
                  case "sound":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        if(params[1] == "off")
                        {
                           rootClass.mixer.bSoundOn = false;
                        }
                        else if(params[1] == "on")
                        {
                           rootClass.mixer.bSoundOn = true;
                        }
                     }
                     break;
                  case "ignore":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        if(tuoNm.toLowerCase() != rootClass.sfc.myUserName)
                        {
                           cmd = "cmd";
                           ignore(tuoNm);
                           msg = "You are now ignoring user " + tuoNm;
                           pushMsg("server",msg,"SERVER","",0);
                        }
                        else
                        {
                           msg = "You cannot ignore yourself!";
                           pushMsg("warning",msg,"SERVER","",0);
                        }
                     }
                     break;
                  case "unignore":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        cmd = "cmd";
                        unignore(tuoNm);
                        msg = "User " + tuoNm + " is no longer being ignored";
                        pushMsg("server",msg,"SERVER","",0);
                     }
                     break;
                  case "ignoreclear":
                     cmd = null;
                     ignoreList.data.users = new Array();
                     pushMsg("warning","Ignore List Cleared!","SERVER","",0);
                     rootClass.sfc.sendXtMessage("zm","cmd",["ignoreList","$clearAll"],"str",1);
                     break;
                  case "report":
                  case "reportlang":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        rootClass.ui.mcPopup.fOpen("Report",{"unm":tuoNm});
                     }
                     break;
                  case "reporthack":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        parta = params.split(":")[0];
                        partb = params.split(":")[1];
                        tuoNm = parta.slice(1).join(" ");
                        cmd = "cmd";
                        xtArr.push("reporthack");
                        xtArr.push(tuoNm);
                        xtArr.push(partb);
                     }
                     break;
                  case "modon":
                  case "modoff":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "getinfo":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(tuoNm);
                     }
                     break;
                  case "size":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                  case "getroomname":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                     }
                     break;
                  case "event":
                     if(params.length > 2)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                        xtArr.push(params.slice(2).join(" "));
                     }
                     break;
                  case "tfer":
                     if(typeof params[1] != "undefined" && params[1].length > 0 && typeof params[2] != "undefined" && params[2].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                        xtArr.push(params[2]);
                     }
                     break;
                  case "guild":
                     rootClass.world.showGuildList();
                     break;
                  case "guildInvite":
                  case "gi":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        rootClass.world.guildInvite(tuoNm);
                     }
                     break;
                  case "guildremove":
                  case "gr":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        avt = rootClass.world.getAvatarByUserName(tuoNm);
                        if(rootClass.world.myAvatar.objData.guildRank >= 2 || Boolean(avt.isMyAvatar))
                        {
                           modal = new ModalMC();
                           modalO = {};
                           modalO.strBody = "Do you want to remove " + tuoNm + " from the guild?";
                           modalO.callback = rootClass.world.guildRemove;
                           modalO.params = {"userName":tuoNm};
                           modalO.btns = "dual";
                           rootClass.ui.ModalStack.addChild(modal);
                           modal.init(modalO);
                        }
                     }
                     break;
                  case "guildPromote":
                  case "gp":
                     cmd = null;
                     if(rootClass.world.myAvatar.objData.guildRank >= 2)
                     {
                        if(typeof params[1] != "undefined" && params[1].length > 0)
                        {
                           tuoNm = params.slice(1).join(" ");
                           rootClass.world.guildPromote(tuoNm);
                        }
                     }
                     break;
                  case "guildDemote":
                  case "gd":
                     cmd = null;
                     if(rootClass.world.myAvatar.objData.guildRank >= 2)
                     {
                        if(typeof params[1] != "undefined" && params[1].length > 0)
                        {
                           tuoNm = params.slice(1).join(" ");
                           rootClass.world.guildDemote(tuoNm);
                        }
                     }
                     break;
                  case "motd":
                     if(msg.length == 5)
                     {
                        if(rootClass.world.myAvatar.objData.guild != null)
                        {
                           if(rootClass.world.myAvatar.objData.guild.MOTD != null && String(rootClass.world.myAvatar.objData.guild.MOTD) != "undefined")
                           {
                              pushMsg("guild","Message of the day: " + String(rootClass.world.myAvatar.objData.guild.MOTD),"SERVER","",0);
                           }
                           else
                           {
                              pushMsg("guild","No Message of the day has been set.","SERVER","",0);
                           }
                        }
                     }
                     else
                     {
                        rootClass.world.setGuildMOTD(msg.substr(5));
                     }
                     break;
                  case "gc":
                  case "guildcreate":
                     if(rootClass.world.myAvatar.isUpgraded())
                     {
                        if(params[1].length > 0)
                        {
                           guildName = params[1];
                           i = 2;
                           while(i < params.length)
                           {
                              guildName = guildName + " " + params[i];
                              i++;
                           }
                           if(guildName.length <= 25)
                           {
                              modal = new ModalMC();
                              modalO = {};
                              modalO.strBody = "Do you want to create the guild " + guildName + "?";
                              modalO.callback = rootClass.world.createGuild;
                              modalO.params = {"guildName":guildName};
                              modalO.btns = "dual";
                              rootClass.ui.ModalStack.addChild(modal);
                              modal.init(modalO);
                           }
                           else
                           {
                              rootClass.chatF.pushMsg("server","Guild names must be 25 characters or less.","SERVER","",0);
                           }
                        }
                        else
                        {
                           rootClass.chatF.pushMsg("server","Please specify a name for your guild.","SERVER","",0);
                        }
                     }
                     else
                     {
                        rootClass.chatF.pushMsg("server","Only members may create guilds.","SERVER","",0);
                     }
                     break;
                  case "renameGuild":
                  case "rg":
                     if(rootClass.world.myAvatar.objData.guildRank == 3)
                     {
                        if(rootClass.world.myAvatar.objData.intCoins >= 1000)
                        {
                           if(params[1].length > 0)
                           {
                              guildName = params[1];
                              i = 2;
                              while(i < params.length)
                              {
                                 guildName = String(guildName) + " " + String(params[i]);
                                 i++;
                              }
                              if(guildName.length <= 25)
                              {
                                 modal = new ModalMC();
                                 modalO = {};
                                 modalO.strBody = "Do you want to rename the guild to " + guildName + "? This will cost 1000 ACs.";
                                 modalO.callback = rootClass.world.renameGuild;
                                 modalO.params = {"guildName":guildName};
                                 modalO.btns = "dual";
                                 rootClass.ui.ModalStack.addChild(modal);
                                 modal.init(modalO);
                              }
                              else
                              {
                                 rootClass.chatF.pushMsg("server","Guild names must be 25 characters or less.","SERVER","",0);
                              }
                           }
                           else
                           {
                              rootClass.chatF.pushMsg("server","Please specify a name for your guild.","SERVER","",0);
                           }
                        }
                        else
                        {
                           rootClass.chatF.pushMsg("server","You do not have enough ACs.","SERVER","",0);
                        }
                     }
                     break;
                  case "addquest":
                  case "removequest":
                  case "forcestart":
                  case "forcestop":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        try
                        {
                           rootClass.sfc.sendXtMessage("zm","dynamic",[paramStr,params[1],params[2]],"str",1);
                        }
                        catch(e:*)
                        {
                           rootClass.sfc.sendXtMessage("zm","dynamic",[paramStr,params[1]],"str",1);
                        }
                     }
                     break;
                  case "guildreset":
                     rootClass.sfc.sendXtMessage("zm","guild",["guildreset"],"str",1);
                     break;
                  case "yuki":
                     rmId = int(chn.cur.rid);
                     cmd = "message";
                     msg = cleanStr(msg,false,true);
                     xtArr.push(msg.substring(msg.indexOf("//yuki ") + 6,msg.length));
                     xtArr.push(chn.cur.str);
                     xtArr.push("yuki");
                     break;
                  case "ginv":
                     cmd = null;
                     s = String(params[1]);
                     i = 2;
                     while(i < params.length)
                     {
                        s = s + " " + String(params[i]);
                        i++;
                     }
                     rootClass.sfc.sendXtMessage("zm","guild",["gInv",s],"str",1);
                     break;
                  case "invite":
                  case "pi":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        if(rootClass.world.partyMembers.length < 4 || !rootClass.world.isPartyMember(tuoNm))
                        {
                           rootClass.world.partyInvite(tuoNm);
                        }
                     }
                     break;
                  case "ps":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        rootClass.world.partySummon(tuoNm);
                     }
                     break;
                  case "pk":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        rootClass.world.doPartyKick(tuoNm);
                     }
                     break;
                  case "duel":
                     cmd = null;
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        rootClass.world.sendDuelInvite(tuoNm);
                     }
                     break;
                  case "friends":
                     cmd = null;
                     rootClass.world.showFriendsList();
                     break;
                  case "friend":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        tuoNm = params.slice(1).join(" ");
                        if(tuoNm.toLowerCase() != rootClass.sfc.myUserName)
                        {
                           rootClass.world.requestFriend(tuoNm);
                        }
                     }
                     break;
                  case "modban":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        tuoNm = params.slice(1).join(" ");
                        xtArr.push(params[0]);
                        xtArr.push(tuoNm);
                        xtArr.push(24);
                     }
                     break;
                  case "join":
                     if(typeof params[1] != "undefined" && params[1].length > 0 && rootClass.world.uoTree[rootClass.sfc.myUserName].intState != 0 && Boolean(rootClass.world.coolDown("tfer")))
                     {
                        rootClass.world.returnInfo = null;
                        cmd = "cmd";
                        uName = rootClass.sfc.myUserName;
                        strMap = params[1];
                        if(params.length > 2)
                        {
                           m = 2;
                           while(m < params.length)
                           {
                              strMap = strMap + " " + params[m];
                              m++;
                           }
                        }
                        xtArr.push("tfer");
                        xtArr.push(rootClass.sfc.myUserName);
                        xtArr.push(strMap);
                     }
                     break;
                  case "roomid":
                     cmd = "cmd";
                     xtArr.push("roomID");
                     xtArr.push(rootClass.sfc.myUserName);
                     xtArr.push(params[1]);
                     break;
                  case "house":
                     cmd = null;
                     if(params[1] == null)
                     {
                        tuoNm = rootClass.sfc.myUserName;
                     }
                     else
                     {
                        tuoNm = params.slice(1).join(" ");
                     }
                     rootClass.world.gotoHouse(tuoNm);
                     break;
                  case "kick":
                  case "ipkick":
                  case "ipunmute":
                  case "unmute":
                  case "freeze":
                  case "unfreeze":
                  case "watch":
                  case "unwatch":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        tuoNm = params.slice(1).join(" ");
                        xtArr.push(params[0]);
                        xtArr.push(tuoNm);
                     }
                     break;
                  case "mute":
                  case "ban":
                  case "ipmute":
                     if(rootClass.world.myAvatar.isStaff() && typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        tuoNm = params.slice(2).join(" ");
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                        xtArr.push(tuoNm);
                     }
                     break;
                  case "goto":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = null;
                        rootClass.world.goto(params.slice(1).join(" "));
                     }
                     break;
                  case "pull":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = null;
                        rootClass.world.pull(params.slice(1).join(" "));
                     }
                     break;
                  case "clear":
                  case "bonus":
                  case "boost":
                     if(params.length > 1)
                     {
                        cmd = "cmd";
                        i = 0;
                        while(i < params.length)
                        {
                           xtArr.push(params[i]);
                           i++;
                        }
                     }
                     break;
                  case "frostreset":
                     cmd = "cmd";
                     xtArr.push("frostreset");
                     break;
                  case "queue":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "killmap":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                     }
                     break;
                  case "item":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                        xtArr.push(params[2]);
                     }
                     break;
                  case "combat":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     xtArr.push(params[1]);
                     break;
                  case "addrep":
                  case "addxp":
                  case "addv":
                  case "hp":
                  case "level":
                  case "getevents":
                  case "getevent":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        xtArr.push(params[1]);
                     }
                     break;
                  case "datadump":
                  case "monitor":
                  case "resetevents":
                  case "resetlogins":
                  case "resetgrove":
                  case "resettimes":
                  case "getlogins":
                  case "gettimes":
                  case "clock":
                  case "whitelist":
                     cmd = "cmd";
                     i = 0;
                     while(i < params.length)
                     {
                        xtArr.push(params[i]);
                        i++;
                     }
                     break;
                  case "getbreakdown":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "adminyell":
                  case "iay":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        msg = params.slice(1).join(" ");
                        msg = cleanStr(msg,false,true);
                        xtArr.push(msg);
                     }
                     break;
                  case "iteratortest":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "fps":
                     cmd = null;
                     rootClass.world.toggleFPS();
                     break;
                  case "mod":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "pmoff":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     xtArr.push(msg.substr(7));
                     break;
                  case "pmon":
                  case "partyon":
                  case "partyoff":
                  case "chaton":
                  case "chatoff":
                  case "friendon":
                  case "friendoff":
                  case "waron":
                  case "waroff":
                  case "kickall":
                  case "restart":
                  case "restartnow":
                  case "shutdown":
                  case "shutdownnow":
                  case "empty":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     break;
                  case "roll":
                     cmd = "util";
                     xtArr.push(params[0]);
                     break;
                  case "geta":
                     if(Boolean(rootClass.world.myAvatar.isStaff()) && params.length == 3)
                     {
                        pushMsg("warning","geta " + params[1] + "," + params[2] + ": " + rootClass.world.getAchievement(params[1],params[2]),"SERVER","",0);
                     }
                     break;
                  case "seta":
                     if(Boolean(rootClass.world.myAvatar.isStaff()) && params.length == 4)
                     {
                        rootClass.world.setAchievement(params[1],params[2],params[3]);
                     }
                     break;
                  case "queststring":
                     if(rootClass.world.myAvatar.isStaff())
                     {
                        rootClass.world.loadQuestStringData();
                        cmd = "cmd";
                        i = 0;
                        while(i < params.length)
                        {
                           xtArr.push(params[i]);
                           i++;
                        }
                     }
                     break;
                  case "e":
                  case "me":
                  case "em":
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        emStr = params.slice(1).join(" ");
                        emStr = cleanStr(emStr,false,true);
                        rmId = int(chn.cur.rid);
                        cmd = "em";
                        xtArr.push(emStr);
                        xtArr.push(chn.event.str);
                     }
                     break;
                  case "who":
                     cmd = "cmd";
                     xtArr.push(params[0]);
                     if(typeof params[1] != "undefined" && params[1].length > 0)
                     {
                        xtArr.push(params.splice(1).join(" "));
                     }
                     break;
                  case "afk":
                     cmd = null;
                     rootClass.world.afkToggle();
                     break;
                  case "rest":
                     rootClass.world.rest();
                     break;
                  case "repairavatars":
                     cmd = null;
                     rootClass.world.repairAvatars();
                     break;
                  case "samba":
                     bAch = rootClass.world.getAchievement("ia0",11);
                     if(!bAch)
                     {
                        pushMsg("warning","You must learn this dance from Samba in Bloodtusk Ravine.","SERVER","",0);
                        break;
                     }
                     if(!rootClass.world.myAvatar.isUpgraded())
                     {
                        pushMsg("warning","Requires membership to use this emote.","SERVER","",0);
                        break;
                     }
                  case "danceweapon":
                     if(!rootClass.world.myAvatar.isUpgraded())
                     {
                        pushMsg("warning","Requires membership to use this emote.","SERVER","",0);
                        break;
                     }
                  case "useweapon":
                     if(!rootClass.world.myAvatar.isUpgraded())
                     {
                        pushMsg("warning","Requires membership to use this emote.","SERVER","",0);
                        break;
                     }
                  case "powerup":
                  case "kneel":
                  case "jumpcheer":
                  case "salute2":
                  case "cry2":
                  case "spar":
                  case "stepdance":
                  case "headbang":
                  case "dazed":
                     if(!rootClass.world.myAvatar.isUpgraded())
                     {
                        pushMsg("warning","Requires membership to use this emote.","SERVER","",0);
                        break;
                     }
                  case "dance":
                  case "laugh":
                  case "lol":
                  case "point":
                  case "use":
                  case "fart":
                  case "backflip":
                  case "sleep":
                  case "jump":
                  case "punt":
                  case "dance2":
                  case "swordplay":
                  case "feign":
                  case "wave":
                  case "bow":
                  case "cry":
                  case "unsheath":
                  case "cheer":
                  case "stern":
                  case "salute":
                  case "airguitar":
                  case "facepalm":
                     uVars = {};
                     cmd = uVars.typ = "emotea";
                     uVars.strEmote = paramStr;
                     if(uVars.strEmote == "lol")
                     {
                        uVars.strEmote = "laugh";
                     }
                     uVars.strChar = params[1];
                     break;
                  default:
                     if(unm == "iterator" || Boolean(rootClass.world.myAvatar.isStaff()))
                     {
                        cmd = "cmd";
                        index = 0;
                        while(index < params.length)
                        {
                           xtArr.push(params[index]);
                           index++;
                        }
                     }
               }
            }
            else if(typ != "whisper")
            {
               rmId = int(chn.cur.rid);
               cmd = "message";
               msg = cleanStr(msg,false,true);
               xtArr.push(msg);
               xtArr.push(chn.cur.str);
            }
            else
            {
               rmId = 1;
               cmd = "whisper";
               msg = cleanStr(msg,false,true);
               xtArr.push(msg);
               xtArr.push(unm);
            }
            if(cmd == "emotea")
            {
               rootClass.world.myAvatar.pMC.mcChar.gotoAndPlay(rootClass.strToProperCase(uVars.strEmote));
               rootClass.sfc.sendXtMessage("zm",cmd,[uVars.strEmote],"str",1);
            }
            else if(cmd == "mod" || cmd == "cmd")
            {
               if(xtArr.length)
               {
                  rootClass.sfc.sendXtMessage("zm",cmd,xtArr,"str",1);
               }
            }
            else if(cmd != "simple")
            {
               if(!(cmd == null || xtArr.length < 1))
               {
                  if(!rootClass.serialCmdMode)
                  {
                     rootClass.world.afkPostpone();
                     myAvatar = rootClass.world.myAvatar;
                     profanityResult = {};
                     profanityResult = nuProfanityCheck(cleanStr(xtArr[0]));
                     if(iChat == 0)
                     {
                        pushMsg("warning","This server only allows canned chat.","SERVER","",0);
                     }
                     else if(iChat == 1 && !rootClass.world.myAvatar.hasUpgraded() && !rootClass.world.myAvatar.isVerified() && !rootClass.world.myAvatar.isStaff())
                     {
                        pushMsg("warning","Chat is a members-only feature at this time.","SERVER","",0);
                     }
                     else if(!rootClass.world.myAvatar.hasUpgraded() && !rootClass.world.myAvatar.isVerified() && !rootClass.world.myAvatar.isStaff() && !rootClass.world.myAvatar.isEmailVerified())
                     {
                        if(int(rootClass.world.myAvatar.objData.iAge) < 13)
                        {
                           pushMsg("warning","Upgrade is required to chat in this server.","SERVER","",0);
                        }
                        else
                        {
                           pushMsg("warning","Confirm your email at https://account.aq.com/ to protect your account and enable chat.","SERVER","",0);
                        }
                     }
                     else if(myAvatar.objData.bPermaMute == 1)
                     {
                        pushMsg("warning","You are mute! Chat privileges have been permanently revoked.","SERVER","",0);
                     }
                     else if(myAvatar.objData.dMutedTill != null && myAvatar.objData.dMutedTill.getTime() > rootClass.date_server.getTime())
                     {
                        iDiff = (myAvatar.objData.dMutedTill.getTime() - rootClass.date_server.getTime()) / 1000;
                        iHrs = iDiff / (60 * 60);
                        iMins = (iDiff - iHrs * 60 * 60) / 60;
                        pushMsg("warning","You are mute! Chat privileges have been revoked for next " + iHrs + " h " + iMins + " m!","SERVER","",0);
                     }
                     else if(isUnsendable(msg))
                     {
                        pushMsg("warning","Please do not send messages that may contain private information, such as an email address.","SERVER","",0);
                     }
                     else if(xtArr[0].length > 0)
                     {
                        if(Boolean(profanityResult.code) && Boolean(rootClass.uoPref.bProf))
                        {
                           xtArr[0] = maskStringBetween(xtArr[0],profanityResult.indeces);
                        }
                        if(!rootClass.uoPref.bProf)
                        {
                           profanityResult = nuProfanityCheck(cleanStr(xtArr[0]),true);
                           if(profanityResult.code)
                           {
                              xtArr[0] = maskStringBetween(xtArr[0],profanityResult.indeces);
                           }
                        }
                        xtArr[0] = forceRemove(xtArr[0]);
                        rootClass.sfc.sendXtMessage("zm",cmd,xtArr,"str",rmId);
                     }
                  }
                  else
                  {
                     rootClass.sfc.sendXtMessage("zm",cmd,xtArr,"str",rmId);
                  }
               }
            }
         }
         if(!rootClass.serialCmdMode)
         {
            closeMsgEntry();
         }
      }
      
      private function checkFieldsVPos() : *
      {
         var _loc1_:* = mci.t1;
         _loc1_.resetVPos = 0;
         if(panelIndex == t1Arr.length - 1)
         {
            _loc1_.resetVPos = 1;
         }
      }
      
      private function setFieldsVPos() : *
      {
         var _loc1_:* = mci.t1;
         if(_loc1_.resetVPos)
         {
            panelIndex = t1Arr.length - 1;
         }
         panelIndex = Math.min(panelIndex,t1Arr.length - 1);
      }
      
      public function format_time() : String
      {
         var _loc4_:String = null;
         var _loc1_:Number = Number(rootClass.date_server.hours);
         var _loc2_:Number = Number(rootClass.date_server.minutes);
         var _loc3_:String = "PM";
         if(_loc1_ < 10)
         {
            _loc4_ = "0" + _loc1_;
         }
         if(_loc1_ > 12)
         {
            _loc1_ -= 12;
         }
         else if(_loc1_ == 0)
         {
            _loc3_ = "AM";
            _loc1_ = 12;
         }
         else if(_loc1_ < 12)
         {
            _loc3_ = "AM";
         }
         _loc4_ = "" + _loc1_;
         var _loc5_:String = "" + _loc2_;
         if(_loc2_ < 10)
         {
            _loc5_ = "0" + _loc2_;
         }
         if(_loc5_ == "NaN")
         {
            return "";
         }
         return _loc4_ + ":" + _loc5_ + " " + _loc3_;
      }
      
      private function html2Fields(param1:*, param2:*, param3:*, param4:*) : *
      {
         var _loc5_:* = mci.t1;
         switch(param2)
         {
            case "=":
            default:
               t1Arr = [{
                  "s":param1,
                  "id":param4
               }];
               break;
            case "+=":
               t1Arr.push({
                  "s":param1,
                  "id":param4
               });
         }
      }
      
      public function writeText(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc4_:* = true;
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc7_ = t1Arr.length - 1;
         while(_loc7_ > -1)
         {
            if(_loc7_ <= param1 && _loc4_)
            {
               _loc8_ = int(t1Arr[_loc7_].id);
               tl.ti.htmlText = t1Arr[_loc7_].s;
               formatWithoutTextLinks(tl.ti);
               _loc6_ = checkPos(tl,_loc7_,_loc8_,param1);
               if(_loc6_ <= 0)
               {
                  _loc4_ = false;
               }
               else
               {
                  _loc5_.push(_loc8_);
                  if(drawnA.indexOf(_loc8_) > -1)
                  {
                     _loc2_ = getBitmapByIndex(_loc8_,mci.t1);
                  }
                  else
                  {
                     _loc2_ = buildTextLinks(tl.ti,t1Arr[_loc7_].s,mci.t1,drawnA,_loc8_);
                  }
                  _loc2_.y = _loc6_;
                  MovieClip(_loc2_).mouseEnabled = false;
               }
            }
            _loc7_--;
         }
         _loc7_ = 0;
         while(_loc7_ < drawnA.length)
         {
            if(_loc5_.indexOf(drawnA[_loc7_]) < 0)
            {
               _loc2_ = getBitmapByIndex(drawnA[_loc7_],mci.t1);
               if(_loc2_ != null)
               {
                  mci.t1.removeChild(_loc2_);
                  drawnA.splice(_loc7_,1);
                  _loc7_--;
               }
            }
            _loc7_++;
         }
      }
      
      private function formatWithoutTextLinks(param1:TextField) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         var _loc16_:* = null;
         var _loc2_:String = "$({";
         var _loc3_:String = "})$";
         var _loc4_:* = "<font color=\"#";
         var _loc5_:* = "\">";
         var _loc6_:* = "</font>";
         while(param1.htmlText.indexOf(_loc2_) > -1 && param1.htmlText.indexOf(_loc3_) > -1)
         {
            _loc7_ = param1.htmlText;
            _loc8_ = _loc7_.substr(0,_loc7_.indexOf(_loc2_));
            _loc9_ = _loc7_.substr(_loc7_.indexOf(_loc3_) + _loc3_.length);
            _loc10_ = _loc7_.substr(_loc7_.indexOf(_loc2_) + _loc2_.length);
            _loc11_ = _loc10_.substr(0,_loc10_.indexOf(_loc3_)).split(",");
            _loc12_ = _loc11_[0];
            _loc13_ = _loc11_[1];
            _loc14_ = int(param1.text.indexOf(_loc2_));
            switch(_loc12_)
            {
               case "url":
                  _loc16_ = _loc13_;
                  _loc15_ = _loc4_ + "FFFF99" + _loc5_ + "<u>" + _loc16_ + "</u>" + _loc6_;
                  break;
               case "user":
                  _loc16_ = _loc13_;
                  _loc15_ = _loc4_ + "FFFFFF" + _loc5_ + _loc16_ + _loc6_;
                  break;
               case "item":
               case "quest":
                  _loc16_ = "[" + _loc13_ + "]";
                  _loc15_ = _loc4_ + "00CCFF" + _loc5_ + _loc16_ + _loc6_;
                  break;
            }
            param1.htmlText = _loc8_ + _loc15_ + _loc9_;
         }
      }
      
      private function buildTextLinks(param1:TextField, param2:String, param3:MovieClip, param4:Array, param5:int) : DisplayObject
      {
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:Array = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:int = 0;
         var _loc21_:String = null;
         var _loc22_:* = null;
         var _loc23_:Object = null;
         var _loc24_:* = undefined;
         var _loc25_:* = undefined;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:* = undefined;
         var _loc30_:Rectangle = null;
         var _loc31_:Rectangle = null;
         var _loc32_:MovieClip = null;
         var _loc33_:* = undefined;
         var _loc34_:String = null;
         var _loc6_:MovieClip = new MovieClip();
         _loc6_.name = "b" + param5;
         var _loc7_:String = "$({";
         var _loc8_:String = "})$";
         var _loc9_:* = "<font color=\"#";
         var _loc10_:* = "\">";
         var _loc11_:* = "</font>";
         param1.htmlText = param2;
         while(param1.htmlText.indexOf(_loc7_) > -1 && param1.htmlText.indexOf(_loc8_) > -1)
         {
            _loc13_ = param1.htmlText;
            _loc14_ = _loc13_.substr(0,_loc13_.indexOf(_loc7_));
            _loc15_ = _loc13_.substr(_loc13_.indexOf(_loc8_) + _loc8_.length);
            _loc16_ = _loc13_.substr(_loc13_.indexOf(_loc7_) + _loc7_.length);
            _loc17_ = _loc16_.substr(0,_loc16_.indexOf(_loc8_)).split(",");
            _loc18_ = _loc17_[0];
            _loc19_ = _loc17_[1];
            _loc19_ = _loc19_.split("&amp;").join("&");
            _loc20_ = int(param1.text.indexOf(_loc7_));
            _loc23_ = {};
            switch(_loc18_)
            {
               case "url":
                  _loc22_ = _loc19_;
                  _loc21_ = _loc9_ + "FFFF99" + _loc10_ + "<u>" + _loc22_ + "</u>" + _loc11_;
                  _loc23_.callback = urlClick;
                  break;
               case "user":
                  _loc22_ = _loc19_;
                  _loc21_ = _loc9_ + "FFFFFF" + _loc10_ + _loc22_ + _loc11_;
                  _loc23_.callback = pmClick;
                  break;
               case "item":
                  _loc22_ = "[" + _loc19_ + "]";
                  _loc21_ = _loc9_ + "00CCFF" + _loc10_ + _loc22_ + _loc11_;
                  _loc23_.callback = null;
                  break;
               case "quest":
                  _loc23_.sName = _loc17_[1];
                  _loc23_.QuestID = _loc17_[2];
                  _loc23_.iLvl = _loc17_[3];
                  _loc23_.unm = _loc17_[4];
                  _loc22_ = "[" + _loc19_ + "]";
                  _loc21_ = _loc9_ + "00CCFF" + _loc10_ + _loc22_ + _loc11_;
                  _loc23_.callback = rootClass.world.doCTAClick;
            }
            param1.htmlText = _loc14_ + _loc21_ + _loc15_;
            _loc24_ = _loc20_;
            _loc25_ = _loc20_ + _loc22_.length - 1;
            _loc26_ = param1.getLineIndexOfChar(_loc24_);
            _loc27_ = param1.getLineIndexOfChar(_loc25_);
            _loc28_ = _loc26_;
            while(_loc28_ <= _loc27_)
            {
               if(_loc28_ == _loc26_)
               {
                  _loc29_ = param1.getCharBoundaries(_loc24_);
               }
               else
               {
                  _loc29_ = param1.getCharBoundaries(param1.getLineOffset(_loc28_));
               }
               if(_loc28_ == _loc27_)
               {
                  _loc30_ = param1.getCharBoundaries(_loc25_);
               }
               else
               {
                  _loc30_ = param1.getCharBoundaries(param1.getLineOffset(_loc28_ + 1) - 1);
               }
               _loc31_ = new Rectangle(_loc29_.x,_loc29_.y,_loc30_.x - _loc29_.x + _loc30_.width,_loc30_.y - _loc29_.y + _loc30_.height);
               _loc32_ = new MovieClip();
               _loc32_.graphics.beginFill(52479);
               _loc32_.graphics.drawRect(0,0,_loc31_.width,_loc31_.height);
               _loc32_.graphics.endFill();
               _loc33_ = _loc6_.addChild(_loc32_);
               _loc33_.alpha = 0;
               _loc33_.x = param1.x + _loc29_.x;
               _loc33_.y = param1.y + _loc29_.y;
               for(_loc34_ in _loc23_)
               {
                  if(_loc34_ != "callback")
                  {
                     _loc33_[_loc34_] = _loc23_[_loc34_];
                  }
               }
               _loc33_.str = _loc19_;
               _loc33_.buttonMode = true;
               _loc33_.addEventListener(MouseEvent.CLICK,_loc23_.callback,false,0,true);
               _loc28_++;
            }
         }
         var _loc12_:* = new uiTextLine();
         _loc12_.ti.htmlText = tl.ti.htmlText;
         _loc12_.ti.autoSize = "left";
         _loc12_.ti.multiline = true;
         MovieClip(_loc12_).mouseEnabled = false;
         MovieClip(_loc12_).mouseChildren = false;
         _loc12_.name = "bmp";
         if(_loc6_.numChildren > 0)
         {
            _loc6_.swapChildren(_loc6_.getChildAt(0),_loc6_.addChildAt(_loc12_,0));
         }
         else
         {
            _loc6_.addChild(_loc12_);
         }
         param4.push(param5);
         return param3.addChild(_loc6_);
      }
      
      private function checkPos(param1:MovieClip, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:DisplayObject = getBitmapByIndex(param3 + 1,mci.t1);
         if(_loc5_ != null && param2 < param4)
         {
            return _loc5_.y - param1.height + 2;
         }
         return Math.round(tfHeight - param1.height);
      }
      
      private function pmClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         if(param1.shiftKey)
         {
            _loc2_ = param1.currentTarget as MovieClip;
            openPMsg(_loc2_.str);
         }
         else
         {
            rootClass.world.onWalkClick();
         }
      }
      
      private function urlClick(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.currentTarget as MovieClip;
         navigateToURL(new URLRequest(_loc2_.str),"_blank");
      }
      
      private function getBitmapByIndex(param1:int, param2:DisplayObjectContainer) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         while(_loc4_ < param2.numChildren)
         {
            if(int(param2.getChildAt(_loc4_).name.substr(1)) == param1)
            {
               return param2.getChildAt(_loc4_);
            }
            _loc4_++;
         }
         return null;
      }
      
      public function nuProfanityCheck(param1:String, param2:Boolean = false) : Object
      {
         var _loc5_:* = null;
         var _loc3_:* = param2 ? profanityD : profanityA;
         var _loc4_:* = param2 ? profanityF : profanityB;
         var _loc6_:int = 0;
         var _loc7_:Object = {
            "code":0,
            "term":"",
            "index":-1,
            "indeces":[]
         };
         _loc5_ = " " + removeHTML(cleanStr(param1.toLowerCase())) + " ";
         _loc5_ = rootClass.stripMarks(_loc5_);
         _loc5_ = rootClass.stripDuplicateVowels(_loc5_);
         _loc5_ = _loc5_.replace(regExpMultiG,"gg");
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc7_.index = _loc5_.indexOf(" " + _loc3_[_loc6_] + " ");
            if(_loc7_.index > -1)
            {
               _loc7_.term = _loc3_[_loc6_];
               _loc7_.indeces.push({"term":_loc7_.term});
               _loc7_.code = 1;
            }
            _loc6_++;
         }
         _loc5_ = rootClass.stripDuplicateVowels(removeHTML(cleanStr(param1.toLowerCase())));
         _loc5_ = rootClass.stripWhiteStrict(_loc5_);
         _loc5_ = _loc5_.replace(regExpMultiG,"gg");
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_.index = _loc5_.indexOf(_loc4_[_loc6_]);
            if(_loc7_.index > -1)
            {
               _loc7_.term = _loc4_[_loc6_];
               _loc7_.indeces.push({"term":_loc7_.term});
               _loc7_.code = 2;
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function createAsterisk(param1:int) : *
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += "*";
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function buildRegex(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += "(" + (regexEscapes.indexOf(param1.charAt(_loc3_)) > -1 ? "\\" : "") + param1.charAt(_loc3_) + ")+";
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function forceRemove(param1:String) : String
      {
         var _loc2_:String = param1;
         var _loc3_:RegExp = /\W*?(cum|faggot)\W*\b/gi;
         return _loc2_.replace(_loc3_,"");
      }
      
      public function maskStringBetween(param1:String, param2:Array) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:RegExp = null;
         var _loc3_:String = param1;
         if(param2.length > 0)
         {
            for each(_loc4_ in param2)
            {
               _loc5_ = new RegExp(buildRegex(_loc4_.term),"gi");
               _loc3_ = _loc3_.replace(_loc5_,createAsterisk(3));
            }
         }
         return _loc3_;
      }
      
      public function pushMsg(param1:*, param2:*, param3:*, param4:*, param5:*, param6:int = 0) : *
      {
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc13_:Object = null;
         var _loc14_:String = null;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc24_:* = undefined;
         var _loc25_:* = undefined;
         var _loc26_:* = undefined;
         var _loc27_:* = undefined;
         var _loc28_:* = undefined;
         var _loc29_:* = null;
         if(rootClass.litePreference.data.bChatFilter)
         {
            if(Boolean(rootClass.litePreference.data.dOptions["disRed"]) && param1 == "warning")
            {
               _loc10_ = true;
               if(param2.indexOf("You are out of range!") > -1)
               {
                  _loc10_ = false;
               }
               else if(param2.indexOf("is not ready yet.") > -1)
               {
                  _loc10_ = false;
               }
               else if(param2.indexOf("No target selected!") > -1)
               {
                  _loc10_ = false;
               }
               else if(param2.indexOf("Not enough mana!") > -1)
               {
                  _loc10_ = false;
               }
               if(!_loc10_)
               {
                  return;
               }
            }
         }
         var _loc7_:Boolean = false;
         if(ignoreList.data.users != null && ignoreList.data.users.indexOf(param3) > -1)
         {
            return;
         }
         if(param3 != "SERVER")
         {
            _loc11_ = 0;
            _loc12_ = rootClass.stripWhite(param2.toLowerCase());
            _loc13_ = nuProfanityCheck(param2.toLowerCase());
            if(param3.toLowerCase() != rootClass.sfc.myUserName && param6 == 0)
            {
               _loc14_ = param2.replace(/[^a-z]/gi,"");
               if(strContains(_loc14_.toLowerCase(),["aqwtrade","qwtrade","qwtrde","qwtrd","aqwtrad","aqwtrde","aqwtrd","edartwqa","aqwpirate","aqwolf"]))
               {
                  return;
               }
               if(strContains(_loc12_,illegalStrings) || strContains(_loc12_,unsendable))
               {
                  _loc11_ = 1;
               }
               _loc12_ = rootClass.stripWhiteStrict(param2.toLowerCase());
               if(strContains(_loc12_,["email","password"]))
               {
                  _loc11_ = 1;
               }
               if(param1 == "whisper" && modWhisperCheck(param2) > 0)
               {
                  _loc7_ = true;
               }
               if(_loc11_)
               {
                  return;
               }
            }
            if(Boolean(_loc13_.code) && Boolean(rootClass.uoPref.bProf))
            {
               param2 = maskStringBetween(param2,_loc13_.indeces);
            }
            if(!rootClass.uoPref.bProf)
            {
               _loc13_ = nuProfanityCheck(param2.toLowerCase(),true);
               if(_loc13_.code)
               {
                  param2 = maskStringBetween(param2,_loc13_.indeces);
               }
            }
            param2 = forceRemove(param2);
         }
         var _loc8_:String = "$({";
         var _loc9_:String = "})$";
         startWindowTimer();
         if(param3.toLowerCase() == rootClass.sfc.myUserName && rootClass.world.myAvatar.objData.intActivationFlag == 1)
         {
            pushMsg("warning","Confirm your email at https://account.aq.com/ to protect your account and remove this message. ","SERVER","",0);
         }
         if(isChannel(param1))
         {
            if(param1 == "zone")
            {
               param3 = rootClass.strToProperCase(param3);
               if(param3 == "Eienyuki" && param6 == 1)
               {
                  popBubble("u:yorumi","Eienyuki: " + param2,param1);
               }
               else
               {
                  popBubble("u:" + param3,param2,param1);
               }
            }
            checkFieldsVPos();
            chatArray.push([param1,param2,param3,param4,param5,msgID,"<font size=\"11\" style=\"font-family:Arial;\">" + format_time() + "</font> "]);
            ++msgID;
            if(chatArray.length > lineLimit)
            {
               chatArray.splice(0,chatArray.length - lineLimit);
            }
            html2Fields("","=","server",0);
            t1Arr = [];
            _loc15_ = 0;
            while(_loc15_ < chatArray.length)
            {
               _loc16_ = chatArray[_loc15_][0];
               _loc17_ = chatArray[_loc15_][1];
               _loc18_ = chatArray[_loc15_][2];
               _loc19_ = chatArray[_loc15_][3];
               _loc20_ = chatArray[_loc15_][4];
               _loc21_ = int(chatArray[_loc15_][5]);
               _loc22_ = Boolean(rootClass.litePreference.data.bChatFilter) && Boolean(rootClass.litePreference.data.dOptions["timeStamps"]) ? chatArray[_loc15_][6] : "";
               _loc23_ = "<font color=\"#";
               _loc24_ = "\">";
               _loc25_ = "</font>";
               _loc26_ = chn[_loc16_].tag == "" ? "" : "[" + chn[_loc16_].tag + "] ";
               _loc27_ = _loc18_;
               _loc17_ = _loc17_.replace(regExpURL,"$({url,$&})$");
               if(_loc18_ != null && _loc18_ != "SERVER")
               {
                  _loc28_ = _loc8_ + "user," + _loc27_ + _loc9_ + ": ";
               }
               if(_loc18_ == "SERVER")
               {
                  _loc28_ = "";
               }
               if(_loc16_ != "whisper")
               {
                  if(_loc16_ != "event")
                  {
                     html2Fields(_loc22_ + _loc23_ + chn[_loc16_].col + _loc24_ + _loc26_ + _loc28_ + _loc17_ + _loc25_ + "<br>","+=",_loc16_,_loc21_);
                  }
                  else
                  {
                     html2Fields(_loc22_ + _loc23_ + "CCCCCC" + _loc24_ + "*" + _loc23_ + "FFFFFF" + _loc24_ + _loc27_ + _loc25_ + _loc23_ + "CCCCCC" + _loc24_ + " " + _loc17_ + _loc25_ + "*<br>","+=",_loc16_,_loc21_);
                  }
               }
               else if(_loc18_ == rootClass.sfc.myUserName || isMyModHandle(_loc18_))
               {
                  if(_loc20_ == 0)
                  {
                     html2Fields(_loc22_ + "<font color=\"#" + rootClass.modColor(chn[_loc16_].col,"666666","-") + "\">" + "To " + _loc19_ + ": " + _loc17_ + "</font><br>","+=",_loc16_,_loc21_);
                  }
                  else
                  {
                     html2Fields(_loc22_ + "<font color=\"#" + chn[_loc16_].col + "\">From " + _loc28_ + _loc17_ + "</font><br>","+=",_loc16_,_loc21_);
                  }
               }
               else
               {
                  html2Fields(_loc22_ + "<font color=\"#" + chn[_loc16_].col + "\">From " + _loc28_ + _loc17_ + "</font><br>","+=",_loc16_,_loc21_);
               }
               _loc15_++;
            }
            setFieldsVPos();
            writeText(panelIndex);
         }
         if(_loc7_)
         {
            pushMsg("warning","<font color=\'#FFFFFF\'>" + param3 + "</font> IS NOT A MODERATOR.  DO NOT GIVE ACCOUNT INFORMATION TO OTHER PLAYERS.","SERVER","",0);
            _loc29_ = "<font color=\'#FF0000\'>WARNING</font><br/><font color=\'#FFFFFF\'>" + param3.toUpperCase() + "</font><font color=\'#FFFFFF\'> IS NOT A MODERATOR.<br/>Do not give account information to other players.<font>";
            _loc29_ = _loc29_ + "<br/><a href=\'event:link::https://aq.com/safety.asp\'><font color=\'#66CCFF\'><u>Click here</u></font></a> to learn more.";
            rootClass.ui.ToolTip.openWith({
               "str":_loc29_,
               "lowerright":true,
               "invert":true,
               "closein":10000
            });
         }
      }
      
      public function profanityCheck(param1:String) : Object
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:Object = {
            "code":0,
            "term":"",
            "index":-1,
            "indeces":[]
         };
         _loc2_ = " " + removeHTML(cleanStr(param1.toLowerCase())) + " ";
         _loc2_ = rootClass.stripMarks(_loc2_);
         _loc2_ = rootClass.stripDuplicateVowels(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < profanityA.length)
         {
            if(profanityA[_loc3_] == "weebly")
            {
            }
            _loc4_.index = _loc2_.indexOf(" " + profanityA[_loc3_] + " ");
            if(_loc4_.index > -1)
            {
               _loc4_.term = profanityA[_loc3_];
               _loc4_.code = 1;
               return _loc4_;
            }
            _loc3_++;
         }
         _loc2_ = rootClass.stripDuplicateVowels(removeHTML(cleanStr(param1.toLowerCase())));
         _loc2_ = rootClass.stripWhiteStrict(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < profanityB.length)
         {
            _loc4_.index = _loc2_.indexOf(profanityB[_loc3_]);
            if(_loc4_.index > -1)
            {
               _loc4_.term = profanityB[_loc3_];
               _loc4_.code = 2;
               return _loc4_;
            }
            _loc3_++;
         }
         _loc2_ = rootClass.stripDuplicateVowels(removeHTML(cleanStr(param1.toLowerCase())));
         _loc2_ = rootClass.stripWhiteStrictB(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < profanityB.length)
         {
            _loc4_.index = _loc2_.indexOf(profanityB[_loc3_]);
            if(_loc4_.index > -1)
            {
               _loc4_.term = profanityB[_loc3_];
               _loc4_.code = 2;
               return _loc4_;
            }
            _loc3_++;
         }
         var _loc5_:Array = [];
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            if(legalCharsStrict.indexOf(param1.charAt(_loc7_)) > -1)
            {
               if(_loc6_.length == 0 || param1.charAt(_loc7_) != _loc6_.charAt(_loc6_.length - 1))
               {
                  _loc6_ += param1.charAt(_loc7_);
                  _loc5_.push(_loc7_);
               }
            }
            _loc7_++;
         }
         _loc3_ = 0;
         while(_loc3_ < profanityC.length)
         {
            _loc4_.index = _loc6_.indexOf(profanityC[_loc3_]);
            if(_loc4_.index > -1)
            {
               _loc4_.code = 3;
               _loc4_.indeces.push(_loc5_[_loc4_.index]);
               _loc4_.indeces.push(_loc5_[_loc4_.index] + profanityC[_loc3_].length - 1);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function modWhisperCheck(param1:String) : int
      {
         var _loc3_:String = null;
         var _loc2_:String = rootClass.stripWhiteStrict(removeHTML(param1.toLowerCase()));
         for each(_loc3_ in modWhisperCheckList)
         {
            if(_loc2_.indexOf(_loc3_) > -1)
            {
               return 1;
            }
         }
         return 0;
      }
      
      private function removeHTML(param1:String) : String
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc2_:String = param1.toLowerCase();
         var _loc3_:String = "" + param1;
         var _loc4_:Array = ["&nbsp;","<br>"];
         for each(_loc6_ in _loc4_)
         {
            while(_loc2_.indexOf(_loc6_) > -1)
            {
               _loc5_ = int(_loc2_.indexOf(_loc6_));
               _loc2_ = _loc2_.substr(0,_loc5_) + " " + _loc2_.substr(_loc5_ + _loc6_.length,_loc2_.length);
               _loc3_ = _loc3_.substr(0,_loc5_) + " " + _loc3_.substr(_loc5_ + _loc6_.length,_loc3_.length);
            }
         }
         return _loc3_;
      }
      
      public function isUnsendable(param1:String) : Boolean
      {
         var _loc2_:* = 0;
         while(_loc2_ < unsendable.length)
         {
            if(param1.toLowerCase().indexOf(unsendable[_loc2_]) > -1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isIgnored(param1:String) : Boolean
      {
         return ignoreList.data.users.indexOf(param1.toLowerCase()) >= 0;
      }
      
      public function ignore(param1:String) : void
      {
         var mc:* = undefined;
         var strName:String = param1;
         if(ignoreList.data.users.indexOf(strName.toLowerCase()) == -1)
         {
            ignoreList.data.users.push(strName.toLowerCase());
            try
            {
               ignoreList.flush();
            }
            catch(e:Error)
            {
            }
            mc = rootClass.world.getAvatarByUserName(strName.toLowerCase());
            if(mc != null)
            {
               mc.pMC.ignore.visible = true;
            }
            rootClass.sfc.sendXtMessage("zm","cmd",["ignoreList",ignoreList.data.users],"str",1);
         }
         try
         {
            if(rootClass.ui.mcOFrame.fData.typ == "userListIgnore")
            {
               rootClass.ui.mcOFrame.update();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function unignore(param1:String) : void
      {
         var mc:*;
         var strName:String = param1;
         var uind:* = ignoreList.data.users.indexOf(strName.toLowerCase());
         while(uind > -1)
         {
            ignoreList.data.users.splice(uind,1);
            uind = ignoreList.data.users.indexOf(strName.toLowerCase());
         }
         try
         {
            ignoreList.flush();
         }
         catch(e:Error)
         {
         }
         mc = rootClass.world.getAvatarByUserName(strName.toLowerCase());
         if(mc != null)
         {
            mc.pMC.ignore.visible = false;
         }
         rootClass.sfc.sendXtMessage("zm","cmd",["ignoreList",ignoreList.data.users],"str",1);
         try
         {
            if(rootClass.ui.mcOFrame.fData.typ == "userListIgnore")
            {
               rootClass.ui.mcOFrame.update();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function muteMe(param1:int) : void
      {
         var _loc2_:Date = new Date();
         mute.ts = Number(_loc2_.getTime());
         mute.cd = param1;
         mute.timer.delay = param1;
         mute.timer.start();
         pushMsg("warning","You have been muted! Chat privileges are temporarily revoked.","SERVER","",0);
      }
      
      public function unmuteMe(param1:Event = null) : void
      {
         mute.ts = 0;
         mute.cd = 0;
         mute.timer.reset();
         pushMsg("server","You have been unmuted.  Chat privileges are restored.","SERVER","",0);
      }
      
      public function amIMute() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         var _loc1_:Boolean = false;
         if(mute.ts > 0)
         {
            _loc2_ = new Date();
            _loc3_ = Number(_loc2_.getTime());
            if(_loc3_ - mute.ts >= mute.cd)
            {
               mute.ts = 0;
               mute.cd = 0;
            }
            else
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function isChannel(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in chn)
         {
            if(_loc2_.toLowerCase() == param1.toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      private function isMyModHandle(param1:String) : Boolean
      {
         if(param1.split("-")[0] == "Moderator" && Boolean(int(param1.split("-")[1] == rootClass.world.modID)))
         {
            return true;
         }
         return false;
      }
   }
}

