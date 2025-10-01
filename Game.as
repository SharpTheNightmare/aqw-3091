package
{
   import com.adobe.serialization.json.JSON;
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.external.*;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.*;
   import flash.ui.Keyboard;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import it.gotoandplay.smartfoxserver.*;
   import liteAssets.draw.*;
   import liteAssets.handlers.optionHandler;
   
   public class Game extends MovieClip
   {
      
      public static var root:DisplayObject;
      
      public static var serverName:String;
      
      public static var objLogin:Object;
      
      public static var mcUpgradeWindow:MovieClip;
      
      public static var mcACWindow:MovieClip;
      
      public static var strToken:String;
      
      public static var ISWEB:Boolean = true;
      
      public static var serverPort:int = 5588;
      
      public static var serverIP:String = "";
      
      public static var serverGamePath:String = "";
      
      public static var serverFilePath:String = "";
      
      public static var serverURL:String = "";
      
      public static var cLoginZone:String = "zone_master";
      
      public static var clientToken:String = "SPIDER#0001";
      
      public static var bPTR:Boolean = false;
      
      public static var loginInfo:Object = new Object();
      
      public static const ASSETS_LOADED:String = "main_assets_loaded";
      
      public static var ASSETS_READY:String = "";
      
      public static const FB_APP_NAME:String = "AQW";
      
      public static const FB_APP_URL:String = "www.aq.com";
      
      public static const FB_APP_ID:String = "51356733862";
      
      public static const FB_APP_SEC:String = "This should never be stored in the client";
      
      MovieClip.prototype.removeAllChildren = function():void
      {
         var _loc1_:* = this.numChildren - 1;
         while(_loc1_ >= 0)
         {
            this.removeChildAt(_loc1_);
            _loc1_--;
         }
      };
      
      public var MsgBox:MovieClip;
      
      public var mcAccount:MovieClip;
      
      public var ctr_watermark:MovieClip;
      
      public var mcExtSWF:MovieClip;
      
      public var ui:MovieClip;
      
      public var mcLogin:MovieClip;
      
      public var loader:*;
      
      public var csLoader:Loader;
      
      public var csbLoaded:Number;
      
      public var csbTotal:Number;
      
      public var clientVersion:Number = 3.012;
      
      public var cVersion:String;
      
      public var sToken:String;
      
      public var failedServers:*;
      
      public var world:World;
      
      public var bagSpace:String = "interface/spiderbagr2.swf";
      
      public var iMaxBagSlots:* = 400;
      
      public var iMaxBankSlots:* = 450;
      
      public var iMaxHouseSlots:* = 250;
      
      public var iMaxFriends:* = 225;
      
      public var iMaxLoadoutSlots:* = 20;
      
      private var swfObj:String = "AQWGame";
      
      public var showFB:Boolean = false;
      
      public var fbL:fbLinkWindow;
      
      public var titleDomain:ApplicationDomain;
      
      public var mcO:MovieClip;
      
      private var rn:RandomNumber;
      
      public var elmType:String;
      
      public var assetsDomain:ApplicationDomain;
      
      public var assetsContext:LoaderContext;
      
      public var handleSessionEvent:Function;
      
      public const EMAIL_REGEX:RegExp;
      
      public var mixer:SoundFX;
      
      public var sfc:SmartFoxClient;
      
      public var chatF:*;
      
      public var sFilePath:String = "";
      
      public var params:Object;
      
      public var userPreference:SharedObject;
      
      public var litePreference:SharedObject;
      
      public var uoPref:Object;
      
      public var litePref:Array;
      
      public var loginLoader:URLLoader;
      
      public var objServerInfo:Object;
      
      public var sfcSocial:Boolean = false;
      
      public var ldrMC:LoaderMC;
      
      public var mcConnDetail:ConnDetailMC;
      
      public var querystring:Object;
      
      public var ts_login_server:Number;
      
      public var ts_login_client:Number;
      
      public var aaaloop:int = 0;
      
      public var totalPingTime:Number = 0;
      
      public var pingCount:int = 0;
      
      public var arrRanks:Array;
      
      public var iRankMax:int = 10;
      
      public var arrHP:Array;
      
      private var aswc:Apop;
      
      public var hasPreviewed:Boolean;
      
      public var intLevelCap:int;
      
      public var PCstBase:int;
      
      public var PCstRatio:Number;
      
      public var PCstGoal:int;
      
      public var GstBase:int;
      
      public var GstRatio:Number;
      
      public var GstGoal:int;
      
      public var PChpBase1:int;
      
      public var PChpBase100:int;
      
      public var PChpGoal1:int;
      
      public var PChpGoal100:int;
      
      public var PChpDelta:int;
      
      public var intHPperEND:int;
      
      public var intAPtoDPS:int;
      
      public var intSPtoDPS:int;
      
      public var bigNumberBase:int;
      
      public var resistRating:Number;
      
      public var modRating:Number;
      
      public var baseDodge:Number;
      
      public var baseBlock:Number;
      
      public var baseParry:Number;
      
      public var baseCrit:Number;
      
      public var baseHit:Number;
      
      public var baseHaste:Number;
      
      public var baseMiss:Number;
      
      public var baseResist:Number;
      
      public var baseCritValue:Number;
      
      public var baseBlockValue:Number;
      
      public var baseResistValue:Number;
      
      public var baseEventValue:Number;
      
      public var PCDPSMod:Number = 0.85;
      
      public var curveExponent:Number = 0.66;
      
      public var statsExponent:Number = 1.33;
      
      public var stats:Array;
      
      public var orderedStats:Array;
      
      public var ratiosBySlot:Object;
      
      public var I0pct:Number = 0.8;
      
      public var I2pct:Number = 1.25;
      
      public var classCatMap:Object;
      
      private var coreValues:Object;
      
      private var travelMapData:Object;
      
      private var WorldMapData:worldMap;
      
      private var skipR2:Boolean = false;
      
      private var apop_:apopCore;
      
      public var apopTree:Object;
      
      public var curID:String;
      
      public var serialCmdMode:Boolean = false;
      
      public var serialCmd:Object;
      
      private var conn:*;
      
      public var confirmTime:int = 0;
      
      public var quests:Boolean = false;
      
      public var bits:Array;
      
      private var fbc:MovieClip;
      
      public var mcGameMenu:MovieClip;
      
      public var firstMenu:Boolean = true;
      
      public var bPassword:Boolean = true;
      
      public var pDash:Boolean;
      
      internal var cancelTargetTimer:Timer;
      
      public var keyDict:Dictionary;
      
      private var travelLoaderMC:*;
      
      public var TRAVEL_DATA_READY:Boolean = false;
      
      private var bLoaded:Number = 0;
      
      private var bTotal:Number = 0;
      
      private var weakPass:Array;
      
      public var extCall:ExternalCalls;
      
      public var FBConnectCallback:Function;
      
      public var sBG:String = "generic2.swf";
      
      public var IsEU:Boolean = false;
      
      public var TempLoginName:* = "";
      
      public var TempLoginPass:* = "";
      
      public var mtcidNow:Number;
      
      public var intChatMode:int;
      
      public var serverPath:String;
      
      public var playerPollData:Object;
      
      private var characters:SharedObject;
      
      public var csShowServers:Boolean = false;
      
      public var mcCharSelect:*;
      
      internal var interfaceQueue:Array;
      
      internal var visualLoader:*;
      
      public var interfaceRef:Object;
      
      internal var interfaceLoaded:Number = 0;
      
      internal var interfaceTotal:Number = 0;
      
      public var newInstance:Boolean = false;
      
      public var BOOK_DATA_READY:* = null;
      
      public var bolLoader:Loader;
      
      public var bolContent:MovieClip;
      
      public var equipPotionOnSeia:Boolean;
      
      public var lastPing:Number = 0;
      
      public var lastPingTime:uint = 0;
      
      public var lastPingValues:Array;
      
      public var bankFiltersMC:bankFilters;
      
      public var pLoggerUI:packetlogger;
      
      public var cMenuUI:cellMenu;
      
      public var cDropsUI:customDrops;
      
      public var pAurasUI:playerAuras;
      
      public var tAurasUI:targetAuras;
      
      public var bAnalyzer:battleAnalyzer;
      
      public var cameraToolMC:cameraTool;
      
      internal var petDisable:Timer;
      
      public var portraitsCnt:Array;
      
      public var pinnedQuests:String;
      
      internal var disableTimer:Timer;
      
      public var regExLineSpace:RegExp;
      
      public var showServers:Boolean = false;
      
      public var baseClassStats:Object;
      
      private var statsNewClass:Boolean = false;
      
      private var mcStatsPanel:MovieClip;
      
      public function Game()
      {
         var onConnectionHandler:Function;
         var isWarned:Function;
         var onConnectionLostHandler:Function;
         var onLoginHandler:Function;
         var onLogoutHandler:Function;
         var onMultiConnectionHandler:Function;
         var onMultiConnectionLostHandler:Function;
         var onMultiLogoutHandler:Function;
         var onMultiLoginHandler:Function;
         var onJoinRoomHandler:Function;
         var onUserEnterRoomHandler:Function;
         var onUserLeaveRoomHandler:Function;
         var onUserVariablesUpdateHandler:Function;
         var onRoomListUpdateHandler:Function;
         var onRoomVariablesUpdateHandler:Function;
         var onRoomAddedHandler:Function;
         var onPublicMessageHandler:Function;
         var onPrivateMessageHandler:Function;
         var onModeratorMessage:Function;
         var onObjectReceivedHandler:Function;
         var onRoundTripResponseHandler:Function;
         var isNewClass:Boolean = false;
         var onExtensionResponseHandler:Function = null;
         cVersion = String(clientVersion);
         failedServers = {};
         rn = new RandomNumber();
         assetsDomain = new ApplicationDomain();
         assetsContext = new LoaderContext(false,assetsDomain);
         EMAIL_REGEX = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
         mixer = new SoundFX(assetsDomain);
         params = {};
         uoPref = {};
         litePref = [];
         loginLoader = new URLLoader();
         ldrMC = new LoaderMC(MovieClip(this));
         querystring = {};
         arrRanks = [0];
         arrHP = [];
         stats = ["STR","END","DEX","INT","WIS","LCK"];
         orderedStats = ["STR","INT","DEX","WIS","END","LCK"];
         ratiosBySlot = {
            "he":0.25,
            "ar":0.25,
            "ba":0.2,
            "Weapon":0.33
         };
         classCatMap = {
            "M1":{},
            "M2":{},
            "M3":{},
            "M4":{},
            "C1":{},
            "C2":{},
            "C3":{},
            "S1":{}
         };
         coreValues = {
            "PCstRatio":7.47,
            "PChpDelta":1640,
            "PChpBase1":360,
            "baseHit":0,
            "intSPtoDPS":10,
            "resistRating":17,
            "curveExponent":0.66,
            "baseCritValue":1.5,
            "PChpGoal100":4000,
            "intLevelCap":100,
            "baseMiss":0.1,
            "baseParry":0.03,
            "GstBase":12,
            "modRating":3,
            "baseResistValue":0.7,
            "baseBlockValue":0.7,
            "intHPperEND":5,
            "baseHaste":0,
            "baseBlock":0,
            "statsExponent":1,
            "PChpBase100":2000,
            "intAPtoDPS":10,
            "PCstBase":15,
            "baseCrit":0.05,
            "baseEventValue":0.05,
            "GstGoal":572,
            "PChpGoal1":400,
            "GstRatio":5.6,
            "intLevelMax":100,
            "bigNumberBase":8,
            "PCstGoal":762,
            "baseDodge":0.04,
            "PCDPSMod":0.85
         };
         apopTree = new Object();
         serialCmd = {
            "cmd":"",
            "si":0,
            "servers":[],
            "callBack":serialCmdDone,
            "active":false
         };
         bits = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576,2097152,4194304,8388608,16777216,33554432,67108864,134217728,268435456,536870912,1073741824,2147483648];
         cancelTargetTimer = new Timer(5000,1);
         weakPass = new Array("0","1111","11111","111111","11111111","112233","1212","121212","123123","1234","12345","123456","1234567","12345678","1313","131313","2000","2112","2222","232323","3333","4128","4321","4444","5150","5555","654321","6666","666666","6969","696969","7777","777777","7777777","8675309","987654","aaaa","aaaaaa","abc123","abgrtyu","access","access14","action","albert","alex","alexis","amanda","amateur","andrea","andrew","angel","angela","angels","animal","anthony","apollo","apple","apples","arsenal","arthur","asdf","asdfgh","ashley","asshole","august","austin","baby","badboy","bailey","banana","barney","baseball","batman","beach","bear","beaver","beavis","beer","bigcock","bigdaddy","bigdick","bigdog","bigtits","bill","billy","birdie","bitch","bitches","biteme","black","blazer","blonde","blondes","blowjob","blowme","blue","bond007","bonnie","booboo","boobs","booger","boomer","booty","boston","brandon","brandy","braves","brazil","brian","bronco","broncos","bubba","buddy","bulldog"
         ,"buster","butter","butthead","calvin","camaro","cameron","canada","captain","carlos","carter","casper","charles","charlie","cheese","chelsea","chester","chevy","chicago","chicken","chris","cocacola","cock","coffee","college","compaq","computer","cookie","cool","cooper","corvette","cowboy","cowboys","cream","crystal","cumming","cumshot","cunt","dakota","dallas","daniel","danielle","dave","david","debbie","dennis","diablo","diamond","dick","dirty","doctor","doggie","dolphin","dolphins","donald","dragon","dreams","driver","eagle","eagle1","eagles","edward","einstein","enjoy","enter","eric","erotic","extreme","falcon","fender","ferrari","fire","firebird","fish","fishing","florida","flower","flyers","football","ford","forever","frank","fred","freddy","freedom","fuck","fucked","fucker","fucking","fuckme","fuckyou","gandalf","gateway","gators","gemini","george","giants","ginger","girl","girls","golden","golf","golfer","gordon","great","green","gregory","guitar","gunner","hammer","hannah","happy"
         ,"hardcore","harley","heather","hello","helpme","hentai","hockey","hooters","horney","horny","hotdog","house","hunter","hunting","iceman","iloveyou","internet","iwantu","jack","jackie","jackson","jaguar","jake","james","japan","jasmine","jason","jasper","jennifer","jeremy","jessica","john","johnny","johnson","jordan","joseph","joshua","juice","junior","justin","kelly","kevin","killer","king","kitty","knight","ladies","lakers","lauren","leather","legend","letmein","little","london","love","lover","lovers","lucky","maddog","madison","maggie","magic","magnum","marine","mark","marlboro","martin","marvin","master","matrix","matt","matthew","maverick","maxwell","melissa","member","mercedes","merlin","michael","michelle","mickey","midnight","mike","miller","mine","mistress","money","monica","monkey","monster","morgan","mother","mountain","movie","muffin","murphy","music","mustang","naked","nascar","nathan","naughty","ncc1701","newyork","nicholas","nicole","nipple","nipples","oliver","orange","ou812"
         ,"packers","panther","panties","paris","parker","pass","password","patrick","paul","peaches","peanut","penis","pepper","peter","phantom","phoenix","player","please","pookie","porn","porno","porsche","power","prince","princess","private","purple","pussies","pussy","qazwsx","qwert","qwerty","qwertyui","rabbit","rachel","pokemon","racing","raiders","rainbow","ranger","rangers","rebecca","redskins","redsox","redwings","richard","robert","rock","rocket","rosebud","runner","rush2112","russia","samantha","sammy","samson","sandra","saturn","scooby","scooter","scorpio","scorpion","scott","secret","sexsex","sexy","shadow","shannon","shaved","shit","sierra","silver","skippy","slayer","slut","smith","smokey","snoopy","soccer","sophie","spanky","sparky","spider","squirt","srinivas","star","stars","startrek","starwars","steelers","steve","steven","sticky","stupid","success","suckit","summer","sunshine","super","superman","surfer","swimming","sydney","taylor","teens","tennis","teresa","test","tester","testing"
         ,"theman","thomas","thunder","thx1138","tiffany","tiger","tigers","tigger","time","tits","tomcat","topgun","toyota","travis","trouble","trustno1","tucker","turtle","united","vagina","victor","victoria","video","viking","viper","voodoo","voyager","walter","warrior","welcome","whatever","white","william","willie","wilson","winner","winston","winter","wizard","wolf","women","xavier","xxxx","xxxxx","xxxxxx","xxxxxxxx","yamaha","yankee","yankees","yellow","young","zxcvbn","zxcvbnm","zzzzzz","artix","aqworlds","adventure","mechquest","dragonfable","123456789","1234567890","987654321","0123456789","12345678910","qwertyuiop","123123123","asdfghjkl","123321","0987654321","147258369","789456123","159753","741852963","minecraft","147852369","0123456","qwerty123","123654789","naruto","9876543210","12341234","123qwe","159357","123654","gabriel","123456789a");
         characters = SharedObject.getLocal("AQWChars","/",true);
         interfaceQueue = new Array();
         interfaceRef = new Object();
         lastPingValues = [];
         petDisable = new Timer(0);
         portraitsCnt = [];
         disableTimer = new Timer(50,1);
         regExLineSpace = /(\r\n)/gi;
         super();
         onConnectionHandler = function(param1:SFSEvent):*
         {
            if(param1.params.success)
            {
               sfc.login(cLoginZone,clientToken + "~" + loginInfo.strUsername + "~" + clientVersion,loginInfo.strToken);
               if(world != null)
               {
                  world.uiLock = true;
               }
            }
            else if(serialCmdMode)
            {
               serialCmdNext();
            }
         };
         isWarned = function():Boolean
         {
            var curTS:Number = NaN;
            var iDiff:Number = NaN;
            if("logoutWarningTS" in userPreference.data)
            {
               curTS = Number(new Date().getTime());
               iDiff = userPreference.data.logoutWarningTS + userPreference.data.logoutWarningDur * 1000 - curTS;
               if(iDiff > 60000)
               {
                  userPreference.data.logoutWarningDur = 60;
                  userPreference.data.logoutWarningTS = curTS;
                  try
                  {
                     userPreference.flush();
                  }
                  catch(e:Error)
                  {
                  }
               }
               if(iDiff > 1000)
               {
                  return true;
               }
            }
            return false;
         };
         onConnectionLostHandler = function(param1:SFSEvent):*
         {
            var _loc2_:Boolean = false;
            if(!serialCmdMode)
            {
               if(world != null)
               {
                  cleanupInterfaces();
                  world.exitCombat();
                  world.setTarget(null);
                  world.killTimers();
                  world.killListeners();
                  world.clearLoaders(true);
                  try
                  {
                     world.removeChild(world.map);
                  }
                  catch(e:*)
                  {
                  }
                  removeChild(world);
                  world = null;
                  SoundMixer.stopAll();
                  firstMenu = true;
                  if(mcCharSelect)
                  {
                     if(mcCharSelect.parent != null)
                     {
                        MovieClip(mcCharSelect.parent).removeChild(mcCharSelect);
                     }
                     mcCharSelect = null;
                  }
               }
               if(sfc.isConnected)
               {
                  sfc.disconnect();
               }
               if(param1.params != null)
               {
                  if(param1.params.disconnect == true)
                  {
                     mcConnDetail.showDisconnect("Communication with server has been lost. Please check your internet connection and try again.");
                     _loc2_ = true;
                  }
               }
               if(!_loc2_)
               {
                  if(showServers)
                  {
                     gotoAndPlay("Login");
                  }
                  else
                  {
                     gotoAndPlay(charCount() > 0 && litePreference.data.bCharSelect && !isWarned() ? "Select" : "Login");
                  }
               }
            }
            newInstance = true;
         };
         onLoginHandler = function(param1:SFSEvent):*
         {
         };
         onLogoutHandler = function(param1:SFSEvent):*
         {
            if(!serialCmdMode)
            {
               if(world != null)
               {
                  cleanupInterfaces();
                  world.exitCombat();
                  world.setTarget(null);
                  world.killTimers();
                  world.killListeners();
                  world.clearLoaders(true);
                  try
                  {
                     world.removeChild(world.map);
                  }
                  catch(e:*)
                  {
                  }
                  removeChild(world);
                  world = null;
                  SoundMixer.stopAll();
                  firstMenu = true;
                  if(mcCharSelect)
                  {
                     if(mcCharSelect.parent != null)
                     {
                        MovieClip(mcCharSelect.parent).removeChild(mcCharSelect);
                     }
                     mcCharSelect = null;
                  }
               }
               if(sfc.isConnected)
               {
                  sfc.disconnect();
               }
               if(FacebookConnect.isLoggedIn)
               {
                  FacebookConnect.Logout();
               }
               if(showServers)
               {
                  gotoAndPlay("Login");
               }
               else
               {
                  gotoAndPlay(charCount() > 0 && litePreference.data.bCharSelect && !isWarned() ? "Select" : "Login");
               }
            }
            else
            {
               if(sfc.isConnected)
               {
                  sfc.disconnect();
               }
               serialCmdNext();
            }
            newInstance = true;
         };
         onMultiConnectionHandler = function(param1:SFSEvent):*
         {
            if(param1.params.success)
            {
               this.sfc.login(cLoginZone,clientToken + "~" + this.sLogin,loginInfo.strToken);
            }
         };
         onMultiConnectionLostHandler = function(param1:SFSEvent):*
         {
         };
         onMultiLogoutHandler = function(param1:SFSEvent):*
         {
         };
         onMultiLoginHandler = function(param1:SFSEvent):*
         {
         };
         onJoinRoomHandler = function(param1:SFSEvent):*
         {
         };
         onUserEnterRoomHandler = function(param1:SFSEvent):*
         {
         };
         onUserLeaveRoomHandler = function(param1:SFSEvent):*
         {
         };
         onUserVariablesUpdateHandler = function(param1:SFSEvent):*
         {
         };
         onRoomListUpdateHandler = function(param1:SFSEvent):*
         {
         };
         onRoomVariablesUpdateHandler = function(param1:SFSEvent):*
         {
         };
         onRoomAddedHandler = function(param1:SFSEvent):*
         {
         };
         onPublicMessageHandler = function(param1:SFSEvent):*
         {
         };
         onPrivateMessageHandler = function(param1:SFSEvent):*
         {
         };
         onModeratorMessage = function(param1:SFSEvent):*
         {
            var _loc2_:* = param1.params.message;
            var _loc3_:* = param1.params.sender;
         };
         onObjectReceivedHandler = function(param1:SFSEvent):*
         {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:MovieClip = null;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if(sfcSocial)
            {
               _loc2_ = param1.params.sender;
               _loc3_ = param1.params.obj;
               switch(_loc3_.typ)
               {
                  case "flourish":
                     if(world.CHARS.getChildByName(_loc3_.oName) != null)
                     {
                        MovieClip(world.CHARS.getChildByName(_loc3_.oName)).userName = _loc2_.getName();
                        MovieClip(world.CHARS.getChildByName(_loc3_.oName)).gotoAndPlay(_loc3_.oFrame);
                     }
                     break;
                  case "danceRequest":
                     if(_loc3_.cell == world.strFrame)
                     {
                        _loc5_ = new ModalMC();
                        _loc6_ = {};
                        _loc6_.strBody = "Would you care to dance?";
                        _loc6_.params = {};
                        _loc6_.params.emote1 = "/dance";
                        _loc6_.params.sender = _loc2_;
                        _loc6_.callback = world.danceRequest;
                        ui.ModalStack.addChild(_loc5_);
                        _loc5_.init(_loc6_);
                     }
                     break;
                  case "danceDenied":
                     if(_loc3_.cell == world.strFrame)
                     {
                        chatF.submitMsg("/cry","emotea",sfc.myUserName);
                     }
               }
            }
         };
         onRoundTripResponseHandler = function(param1:SFSEvent):void
         {
            var _loc2_:int = int(param1.params.elapsed);
            if(mcO)
            {
               mcO.averageLatency(_loc2_ / 2);
            }
         };
         onExtensionResponseHandler = function(param1:SFSEvent):*
         {
            var resObj:* = undefined;
            var protocol:* = undefined;
            var i:int = 0;
            var s:String = null;
            var j:int = 0;
            var o:Object = null;
            var a:Array = null;
            var b:Array = null;
            var mc:MovieClip = null;
            var tuo:* = undefined;
            var typ:String = null;
            var nam:String = null;
            var val:* = undefined;
            var msg:String = null;
            var msgT:String = null;
            var snd:String = null;
            var rcp:String = null;
            var org:* = undefined;
            var cmd:String = null;
            var anims:Array = null;
            var animIndex:uint = 0;
            var monAvt:Avatar = null;
            var avtAvt:Avatar = null;
            var Mon:Avatar = null;
            var avt:Avatar = null;
            var pMC:MovieClip = null;
            var unm:String = null;
            var uid:int = 0;
            var rmId:int = 0;
            var MonMapID:int = 0;
            var MonID:int = 0;
            var prop:String = null;
            var uoName:* = undefined;
            var uoLeaf:Object = null;
            var monLeaf:Object = null;
            var cLeaf:Object = null;
            var tLeaf:Object = null;
            var actObj:Object = null;
            var cell:String = null;
            var st:int = 0;
            var sta:String = null;
            var evt:String = null;
            var modal:MovieClip = null;
            var modalO:Object = null;
            var modalRR:* = undefined;
            var modalORR:Object = null;
            var silentMute:int = 0;
            var filter:int = 0;
            var updateID:String = null;
            var updateA:Array = null;
            var updateN:String = null;
            var updateO:Object = null;
            var iSel:Object = null;
            var eSel:Object = null;
            var now:Number = NaN;
            var res:* = undefined;
            var newmon:Object = null;
            var cluster:* = undefined;
            var strMsg:* = undefined;
            var strLabel:* = undefined;
            var str:* = undefined;
            var slots:int = 0;
            var dest:* = undefined;
            var dt:* = undefined;
            var motd:* = undefined;
            var vars:Array = null;
            var MonMapIDs:* = undefined;
            var id:* = undefined;
            var strMonName:String = null;
            var rand:int = 0;
            var clMon:* = undefined;
            var tAvt:Avatar = null;
            var cAvt:Avatar = null;
            var strF:String = null;
            var intf:* = undefined;
            var mcQFrame:* = undefined;
            var ulo:* = undefined;
            var myLeaf:* = undefined;
            var adShown:Boolean = false;
            var testDate:Date = null;
            var dropItem:* = undefined;
            var anim:Object = null;
            var updateCtr:int = 0;
            var ai:int = 0;
            var slot:int = 0;
            var supressMupltiples:* = undefined;
            var isYou:* = undefined;
            var sMsg:* = undefined;
            var arrWearableSpots:* = undefined;
            var spot:String = null;
            var costumeItem:* = undefined;
            var bi:int = 0;
            var branchA:Object = null;
            var mID:String = null;
            var psES:* = undefined;
            var deltaXP:int = 0;
            var xp:* = undefined;
            var xpB:* = undefined;
            var deltaGold:int = 0;
            var gold:* = undefined;
            var deltaCP:int = 0;
            var iRank:* = undefined;
            var txtBonusCP:String = null;
            var flo:* = undefined;
            var friend:* = undefined;
            var fct:Function = null;
            var item:* = undefined;
            var sMeta:String = null;
            var dID:* = undefined;
            var dItem:* = undefined;
            var iData:* = undefined;
            var isOK:Boolean = false;
            var bItem:* = undefined;
            var dropitem:* = undefined;
            var ItemID:* = undefined;
            var itemObj:* = undefined;
            var fi:* = undefined;
            var iobj:* = undefined;
            var itemArr:* = undefined;
            var dropindex:* = undefined;
            var dropID:* = undefined;
            var dropQty:int = 0;
            var qi:String = null;
            var qr:String = null;
            var qj:String = null;
            var qk:String = null;
            var qat:Array = null;
            var ri:* = undefined;
            var fgWin:* = undefined;
            var m:* = undefined;
            var k:* = undefined;
            var bpObj:* = undefined;
            var oldActions:* = undefined;
            var blanki:* = undefined;
            var actBar:* = undefined;
            var delIcon:* = undefined;
            var pseudoAI:int = 0;
            var actIconClass:Class = null;
            var actIcon:* = undefined;
            var actIconMC:* = undefined;
            var blankMC:* = undefined;
            var isNotUnlocked:Boolean = false;
            var existing:* = undefined;
            var c:Color = null;
            var stuS:String = null;
            var hasteCoeff:Number = NaN;
            var cd:* = undefined;
            var stu:String = null;
            var mcPath:* = undefined;
            var e:SFSEvent = param1;
            resObj = e.params.dataObj;
            protocol = e.params.type;
            i = 0;
            s = "";
            j = 0;
            prop = "";
            var updated:Object = {};
            silentMute = 0;
            filter = 0;
            var cInf:String = "";
            var tInf:String = "";
            var cTyp:String = "";
            var cID:int = -1;
            var tTyp:String = "";
            var tID:int = -1;
            var ul:Array = [];
            var dat:Date = new Date();
            now = Number(dat.getTime());
            if(protocol == "str")
            {
               cmd = resObj[0];
               switch(cmd)
               {
                  case "dungeonCompleted":
                     if("eventTrigger" in MovieClip(world.map))
                     {
                        world.map.eventTrigger({"cmd":"DungeonComplete"});
                     }
                     break;
                  case "dungeonMTC":
                     res = resObj[2] == "true";
                     if(res)
                     {
                        dest = String(resObj[3]).split(",");
                        world.moveToCell(dest[0],dest[1],true);
                     }
                     break;
                  case "hi":
                     if(mcO)
                     {
                        mcO.latency -= new Date().getTime();
                        mcO.latency = Math.ceil(Math.abs(mcO.latency) / 2);
                        mcO.updateLatency();
                     }
                     break;
                  case "loginResponse":
                     showTracking("5");
                     if(resObj[2] == 1 || resObj[2] == "true" || resObj[2] == "True")
                     {
                        ctr_watermark.visible = objServerInfo.sName == "Class Test Realm";
                        mcConnDetail.showConn("Loading Character Data...");
                        sfc.myUserId = Number(resObj[3]);
                        sfc.myUserName = String(resObj[4]);
                        ts_login_client = now;
                        dt = stringToDate(resObj[6]);
                        ts_login_server = dt.getTime();
                        motd = "Message of The Day: Staff will never ask for your password! If someone asks for your password, report them for Griefing. NEVER share your password!";
                        chatF.pushMsg("moderator",motd,"SERVER","",0);
                        chatF.pushMsg("server","The server time is now " + dt.toString(),"SERVER","",0);
                        vars = resObj[7].split(",");
                        retrieveInfo(vars);
                        confirmTime = getTimer();
                     }
                     else
                     {
                        mcConnDetail.showError(resObj[5]);
                     }
                     break;
                  case "loginIterator":
                     if(resObj[2] == 1 || resObj[2] == "true")
                     {
                        sfc.myUserId = Number(resObj[3]);
                        sfc.myUserName = String(resObj[4]);
                        chatF.submitMsg(serialCmd.cmd,"serialCmd",serialCmdMode ? "iterator" : sfc.myUserName);
                     }
                     else
                     {
                        mcConnDetail.showError("Login Failed!");
                     }
                     break;
                  case "iterator":
                     sfc.logout();
                     break;
                  case "loginMulti":
                     if(!(resObj[2] == 1 || resObj[2] == "true"))
                     {
                        mcConnDetail.showError("Login Failed!");
                     }
                     break;
                  case "notify":
                     typ = "server";
                     msg = resObj[2];
                     msg = chatF.cleanChars(msg);
                     msg = chatF.cleanStr(msg);
                     chatF.pushMsg(typ,msg,"SERVER","",0);
                     MsgBox.notify(msg);
                     break;
                  case "logoutWarning":
                     userPreference.data.logoutWarning = String(resObj[2]);
                     userPreference.data.logoutWarningDur = Number(resObj[3]);
                     userPreference.data.logoutWarningTS = now;
                     try
                     {
                        userPreference.flush();
                     }
                     catch(e:Error)
                     {
                     }
                     break;
                  case "multiLoginWarning":
                     mcConnDetail.showError("Your AQWorlds game account has been logged on from another window session or computer, or you made changes in Manage Account.");
                     break;
                  case "server":
                     if(serialCmdMode)
                     {
                        msg = resObj[2];
                        mcLogin.il.cmd.msgBox.text += "[" + serialCmd.servers[serialCmd.si - 1].sName + "]: " + msg + "\n";
                        mcLogin.il.cmd.msgBox.scrollV = mcLogin.il.cmd.msgBox.maxScrollV;
                        break;
                     }
                     typ = "server";
                     msg = resObj[2];
                     msg = chatF.cleanChars(msg);
                     msg = chatF.cleanStr(msg);
                     chatF.pushMsg(typ,msg,"SERVER","",0);
                     break;
                  case "serverf":
                     msg = String(resObj[2]);
                     typ = "server";
                     str = chatF.cleanStr(msg);
                     unm = String(resObj[3]);
                     uid = int(resObj[4]);
                     rmId = int(resObj[5]);
                     msg = chatF.cleanChars(msg);
                     msgT = stripWhite(msg.toLowerCase());
                     if(chatF.strContains(msgT,chatF.illegalStrings))
                     {
                        silentMute = 1;
                     }
                     msgT = stripWhiteStrict(msg.toLowerCase());
                     if(chatF.strContains(msgT,["email","password"]))
                     {
                        silentMute = 1;
                     }
                     if(!silentMute)
                     {
                        chatF.pushMsg(typ,msg,"SERVER","",0);
                     }
                     break;
                  case "popup":
                     switch(resObj[2])
                     {
                        case "moderator":
                        case "warning":
                        case "server":
                           typ = resObj[2];
                           msg = resObj[3];
                           msg = chatF.cleanChars(msg);
                           msg = chatF.cleanStr(msg);
                           chatF.pushMsg(typ,msg,"SERVER","",0);
                           break;
                        case "blackbanner":
                           MsgBox.notify(resObj[3]);
                           break;
                        case "update":
                           addUpdate(resObj[3]);
                           break;
                        case "messagebox":
                           showMessageBox(resObj[3]);
                     }
                     break;
                  case "moderator":
                     typ = "moderator";
                     msg = resObj[2];
                     msg = chatF.cleanChars(msg);
                     msg = chatF.cleanStr(msg);
                     chatF.pushMsg(typ,msg,"SERVER","",0);
                     break;
                  case "wheel":
                     if(sfcSocial)
                     {
                        typ = "wheel";
                        msg = resObj[2];
                        msg = chatF.cleanChars(msg);
                        msg = chatF.cleanStr(msg);
                        chatF.pushMsg(typ,msg,"SERVER","",0);
                     }
                     break;
                  case "gsupdate":
                     try
                     {
                        world.map.killCount(resObj[2]);
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "frostupdate":
                     try
                     {
                        world.map.frostWar(resObj[2],resObj[3]);
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "warning":
                     typ = "warning";
                     msg = resObj[2];
                     msg = chatF.cleanChars(msg);
                     msg = chatF.cleanStr(msg);
                     chatF.pushMsg(typ,msg,"SERVER","",0);
                     break;
                  case "respawnMon":
                     if(world.strMapName == "caroling" && world.CarolingMonsterKillCount >= 5)
                     {
                        break;
                     }
                     if(sfcSocial)
                     {
                        MonMapIDs = resObj[2].split(",");
                        for(id in MonMapIDs)
                        {
                           Mon = world.getMonster(MonMapIDs[id]);
                           monLeaf = world.monTree[MonMapIDs[id]];
                           if(monLeaf != null && Mon.objData != null && Mon.objData.strFrame == world.strFrame)
                           {
                              monLeaf.targets = {};
                              strMonName = "";
                              if(Number(world.objExtra["bMonName"]) == 1)
                              {
                                 rand = Math.round(Math.random() * (world.chaosNames.length - 1));
                                 if(world.chaosNames[rand] == world.myAvatar.objData.strUsername)
                                 {
                                    rand = rand == 0 ? ++rand : --rand;
                                 }
                                 strMonName = world.chaosNames[rand];
                              }
                              Mon.pMC.respawn(strMonName);
                              Mon.pMC.x = Mon.pMC.ox;
                              Mon.pMC.y = Mon.pMC.oy;
                              if(Mon.objData.bRed == 1 && world.myAvatar.dataLeaf.intState > 0)
                              {
                                 world.aggroMon(MonMapIDs[id]);
                              }
                           }
                        }
                     }
                     break;
                  case "resTimed":
                     if(resObj.length > 2 && String(resObj[2]) != null && String(resObj[3]) != null)
                     {
                        world.moveToCell(String(resObj[2]),String(resObj[3]));
                     }
                     else
                     {
                        world.moveToCell(world.spawnPoint.strFrame,world.spawnPoint.strPad);
                     }
                     world.map.transform.colorTransform = world.defaultCT;
                     world.CHARS.transform.colorTransform = world.defaultCT;
                     break;
                  case "exitArea":
                     uid = int(resObj[2]);
                     unm = String(resObj[3]);
                     world.manageAreaUser(String(resObj[3]),"-");
                     avt = world.avatars[uid];
                     if(avt != null)
                     {
                        if(avt == world.myAvatar.target)
                        {
                           world.setTarget(null);
                        }
                        if(avt.objData != null && world.isPartyMember(avt.objData.strUsername))
                        {
                           world.updatePartyFrame({
                              "unm":avt.objData.strUsername,
                              "range":false
                           });
                        }
                        world.destroyAvatar(uid);
                        delete world.uoTree[unm];
                        if(ui.mcInterface.areaList.currentLabel == "hold")
                        {
                           areaListGet();
                        }
                     }
                     break;
                  case "uotls":
                     o = {};
                     a = resObj[3].split(",");
                     i = 0;
                     while(i < a.length)
                     {
                        o[a[i].split(":")[0]] = a[i].split(":")[1];
                        i++;
                     }
                     userTreeWrite(String(resObj[2]),o);
                     if(ui.mcInterface.areaList.currentLabel == "hold")
                     {
                        areaListGet();
                     }
                     break;
                  case "mtls":
                     o = {};
                     a = resObj[3].split(",");
                     i = 0;
                     while(i < a.length)
                     {
                        o[a[i].split(":")[0]] = a[i].split(":")[1];
                        i++;
                     }
                     monsterTreeWrite(int(resObj[2]),o);
                     break;
                  case "spcs":
                     MonMapID = int(resObj[2]);
                     MonID = int(resObj[3]);
                     monLeaf = world.monTree[MonMapID];
                     newmon = {};
                     i = 0;
                     while(i < world.mondef.length)
                     {
                        if(world.mondef[i].MonID == MonID)
                        {
                           newmon = world.mondef[i];
                           i = int(world.mondef.length);
                        }
                        i++;
                     }
                     monLeaf.intHP = 0;
                     monLeaf.intMP = 0;
                     monLeaf.intHPMax = newmon.intHPMax;
                     monLeaf.intMPMax = newmon.intMPMax;
                     monLeaf.intState = 0;
                     monLeaf.iLvl = newmon.iLvl;
                     monLeaf.MonID = MonID;
                     cluster = world.getMonsterCluster(MonMapID);
                     i = 0;
                     while(i < cluster.length)
                     {
                        clMon = cluster[i];
                        if(monLeaf.MonID == clMon.objData.MonID)
                        {
                           if(monLeaf.strFrame == world.strFrame)
                           {
                              world.CHARS.addChild(clMon.pMC);
                           }
                           clMon.dataLeaf = monLeaf;
                        }
                        else
                        {
                           if(monLeaf.strFrame == world.strFrame)
                           {
                              world.TRASH.addChild(clMon.pMC);
                           }
                           clMon.dataLeaf = null;
                        }
                        i++;
                     }
                     break;
                  case "cc":
                     strMsg = chatF.getCCText(resObj[2]);
                     unm = String(resObj[3]);
                     if(chatF.ignoreList.data.users != undefined)
                     {
                        if(chatF.ignoreList.data.users.indexOf(unm) > -1)
                        {
                           filter = 1;
                        }
                     }
                     if(filter == 0)
                     {
                        chatF.pushMsg("zone",strMsg,unm,"",0);
                     }
                     break;
                  case "emotea":
                     strLabel = String(resObj[2]);
                     uid = int(resObj[3]);
                     pMC = world.getMCByUserID(uid);
                     if(pMC != null)
                     {
                        pMC.mcChar.gotoAndPlay(strToProperCase(strLabel));
                     }
                     break;
                  case "em":
                     unm = String(resObj[2]);
                     msg = chatF.cleanStr(String(resObj[3]));
                     while(msg.indexOf("  ") > -1)
                     {
                        msg = msg.split("  ").join(" ");
                     }
                     msg = chatF.cleanChars(msg);
                     msgT = stripWhiteStrict(msg.toLowerCase());
                     if(chatF.strContains(msgT,chatF.illegalStrings))
                     {
                        silentMute = 1;
                     }
                     if(!silentMute)
                     {
                        chatF.pushMsg("event",msg,unm,"",0);
                     }
                     break;
                  case "chatm":
                     str = String(resObj[2]);
                     str = chatF.cleanStr(str,true,false,Boolean(int(resObj[6])));
                     unm = String(resObj[3]);
                     uid = int(resObj[4]);
                     rmId = int(resObj[5]);
                     typ = str.substr(0,str.indexOf("~"));
                     msg = str.substr(str.indexOf("~") + 1);
                     msg = chatF.cleanChars(msg);
                     if(chatF.ignoreList.data.users != undefined)
                     {
                        if(chatF.ignoreList.data.users.indexOf(unm.toLowerCase()) > -1)
                        {
                           filter = 1;
                        }
                     }
                     if(!filter)
                     {
                        chatF.pushMsg(typ,msg,unm.toLowerCase() == unm ? unm.charAt(0).toUpperCase() + unm.slice(1) : unm,uid,0,int(resObj[6]));
                     }
                     break;
                  case "whisper":
                     typ = "whisper";
                     msg = resObj[2];
                     snd = String(resObj[3]);
                     rcp = String(resObj[4]);
                     org = resObj[5];
                     msg = chatF.cleanStr(msg);
                     msg = chatF.cleanChars(msg);
                     silentMute = 0;
                     if(msg.indexOf(":=sm") > -1)
                     {
                        msg = msg.substr(0,msg.indexOf(":=sm"));
                        if(unm != sfc.myUserName)
                        {
                           silentMute = 1;
                        }
                     }
                     if(chatF.ignoreList.data.users != undefined)
                     {
                        if(chatF.ignoreList.data.users.indexOf(snd.toLowerCase()) > -1)
                        {
                           filter = 1;
                        }
                     }
                     if(!filter && (!silentMute || silentMute && snd == rcp))
                     {
                        if(snd.toLowerCase() != sfc.myUserName.toLowerCase())
                        {
                           chatF.pmSourceA = [snd];
                           if(chatF.pmSourceA.length > 20)
                           {
                              chatF.pmSourceA.splice(0,chatF.pmSourceA.length - 20);
                           }
                        }
                        if(org == 1)
                        {
                           chatF.pushMsg(typ,msg,snd,rcp,0);
                           chatF.pushMsg(typ,msg,snd,rcp,1);
                        }
                        else
                        {
                           chatF.pushMsg(typ,msg,snd,rcp,org,int(resObj[6]));
                        }
                     }
                     break;
                  case "mute":
                     chatF.muteMe(int(resObj[2]));
                     break;
                  case "unmute":
                     chatF.unmuteMe();
                     break;
                  case "mvna":
                     if(world.uoTree[sfc.myUserName].freeze == null || !world.uoTree[sfc.myUserName].freeze)
                     {
                        world.uoTree[sfc.myUserName].freeze = true;
                     }
                     break;
                  case "mvnb":
                     if(world.uoTree[sfc.myUserName].freeze != null)
                     {
                        delete world.uoTree[sfc.myUserName].freeze;
                     }
                     break;
                  case "gtc":
                     if(String(resObj[2]) != null && String(resObj[3]) != null)
                     {
                        world.moveToCell(String(resObj[2]),String(resObj[3]));
                     }
                     break;
                  case "mtcid":
                     if(resObj.length > 2)
                     {
                        world.moveToCellByIDb(Number(resObj[2]));
                     }
                     if(resObj[3] != null)
                     {
                        mtcidNow = Number(resObj[3]);
                     }
                     break;
                  case "hi":
                     world.connMsgOut = false;
                     world.connTestTimer.reset();
                     world.unlockActions();
                     break;
                  case "Dragon Buff":
                     world.map.doDragonBuff();
                     break;
                  case "trap door":
                     world.map.doTrapDoor(resObj[2]);
                     break;
                  case "gMOTD":
                     world.myAvatar.objData.guild.MOTD = resObj[2];
                     break;
                  case "buyGSlots":
                     slots = int(resObj[2]);
                     if(!isNaN(slots))
                     {
                        world.myAvatar.objData.intCoins -= slots * 200;
                     }
                     if(world.myAvatar.objData != null)
                     {
                        world.myAvatar.updateGuildInfo();
                     }
                     break;
                  case "gRename":
                     world.myAvatar.objData.intCoins -= 1000;
                     break;
                  case "fbRes":
                     if(resObj[4] != null)
                     {
                        typ = "warning";
                        msg = resObj[4];
                        msg = chatF.cleanChars(msg);
                        msg = chatF.cleanStr(msg);
                        chatF.pushMsg(typ,msg,"SERVER","",0);
                     }
                     break;
                  case "elmSwitch":
                     try
                     {
                        world.map.setupElement(String(resObj[2]));
                     }
                     catch(e:*)
                     {
                     }
               }
            }
            if(protocol == "json")
            {
               cmd = resObj.cmd;
               strF = "";
               switch(cmd)
               {
                  case "friendshipStats":
                     intf = getInterface("friendship_ui");
                     if(intf != null)
                     {
                        intf = intf.getChildAt(0);
                        intf.InitInterface(resObj);
                     }
                     break;
                  case "friendshipInfo":
                     intf = getInterface("friendship_engine");
                     if(intf != null)
                     {
                        intf = intf.getChildAt(0);
                        intf.FinalizeConvo(resObj);
                     }
                     break;
                  case "friendshipGift":
                     intf = getInterface("friendship_engine");
                     if(intf != null)
                     {
                        intf = intf.getChildAt(0);
                        intf.FinalizeGift(resObj);
                     }
                     break;
                  case "friendshipTalk":
                     intf = getInterface("friendship_engine");
                     if(intf != null)
                     {
                        intf = intf.getChildAt(0);
                        intf.FinalizeTalk(resObj);
                     }
                     break;
                  case "friendshipChoice":
                     intf = getInterface("friendship_engine");
                     if(intf != null)
                     {
                        intf = intf.getChildAt(0);
                        intf.FinalizeChoice(resObj);
                     }
                     break;
                  case "addLoadout":
                     if(!resObj.success)
                     {
                        MsgBox.notify(resObj.msg);
                     }
                     else
                     {
                        intf = getInterface("outfitSets");
                        if(intf != null)
                        {
                           intf = intf.getChildAt(0);
                           intf.onServerResponseUpdate();
                        }
                     }
                     break;
                  case "removeLoadout":
                     if(!resObj.success)
                     {
                        MsgBox.notify(resObj.msg);
                     }
                     else
                     {
                        intf = getInterface("outfitSets");
                        if(intf != null)
                        {
                           intf = intf.getChildAt(0);
                           intf.onServerResponseRemove(resObj.setName);
                        }
                     }
                     break;
                  case "wearItem":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null)
                     {
                        if(avt.pMC != null && avt.objData != null)
                        {
                           if(!avt.objData.eqp[resObj.sES])
                           {
                              avt.objData.eqp[resObj.sES] = {};
                           }
                           avt.objData.eqp[resObj.sES].sFile = resObj.sFile == "undefined" ? "" : resObj.sFile;
                           avt.objData.eqp[resObj.sES].sLink = resObj.sLink;
                           avt.objData.eqp[resObj.sES].sType = resObj.ItemID == 156 || resObj.ItemID == 12583 ? "Unarmed" : resObj.sType;
                           avt.loadMovieAtES(resObj.sES,avt.objData.eqp[resObj.sES].sFile,avt.objData.eqp[resObj.sES].sLink);
                        }
                        if(avt.isMyAvatar)
                        {
                           if(!resObj.success)
                           {
                              MsgBox.notify(resObj.msg);
                           }
                           avt.wearItem(resObj.ItemID);
                           if(MovieClip(ui.mcPopup.getChildByName("mcInventory")) != null)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                           }
                        }
                     }
                     break;
                  case "unwearItem":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null)
                     {
                        if(avt.pMC != null && avt.objData != null)
                        {
                           if(avt.isMyAvatar)
                           {
                              avt.unwearItem(resObj.ItemID);
                           }
                           if(resObj.hasOwnProperty("bRemove"))
                           {
                              delete avt.objData.eqp[resObj.sES];
                              avt.unloadMovieAtES(resObj.sES);
                           }
                           else
                           {
                              avt.objData.eqp[resObj.sES].sFile = resObj.sFile == "undefined" ? "" : resObj.sFile;
                              avt.objData.eqp[resObj.sES].sLink = resObj.sLink;
                              avt.objData.eqp[resObj.sES].sType = resObj.sType;
                              avt.loadMovieAtES(resObj.sES,avt.objData.eqp[resObj.sES].sFile,avt.objData.eqp[resObj.sES].sLink);
                           }
                        }
                        if(avt.isMyAvatar)
                        {
                           if(!resObj.success)
                           {
                              MsgBox.notify(resObj.msg);
                           }
                           if(MovieClip(ui.mcPopup.getChildByName("mcInventory")) != null)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                           }
                        }
                     }
                     break;
                  case "wearLoadout":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null)
                     {
                        if(avt.pMC != null && avt.objData != null)
                        {
                           arrWearableSpots = ["Weapon","he","ba","co"];
                           for each(spot in arrWearableSpots)
                           {
                              if(avt.isMyAvatar)
                              {
                                 avt.unwearItemAtES(spot);
                              }
                              costumeItem = resObj.costume[spot];
                              if(costumeItem)
                              {
                                 if(!avt.objData.eqp[spot])
                                 {
                                    avt.objData.eqp[spot] = {};
                                 }
                                 avt.objData.eqp[spot].sFile = costumeItem.sFile == "undefined" ? "" : costumeItem.sFile;
                                 avt.objData.eqp[spot].sLink = costumeItem.sLink;
                                 avt.objData.eqp[spot].sType = costumeItem.sType;
                                 avt.loadMovieAtES(spot,avt.objData.eqp[spot].sFile,avt.objData.eqp[spot].sLink);
                                 if(avt.isMyAvatar)
                                 {
                                    avt.wearItem(costumeItem.ItemID);
                                 }
                              }
                           }
                        }
                        if(avt.isMyAvatar)
                        {
                           if(!resObj.success)
                           {
                              MsgBox.notify(resObj.msg);
                           }
                        }
                     }
                     break;
                  case "savePrefs":
                     if(resObj.msg != "")
                     {
                        MsgBox.notify(resObj.msg);
                     }
                     switch(resObj.section)
                     {
                        case "boosts":
                        case "loadouts":
                        case "prefs":
                     }
                     break;
                  case "loadPrefs":
                     if(resObj.success)
                     {
                        world.objInfo["customs"] = resObj.result;
                     }
                     break;
                  case "acceptQuest":
                     mcQFrame = getInstanceFromModalStack("QFrameMC");
                     if(!resObj.bSuccess)
                     {
                        MsgBox.notify(resObj.msg);
                        world.abandonQuest(resObj.QuestID);
                        mcQFrame = getInstanceFromModalStack("QFrameMC");
                        if(mcQFrame)
                        {
                           mcQFrame.mc.cnt.gotoAndPlay("intro");
                        }
                     }
                     else if(mcQFrame)
                     {
                        mcQFrame.mc.cnt.gotoAndPlay("back");
                     }
                     break;
                  case "afkGameResponse":
                     world.objResponse["afkGameResponse"] = resObj;
                     world.dispatchEvent(new Event("afkGameResponse"));
                     break;
                  case "who":
                     ulo = {};
                     ulo.typ = "userListA";
                     ulo.ul = resObj.users;
                     ui.mcOFrame.fOpenWith(ulo);
                     break;
                  case "al":
                     areaListShow(resObj);
                     break;
                  case "getinfo":
                     for(prop in resObj)
                     {
                        if(prop != "cmd")
                        {
                        }
                     }
                     break;
                  case "reloadmap":
                     if(world.strMapName == resObj.sName)
                     {
                        world.setMapEvents(null);
                        world.strMapFileName = resObj.sFileName;
                        world.reloadCurrentMap();
                     }
                     break;
                  case "moveToArea":
                     if(world.ldr_House.hasEventListener(Event.COMPLETE))
                     {
                        world.ldr_House.close();
                        world.ldr_House.contentLoaderInfo.removeEventListener(Event.COMPLETE,world.onHouseItemComplete);
                        world.ldr_House.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,world.onHouseItemError);
                     }
                     if(resObj.areaName.toLowerCase().indexOf("battleodium") == 0 || resObj.areaName.toLowerCase().indexOf("greyguard") == 0)
                     {
                        if(getInterface("friendship_engine") == null)
                        {
                           requestInterface("friendship/friendship_engine.swf","friendship_engine");
                        }
                     }
                     if(resObj.areaName.toLowerCase().indexOf("magicmeadow") == 0 || resObj.areaName.toLowerCase().indexOf("magicmeaderp") == 0)
                     {
                        if(getInterface("pony_engine") == null)
                        {
                           requestInterface("ponyvspony/pony_engine.swf","pony_engine");
                        }
                        else
                        {
                           world.myAvatar.swapMorphs(true);
                        }
                     }
                     else if(getInterface("pony_engine") != null)
                     {
                        world.myAvatar.swapMorphs(false);
                     }
                     if(resObj.areaName.indexOf("battleon") > -1 && resObj.areaName.indexOf("battleontown") < 0)
                     {
                        world.rootClass.openMenu();
                        world.rootClass.firstMenu = false;
                     }
                     else if(!world.rootClass.firstMenu)
                     {
                        world.rootClass.menuClose();
                     }
                     if(resObj.strMapName == "trickortreat")
                     {
                        world.TrickOrTreatMonsterDead = false;
                     }
                     else if(resObj.strMapName == "caroling")
                     {
                        world.CarolingMonsterKillCount = 0;
                     }
                     world.mapLoadInProgress = true;
                     world.strAreaName = resObj.areaName;
                     world.initObjExtra(resObj.sExtra);
                     world.areaUsers = [];
                     myLeaf = null;
                     world.modID = -1;
                     if(world.uoTreeLeaf(sfc.myUserName) != null)
                     {
                        myLeaf = copyObj(world.uoTreeLeaf(sfc.myUserName));
                     }
                     world.uoTree = {};
                     if(myLeaf != null)
                     {
                        world.uoTree[sfc.myUserName] = myLeaf;
                     }
                     if(resObj.monName != null)
                     {
                        world.chaosNames = resObj.monName.split(",");
                     }
                     if(resObj.pvpTeam != null)
                     {
                        myLeaf.pvpTeam = resObj.pvpTeam;
                        world.bPvP = true;
                        ui.mcPortrait.pvpIcon.visible = true;
                        ui.mcPortrait.partyLead.y = 18;
                        world.setPVPFactionData(resObj.PVPFactions);
                        if(world.objExtra["bChaos"] == null)
                        {
                           updatePVPScore(resObj.pvpScore);
                           showPVPScore();
                        }
                     }
                     else
                     {
                        ui.mcPortrait.pvpIcon.visible = false;
                        ui.mcPortrait.partyLead.y = 0;
                        delete myLeaf.pvpTeam;
                        world.bPvP = false;
                        hidePVPScore();
                        world.setPVPFactionData(null);
                     }
                     if(resObj.pvpScore != null)
                     {
                        updatePVPScore(resObj.pvpScore);
                     }
                     bi = 0;
                     while(bi < resObj.uoBranch.length)
                     {
                        branchA = resObj.uoBranch[bi];
                        unm = branchA.uoName;
                        uoLeaf = {};
                        for(s in branchA)
                        {
                           nam = s;
                           val = branchA[s];
                           if(nam.toLowerCase().indexOf("int") > -1 || nam.toLowerCase() == "tx" || nam.toLowerCase() == "ty" || nam.toLowerCase() == "sp" || nam.toLowerCase() == "pvpTeam")
                           {
                              val = int(val);
                           }
                           uoLeaf[nam] = val;
                        }
                        if(unm != sfc.myUserName)
                        {
                           uoLeaf.auras = [];
                        }
                        uoLeaf.targets = {};
                        world.uoTreeLeafSet(unm,uoLeaf);
                        world.manageAreaUser(unm,"+");
                        bi++;
                     }
                     world.monTree = {};
                     world.monsters = [];
                     bi = 0;
                     while(bi < resObj.monBranch.length)
                     {
                        branchA = resObj.monBranch[bi];
                        monLeaf = {};
                        mID = "1";
                        for(s in branchA)
                        {
                           nam = s;
                           val = branchA[s];
                           if(nam.toLowerCase().indexOf("monmapid") > -1)
                           {
                              mID = val;
                           }
                           if(nam.toLowerCase().indexOf("int") > -1 || nam.toLowerCase().indexOf("monid") > -1 || nam.toLowerCase().indexOf("monmapid") > -1)
                           {
                              val = Number(val);
                           }
                           monLeaf[nam] = val;
                        }
                        monLeaf.auras = [];
                        monLeaf.targets = {};
                        monLeaf.strBehave = "walk";
                        world.monTree[mID] = monLeaf;
                        bi++;
                     }
                     if("event" in resObj)
                     {
                        world.setMapEvents(resObj.event);
                     }
                     else
                     {
                        world.setMapEvents(null);
                     }
                     if("cellMap" in resObj)
                     {
                        world.setCellMap(resObj.cellMap);
                     }
                     else
                     {
                        world.setCellMap(null);
                     }
                     if(world.strFrame != "")
                     {
                        world.exitCell();
                     }
                     world.killLoaders();
                     world.clearMonstersAndProps();
                     world.clearAllAvatars();
                     world.avatars[sfc.myUserId] = world.myAvatar;
                     world.strMapName = resObj.strMapName;
                     world.strMapFileName = resObj.strMapFileName;
                     world.intType = resObj.intType;
                     world.intKillCount = resObj.intKillCount;
                     world.objLock = resObj.objLock != null ? resObj.objLock : null;
                     world.mondef = resObj.mondef;
                     world.monmap = resObj.monmap;
                     world.curRoom = Number(resObj.areaId);
                     world.actionResultsMon = [];
                     world.actionResults = [];
                     world.actionResultsAura = [];
                     world.mapBoundsMC = null;
                     chatF.chn.zone.rid = world.curRoom;
                     if("houseData" in resObj)
                     {
                        world.initHouseData(resObj.houseData);
                     }
                     else
                     {
                        world.initHouseData(null);
                     }
                     world.updatePartyFrame();
                     world.clearLoaders();
                     s = resObj.strMapFileName.toLowerCase();
                     world.loadMap(s);
                     elmType = resObj.elmType;
                     if(world.rootClass.hasPreviewed)
                     {
                        for(psES in world.myAvatar.objData.eqp)
                        {
                           if(world.myAvatar.objData.eqp[psES].wasCreated)
                           {
                              delete world.myAvatar.objData.eqp[psES];
                              world.myAvatar.unloadMovieAtES(psES);
                           }
                           else if(world.myAvatar.objData.eqp[psES].isPreview)
                           {
                              if(psES == "pe")
                              {
                                 if(world.myAvatar.objData.eqp["pe"])
                                 {
                                    world.myAvatar.unloadPet();
                                 }
                              }
                              world.myAvatar.objData.eqp[psES].sType = world.myAvatar.objData.eqp[psES].oldType;
                              world.myAvatar.objData.eqp[psES].sFile = world.myAvatar.objData.eqp[psES].oldFile;
                              world.myAvatar.objData.eqp[psES].sLink = world.myAvatar.objData.eqp[psES].oldLink;
                              world.myAvatar.loadMovieAtES(psES,world.myAvatar.objData.eqp[psES].oldFile,world.myAvatar.objData.eqp[psES].oldLink);
                              world.myAvatar.objData.eqp[psES].isPreview = null;
                           }
                        }
                        world.rootClass.hasPreviewed = false;
                     }
                     if(world.myAvatar && world.myAvatar.items && world.myAvatar.items.length > 0 && Boolean(litePreference.data.bCharSelect))
                     {
                        saveChar();
                     }
                     break;
                  case "initUserData":
                     try
                     {
                        avt = world.getAvatarByUserID(resObj.uid);
                        uoLeaf = avt.dataLeaf;
                        if(avt != null && uoLeaf != null)
                        {
                           avt.initAvatar({"data":resObj.data});
                           if(avt.isMyAvatar)
                           {
                              loadGameMenu();
                              avt.objData.strHomeTown = avt.objData.strMapName;
                              if(avt.objData.guild != null)
                              {
                                 chatF.chn.guild.act = 1;
                                 if(String(avt.objData.guild.MOTD) != "undefined")
                                 {
                                    chatF.pushMsg("guild","Message of the day: " + String(avt.objData.guild.MOTD),"SERVER","",0);
                                 }
                              }
                              if(Game.serverFilePath.indexOf("content.aq.com") == -1)
                              {
                                 world.rootClass.extCall.showIt("login");
                              }
                              if(avt.objData.iUpg > 0)
                              {
                                 if(avt.objData.iUpgDays < 0)
                                 {
                                    chatF.pushMsg("moderator","Your membership has expired. Please visit our website to renew your membership.","SERVER","",0);
                                 }
                                 else if(avt.objData.iUpgDays < 7)
                                 {
                                    chatF.pushMsg("moderator","Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1) + " days. Please visit our website to renew your membership.","SERVER","",0);
                                 }
                              }
                              updateXPBar();
                              ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                              if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                              {
                                 MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                              }
                              world.getInventory(resObj.uid);
                              world.initAchievements();
                              readIA1Preferences();
                           }
                        }
                     }
                     catch(e:Error)
                     {
                     }
                     break;
                  case "initUserDatas":
                     a = resObj.a;
                     i = 0;
                     while(i < a.length)
                     {
                        o = a[i];
                        try
                        {
                           avt = world.getAvatarByUserID(o.uid);
                           uoLeaf = avt.dataLeaf;
                           if(avt != null && uoLeaf != null)
                           {
                              avt.initAvatar({"data":o.data});
                              if(avt.isMyAvatar && (avt.items == null || avt.items.length < 1))
                              {
                                 loadGameMenu();
                                 avt.objData.strHomeTown = avt.objData.strMapName;
                                 if(avt.objData.guild != null)
                                 {
                                    chatF.chn.guild.act = 1;
                                    if(String(avt.objData.guild.MOTD) != "undefined")
                                    {
                                       chatF.pushMsg("guild","Message of the day: " + String(avt.objData.guild.MOTD),"SERVER","",0);
                                    }
                                 }
                                 if(Game.serverFilePath.indexOf("content.aq.com") == -1)
                                 {
                                    world.rootClass.extCall.showIt("login");
                                 }
                                 if(avt.objData.iUpg > 0)
                                 {
                                    if(avt.objData.iUpgDays < 0)
                                    {
                                       chatF.pushMsg("moderator","Your membership has expired. Please visit our website to renew your membership.","SERVER","",0);
                                    }
                                    else if(avt.objData.iUpgDays < 7)
                                    {
                                       chatF.pushMsg("moderator","Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1) + " days. Please visit our website to renew your membership.","SERVER","",0);
                                    }
                                 }
                                 if(avt.objData.dRefReset != null && (avt.objData.iRefGold > 0 || avt.objData.iRefExp > 0))
                                 {
                                    modalRR = new ModalMC();
                                    modalORR = {};
                                    modalORR.strBody = "You earned <font color=\'#FFCC00\'><b>" + Math.ceil(avt.objData.iRefGold) + " Gold</b></font> and <font color=\'#990099\'><b>" + Math.ceil(avt.objData.iRefExp) + " XP</b></font><br/> from Referred Friends.";
                                    modalORR.callback = world.sendRewardReferralRequest;
                                    modalORR.btns = "mono";
                                    ui.ModalStack.addChild(modalRR);
                                    modalRR.init(modalORR);
                                 }
                                 updateXPBar();
                                 ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                                 if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                                 {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                                 }
                                 world.getInventory(o.uid);
                                 world.initAchievements();
                                 readIA1Preferences();
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        i++;
                     }
                     break;
                  case "changeColor":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null && avt.bitData)
                     {
                        if(avt.isMyAvatar)
                        {
                           showPortrait(avt);
                        }
                        if(resObj.HairID != null)
                        {
                           avt.objData.HairID = resObj.HairID;
                           avt.objData.strHairName = resObj.strHairName;
                           avt.objData.strHairFilename = resObj.strHairFilename;
                           if(avt.pMC != null && avt.pMC.stage != null)
                           {
                              avt.pMC.loadHair();
                           }
                        }
                        avt.objData.intColorSkin = resObj.intColorSkin;
                        avt.objData.intColorHair = resObj.intColorHair;
                        avt.objData.intColorEye = resObj.intColorEye;
                        if(avt.pMC != null && avt.pMC.stage != null)
                        {
                           avt.pMC.updateColor();
                        }
                     }
                     break;
                  case "changeArmorColor":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null && avt.bitData)
                     {
                        avt.objData.intColorBase = resObj.intColorBase;
                        avt.objData.intColorTrim = resObj.intColorTrim;
                        avt.objData.intColorAccessory = resObj.intColorAccessory;
                        if(avt.pMC != null && avt.pMC.stage != null)
                        {
                           avt.pMC.updateColor();
                        }
                     }
                     break;
                  case "balance":
                     if(resObj.intExp != null)
                     {
                        world.myAvatar.objData.intExp = resObj.intExp;
                        updateXPBar();
                     }
                     if(resObj.intGold != null)
                     {
                        world.myAvatar.objData.intGold = resObj.intGold;
                        ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        }
                     }
                     if(resObj.intCoins != null)
                     {
                        world.myAvatar.objData.intCoins = resObj.intCoins;
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        }
                     }
                     break;
                  case "addGoldExp":
                     if(resObj.intExp != null && resObj.intExp > 0)
                     {
                        if(bAnalyzer)
                        {
                           if(Boolean(bAnalyzer.isRunning))
                           {
                              bAnalyzer.addExp(resObj.intExp);
                           }
                        }
                        deltaXP = int(resObj.intExp);
                        world.myAvatar.objData.intExp += deltaXP;
                        updateXPBar();
                        xp = new xpDisplay();
                        xp.t.ti.text = deltaXP + " xp";
                        xpB = null;
                        if("bonusExp" in resObj)
                        {
                           xpB = new xpDisplayBonus();
                           xpB.t.ti.text = String("+ " + resObj.bonusExp + " xp!");
                           xp.t.ti.text = deltaXP - resObj.bonusExp + " xp";
                        }
                        if(resObj.typ != null && resObj.typ == "m")
                        {
                           Mon = world.getMonster(resObj.id);
                           xp.x = Mon.pMC.mcChar.x;
                           xp.y = Mon.pMC.mcChar.y - 40;
                           Mon.pMC.addChild(xp);
                           if(xpB != null)
                           {
                              xpB.x = xp.x;
                              xpB.y = xp.y;
                              Mon.pMC.addChild(xpB);
                           }
                        }
                        else
                        {
                           xp.x = world.myAvatar.pMC.mcChar.x;
                           xp.y = world.myAvatar.pMC.pname.y + 10;
                           world.myAvatar.pMC.addChild(xp);
                           if(xpB != null)
                           {
                              xpB.x = xp.x;
                              xpB.y = xp.y;
                              world.myAvatar.pMC.addChild(xpB);
                           }
                        }
                     }
                     if(resObj.intGold != null && resObj.intGold > 0)
                     {
                        if(bAnalyzer)
                        {
                           if(Boolean(bAnalyzer.isRunning))
                           {
                              bAnalyzer.addGold(resObj.intGold);
                           }
                        }
                        mixer.playSound("Coins");
                        deltaGold = int(resObj.intGold);
                        world.myAvatar.objData.intGold += resObj.intGold;
                        ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        }
                        gold = new goldDisplay();
                        gold.t.ti.text = deltaGold + " g";
                        gold.tMask.ti.text = deltaGold + " g";
                        if(resObj.typ != null && resObj.typ == "m")
                        {
                           Mon = world.getMonster(resObj.id);
                           gold.x = Mon.pMC.mcChar.x;
                           gold.y = Mon.pMC.mcChar.y - 20;
                           Mon.pMC.addChild(gold);
                        }
                        else
                        {
                           gold.x = world.myAvatar.pMC.mcChar.x;
                           gold.y = world.myAvatar.pMC.pname.y - 30;
                           world.myAvatar.pMC.addChild(gold);
                        }
                     }
                     if(resObj.iCP != null)
                     {
                        deltaCP = int(resObj.iCP);
                        world.myAvatar.objData.iCP += deltaCP;
                        world.myAvatar.updateArmorRep();
                        iRank = world.myAvatar.objData.iRank;
                        world.myAvatar.updateRep();
                        if(iRank != world.myAvatar.objData.iRank)
                        {
                           world.myAvatar.rankUp(world.myAvatar.objData.strClassName,world.myAvatar.objData.iRank);
                           FB_showFeedDialog("Rank Up!","reached Rank " + world.myAvatar.objData.iRank + " " + world.myAvatar.objData.strClassName + " in AQWorlds!","aqw-rankup.jpg");
                        }
                        txtBonusCP = "";
                        if(resObj.bonusCP == null)
                        {
                           resObj.bonusCP = 0;
                        }
                        else
                        {
                           txtBonusCP = " + " + resObj.bonusCP + "(Bonus)";
                        }
                        chatF.pushMsg("server","Class Points for " + world.myAvatar.objData.strClassName + " increased by " + (deltaCP - resObj.bonusCP) + txtBonusCP + ".","SERVER","",0);
                     }
                     if(resObj.FactionID != null)
                     {
                        if(resObj.bonusRep == null)
                        {
                           resObj.bonusRep = 0;
                        }
                        world.myAvatar.addRep(resObj.FactionID,resObj.iRep,resObj.bonusRep);
                     }
                     break;
                  case "levelUp":
                     world.myAvatar.objData.intLevel = resObj.intLevel;
                     world.myAvatar.objData.intExpToLevel = resObj.intExpToLevel;
                     world.myAvatar.objData.intExp = resObj.xp;
                     updateXPBar();
                     showPortraitBox(world.myAvatar,ui.mcPortrait);
                     world.myAvatar.levelUp();
                     if(resObj.intLevel == 10)
                     {
                        world.rootClass.extCall.showIt("level10");
                     }
                     if("updatePStats" in world.map)
                     {
                        world.map.updatePStats();
                     }
                     break;
                  case "loadInventoryBig":
                     world.myAvatar.iBankCount = int(resObj.bankCount);
                     world.myAvatar.initInventory(resObj.items);
                     world.initHouseInventory({
                        "sHouseInfo":world.myAvatar.objData.sHouseInfo,
                        "items":resObj.hitems
                     });
                     world.myAvatar.initFactions(resObj.factions);
                     world.myAvatar.initGuild(resObj.guild);
                     world.uiLock = false;
                     world.myAvatar.invLoaded = true;
                     world.myAvatar.calculateIntoBoosts();
                     try
                     {
                        if("eventTrigger" in MovieClip(world.map))
                        {
                           world.map.eventTrigger({"cmd":"userLoaded"});
                        }
                     }
                     catch(e:*)
                     {
                     }
                     world.myAvatar.checkItemAnimation();
                     adShown = false;
                     testDate = new Date();
                     if(FacebookConnect.isLoggedIn)
                     {
                     }
                     if(world.myAvatar.objData.iUpg < 1 && world.map.noPopup != true)
                     {
                        testDate.setDate(testDate.getDate() - 3);
                        if(world.myAvatar.objData.dCreated > testDate && world.myAvatar.objData.intHits > 1 && Math.random() < 0.2)
                        {
                           adShown = true;
                           world.loadMovieFront("interface/DragonHeroOffer-28Feb13.swf","Inline Asset");
                        }
                     }
                     if(world.myAvatar.objData.intActivationFlag == 1 && world.myAvatar.objData.intHits < 16 && world.map.noPopup != true)
                     {
                        if(world.myAvatar.objData.intHits == 5 || world.myAvatar.objData.intHits == 15)
                        {
                           world.loadMovieFront("interface/ConfirmedEmailPopup.swf","Inline Asset");
                        }
                     }
                     break;
                  case "friends":
                     world.myAvatar.initFriendsList(resObj.friends);
                     if(resObj.showList)
                     {
                        flo = {};
                        flo.typ = "userListFriends";
                        for each(friend in world.myAvatar.friends)
                        {
                           friend.bOffline = friend.sServer == objServerInfo.sName ? 0 : (friend.sServer == "Offline" ? 2 : 1);
                        }
                        world.myAvatar.friends.sortOn("sName",Array.CASEINSENSITIVE);
                        world.myAvatar.friends.sortOn(["bOffline","sServer","sName"],[Array.NUMERIC,Array.CASEINSENSITIVE,Array.CASEINSENSITIVE]);
                        flo.ul = world.myAvatar.friends;
                        ui.mcOFrame.fOpenWith(flo);
                        mcO.fClose();
                     }
                     break;
                  case "initInventory":
                     world.myAvatar.initInventory(resObj.items);
                     if("eventTrigger" in MovieClip(world.map))
                     {
                        world.map.eventTrigger({"cmd":"userLoaded"});
                     }
                     break;
                  case "loadHouseInventory":
                     world.initHouseInventory(resObj);
                     break;
                  case "house":
                     MsgBox.notify(resObj.msg);
                     break;
                  case "buyBagSlots":
                     world.dispatchEvent(new Event("buyBagSlots"));
                     if(resObj.bitSuccess == 1)
                     {
                        mixer.playSound("Heal");
                        world.myAvatar.objData.iBagSlots += Number(resObj.iSlots);
                        world.myAvatar.objData.intCoins -= Number(resObj.iSlots) * 200;
                        MsgBox.notify("You now have " + world.myAvatar.objData.iBagSlots + " inventory spaces!");
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                        }
                        if(ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "HouseShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                        }
                     }
                     break;
                  case "buyBankSlots":
                     world.dispatchEvent(new Event("buyBankSlots"));
                     if(resObj.bitSuccess == 1)
                     {
                        mixer.playSound("Heal");
                        world.myAvatar.objData.iBankSlots += Number(resObj.iSlots);
                        world.myAvatar.objData.intCoins -= Number(resObj.iSlots) * 200;
                        MsgBox.notify("You now have " + world.myAvatar.objData.iBankSlots + " bank spaces!");
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                        }
                        if(ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "HouseShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                        }
                     }
                     break;
                  case "buyHouseSlots":
                     world.dispatchEvent(new Event("buyHouseSlots"));
                     if(resObj.bitSuccess == 1)
                     {
                        mixer.playSound("Heal");
                        world.myAvatar.objData.iHouseSlots += Number(resObj.iSlots);
                        world.myAvatar.objData.intCoins -= Number(resObj.iSlots) * 200;
                        MsgBox.notify("You now have " + world.myAvatar.objData.iHouseSlots + " house inventory spaces!");
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshSlots"});
                        }
                        if(ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "HouseShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshSlots"});
                        }
                     }
                     break;
                  case "buyLoadoutSlots":
                     if(resObj.bitSuccess == 1)
                     {
                        mixer.playSound("Heal");
                        world.myAvatar.objData.iLoadoutSlots += Number(resObj.iSlots);
                        world.myAvatar.objData.intCoins -= Number(resObj.iSlots) * 200;
                        world.dispatchEvent(new Event("buyLoadoutSlots"));
                     }
                     break;
                  case "callfct":
                     try
                     {
                        fct = world.map[resObj.fctNam];
                        fct(resObj.fctParams);
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "genderSwap":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null && avt.bitData)
                     {
                        if(resObj.bitSuccess == 1)
                        {
                           if(avt.isMyAvatar)
                           {
                              MsgBox.notify("Your gender has been successfully changed.");
                              avt.objData.intCoins -= resObj.intCoins;
                           }
                           avt.objData.strGender = resObj.gender;
                           avt.objData.HairID = resObj.HairID;
                           avt.objData.strHairName = resObj.strHairName;
                           avt.objData.strHairFilename = resObj.strHairFilename;
                           avt.initAvatar({"data":avt.objData});
                        }
                     }
                     break;
                  case "loadBank":
                     if(resObj.bitSuccess)
                     {
                        if(resObj.items != null && resObj.items != "undefined")
                        {
                           world.addItemsToBank(resObj.items);
                        }
                        if(ui.mcPopup.currentLabel == "Bank")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshBank"});
                        }
                        else
                        {
                           ui.mcPopup.fOpen("Bank");
                        }
                     }
                     else
                     {
                        modal = new ModalMC();
                        modalO = {};
                        modalO.strBody = "Error loading bank items!  Try logging out and back in to fix this problem.";
                        modalO.params = {};
                        modalO.glow = "red,medium";
                        modalO.btns = "mono";
                        ui.ModalStack.addChild(modal);
                        modal.init(modalO);
                     }
                     break;
                  case "bankFromInv":
                     if("bSuccess" in resObj && resObj.bSuccess == 1)
                     {
                        world.myAvatar.bankFromInv(resObj.ItemID);
                        world.checkAllQuestStatus();
                        if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshItems"});
                        }
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                        }
                     }
                     else
                     {
                        modal = new ModalMC();
                        modalO = {};
                        modalO.strBody = resObj.msg;
                        modalO.params = {};
                        modalO.glow = "red,medium";
                        modalO.btns = "mono";
                        ui.ModalStack.addChild(modal);
                        modal.init(modalO);
                     }
                     break;
                  case "bankToInv":
                     world.myAvatar.bankToInv(resObj.ItemID);
                     world.checkAllQuestStatus();
                     if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshItems"});
                     }
                     if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                     }
                     break;
                  case "bankSwapInv":
                     world.myAvatar.bankSwapInv(resObj.invItemID,resObj.bankItemID);
                     world.checkAllQuestStatus();
                     if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshItems"});
                     }
                     if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                     }
                     break;
                  case "loadShop":
                     if(world.shopinfo != null && "ShopID" in world.shopinfo && world.shopinfo.ShopID == resObj.shopinfo.ShopID && "bLimited" in world.shopinfo && Boolean(world.shopinfo.bLimited))
                     {
                        i = 0;
                        while(i < resObj.shopinfo.items.length)
                        {
                           world.shopinfo.items.push(resObj.shopinfo.items[i]);
                           world.shopinfo.items.shift();
                           i++;
                        }
                        if(ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "HouseShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                        }
                        else
                        {
                           ui.mcPopup.fOpen("Shop");
                        }
                     }
                     else
                     {
                        world.shopinfo = resObj.shopinfo;
                        if(resObj.shopinfo.bHouse == 1)
                        {
                           ui.mcPopup.fOpen("HouseShop");
                        }
                        else if(isMergeShop(resObj.shopinfo))
                        {
                           ui.mcPopup.fOpen("MergeShop");
                        }
                        else
                        {
                           ui.mcPopup.fOpen("Shop");
                        }
                     }
                     break;
                  case "loadEnhShop":
                     world.enhShopID = resObj.shopinfo.ShopID;
                     world.enhShopItems = resObj.shopinfo.items;
                     ui.mcPopup.fOpen("EnhShop");
                     break;
                  case "enhanceItemShop":
                     if(resObj.iCost != null)
                     {
                        world.myAvatar.objData.intGold -= Number(resObj.iCost);
                        ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                        if(ui.mcPopup.currentLabel == "Inventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        }
                        if(ui.mcPopup.currentLabel == "Shop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                        }
                     }
                     for each(o in world.myAvatar.items)
                     {
                        if(resObj.ItemIDs.indexOf(Number(o.ItemID)) != -1)
                        {
                           o.iEnh = resObj.EnhID;
                           o.EnhID = resObj.EnhID;
                           o.EnhPatternID = resObj.EnhPID;
                           o.EnhLvl = resObj.EnhLvl;
                           o.EnhDPS = resObj.EnhDPS;
                           o.EnhRng = resObj.EnhRng;
                           o.EnhRty = resObj.EnhRty;
                           o.ProcID = resObj.ProcID;
                        }
                     }
                     mixer.playSound("Good");
                     if(ui.mcPopup.currentLabel == "Inventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"previewEquipOnly"
                        });
                     }
                     if(ui.mcPopup.currentLabel == "Shop")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"closeWindows"
                        });
                     }
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = "You have upgraded your items with <b>" + resObj.EnhName + "</b>, level <b>" + resObj.EnhLvl + "</b>!";
                     modalO.params = {};
                     modalO.glow = "white,medium";
                     modalO.btns = "mono";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     break;
                  case "enhanceItemLocal":
                     iSel = null;
                     eSel = null;
                     for each(o in world.myAvatar.items)
                     {
                        if(o.ItemID == resObj.ItemID)
                        {
                           iSel = o;
                        }
                     }
                     iSel.iEnh = resObj.EnhID;
                     iSel.EnhID = resObj.EnhID;
                     iSel.EnhPatternID = resObj.EnhPID;
                     iSel.EnhLvl = resObj.EnhLvl;
                     iSel.EnhDPS = resObj.EnhDPS;
                     iSel.EnhRng = resObj.EnhRng;
                     iSel.EnhRty = resObj.EnhRty;
                     iSel.ProcID = resObj.ProcID;
                     mixer.playSound("Good");
                     if(ui.mcPopup.currentLabel == "Inventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"previewEquipOnly"
                        });
                     }
                     if(ui.mcPopup.currentLabel == "Shop")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"closeWindows"
                        });
                     }
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = "You have upgraded " + iSel.sName + " with " + resObj.EnhName + ", level " + resObj.EnhLvl + "!";
                     modalO.params = {};
                     modalO.glow = "white,medium";
                     modalO.btns = "mono";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     break;
                  case "loadHairShop":
                     world.hairshopinfo = resObj;
                     openCharacterCustomize();
                     break;
                  case "buyItem":
                     if(resObj.bitSuccess == 0)
                     {
                        if("bSoldOut" in resObj && Boolean(resObj.bSoldOut))
                        {
                           if(world.shopinfo.bLimited)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                 "eventType":"refreshShop",
                                 "sInstruction":"closeWindows"
                              });
                           }
                           modal = new ModalMC();
                           modalO = {};
                           modalO.strBody = resObj.strMessage + " is no longer in stock.";
                           modalO.params = {};
                           modalO.glow = "red,medium";
                           modalO.btns = "mono";
                           ui.ModalStack.addChild(modal);
                           modal.init(modalO);
                        }
                        else if(resObj.strMessage != null)
                        {
                           MsgBox.notify(resObj.strMessage);
                        }
                     }
                     else
                     {
                        if(resObj.strMessage != null)
                        {
                           MsgBox.notify(resObj.strMessage);
                        }
                        item = copyObj(world.shopBuyItem);
                        item.iQty = resObj.iQty;
                        item.CharItemID = resObj.CharItemID;
                        item.bBank = resObj.bBank;
                        if(item.bCoins == 0)
                        {
                           world.myAvatar.objData.intGold -= Number(item.iCost * resObj.iQty);
                           ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                           if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                           }
                        }
                        else
                        {
                           item.iHrs = 0;
                           world.myAvatar.objData.intCoins -= Number(item.iCost * resObj.iQty);
                        }
                        if(resObj.virtual)
                        {
                           item.virtual = resObj.virtual;
                        }
                        showItemDrop(item,false);
                        if(world.invTree[item.ItemID] == null)
                        {
                           world.invTree[item.ItemID] = copyObj(resObj);
                           world.invTree[item.ItemID].iQty = 0;
                        }
                        if(!resObj.virtual)
                        {
                           world.myAvatar.addItem(item);
                        }
                        if(item.bHouse == 1)
                        {
                           if(item.sType == "House" && !world.isHouseEquipped())
                           {
                              world.sendEquipItemRequest(item);
                              world.myAvatar.getItemByID(item.ItemID).bEquip = 1;
                           }
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                              "eventType":"refreshItems",
                              "sInstruction":"closeWindows"
                           });
                           if(world.shopinfo.bLimited)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshShop"});
                           }
                           if(ui.mcPopup.currentLabel == "HouseInventory")
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                 "eventType":"refreshItems",
                                 "sInstruction":"closeWindows"
                              });
                           }
                        }
                        else if(ui.mcPopup.currentLabel == "Shop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                              "eventType":"refreshItems",
                              "sInstruction":"closeWindows"
                           });
                           if(world.shopinfo.bLimited)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshShop"});
                           }
                        }
                        else if(ui.mcPopup.currentLabel == "MergeShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                        }
                        else if(ui.mcPopup.currentLabel == "Inventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                              "eventType":"refreshItems",
                              "sInstruction":"closeWindows"
                           });
                        }
                        world.updateQuestProgress("item",item);
                        if(item.sType == "Item")
                        {
                           updateItemSkill();
                        }
                     }
                     break;
                  case "sellItem":
                     world.myAvatar.removeItem({
                        "CharItemID":resObj.CharItemID,
                        "iQty":resObj.iQty
                     });
                     if(resObj.bCoins == 1)
                     {
                        world.myAvatar.objData.intCoins += resObj.intAmount;
                     }
                     else if(world.myAvatar.objData.intGold < 100000000)
                     {
                        world.myAvatar.objData.intGold += resObj.intAmount;
                        ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                     }
                     if(ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "HouseShop")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshCoins"});
                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"closeWindows"
                        });
                     }
                     else if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                           "eventType":"refreshItems",
                           "sInstruction":"closeWindows"
                        });
                     }
                     world.checkAllQuestStatus();
                     break;
                  case "removeItem":
                     world.myAvatar.removeItem(resObj);
                     if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                     }
                     if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshBank"});
                     }
                     world.checkAllQuestStatus();
                     break;
                  case "updateClass":
                     isNewClass = true;
                     statsNewClass = true;
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null && avt.objData != null)
                     {
                        avt.objData.strClassName = resObj.sClassName;
                        avt.objData.iCP = resObj.iCP;
                        avt.objData.sClassCat = resObj.sClassCat;
                        avt.updateRep();
                        if(resObj.uid == sfc.myUserId)
                        {
                           if("sDesc" in resObj)
                           {
                              avt.objData.sClassDesc = resObj.sDesc;
                           }
                           if("sStats" in resObj)
                           {
                              avt.objData.sClassStats = resObj.sStats;
                           }
                           if("aMRM" in resObj)
                           {
                              avt.objData.aClassMRM = resObj.aMRM;
                           }
                        }
                     }
                     break;
                  case "equipItem":
                     avt = world.getAvatarByUserID(resObj.uid);
                     tLeaf = world.getUoLeafById(resObj.uid);
                     if(avt != null)
                     {
                        if(avt.isMyAvatar)
                        {
                           sMeta = world.myAvatar.getItemByEquipSlot(resObj.strES) ? world.myAvatar.getItemByEquipSlot(resObj.strES).sMeta : "";
                           if(Boolean(sMeta) && sMeta.length > 0)
                           {
                              if(world.myAvatar.invLoaded)
                              {
                                 avt.calculateIntoBoosts();
                              }
                           }
                        }
                        if(avt.pMC != null && avt.objData != null)
                        {
                           avt.objData.eqp[resObj.strES] = {};
                           avt.objData.eqp[resObj.strES].sFile = resObj.sFile == "undefined" ? "" : resObj.sFile;
                           avt.objData.eqp[resObj.strES].sLink = resObj.sLink;
                           if("sType" in resObj)
                           {
                              avt.objData.eqp[resObj.strES].sType = resObj.sType;
                           }
                           if("ItemID" in resObj)
                           {
                              avt.objData.eqp[resObj.strES].ItemID = resObj.ItemID;
                           }
                           if("sMeta" in resObj)
                           {
                              avt.objData.eqp[resObj.strES].sMeta = resObj.sMeta;
                           }
                           avt.loadMovieAtES(resObj.strES,resObj.sFile,resObj.sLink);
                        }
                        if(avt.isMyAvatar)
                        {
                           avt.equipItem(resObj.ItemID);
                           if(MovieClip(ui.mcPopup.getChildByName("mcInventory")) != null)
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                           }
                           if(ui.mcPopup.mcTempInventory != null)
                           {
                              ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                              ui.mcPopup.mcTempInventory.refreshDetail();
                           }
                           if("sMeta" in resObj && String(resObj.sMeta).length > 0)
                           {
                              if(world.myAvatar.invLoaded)
                              {
                                 avt.calculateIntoBoosts();
                              }
                           }
                        }
                     }
                     break;
                  case "unequipItem":
                     avt = world.getAvatarByUserID(resObj.uid);
                     if(avt != null)
                     {
                        if(avt.pMC != null && Boolean(resObj.bUnload))
                        {
                           delete avt.objData.eqp[resObj.strES];
                           avt.unloadMovieAtES(resObj.strES);
                        }
                        if(avt.isMyAvatar)
                        {
                           avt.unequipItem(resObj.ItemID);
                           if(ui.mcPopup.currentLabel == "Inventory")
                           {
                              MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                           }
                           if(ui.mcPopup.mcTempInventory != null)
                           {
                              ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                              ui.mcPopup.mcTempInventory.refreshDetail();
                           }
                           sMeta = world.myAvatar.getItemByID(resObj.ItemID) ? world.myAvatar.getItemByID(resObj.ItemID).sMeta : "";
                           if(Boolean(sMeta) && sMeta.length > 0)
                           {
                              if(world.myAvatar.invLoaded)
                              {
                                 avt.calculateIntoBoosts();
                              }
                           }
                        }
                     }
                     break;
                  case "dropItem":
                     for(dID in resObj.items)
                     {
                        dItem = null;
                        if(world.invTree[dID] == null)
                        {
                           world.invTree[dID] = copyObj(resObj.items[dID]);
                           world.invTree[dID].iQty = 0;
                           dItem = resObj.items[dID];
                        }
                        else
                        {
                           dItem = copyObj(world.invTree[dID]);
                           for(iData in resObj.items[dID])
                           {
                              if(resObj.items[dID][iData] != dItem[iData])
                              {
                                 dItem[iData] = resObj.items[dID][iData];
                                 if(iData != "iQty")
                                 {
                                    world.invTree[dID][iData] = resObj.items[dID][iData];
                                 }
                              }
                           }
                        }
                        if(resObj.Wheel != null)
                        {
                           try
                           {
                              world.map.doWheelDrop(dItem);
                           }
                           catch(e:*)
                           {
                           }
                        }
                        else
                        {
                           dItem.dID = dID;
                           dItem.dQty = int(resObj.items[dID].iQty);
                           isOK = true;
                           if(litePreference.data.blackList)
                           {
                              for each(bItem in litePreference.data.blackList)
                              {
                                 if(isNaN(parseInt(bItem.value)))
                                 {
                                    litePreference.data.blackList.splice(litePreference.data.blackList.indexOf(bItem.value),1);
                                 }
                                 else if(dItem.ItemID == parseInt(bItem.value))
                                 {
                                    isOK = false;
                                 }
                              }
                              litePreference.flush();
                           }
                           if(isOK)
                           {
                              showItemDrop(dItem,true);
                           }
                        }
                     }
                     break;
                  case "referralReward":
                     for(dID in resObj.items)
                     {
                        dItem = null;
                        if(world.invTree[dID] == null)
                        {
                           world.invTree[dID] = copyObj(resObj.items[dID]);
                           world.invTree[dID].iQty = 0;
                           dItem = resObj.items[dID];
                        }
                        else
                        {
                           dItem = copyObj(world.invTree[dID]);
                           dItem.iQty = int(resObj.items[dID].iQty);
                        }
                     }
                     dropItem = new DFrameMC(dItem);
                     ui.dropStack.addChild(dropItem);
                     dropItem.init();
                     dropItem.fY = dropItem.y = -(dropItem.fHeight + 8);
                     dropItem.fX = dropItem.x = -(dropItem.fWidth / 2);
                     cleanDropStack();
                     break;
                  case "getDrop":
                     i = 0;
                     while(i < ui.dropStack.numChildren)
                     {
                        mc = ui.dropStack.getChildAt(i) as MovieClip;
                        if(mc.fData != null && mc.fData.ItemID == resObj.ItemID)
                        {
                           if(resObj.bSuccess == 1)
                           {
                              mc.gotoAndPlay("out");
                           }
                           else
                           {
                              modal = new ModalMC();
                              modalO = {};
                              modalO.strBody = "Item could not be added to your inventory! Please make sure your inventory is not full or the item is already present in your inventory/bank.";
                              modalO.params = {};
                              modalO.glow = "red,medium";
                              modalO.btns = "mono";
                              ui.ModalStack.addChild(modal);
                              modal.init(modalO);
                              mc.cnt.ybtn.mouseEnabled = true;
                              mc.cnt.ybtn.mouseChildren = true;
                           }
                        }
                        i++;
                     }
                     if(resObj.bSuccess == 1)
                     {
                        dropitem = copyObj(world.invTree[resObj.ItemID]);
                        dropitem.CharItemID = resObj.CharItemID;
                        dropitem.bBank = resObj.bBank;
                        dropitem.iQty = int(resObj.iQty);
                        if(resObj.EnhID != null)
                        {
                           dropitem.EnhID = int(resObj.EnhID);
                           dropitem.EnhLvl = int(resObj.EnhLvl);
                           dropitem.EnhPatternID = int(resObj.EnhPatternID);
                           dropitem.EnhRty = int(resObj.EnhRty);
                        }
                        world.myAvatar.addItem(dropitem);
                        world.updateQuestProgress("item",dropitem);
                        if(resObj.showDrop == 1)
                        {
                           showItemDrop(dropitem,false);
                        }
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                        }
                        if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshBank"});
                        }
                        if(ui.mcPopup.currentLabel == "HouseShop" || ui.mcPopup.currentLabel == "Shop" || ui.mcPopup.currentLabel == "MergeShop")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType":"refreshItems"});
                        }
                        if(dropitem.sType == "Item")
                        {
                           updateItemSkill();
                        }
                        if(resObj.pendingID != null)
                        {
                           world.myAvatar.updatePending(int(resObj.pendingID));
                        }
                        if(Boolean(cDropsUI) && Boolean(litePreference.data.bCustomDrops))
                        {
                           cDropsUI.acceptDrop(dropitem);
                        }
                     }
                     break;
                  case "addItems":
                     for(ItemID in resObj.items)
                     {
                        if(world.invTree[ItemID] == null)
                        {
                           itemObj = copyObj(resObj.items[ItemID]);
                        }
                        else
                        {
                           itemObj = copyObj(world.invTree[ItemID]);
                           for(iData in resObj.items[ItemID])
                           {
                              if(resObj.items[ItemID][iData] != itemObj[iData])
                              {
                                 itemObj[iData] = resObj.items[ItemID][iData];
                                 if(iData != "iQty")
                                 {
                                    world.invTree[ItemID][iData] = resObj.items[ItemID][iData];
                                 }
                              }
                           }
                        }
                        showItemDrop(itemObj,false);
                        if(Number(itemObj.bTemp) == 0)
                        {
                           world.myAvatar.addItem(itemObj);
                        }
                        else
                        {
                           world.myAvatar.addTempItem(itemObj);
                        }
                        world.updateQuestProgress("item",itemObj);
                        if(itemObj.sMeta == "doUpdate")
                        {
                           try
                           {
                              world.map.doUpdate();
                           }
                           catch(e:*)
                           {
                           }
                        }
                        if(itemObj.sType == "Item")
                        {
                           updateItemSkill();
                        }
                        if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                        }
                        if(ui.mcPopup.currentLabel == "Bank" || ui.mcPopup.currentLabel == "HouseBank")
                        {
                           MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshBank"});
                        }
                     }
                     break;
                  case "Wheel":
                     dropItem = copyObj(resObj.dropItems["18927"]);
                     dropItem.CharItemID = resObj.charItem1;
                     if(world.invTree["18927"] == null)
                     {
                        dropItem.bBank = 0;
                     }
                     dropItem.iQty = resObj.dropQty != null ? Number(resObj.dropQty) : 1;
                     world.myAvatar.addItem(dropItem);
                     dropItem = copyObj(resObj.dropItems["19189"]);
                     dropItem.CharItemID = resObj.charItem2;
                     if(world.invTree["19189"] == null)
                     {
                        dropItem.bBank = 0;
                     }
                     dropItem.iQty = 1;
                     world.myAvatar.addItem(dropItem);
                     if(resObj.Item != null)
                     {
                        dropItem = copyObj(resObj.Item);
                        dropItem.CharItemID = resObj.CharItemID;
                        dropItem.bBank = 0;
                        dropItem.iQty = 1;
                        world.myAvatar.addItem(dropItem);
                     }
                     if(ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                     }
                     try
                     {
                        world.map.doWheelDrop(resObj.Item,resObj.dropQty);
                     }
                     catch(e:*)
                     {
                     }
                  case "powerGem":
                     for(ItemID in resObj.items)
                     {
                        if(world.invTree[ItemID] == null)
                        {
                           itemObj = copyObj(resObj.items[ItemID]);
                        }
                        else
                        {
                           itemObj = copyObj(world.invTree[ItemID]);
                           itemObj.iQty = int(resObj.items[ItemID].iQty);
                        }
                        showItemDrop(itemObj,false);
                        world.myAvatar.addItem(itemObj);
                     }
                     break;
                  case "forceAddItem":
                     for(fi in resObj.items)
                     {
                        iobj = copyObj(resObj.items[fi]);
                        world.myAvatar.addItem(iobj);
                     }
                     break;
                  case "warvalues":
                     world.map.updateWarValues(resObj.wars);
                     break;
                  case "turnIn":
                     if(resObj.sItems != null && resObj.sItems.length >= 3)
                     {
                        itemArr = resObj.sItems.split(",");
                        dropindex = 0;
                        while(dropindex < itemArr.length)
                        {
                           dropID = itemArr[dropindex].split(":")[0];
                           dropQty = int(itemArr[dropindex].split(":")[1]);
                           if(world.invTree[dropID].bTemp == 0)
                           {
                              world.myAvatar.removeItemByID(dropID,dropQty);
                           }
                           else
                           {
                              world.myAvatar.removeTempItem(dropID,dropQty);
                           }
                           dropindex++;
                        }
                     }
                     if(ui.mcPopup.currentLabel == "HouseInventory" || ui.mcPopup.currentLabel == "Inventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
                     }
                     break;
                  case "getQuest":
                     break;
                  case "getQuests":
                     for(qi in resObj.quests)
                     {
                        if(world.questTree[qi] == null)
                        {
                           o = resObj.quests[qi];
                           world.questTree[qi] = o;
                           for(qr in o.oReqd)
                           {
                              if(world.invTree[qr] == null)
                              {
                                 world.invTree[qr] = o.oReqd[qr];
                                 world.invTree[qr].iQty = 0;
                              }
                           }
                           for(qj in o.oItems)
                           {
                              if(world.invTree[qj] == null)
                              {
                                 world.invTree[qj] = o.oItems[qj];
                                 world.invTree[qj].iQty = 0;
                              }
                           }
                           qk = "";
                           qat = ["itemsS","itemsC","itemsR","itemsrand"];
                           i = 0;
                           while(i < qat.length)
                           {
                              s = qat[i];
                              if(o.oRewards[s] != null)
                              {
                                 for(ri in o.oRewards[s])
                                 {
                                    if(isNaN(ri))
                                    {
                                       qk = ri.ItemID;
                                    }
                                    else
                                    {
                                       qk = o.oRewards[s][ri].ItemID;
                                    }
                                    if(world.invTree[qk] == null)
                                    {
                                       world.invTree[qk] = copyObj(o.oRewards[s][ri]);
                                       world.invTree[qk].iQty = 0;
                                    }
                                 }
                              }
                              i++;
                           }
                        }
                     }
                     if(ui.ModalStack.numChildren > 0)
                     {
                        MovieClip(ui.ModalStack.getChildAt(0)).open();
                     }
                     break;
                  case "getQuests2":
                     for(qi in resObj.quests)
                     {
                        if(world.questTree[qi] == null)
                        {
                           o = resObj.quests[qi];
                           world.questTree[qi] = o;
                           for(qr in o.oReqd)
                           {
                              if(world.invTree[qr] == null)
                              {
                                 world.invTree[qr] = o.oReqd[qr];
                                 world.invTree[qr].iQty = 0;
                              }
                           }
                           for(qj in o.oItems)
                           {
                              if(world.invTree[qj] == null)
                              {
                                 world.invTree[qj] = o.oItems[qj];
                                 world.invTree[qj].iQty = 0;
                              }
                           }
                           qk = "";
                           qat = ["itemsS","itemsC","itemsR","itemsrand"];
                           i = 0;
                           while(i < qat.length)
                           {
                              s = qat[i];
                              if(o.oRewards[s] != null)
                              {
                                 for(ri in o.oRewards[s])
                                 {
                                    if(isNaN(ri))
                                    {
                                       qk = ri.ItemID;
                                    }
                                    else
                                    {
                                       qk = o.oRewards[s][ri].ItemID;
                                    }
                                    if(world.invTree[qk] == null)
                                    {
                                       world.invTree[qk] = copyObj(o.oRewards[s][ri]);
                                       world.invTree[qk].iQty = 0;
                                    }
                                 }
                              }
                              i++;
                           }
                        }
                     }
                     createApop();
                     break;
                  case "ccqr":
                     if(resObj.bSuccess == 0)
                     {
                        if(Boolean(resObj.hasOwnProperty("msg")) && resObj.msg != null)
                        {
                           MsgBox.notify("Quest Complete Failed: " + resObj.msg);
                        }
                        else
                        {
                           MsgBox.notify("Quest Complete Failed!");
                        }
                     }
                     else
                     {
                        if("eventTrigger" in MovieClip(world.map))
                        {
                           world.map.eventTrigger({
                              "cmd":"questComplete",
                              "args":resObj.QuestID
                           });
                        }
                        world.completeQuest(resObj.QuestID);
                        if(ui.ModalStack.numChildren)
                        {
                           fgWin = ui.ModalStack.getChildAt(0);
                           if(fgWin != null && fgWin.toString().indexOf("QFrameMC") > -1)
                           {
                              fgWin.turninResult(resObj.QuestID);
                           }
                        }
                        showQuestpopup(resObj);
                        if(apop_ != null)
                        {
                           apop_.questComplete(int(resObj.QuestID));
                        }
                        if(world.rootClass.litePreference.data.bReaccept)
                        {
                           if(world.questTree[resObj.QuestID])
                           {
                              if(world.questTree[resObj.QuestID].hasOwnProperty("bOnce"))
                              {
                                 if(world.questTree[resObj.QuestID].bOnce > 0)
                                 {
                                    break;
                                 }
                              }
                              if(getQuestValidationString(world.questTree[resObj.QuestID]) == "")
                              {
                                 world.acceptQuest(int(resObj.QuestID));
                              }
                           }
                        }
                     }
                     break;
                  case "updateQuest":
                     world.setQuestValue(resObj.iIndex,resObj.iValue);
                     break;
                  case "showQuestLink":
                     world.showQuestLink(resObj);
                     break;
                  case "dailylogin":
                     break;
                  case "initMonData":
                     for(m in resObj.mon)
                     {
                        world.updateMonster(resObj.mon[m]);
                     }
                     break;
                  case "aura+":
                  case "aura*":
                  case "aura-":
                  case "aura--":
                  case "aura++":
                  case "aura+p":
                     world.handleAuraEvent(cmd,resObj);
                     break;
                  case "clearAuras":
                     tAvt = world.myAvatar;
                     tLeaf = tAvt.dataLeaf;
                     world.showAuraChange({
                        "cmd":"aura-",
                        "auras":tLeaf.auras
                     },tAvt,tLeaf);
                     tLeaf.auras = [];
                     break;
                  case "uotls":
                     userTreeWrite(resObj.unm,resObj.o);
                     break;
                  case "mtls":
                     monsterTreeWrite(resObj.id,resObj.o,resObj.targets);
                     break;
                  case "cb":
                     if(resObj.m != null)
                     {
                        for(updateID in resObj.m)
                        {
                           monsterTreeWrite(int(updateID),resObj.m[updateID]);
                        }
                     }
                     if(resObj.p != null)
                     {
                        for(updateID in resObj.p)
                        {
                           userTreeWrite(updateID,resObj.p[updateID]);
                        }
                     }
                     if(resObj.anims != null)
                     {
                        if(sfcSocial)
                        {
                           for each(o in resObj.anims)
                           {
                              if(resObj.isProc)
                              {
                                 doAnim(o,resObj.isProc);
                              }
                              else
                              {
                                 doAnim(o);
                              }
                           }
                        }
                     }
                     if(resObj.a != null)
                     {
                        i = 0;
                        while(i < resObj.a.length)
                        {
                           world.handleAuraEvent(resObj.a[i].cmd,resObj.a[i]);
                           i++;
                        }
                     }
                     break;
                  case "ct":
                     anim = new Object();
                     if(resObj.m != null)
                     {
                        for(updateID in resObj.m)
                        {
                           monsterTreeWrite(int(updateID),resObj.m[updateID]);
                        }
                     }
                     if(resObj.p != null)
                     {
                        for(updateID in resObj.p)
                        {
                           userTreeWrite(updateID,resObj.p[updateID]);
                        }
                     }
                     if(resObj.a != null)
                     {
                        j = 0;
                        while(j < resObj.a.length)
                        {
                           try
                           {
                              k = 0;
                              while(k < resObj.a[j].auras.length)
                              {
                                 if(resObj.a[j].auras[k].spellOn != null)
                                 {
                                    anim[resObj.a[j].auras[k].spellOn] = resObj.a[j].auras[k].dur;
                                 }
                                 k++;
                              }
                           }
                           catch(e:*)
                           {
                           }
                           world.handleAuraEvent(resObj.a[j].cmd,resObj.a[j]);
                           j++;
                        }
                     }
                     if(resObj.sara != null)
                     {
                        for each(o in resObj.sara)
                        {
                           world.handleSAR(o);
                        }
                     }
                     if(resObj.sarsa != null)
                     {
                        for each(o in resObj.sarsa)
                        {
                           world.handleSARS(o);
                        }
                     }
                     if(resObj.anims != null)
                     {
                        if(sfcSocial)
                        {
                           for each(o in resObj.anims)
                           {
                              if(resObj.isProc)
                              {
                                 doAnim(o,resObj.isProc,anim[o.strl]);
                              }
                              else
                              {
                                 doAnim(o,false,anim[o.strl]);
                              }
                           }
                        }
                     }
                     if(resObj.pvp != null)
                     {
                        switch(resObj.pvp.cmd)
                        {
                           case "PVPS":
                              updatePVPScore(resObj.pvp.pvpScore);
                              break;
                           case "PVPC":
                              world.PVPResults.pvpScore = resObj.pvp.pvpScore;
                              world.PVPResults.team = resObj.pvp.team;
                              updatePVPScore(resObj.pvp.pvpScore);
                              togglePVPPanel("results");
                        }
                     }
                     if(Boolean(world.myAvatar.objData.eqp["pe"]) && Boolean(world.rootClass.litePreference.data.bBattlepet))
                     {
                        for each(bpObj in resObj.anims)
                        {
                           if(bpObj.tInf.indexOf("m:") > -1 && bpObj.cInf.indexOf("p:") > -1)
                           {
                              if(world.getAvatarByUserID(Number(bpObj.cInf.split(":")[1])).isMyAvatar)
                              {
                                 if(bpObj.animStr == world.actions.active[0].anim)
                                 {
                                    world.myAvatar.pMC.queueAnim("PetAttack");
                                 }
                              }
                           }
                        }
                     }
                     if(litePreference.data.bAuras)
                     {
                        pAurasUI.handleAura(resObj);
                        tAurasUI.handleAura(resObj);
                     }
                     break;
                  case "sar":
                     world.handleSAR(resObj);
                     break;
                  case "sars":
                     world.handleSARS(resObj);
                     break;
                  case "showAuraResult":
                     world.showAuraImpact(resObj);
                     break;
                  case "anim":
                     if(sfcSocial)
                     {
                        doAnim(resObj);
                     }
                     break;
                  case "sAct":
                     if(isNewClass)
                     {
                        oldActions = null;
                        if(world.actions != null && world.actions.active != null)
                        {
                           for each(actObj in world.actions.active)
                           {
                              if(actObj != null)
                              {
                                 if(actObj.ref == "i1")
                                 {
                                    oldActions = copyObj(actObj);
                                 }
                              }
                           }
                        }
                        world.actions = {};
                        world.actions.active = oldActions != null ? [null,null,null,null,null,oldActions] : [];
                        world.actions.passive = [];
                        world.actionMap = [null,null,null,null,null,world.actionMap[5]];
                        blanki = 0;
                        while(blanki < 5)
                        {
                           ui.mcInterface.actBar.getChildByName("blank" + blanki).visible = true;
                           actBar = ui.mcInterface.actBar;
                           delIcon = actBar.getChildByName("i" + (blanki + 1));
                           if(delIcon != null)
                           {
                              delIcon.removeEventListener(MouseEvent.CLICK,actIconClick);
                              delIcon.removeEventListener(MouseEvent.MOUSE_OVER,actIconOver);
                              delIcon.removeEventListener(MouseEvent.MOUSE_OUT,actIconOut);
                              if(delIcon.icon2 != null)
                              {
                                 delIcon.removeEventListener(Event.ENTER_FRAME,world.countDownAct);
                                 if(delIcon.icon2.mask != null)
                                 {
                                    actBar.removeChild(delIcon.icon2.mask);
                                    delIcon.icon2.mask = null;
                                 }
                                 actBar.removeChild(delIcon.icon2);
                              }
                              actBar.removeChild(delIcon);
                           }
                           ui.mcInterface.actBar.getChildByName("txtCD" + blanki).visible = false;
                           ui.mcInterface.actBar.getChildByName("txtCD" + blanki).mouseEnabled = false;
                           blanki++;
                        }
                     }
                     updateCtr = int(resObj.actions.active.length);
                     if(world.actions.active[5] != null)
                     {
                        updateCtr--;
                        delIcon = ui.mcInterface.actBar.getChildByName("i6");
                        if(delIcon)
                        {
                           if(delIcon.icon2 != null)
                           {
                              delIcon.ts = 0;
                           }
                           delIcon.actObj = world.actions.active[5];
                        }
                        world.actions.active[5].ts = 0;
                        world.lockdownPots = false;
                     }
                     ai = 0;
                     slot = 0;
                     ai = 0;
                     while(ai < updateCtr)
                     {
                        actObj = resObj.actions.active[ai];
                        pseudoAI = actObj.ref == "i1" ? 5 : ai;
                        if(!isNewClass)
                        {
                           isNotUnlocked = ui.mcInterface.actBar.getChildByName("i" + (pseudoAI + 1)).cnt.transform.colorTransform.toString().indexOf("0.09765625") > -1;
                           if(Boolean(resObj.actions.active[pseudoAI].isOK) && isNotUnlocked)
                           {
                              existing = ui.mcInterface.actBar.getChildByName("i" + (pseudoAI + 1));
                              existing.addEventListener(MouseEvent.CLICK,actIconClick,false,0,true);
                              existing.buttonMode = true;
                              existing.cnt.transform.colorTransform = new ColorTransform();
                              world.getActionByRef(world.actionMap[pseudoAI]).isOK = true;
                           }
                        }
                        else
                        {
                           actObj.sArg1 = "";
                           actObj.sArg2 = "";
                           world.actions.active[pseudoAI] = actObj;
                           actObj.ts = 0;
                           actObj.actID = -1;
                           actObj.lock = false;
                           world.actionMap[pseudoAI] = actObj.ref;
                           actIconClass = getDefinitionByName("ib2") as Class;
                           actIcon = new actIconClass();
                           actIconMC = ui.mcInterface.actBar.addChild(actIcon);
                           slot = ai < resObj.actions.active.length - 1 ? ai : 5;
                           blankMC = ui.mcInterface.actBar.getChildByName("blank" + slot);
                           actIconMC.x = blankMC.x;
                           actIconMC.width = 42;
                           actIconMC.height = 39;
                           actIconMC.name = String("i" + (pseudoAI + 1));
                           actIconMC.actionIndex = pseudoAI;
                           actIconMC.actObj = actObj;
                           actIconMC.icon2 = null;
                           actIconMC.tQty.visible = false;
                           actIconMC.y -= 6;
                           updateIcons([actIconMC],actObj.icon.split(","),null);
                           blankMC.visible = false;
                           actIconMC.addEventListener(MouseEvent.MOUSE_OVER,actIconOver,false,0,true);
                           actIconMC.addEventListener(MouseEvent.MOUSE_OUT,actIconOut,false,0,true);
                           actIconMC.mouseChildren = false;
                           if(actObj.auto != null && actObj.auto == true)
                           {
                              world.actions.auto = world.actions.active[pseudoAI];
                           }
                           else
                           {
                              world.actions.active[pseudoAI].auto = false;
                           }
                           if(actObj.isOK)
                           {
                              actIconMC.addEventListener(MouseEvent.CLICK,actIconClick,false,0,true);
                              actIconMC.buttonMode = true;
                           }
                           else
                           {
                              c = new Color();
                              c.setTint(3355443,0.9);
                              actIconMC.cnt.transform.colorTransform = c;
                           }
                        }
                        ai++;
                     }
                     world.myAvatar.dataLeaf.passives = [];
                     if(resObj.actions.passive != null)
                     {
                        ai = 0;
                        while(ai < resObj.actions.passive.length)
                        {
                           actObj = copyObj(resObj.actions.passive[ai]);
                           actObj.sArg1 = "";
                           actObj.sArg2 = "";
                           world.actions.passive.push(actObj);
                           if(actObj.auras != null)
                           {
                              i = 0;
                              while(i < actObj.auras.length)
                              {
                                 world.myAvatar.dataLeaf.passives.push(actObj.auras[i]);
                                 i++;
                              }
                           }
                           ai++;
                        }
                     }
                     if(litePreference.data.bAuras)
                     {
                        pAurasUI.classChanged();
                        tAurasUI.classChanged();
                     }
                     isNewClass = false;
                     break;
                  case "seia":
                     if(resObj.iRes == 1)
                     {
                        ai = 0;
                        while(ai < world.actions.active.length)
                        {
                           o = world.actions.active[ai];
                           if(o)
                           {
                              if(o.ref == "i1")
                              {
                                 if("tgtMax" in o)
                                 {
                                    delete o.tgtMax;
                                 }
                                 if("tgtMin" in o)
                                 {
                                    delete o.tgtMin;
                                 }
                                 if("auras" in o)
                                 {
                                    delete o.auras;
                                 }
                                 if(!world.actionTimeCheck(o,true))
                                 {
                                    if(o.OldCD == null)
                                    {
                                       o.OldCD = o.cd;
                                    }
                                 }
                                 else if(world.actionTimeCheck(o,true))
                                 {
                                    o.ts = 0;
                                 }
                                 for(s in resObj.o)
                                 {
                                    if(s != "nam" && s != "ref" && s != "desc" && s != "typ")
                                    {
                                       o[s] = resObj.o[s];
                                    }
                                 }
                                 world.lockdownPots = false;
                              }
                           }
                           ai++;
                        }
                     }
                     if(equipPotionOnSeia)
                     {
                        world.testAction(world.getActionByRef(world.actionMap[5]));
                        equipPotionOnSeia = false;
                     }
                     break;
                  case "stu":
                     avt = world.myAvatar;
                     unm = sfc.myUserName;
                     uoLeaf = world.uoTreeLeaf(unm);
                     if(resObj.wDPS != null)
                     {
                        uoLeaf.wDPS = resObj.wDPS;
                     }
                     if(resObj.mDPS != null)
                     {
                        uoLeaf.mDPS = resObj.mDPS;
                     }
                     if(uoLeaf.sta == null)
                     {
                        uoLeaf.sta = {};
                     }
                     for(stuS in resObj.sta)
                     {
                        uoLeaf.sta[stuS] = resObj.sta[stuS];
                        if(stats.indexOf(stuS.substr(1)) > -1)
                        {
                           uoLeaf.sta[stuS] = int(uoLeaf.sta[stuS]);
                        }
                        else
                        {
                           uoLeaf.sta[stuS] = Number(uoLeaf.sta[stuS]);
                        }
                        if(stuS.toLowerCase().indexOf("$tha") > -1)
                        {
                           actObj = world.getAutoAttack();
                           if(actObj != null && uoLeaf != null && uoLeaf.sta != null)
                           {
                              cd = Math.round(actObj.cd * (1 - Math.min(Math.max(uoLeaf.sta.$tha,-1),0.5)));
                              if(world.autoActionTimer.running)
                              {
                                 world.autoActionTimer.delay -= world.autoActionTimer.delay - cd;
                                 world.autoActionTimer.delay += 100;
                                 world.autoActionTimer.reset();
                                 world.autoActionTimer.start();
                              }
                              else
                              {
                                 world.autoActionTimer.delay = cd;
                              }
                           }
                           hasteCoeff = 1 - Math.min(Math.max(uoLeaf.sta.$tha,-1),0.5);
                           world.GCD = Math.round(hasteCoeff * world.GCDO);
                           for each(actObj in world.actions.active)
                           {
                              if(actObj != null)
                              {
                                 if(actObj.isOK && world.getActIcons(actObj)[0] != null && world.getActIcons(actObj)[0].icon2 == null && now - actObj.ts < actObj.cd * hasteCoeff)
                                 {
                                    world.coolDownAct(actObj,actObj.cd * hasteCoeff - (now - actObj.ts),now);
                                 }
                              }
                           }
                        }
                        if(stuS.toLowerCase().indexOf("$cmc") > -1)
                        {
                           world.updateActBar();
                        }
                     }
                     if(resObj.tempSta != null)
                     {
                        uoLeaf.tempSta = resObj.tempSta;
                        if("updatePStats" in world.map)
                        {
                           world.map.updatePStats();
                        }
                     }
                     if(avt != null)
                     {
                        world.updatePortrait(avt);
                     }
                     if(statsNewClass)
                     {
                        baseClassStats = new Object();
                        for(stu in resObj.sta)
                        {
                           baseClassStats[stu] = resObj.sta[stu];
                        }
                        if(mcStatsPanel)
                        {
                           mcStatsPanel.updateBase();
                        }
                        statsNewClass = false;
                     }
                     if(mcStatsPanel)
                     {
                        mcStatsPanel.update();
                     }
                     break;
                  case "event":
                     world.map.eventTrigger(resObj);
                     break;
                  case "modinfo":
                     world.map.showModInfo(resObj);
                     break;
                  case "modinc":
                     if(resObj.bSuccess)
                     {
                        world.map.hideLoading();
                        world.map.show(resObj.events);
                        world.modID = int(resObj.mID);
                     }
                     else
                     {
                        chatF.pushMsg("warning",resObj.msg,"SERVER","",0);
                     }
                     break;
                  case "ia":
                     if("iaPathMC" in resObj)
                     {
                        try
                        {
                           mc = world;
                           mcPath = resObj.iaPathMC.split(".");
                           while(mcPath.length > 0)
                           {
                              s = String(mcPath.shift());
                              if(mc.getChildByName(s) != null)
                              {
                                 mc = mc.getChildByName(s) as MovieClip;
                              }
                              else
                              {
                                 mc = mc[s];
                              }
                           }
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     else if(resObj.str != null)
                     {
                        avt = world.getAvatarByUserID(int(resObj.str));
                        if(avt != null)
                        {
                           mc = avt.pMC;
                        }
                     }
                     else
                     {
                        mc = MovieClip(world.CHARS.getChildByName(resObj.oName));
                     }
                     if(mc != null && mc != world)
                     {
                        try
                        {
                           switch(resObj.typ)
                           {
                              case "rval":
                                 mc.userName = resObj.unm;
                                 mc.iaF(resObj);
                                 break;
                              case "str":
                                 if(resObj.str == null)
                                 {
                                    mc.userName = resObj.unm;
                                 }
                                 mc.iaF(resObj);
                                 break;
                              case "flourish":
                                 mc.userName = resObj.unm;
                                 mc.gotoAndPlay(resObj.oFrame);
                           }
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     break;
                  case "siau":
                     world.updateCellMap(resObj);
                     break;
                  case "umsg":
                     addUpdate(resObj.s);
                     break;
                  case "gi":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = resObj.owner + " has invited you to join the guild " + resObj.gName + ". Do you accept?";
                     modalO.callback = world.doGuildAccept;
                     modalO.params = {
                        "guildID":resObj.guildID,
                        "owner":resObj.owner
                     };
                     modalO.btns = "dual";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     chatF.pushMsg("server",resObj.owner + " has invited you to join the guild " + resObj.gName,"SERVER","",0);
                     break;
                  case "gd":
                     chatF.pushMsg("server",resObj.unm + " has declined your invitation.","SERVER","",0);
                     break;
                  case "ga":
                     avt = world.getAvatarByUserName(resObj.unm);
                     if(avt != null)
                     {
                        avt.updateGuild(resObj.guild);
                        if(avt.isMyAvatar)
                        {
                           chatF.chn.guild.act = 1;
                           chatF.pushMsg("server","You have joined the guild.","SERVER","",0);
                        }
                        else if(world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                        {
                           chatF.pushMsg("server",avt.pnm + " has joined the guild.","SERVER","",0);
                           world.myAvatar.updateGuild(resObj.guild);
                        }
                     }
                     else if(resObj.guild.Name == world.myAvatar.objData.guild.Name)
                     {
                        chatF.pushMsg("server",resObj.unm + " has joined the guild.","SERVER","",0);
                        world.myAvatar.updateGuild(resObj.guild);
                     }
                     break;
                  case "gr":
                     avt = world.getAvatarByUserName(resObj.unm);
                     if(avt != null)
                     {
                        avt.updateGuild(null);
                        if(avt.isMyAvatar)
                        {
                           chatF.chn.guild.act = 0;
                           chatF.pushMsg("server","You have been removed from the guild.","SERVER","",0);
                        }
                        else if(world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                        {
                           chatF.pushMsg("server",avt.pnm + " has been removed from the guild.","SERVER","",0);
                           world.myAvatar.updateGuild(resObj.guild);
                        }
                     }
                     if(world.myAvatar.objData.guild != null)
                     {
                        if(world.myAvatar.objData.guild.Name == resObj.guild.Name)
                        {
                           chatF.pushMsg("server",resObj.unm + " has been removed from the guild.","SERVER","",0);
                           world.myAvatar.updateGuild(resObj.guild);
                        }
                     }
                     break;
                  case "guildDelete":
                     avt = world.getAvatarByUserName(resObj.unm);
                     if(avt != null)
                     {
                        avt.updateGuild(null);
                        if(avt.isMyAvatar)
                        {
                           chatF.pushMsg("server",resObj.msg,"SERVER","",0);
                        }
                     }
                     break;
                  case "gMOTD":
                     world.myAvatar.objData.guild.MOTD = resObj.MOTD[0];
                     break;
                  case "updateGuild":
                     try
                     {
                        if(world.myAvatar.objData != null)
                        {
                           world.myAvatar.updateGuild(resObj.guild);
                        }
                     }
                     catch(e:*)
                     {
                     }
                     if(resObj.msg != null)
                     {
                        chatF.pushMsg("server",resObj.msg,"SERVER","",0);
                     }
                     break;
                  case "gc":
                     avt = world.getAvatarByUserID(resObj.uid);
                     avt.initGuild(resObj.guild);
                     break;
                  case "interior":
                  case "guildhall":
                  case "guildinv":
                     break;
                  case "pi":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = resObj.owner + " has invited you to join their group.  Do you accept?";
                     modalO.callback = world.doPartyAccept;
                     modalO.params = {"pid":resObj.pid};
                     modalO.btns = "dual";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     chatF.pushMsg("server",resObj.owner + " has invited you to a group.","SERVER","",0);
                     break;
                  case "pa":
                     if(world.partyOwner == "")
                     {
                        world.partyOwner = resObj.owner;
                     }
                     supressMupltiples = false;
                     if(world.partyID == -1)
                     {
                        world.partyID = resObj.pid;
                        chatF.chn.party.act = 1;
                        if(resObj.owner.toLowerCase() != sfc.myUserName)
                        {
                           chatF.pushMsg("server","You have joined the party.","SERVER","",0);
                           supressMupltiples = true;
                        }
                     }
                     i = 0;
                     while(i < resObj.ul.length)
                     {
                        unm = resObj.ul[i];
                        if(unm.toLowerCase() != sfc.myUserName)
                        {
                           world.addPartyMember(unm);
                           if(!supressMupltiples)
                           {
                              chatF.pushMsg("server",unm + " has joined the party.","SERVER","",0);
                           }
                        }
                        i++;
                     }
                     break;
                  case "pr":
                     isYou = false;
                     nam = world.partyOwner;
                     world.partyOwner = resObj.owner;
                     if(nam != world.partyOwner)
                     {
                        chatF.pushMsg("server",world.partyOwner + " is now the party leader.","SERVER","",0);
                     }
                     if(resObj.unm.toLowerCase() == sfc.myUserName.toLowerCase())
                     {
                        isYou = true;
                        chatF.chn.party.act = 0;
                     }
                     if(resObj.typ == "k")
                     {
                        if(isYou)
                        {
                           chatF.pushMsg("server","You have been removed from the party","SERVER","",0);
                        }
                        else
                        {
                           chatF.pushMsg("server",resObj.unm + " has been removed from the party","SERVER","",0);
                        }
                     }
                     else if(resObj.typ == "l")
                     {
                        if(isYou)
                        {
                           chatF.pushMsg("server","You have left the party","SERVER","",0);
                        }
                        else
                        {
                           chatF.pushMsg("server",resObj.unm + " has left the party","SERVER","",0);
                        }
                     }
                     world.removePartyMember(String(resObj.unm).toLowerCase());
                     break;
                  case "pp":
                     nam = world.partyOwner;
                     world.partyOwner = resObj.owner;
                     if(nam != world.partyOwner)
                     {
                        chatF.pushMsg("server",world.partyOwner + " is now the party leader.","SERVER","",0);
                     }
                     world.updatePartyFrame();
                     break;
                  case "ps":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = resObj.unm + " wants to summon you to them.  Do you accept?";
                     modalO.callback = world.acceptPartySummon;
                     modalO.params = resObj;
                     modalO.btns = "dual";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     chatF.pushMsg("server",resObj.unm + " is trying to summon you to them.","SERVER","",0);
                     break;
                  case "pd":
                     chatF.pushMsg("server",resObj.unm + " has declined your invitation.","SERVER","",0);
                     break;
                  case "pc":
                     if(world.partyID > -1)
                     {
                        chatF.pushMsg("server","Your party has been disbanded","SERVER","",0);
                     }
                     world.partyID = -1;
                     world.partyOwner = "";
                     world.partyMembers = [];
                     world.updatePartyFrame();
                     chatF.chn.party.act = 0;
                     if(chatF.chn.cur == chatF.chn.party)
                     {
                        chatF.chn.cur = chatF.chn.zone;
                     }
                     if(chatF.chn.lastPublic == chatF.chn.party)
                     {
                        chatF.chn.lastPublic = chatF.chn.zone;
                     }
                     break;
                  case "PVPQ":
                     world.handlePVPQueue(resObj);
                     break;
                  case "PVPI":
                     world.receivePVPInvite(resObj);
                     break;
                  case "PVPE":
                     relayPVPEvent(resObj);
                     break;
                  case "PVPS":
                     updatePVPScore(resObj.pvpScore);
                     break;
                  case "PVPC":
                     world.PVPResults.pvpScore = resObj.pvpScore;
                     world.PVPResults.team = resObj.team;
                     updatePVPScore(resObj.pvpScore);
                     togglePVPPanel("results");
                     break;
                  case "pvpbreakdown":
                     break;
                  case "di":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = resObj.owner + " has challenged you to a duel.  Do you accept?";
                     modalO.callback = world.doDuelAccept;
                     modalO.params = {"unm":resObj.owner};
                     modalO.btns = "dual";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     chatF.pushMsg("server",resObj.owner + " has challenged you to a duel.","SERVER","",0);
                     break;
                  case "DuelEX":
                     world.duelExpire();
                     break;
                  case "loadFactions":
                     world.myAvatar.initFactions(resObj.factions);
                     break;
                  case "addFaction":
                     world.myAvatar.addFaction(resObj.faction);
                     break;
                  case "loadFriendsList":
                     world.myAvatar.initFriendsList(resObj.friends);
                     break;
                  case "requestFriend":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.strBody = resObj.unm + " has invited you to be friends. Do you accept?";
                     modalO.callback = world.addFriend;
                     modalO.params = {
                        "ID":resObj.ID,
                        "unm":resObj.unm
                     };
                     modalO.btns = "dual";
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     chatF.pushMsg("server",resObj.unm + " has invited you to be friends.","SERVER","",0);
                     break;
                  case "addFriend":
                     world.myAvatar.addFriend(resObj.friend);
                     break;
                  case "updateFriend":
                     world.myAvatar.updateFriend(resObj.friend);
                     break;
                  case "deleteFriend":
                     world.myAvatar.deleteFriend(resObj.ID);
                     break;
                  case "isModerator":
                     modal = null;
                     modalO = null;
                     modal = new ModalMC();
                     modalO = {};
                     modalO.btns = "mono";
                     if(resObj.val)
                     {
                        modalO.strBody = resObj.unm + " is staff!";
                        modalO.glow = "gold,medium";
                        chatF.pushMsg("server",resObj.unm + " is staff!","SERVER","",0);
                     }
                     else
                     {
                        modalO.strBody = resObj.unm + " is NOT staff!";
                        modalO.glow = "red,medium";
                        chatF.pushMsg("warning",resObj.unm + " is NOT staff!","SERVER","",0);
                     }
                     ui.ModalStack.addChild(modal);
                     modal.init(modalO);
                     break;
                  case "loadWarVars":
                     world.objResponse["loadWarVars"] = resObj;
                     world.dispatchEvent(new Event("loadWarVars"));
                     break;
                  case "setAchievement":
                     world.updateAchievement(resObj.field,resObj.index,resObj.value);
                     break;
                  case "loadQuestStringData":
                     world.objQuestString = resObj.obj;
                     world.dispatchEvent(new Event("QuestStringData_Complete"));
                     break;
                  case "getAdData":
                     if(resObj.bSuccess == 1)
                     {
                        world.adData = resObj.bh;
                        world.dispatchEvent(new Event("getAdData"));
                     }
                     break;
                  case "getAdReward":
                     world.myAvatar.objData.iDailyAds += 1;
                     world.adData = null;
                     if(world.myAvatar.objData.iDailyAds < world.myAvatar.objData.iDailyAdCap)
                     {
                        world.sendGetAdDataRequest();
                     }
                     world.myAvatar.objData.intGold += int(resObj.iGold);
                     ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                     if(ui.mcPopup.currentLabel == "HouseInventory" || ui.mcPopup.currentLabel == "Inventory")
                     {
                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshCoins"});
                     }
                     world.myAvatar.objData.intCoins += int(resObj.iCoins);
                     sMsg = "Congratulations! You just received <font color=\'#FFCC00\'><b>" + resObj.iGold + " Gold</b></font>";
                     if(resObj.iCoins > 0)
                     {
                        sMsg += " and <font color=\'#990099\'><b>" + resObj.iCoins + " Adventure Coins</b></font>";
                     }
                     sMsg += " from Ballyhoo.";
                     showMessageBox(sMsg);
                     break;
                  case "xpboost":
                     manageXPBoost(resObj);
                     break;
                  case "gboost":
                     manageGBoost(resObj);
                     break;
                  case "repboost":
                     manageRepBoost(resObj);
                     break;
                  case "cpboost":
                     manageCPBoost(resObj);
                     break;
                  case "gettimes":
                     a = [];
                     for(s in resObj.o)
                     {
                        o = resObj.o[s];
                        o.s = s;
                        a.push(o);
                     }
                     a.sortOn("t",Array.NUMERIC | Array.DESCENDING);
                     i = 0;
                     while(i < a.length)
                     {
                        o = a[i];
                        i++;
                     }
                     break;
                  case "clockTick":
                     if("eventTrigger" in MovieClip(world.map))
                     {
                        world.map.eventTrigger(resObj);
                     }
                     break;
                  case "castWait":
                     try
                     {
                        world.map.fishGame.castingWait(resObj.wait,resObj.derp);
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "CatchResult":
                     world.myAvatar.addRep(20,resObj.catchResult.myRep);
                     try
                     {
                        world.map.fishGame.showCatch(resObj);
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "alchOnStart":
                     world.map.alchemyGame.onStart(resObj);
                     break;
                  case "alchComplete":
                     world.map.alchemyGame.checkComplete(resObj);
                     break;
                  case "spellOnStart":
                     world.map.mcGame.spellOnStart(resObj);
                     break;
                  case "spellComplete":
                     world.map.mcGame.spellComplete(resObj);
                     break;
                  case "spellWaitTimer":
                     world.map.mcGame.spellWaitTimer(resObj);
                     break;
                  case "playerDeath":
                     if("eventTrigger" in MovieClip(world.map))
                     {
                        world.map.eventTrigger(resObj);
                     }
                     break;
                  case "getScrolls":
                     try
                     {
                        world.scrollData = resObj.scrolls;
                        world.map.initScrollData();
                     }
                     catch(e:*)
                     {
                     }
                     break;
                  case "turninscroll":
                     if(resObj.IDs != null)
                     {
                        i = 0;
                        while(i < resObj.IDs.length)
                        {
                           world.myAvatar.updateScrolls(int(resObj.IDs[i]));
                           i++;
                        }
                        s = "";
                        i = 0;
                        while(i < 500)
                        {
                           s += String.fromCharCode(0);
                           i++;
                        }
                        world.myAvatar.objData.pending = s;
                        try
                        {
                           world.map.displayTurnins(resObj.IDs);
                        }
                        catch(e:*)
                        {
                        }
                     }
                     break;
                  case "getapop":
                     if(resObj.apopData != null)
                     {
                        apopTree[String(resObj.apopData.apopID)] = resObj.apopData;
                        if(!resObj.bQuests)
                        {
                           createApop();
                        }
                     }
               }
            }
            try
            {
               if(world.map.Events != null)
               {
                  if(world.map.Events[cmd] != null)
                  {
                     world.map.responseEvent(cmd,resObj);
                  }
               }
            }
            catch(e:*)
            {
            }
         };
         addFrameScript(0,frame1,11,frame12,12,frame13,21,frame22,31,frame32,42,frame43);
         Security.allowDomain("*.aq.com");
         this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
         sfc = new SmartFoxClient();
         sfc.debug = true;
         sfc.smartConnect = false;
         sfc.addEventListener(SFSEvent.onConnection,onConnectionHandler);
         sfc.addEventListener(SFSEvent.onConnectionLost,onConnectionLostHandler);
         sfc.addEventListener(SFSEvent.onLogin,onLoginHandler);
         sfc.addEventListener(SFSEvent.onLogout,onLogoutHandler);
         sfc.addEventListener(SFSEvent.onObjectReceived,onObjectReceivedHandler);
         sfc.addEventListener(SFSEvent.onRoundTripResponse,onRoundTripResponseHandler);
         sfc.addEventListener(SFSEvent.onExtensionResponse,onExtensionResponseHandler);
         classCatMap.M1.ratios = [0.27,0.3,0.22,0.05,0.1,0.06];
         classCatMap.M2.ratios = [0.2,0.22,0.33,0.05,0.1,0.1];
         classCatMap.M3.ratios = [0.24,0.2,0.2,0.24,0.07,0.05];
         classCatMap.M4.ratios = [0.3,0.18,0.3,0.02,0.06,0.14];
         classCatMap.C1.ratios = [0.06,0.2,0.11,0.33,0.15,0.15];
         classCatMap.C2.ratios = [0.08,0.27,0.1,0.3,0.1,0.15];
         classCatMap.C3.ratios = [0.06,0.23,0.05,0.28,0.28,0.1];
         classCatMap.S1.ratios = [0.22,0.18,0.21,0.08,0.08,0.23];
         userPreference = SharedObject.getLocal("AQWUserPref","/");
         litePreference = SharedObject.getLocal("AQLite_Data","/");
         inituoPref();
         initlitePref();
         initKeybindPref();
         if(userPreference.data.quality == null)
         {
            userPreference.data.quality = "AUTO";
         }
         initArrRep();
         if(litePreference.data.bChatUI)
         {
            chatF = new Chat2(this);
            intChatMode = 1;
         }
         else
         {
            chatF = new Chat();
            chatF.rootClass = this;
            intChatMode = 0;
         }
      }
      
      public static function gTrace(param1:*) : *
      {
         if(Game.ISWEB)
         {
            if(!ExternalInterface.available)
            {
               return;
            }
            ExternalInterface.call("console.log",param1);
         }
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.replace(/^\s+|\s+$/g,"");
      }
      
      public static function XMLtoObject(param1:XML) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:* = {};
         for(_loc3_ in param1.attributes())
         {
            _loc2_[String(param1.attributes()[_loc3_].name())] = String(param1.attributes()[_loc3_]);
         }
         for(_loc4_ in param1.children())
         {
            _loc5_ = param1.children()[_loc4_].name();
            if(_loc2_[_loc5_] == undefined)
            {
               _loc2_[_loc5_] = [];
            }
            _loc2_[_loc5_].push(XMLtoObject(param1.children()[_loc4_]));
         }
         return _loc2_;
      }
      
      public static function convertXMLtoObject(param1:XML) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:XML = null;
         var _loc6_:* = undefined;
         var _loc2_:* = {};
         for(_loc3_ in param1.attributes())
         {
            _loc2_[String(param1.attributes()[_loc3_].name())] = String(param1.attributes()[_loc3_]);
         }
         for(_loc4_ in param1.children())
         {
            _loc5_ = param1.children()[_loc4_];
            if(_loc5_.nodeKind() == "text")
            {
               if(_loc5_ == parseFloat(_loc5_).toString())
               {
                  return parseFloat(_loc5_);
               }
               return _loc5_;
            }
            if(_loc5_.nodeKind() == "element")
            {
               _loc6_ = param1.children()[_loc4_].name();
               if(_loc2_[_loc6_] == null)
               {
                  _loc2_[_loc6_] = convertXMLtoObject(param1.children()[_loc4_]);
               }
               else
               {
                  if(!(_loc2_[_loc6_] is Array))
                  {
                     _loc2_[_loc6_] = [_loc2_[_loc6_]];
                  }
                  _loc2_[_loc6_].push(convertXMLtoObject(param1.children()[_loc4_]));
               }
            }
         }
         return _loc2_;
      }
      
      private static function makeGrayscale(param1:DisplayObject, param2:int = 0, param3:Number = 0.33) : void
      {
         var _loc6_:Color = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:Array = [param3,param3,param3,0,0,param3,param3,param3,0,0,param3,param3,param3,0,0,param3,param3,param3,1,0];
         var _loc5_:ColorMatrixFilter = new ColorMatrixFilter(_loc4_);
         param1.filters = [_loc5_];
         if(param2 != 0)
         {
            _loc6_ = new Color();
            _loc6_.brightness = -(param2 / 100);
            param1.transform.colorTransform = _loc6_;
         }
      }
      
      public function loadAccountCreation(param1:String) : *
      {
         mcAccount.removeChildAt(0);
         var _loc2_:Loader = new Loader();
         _loc2_.load(new URLRequest(Game.serverFilePath + param1),new LoaderContext(false,new ApplicationDomain(null)));
         mcAccount.addChild(_loc2_);
      }
      
      public function onCSComplete(param1:Event) : void
      {
         mcCharSelect = param1.currentTarget.content;
         this.addChildAt(mcCharSelect,1);
         csLoader.removeEventListener(Event.COMPLETE,onCSComplete);
         csLoader.removeEventListener(ProgressEvent.PROGRESS,onCSProgress);
         csLoader.removeEventListener(IOErrorEvent.IO_ERROR,onCSError);
      }
      
      public function onCSProgress(param1:ProgressEvent) : void
      {
         csbLoaded = param1.bytesLoaded;
         csbTotal = param1.bytesTotal;
         var _loc2_:int = csbLoaded / csbTotal * 100;
         var _loc3_:Number = csbLoaded / csbTotal;
         loader.mcPct.text = _loc2_ + "%";
         if(csbLoaded >= csbTotal)
         {
            loader.parent.removeChild(loader);
            loader = null;
         }
      }
      
      public function onCSError(param1:IOErrorEvent) : void
      {
         if(loader)
         {
            loader.parent.removeChild(loader);
            loader = null;
         }
         gotoAndPlay("Login");
      }
      
      public function monsterTreeWrite(param1:int, param2:Object, param3:* = null) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:Avatar = null;
         var _loc9_:Avatar = null;
         var _loc10_:Avatar = null;
         var _loc11_:Avatar = null;
         var _loc12_:MovieClip = null;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         var _loc18_:int = 0;
         var _loc19_:String = null;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc4_:int = 0;
         var _loc13_:String = "";
         var _loc14_:Object = {};
         var _loc15_:Object = world.monTree[param1];
         if(_loc15_ != null)
         {
            _loc16_ = -1;
            if(_loc15_ != null && _loc15_.intState != null)
            {
               _loc16_ = int(_loc15_.intState);
            }
            for(_loc17_ in param2)
            {
               _loc6_ = _loc17_;
               _loc7_ = param2[_loc17_];
               _loc14_[_loc6_] = _loc7_;
               if(_loc6_.toLowerCase().indexOf("int") > -1)
               {
                  _loc7_ = Number(_loc7_);
               }
               if(_loc6_ == "react")
               {
                  _loc7_ = _loc7_.split(",");
                  _loc18_ = 0;
                  while(_loc18_ < _loc7_.length)
                  {
                     _loc7_[_loc18_] = Number(_loc7_[_loc18_]);
                     _loc18_++;
                  }
               }
               _loc15_[_loc6_] = _loc7_;
            }
            _loc13_ = "";
            for(_loc13_ in _loc14_)
            {
               _loc6_ = _loc13_;
               _loc7_ = _loc14_[_loc13_];
               if(_loc6_.toLowerCase().indexOf("evt:") < 0)
               {
                  _loc10_ = world.getMonster(param1);
                  if(_loc10_ != null)
                  {
                     if(_loc6_.toLowerCase().indexOf("hp") > -1)
                     {
                        if(_loc10_ != null && _loc10_.objData != null)
                        {
                           _loc7_ = Number(_loc7_);
                           _loc10_.objData[_loc13_] = _loc7_;
                           if(world.myAvatar.target == _loc10_)
                           {
                              world.updatePortrait(_loc10_);
                           }
                           if(world.objLock != null && (_loc6_ == "intHP" && _loc7_ <= 0))
                           {
                              ++world.intKillCount;
                              world.updatePadNames();
                           }
                           if(_loc10_.objData != null && Boolean("boolean"))
                           {
                              if(_loc10_.objData.strFrame == world.strFrame)
                              {
                                 if(_loc7_ <= 0)
                                 {
                                    if(Boolean(bAnalyzer) && (param3 || _loc14_["targets"].length > 0))
                                    {
                                       if(Boolean(bAnalyzer.isRunning))
                                       {
                                          for each(_loc19_ in param3 ? param3 : _loc14_["targets"])
                                          {
                                             if(world.myAvatar.objData.strUsername.toLowerCase() == _loc19_.toLowerCase())
                                             {
                                                bAnalyzer.addKill();
                                             }
                                          }
                                       }
                                    }
                                    if(litePreference.data.bDisSelfMAnim && world.myAvatar.target != null && world.myAvatar.target.dataLeaf.intState == 0)
                                    {
                                       world.cancelTarget();
                                    }
                                    _loc10_.pMC.stopWalking();
                                    world.removeAuraFX(_loc10_.pMC,"all");
                                    _loc10_.pMC.die();
                                    _loc15_.auras = [];
                                    _loc15_.targets = {};
                                    _loc10_.target = null;
                                    if("eventTrigger" in MovieClip(world.map))
                                    {
                                       world.map.eventTrigger({
                                          "cmd":"monDeath",
                                          "args":param1,
                                          "targets":param2.targets
                                       });
                                    }
                                    if(world.myAvatar.dataLeaf.targets[_loc10_.objData.MonMapID] != null)
                                    {
                                       delete world.myAvatar.dataLeaf.targets[_loc10_.objData.MonMapID];
                                    }
                                    if(world.strMapName == "trickortreat" && world.strFrame == "Enter")
                                    {
                                       world.TrickOrTreatMonsterDead = true;
                                       world.loadPlayerNPC();
                                    }
                                    if(world.strMapName == "caroling" && world.strFrame == "Enter")
                                    {
                                       world.CarolingMonsterKillCount += 1;
                                       if(world.CarolingMonsterKillCount >= 5)
                                       {
                                          world.setTarget(null);
                                          world.loadPlayerNPC();
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                     if(_loc6_.toLowerCase().indexOf("state") > -1)
                     {
                        if(_loc10_ != null && _loc10_.objData != null)
                        {
                           _loc7_ = Number(_loc7_);
                           _loc10_.objData[_loc13_] = _loc7_;
                           if(_loc7_ != 2)
                           {
                              _loc10_.dataLeaf.auras = [];
                           }
                           if(_loc10_.objData.strFrame != null && _loc10_.objData.strFrame == world.strFrame)
                           {
                              if(_loc7_ == 1 && _loc10_.pMC != null && (_loc10_.pMC.x != _loc10_.pMC.ox || _loc10_.pMC.y != _loc10_.pMC.oy))
                              {
                                 _loc10_.pMC.walkTo(_loc10_.pMC.ox,_loc10_.pMC.oy,world.WALKSPEED);
                              }
                           }
                           if(_loc7_ != 2)
                           {
                              _loc15_.targets = {};
                           }
                        }
                     }
                     if(_loc6_.toLowerCase().indexOf("dx") > -1)
                     {
                        _loc7_ = Number(_loc7_);
                        if(_loc10_.objData != null && _loc10_.objData.strFrame != null && _loc10_.objData.strFrame == world.strFrame)
                        {
                           _loc20_ = int(world.monTree[param1].dx);
                           _loc21_ = int(world.monTree[param1].dy);
                           _loc10_.pMC.walkTo(_loc20_,_loc21_,world.WALKSPEED);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function userTreeWrite(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:Avatar = null;
         var _loc8_:Avatar = null;
         var _loc9_:Avatar = null;
         var _loc10_:Avatar = null;
         var _loc11_:MovieClip = null;
         var _loc16_:String = null;
         var _loc17_:int = 0;
         var _loc3_:int = 0;
         var _loc12_:String = "";
         var _loc13_:Object = {};
         var _loc14_:Object = {};
         var _loc15_:Object = world.uoTree[param1.toLowerCase()];
         _loc10_ = world.getAvatarByUserName(param1);
         for(_loc16_ in param2)
         {
            _loc5_ = _loc16_;
            _loc6_ = param2[_loc16_];
            if(_loc5_.toLowerCase().indexOf("int") > -1 || _loc5_.toLowerCase() == "tx" || _loc5_.toLowerCase() == "ty" || _loc5_.toLowerCase() == "sp" || _loc5_.toLowerCase() == "pvpTeam")
            {
               _loc6_ = int(_loc6_);
            }
            if(sfcSocial && _loc15_ != null && world.myAvatar.dataLeaf != null && _loc5_.toLowerCase() == "inthp" && param1.toLowerCase() != sfc.myUserName && _loc15_.strFrame == world.myAvatar.dataLeaf.strFrame && (!world.bPvP || _loc15_.pvpTeam == world.myAvatar.dataLeaf.pvpTeam) && _loc6_ > 0 && world.getFirstHeal() != null)
            {
               if(_loc6_ <= _loc15_.intHP && (_loc15_.intHP - _loc6_ >= _loc15_.intHPMax * 0.15 || _loc6_ <= _loc15_.intHPMax * 0.5))
               {
                  try
                  {
                     _loc10_.pMC.showHealIcon();
                  }
                  catch(e:Error)
                  {
                  }
               }
               if(_loc6_ > Math.round(_loc15_.intHPMax * 0.5))
               {
                  try
                  {
                     if(_loc10_.pMC.getChildByName("HealIconMC") != null)
                     {
                        MovieClip(_loc10_.pMC.getChildByName("HealIconMC")).fClose();
                     }
                  }
                  catch(e:Error)
                  {
                  }
               }
            }
            if(_loc5_.toLowerCase() == "afk")
            {
               _loc6_ = _loc6_ == "true";
            }
            _loc13_[_loc5_] = _loc6_;
            _loc14_[_loc5_] = _loc6_;
         }
         _loc17_ = -1;
         if(world.uoTree[param1.toLowerCase()] != null)
         {
            _loc17_ = int(world.uoTree[param1.toLowerCase()].intState);
         }
         world.uoTreeLeafSet(param1,_loc14_);
         _loc15_ = world.uoTree[param1.toLowerCase()];
         if(world.isPartyMember(param1))
         {
            world.updatePartyFrame({"unm":_loc15_.strUsername});
         }
         _loc12_ = "";
         for(_loc12_ in _loc13_)
         {
            _loc6_ = _loc13_[_loc12_];
            if(_loc12_.toLowerCase() == "strframe")
            {
               world.manageAreaUser(param1,"+");
               if(_loc13_[_loc12_] != world.strFrame)
               {
                  _loc11_ = world.getMCByUserID(world.getUserByName(param1).getId());
                  if(_loc11_ != null && _loc11_.stage != null)
                  {
                     if(world.bPvP)
                     {
                        _loc11_.px = _loc13_.px;
                        _loc11_.py = _loc13_.py;
                        _loc11_.mvtd = _loc13_.mvtd;
                        _loc11_.mvts = _loc13_.mvts;
                        _loc11_.sp = _loc13_.sp;
                        _loc11_.walkTo(_loc13_.tx,_loc13_.ty,_loc13_.sp);
                     }
                     _loc11_.pAV.hideMC();
                     if(_loc11_.pAV == world.myAvatar.target)
                     {
                        world.setTarget(null);
                     }
                  }
               }
               else if(_loc13_.sp != null)
               {
                  _loc11_ = world.getMCByUserID(world.getUserByName(param1).getId());
                  if(_loc11_ != null)
                  {
                     _loc11_.walkTo(_loc13_.tx,_loc13_.ty,_loc13_.sp);
                  }
               }
               else
               {
                  world.objectByID(_loc15_.entID);
               }
            }
            if(_loc12_.toLowerCase() == "sp")
            {
               if(_loc13_.strFrame == world.strFrame)
               {
               }
            }
            if(_loc10_ != null)
            {
               if(_loc12_.toLowerCase().indexOf("inthp") > -1 || _loc12_.toLowerCase().indexOf("intmp") > -1)
               {
                  _loc6_ = Number(_loc6_);
                  if(_loc10_.objData != null)
                  {
                     _loc10_.objData[_loc12_] = _loc6_;
                  }
                  if(_loc10_.isMyAvatar || world.myAvatar.target == _loc10_)
                  {
                     world.updatePortrait(_loc10_);
                  }
                  if(_loc10_.isMyAvatar)
                  {
                     world.updateActBar();
                  }
                  if(_loc10_.pMC != null && world.showHPBar)
                  {
                     _loc10_.pMC.updateHPBar();
                  }
               }
               if(_loc10_.isMyAvatar)
               {
                  if(_loc12_.toLowerCase().indexOf("intsp") > -1)
                  {
                     _loc6_ = Number(_loc6_);
                     if(_loc10_.objData != null)
                     {
                        _loc10_.objData[_loc12_] = _loc6_;
                     }
                     if(_loc10_.isMyAvatar || world.myAvatar.target == _loc10_)
                     {
                        world.updatePortrait(_loc10_);
                     }
                     if(_loc10_.isMyAvatar)
                     {
                        world.updateActBar();
                     }
                     if(_loc10_.pMC != null && world.showHPBar)
                     {
                        _loc10_.pMC.updateHPBar();
                     }
                  }
               }
               if(_loc12_.toLowerCase().indexOf("intlevel") > -1)
               {
                  _loc6_ = Number(_loc6_);
                  if(_loc10_.objData != null)
                  {
                     _loc10_.objData[_loc12_] = _loc6_;
                     if(!_loc10_.isMyAvatar && world.myAvatar.target == _loc10_)
                     {
                        showPortraitBox(_loc10_,ui.mcPortraitTarget);
                     }
                  }
               }
               if(_loc12_.toLowerCase().indexOf("intstate") > -1)
               {
                  _loc6_ = int(_loc6_);
                  if(_loc10_.objData != null && world.uoTree[param1.toLowerCase()].strFrame == world.strFrame)
                  {
                     if(_loc6_ == 1 && _loc17_ == 0)
                     {
                        _loc10_.pMC.gotoAndStop("Idle");
                        _loc10_.pMC.scale(world.SCALE);
                     }
                     if(_loc6_ == 1 && _loc17_ == 2)
                     {
                        if("eventTrigger" in MovieClip(world.map))
                        {
                        }
                     }
                  }
                  if(_loc10_.objData != null)
                  {
                     _loc10_.objData[_loc12_] = _loc6_;
                  }
                  if(_loc6_ == 0 && world.uoTree[param1.toLowerCase()].strFrame == world.strFrame && _loc10_.pMC != null)
                  {
                     _loc10_.pMC.stopWalking();
                     _loc10_.pMC.mcChar.gotoAndPlay("Feign");
                     world.removeAuraFX(_loc10_.pMC,"all");
                     if(_loc10_.pMC.getChildByName("HealIconMC") != null)
                     {
                        MovieClip(_loc10_.pMC.getChildByName("HealIconMC")).fClose();
                     }
                     if(_loc10_.isMyAvatar)
                     {
                        world.cancelAutoAttack();
                        world.actionReady = false;
                        world.bitWalk = false;
                        world.map.transform.colorTransform = world.deathCT;
                        world.CHARS.transform.colorTransform = world.deathCT;
                        _loc10_.pMC.transform.colorTransform = world.defaultCT;
                        world.showResCounter();
                     }
                  }
                  if(_loc6_ != 2)
                  {
                     _loc15_.targets = {};
                  }
               }
               if(_loc12_.toLowerCase().indexOf("afk") > -1)
               {
                  if(_loc10_.pMC != null)
                  {
                     _loc10_.pMC.updateName();
                  }
               }
               if(_loc12_ == "showCloak")
               {
                  if(_loc10_.pMC != null)
                  {
                     _loc10_.pMC.setCloakVisibility(_loc6_);
                  }
               }
               if(_loc12_ == "showHelm")
               {
                  if(_loc10_.pMC != null)
                  {
                     _loc10_.pMC.setHelmVisibility(_loc6_);
                  }
               }
               if(_loc12_.toLowerCase().indexOf("cast") > -1)
               {
                  if(_loc10_.pMC != null)
                  {
                     if(_loc6_.t > -1)
                     {
                        _loc10_.pMC.stopWalking();
                        _loc10_.pMC.queueAnim("Use");
                     }
                     else
                     {
                        _loc10_.pMC.endAction();
                        if(_loc10_ == world.myAvatar)
                        {
                           ui.mcCastBar.fClose();
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function doAnim(param1:Object, param2:Boolean = false, param3:* = null) : void
      {
         var anims:Array = null;
         var animIndex:uint = 0;
         var animStr:String = null;
         var pMC:MovieClip = null;
         var cLeaf:Object = null;
         var tLeaf:Object = null;
         var tAvt:Avatar = null;
         var cAvt:Avatar = null;
         var aura:Object = null;
         var buffer:* = undefined;
         var xBuffer:* = undefined;
         var yBuffer:* = undefined;
         var animString:String = null;
         var anim:Object = param1;
         var isProc:Boolean = param2;
         var dur:* = param3;
         var i:int = 0;
         var cTyp:String = "";
         var cID:int = -1;
         var tTyp:String = "";
         var tID:int = -1;
         var tAvts:Array = [];
         var tInfA:Array = [];
         var strF:String = "";
         cAvt = null;
         tAvt = null;
         var cReg:Point = new Point(0,0);
         var tReg:Point = new Point(0,0);
         if(anim.cInf != null && anim.tInf != null)
         {
            cTyp = String(anim.cInf.split(":")[0]);
            cID = int(anim.cInf.split(":")[1]);
            switch(cTyp)
            {
               case "p":
                  cAvt = world.getAvatarByUserID(cID);
                  cLeaf = world.getUoLeafById(cID);
                  break;
               case "m":
                  cAvt = world.getMonster(cID);
                  cLeaf = world.monTree[cID];
                  if(anim.msg != null)
                  {
                     if(anim.msg.indexOf("<mon>") > -1)
                     {
                        anim.msg = anim.msg.split("<mon>").join(cAvt.objData.strMonName);
                     }
                     addUpdate(anim.msg);
                  }
            }
            tInfA = anim.tInf.split(",");
            i = 0;
            while(i < tInfA.length)
            {
               tTyp = String(tInfA[i].split(":")[0]);
               tID = int(tInfA[i].split(":")[1]);
               switch(tTyp)
               {
                  case "p":
                     tAvt = world.getAvatarByUserID(tID);
                     tLeaf = world.getUoLeafById(tID);
                     break;
                  case "m":
                     tAvt = world.getMonster(tID);
                     tLeaf = world.monTree[tID];
                     break;
               }
               tAvts.push(tAvt);
               i++;
            }
            if(tAvts[0] != null)
            {
               tAvt = tAvts[0];
            }
            if(tAvt != null)
            {
               tLeaf = tAvt.dataLeaf;
            }
            if(cAvt != null && cAvt.pMC != null && tAvt != null && tAvt.pMC != null && cLeaf != null && tLeaf != null)
            {
               aura = {};
               for each(aura in cLeaf.auras)
               {
                  try
                  {
                     if(aura.cat != null)
                     {
                        if(aura.cat == "stun")
                        {
                           return;
                        }
                        if(aura.cat == "stone")
                        {
                           return;
                        }
                        if(aura.cat == "disabled")
                        {
                           return;
                        }
                     }
                  }
                  catch(e:Error)
                  {
                  }
               }
               animStr = anim.animStr;
               switch(cTyp)
               {
                  case "p":
                     if(cAvt.objData != null)
                     {
                        if(cAvt != world.myAvatar)
                        {
                           cAvt.target = tAvt;
                        }
                        strF = String(cLeaf.strFrame);
                        if(strF != null && strF == world.strFrame && cLeaf.intState > 0)
                        {
                           if(cAvt != tAvt)
                           {
                              if(tAvt.pMC.x - cAvt.pMC.x >= 0)
                              {
                                 cAvt.pMC.turn("right");
                              }
                              else
                              {
                                 cAvt.pMC.turn("left");
                              }
                           }
                           cAvt.pMC.queueSpFX({
                              "strl":anim.strl,
                              "fx":anim.fx,
                              "avts":tAvts
                           });
                           if(!isNaN(dur))
                           {
                              cAvt.pMC.spellDur = dur;
                           }
                           if(animStr != null)
                           {
                              if(animStr.indexOf(",") > -1)
                              {
                                 animStr = animStr.split(",")[Math.round(Math.random() * (animStr.split(",").length - 1))];
                              }
                              if(animStr != "Thrash" || cAvt.pMC.mcChar.currentLabel != "Thrash")
                              {
                                 cAvt.pMC.queueAnim(animStr);
                              }
                              if(isProc && Boolean(cAvt.pMC.mcChar.weapon.mcWeapon.isProc))
                              {
                                 cAvt.pMC.mcChar.weapon.mcWeapon.gotoAndPlay("Proc");
                              }
                           }
                        }
                     }
                     break;
                  case "m":
                     if(cAvt.objData != null)
                     {
                        if(cAvt != world.myAvatar)
                        {
                           cAvt.target = tAvt;
                        }
                        strF = String(cLeaf.strFrame);
                        cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0,0));
                        tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0,0));
                        cReg = world.CHARS.globalToLocal(cReg);
                        tReg = world.CHARS.globalToLocal(tReg);
                        if(strF != null && strF == world.strFrame && cLeaf.intState > 0)
                        {
                           if(cAvt != tAvt)
                           {
                              if(tReg.x - cReg.x >= 0)
                              {
                                 cAvt.pMC.turn("right");
                              }
                              else
                              {
                                 cAvt.pMC.turn("left");
                              }
                           }
                           if(anim.fx != "p" && anim.fx != "w" && anim.fx != "" && (Math.abs(cReg.x - tReg.x) * world.SCALE > 160 || Math.abs(cReg.y - tReg.y) * world.SCALE > 15))
                           {
                              buffer = int(110 + Math.random() * 50);
                              xBuffer = tReg.x - cReg.x >= 0 ? -buffer : buffer;
                              xBuffer = int(xBuffer * world.SCALE);
                              if(tReg.x + xBuffer < 0 || tReg.x + xBuffer > 960)
                              {
                                 xBuffer *= -1;
                              }
                              buffer = int(Math.random() * 30 - 15);
                              yBuffer = tReg.y - cReg.y >= 0 ? -buffer : buffer;
                              yBuffer = int(yBuffer * world.SCALE);
                              cAvt.pMC.walkTo(tReg.x + xBuffer,tReg.y + yBuffer,32);
                           }
                           if(cAvt.pMC.spFX != null)
                           {
                              cAvt.pMC.spFX.avt = cAvt.target;
                           }
                           cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0,0));
                           tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0,0));
                           if(cAvt != tAvt)
                           {
                              if(tReg.x - cReg.x >= 0)
                              {
                                 cAvt.pMC.turn("right");
                              }
                              else
                              {
                                 cAvt.pMC.turn("left");
                              }
                           }
                           if(litePreference.data.bDisMonAnim)
                           {
                              return;
                           }
                           if(animStr.length > 1)
                           {
                              if(animStr.indexOf(",") > -1)
                              {
                                 if(world.objExtra["bChar"] == 1)
                                 {
                                    animString = cAvt.pMC.Animation;
                                    MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animString);
                                 }
                                 else
                                 {
                                    anims = animStr.split(",");
                                    animIndex = Math.round(Math.random() * (anims.length - 1));
                                    MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(anims[animIndex]);
                                 }
                              }
                              else if(world.objExtra["bChar"] == 1)
                              {
                                 animString = cAvt.pMC.Animation;
                                 MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animString);
                              }
                              else
                              {
                                 MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animStr);
                              }
                           }
                        }
                     }
               }
            }
         }
      }
      
      public function key_StageLogin(param1:KeyboardEvent) : *
      {
         if(param1.target == stage)
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               stage.focus = mcLogin.ni;
            }
         }
      }
      
      public function isSpecificItem(param1:String) : Boolean
      {
         switch(param1)
         {
            case "Lucky Suit Treasure Chest":
            case "Unlucky Suit Treasure Chest":
            case "Apocalyptic LichMoglin on your Back":
               return true;
            default:
               return false;
         }
      }
      
      public function hasBankItem() : Boolean
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in world.myAvatar.items)
         {
            if(_loc1_.sName.indexOf(" Bank") > -1 || _loc1_.sType == "Pet" && _loc1_.sName.indexOf(" Moglin Plush Pet") > -1 || _loc1_.sDesc.indexOf(" Bank Pet ") > -1 || isSpecificItem(_loc1_.sName))
            {
               return true;
            }
         }
         return false;
      }
      
      public function key_StageGame(param1:KeyboardEvent) : *
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         if(Boolean(param1.target) && param1.target.name == "btnSetKeybindActive")
         {
            return;
         }
         if(!(param1.target is TextField || param1.currentTarget is TextField))
         {
            if(param1.keyCode == Keyboard.ENTER || String.fromCharCode(param1.charCode) == "/")
            {
               chatF.openMsgEntry();
            }
            if(isNumpadKey(param1.keyCode))
            {
               param1.keyCode -= 48;
            }
            if(param1.keyCode == litePreference.data.keys["Target Random Monster"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  _loc2_ = world.getMonstersByCell(world.strFrame);
                  _loc3_ = world.strFrame;
                  if(_loc2_.length > 0)
                  {
                     _loc4_ = Math.round(Math.random() * (_loc2_.length - 1));
                     while(_loc2_.length > 1 && !_loc2_[_loc4_] && !_loc2_[_loc4_].pMC && _loc2_[_loc4_].dataLeaf.intState == 0 && world.myAvatar.target == _loc2_[_loc4_])
                     {
                        if(world.strFrame != _loc3_)
                        {
                           break;
                        }
                        _loc4_ = Math.round(Math.random() * (_loc2_.length - 1));
                     }
                     if(world.strFrame == _loc3_)
                     {
                        if(_loc2_[_loc4_] && _loc2_[_loc4_].pMC && _loc2_[_loc4_].dataLeaf.strFrame == world.strFrame && _loc2_[_loc4_].dataLeaf.intState != 0)
                        {
                           world.setTarget(_loc2_[_loc4_]);
                        }
                     }
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Travel Menu\'s Travel"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(ui.getChildByName("mcTravelMenu"))
                  {
                     (ui.getChildByName("mcTravelMenu") as MovieClip).dispatchTravel();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Camera Tool"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(Boolean(stage.getChildByName("worldCameraMC")) || Boolean(getChildByName("cameraToolMC")))
                  {
                     return;
                  }
                  _loc5_ = new cameraTool(this);
                  _loc5_.name = "cameraToolMC";
                  _loc5_.x = -7;
                  addChild(_loc5_);
                  world.visible = false;
               }
            }
            if(param1.keyCode == litePreference.data.keys["World Camera"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(Boolean(stage.getChildByName("worldCameraMC")) || Boolean(getChildByName("cameraToolMC")))
                  {
                     if(stage.getChildByName("worldCameraMC"))
                     {
                        MovieClip(stage.getChildByName("worldCameraMC")).dispatchExit();
                     }
                     return;
                  }
                  _loc6_ = new worldCamera(this);
                  _loc6_.name = "worldCameraMC";
                  stage.addChild(_loc6_);
               }
            }
            if(String.fromCharCode(param1.charCode) == ">")
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(chatF.pmSourceA[0] != null && chatF.pmSourceA[0].length >= 1)
                  {
                     chatF.openPMsg(chatF.pmSourceA[0]);
                     if(intChatMode)
                     {
                        ui.mcInterface.ncText.text = "> ";
                     }
                     else
                     {
                        ui.mcInterface.te.text = "> ";
                     }
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Inventory"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  ui.mcInterface.mcMenu.toggleInventory();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Bank"] && (world.myAvatar.isStaff() || hasBankItem()))
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  world.toggleBank();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Quest Log"])
            {
               if(stage.focus != ui.mcInterface.te && stage.focus != ui.mcInterface.ncText && stage.focus != ui.mcInterface.ncText)
               {
                  world.toggleQuestLog();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Friends List"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(ui.mcOFrame.isOpen)
                  {
                     ui.mcOFrame.fClose();
                  }
                  else
                  {
                     world.showFriendsList();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Character Panel"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  toggleCharpanel("overview");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Player HP Bar"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  world.toggleHPBar();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Options"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(ui.mcPopup.currentLabel == "Option")
                  {
                     ui.mcPopup.onClose();
                  }
                  else
                  {
                     ui.mcPopup.fOpen("Option");
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Area List"])
            {
               if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
               {
                  if(!ui.mcOFrame.isOpen)
                  {
                     world.sendWhoRequest();
                  }
                  else
                  {
                     ui.mcOFrame.fClose();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Jump"])
            {
               if(stage.focus != ui.mcInterface.te && stage.focus != ui.mcInterface.ncText)
               {
                  world.myAvatar.pMC.mcChar.gotoAndPlay("Jump");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Rest"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  world.rest();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Hide Monsters"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  world.toggleMonsters();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Hide Players"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  optionHandler.cmd(MovieClip(this),"Hide Players");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Cancel Target"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(cancelTargetTimer.running)
                  {
                     return;
                  }
                  if(world.autoActionTimer != null && world.autoActionTimer.running)
                  {
                     world.cancelAutoAttack();
                     world.myAvatar.pMC.mcChar.gotoAndStop("Idle");
                  }
                  if(world.myAvatar.target != null)
                  {
                     world.setTarget(null);
                  }
                  if(!cancelTargetTimer.hasEventListener(TimerEvent.TIMER))
                  {
                     cancelTargetTimer.addEventListener(TimerEvent.TIMER,hasCanceledAlready,false,0,true);
                  }
                  _loc7_ = parseInt(world.getActionByRef(world.actionMap[0]).cd);
                  cancelTargetTimer.delay = _loc7_ < 2000 ? 2000 : _loc7_;
                  cancelTargetTimer.start();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Hide UI"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  optionHandler.cmd(MovieClip(this),"Hide UI");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Battle Analyzer"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  optionHandler.cmd(MovieClip(this),"Battle Analyzer");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Decline All Drops"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  optionHandler.cmd(MovieClip(this),"Decline All Drops");
               }
            }
            if(param1.keyCode == litePreference.data.keys["Stats Overview"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  toggleStatspanel();
               }
            }
            if(param1.keyCode == litePreference.data.keys["Battle Analyzer Toggle"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(bAnalyzer)
                  {
                     bAnalyzer.toggle();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Custom Drops UI"])
            {
               if(param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(Boolean(ui.mcPortrait.iconDrops) && Boolean(ui.mcPortrait.iconDrops.visible))
                  {
                     ui.mcPortrait.iconDrops.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["@ Debugger - Cell Menu"])
            {
               if(ui && ui.mcInterface && ui.mcInterface.te && param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(cMenuUI)
                  {
                     cMenuUI.toggle();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["@ Debugger - Packet Logger"])
            {
               if(ui && ui.mcInterface && ui.mcInterface.te && param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(Boolean(pLoggerUI) && Boolean(litePreference.data.dOptions["debugPacket"]))
                  {
                     pLoggerUI.visible = !pLoggerUI.visible;
                     pLoggerUI.toggle();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Dash"])
            {
               if(ui && ui.mcInterface && ui.mcInterface.te && param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(!world.uoTree[world.myAvatar.pnm].sta.$dsh)
                  {
                     world.uoTree[world.myAvatar.pnm].sta.$dsh = 100;
                  }
                  if(world.myAvatar.dataLeaf.intSP >= world.uoTree[world.myAvatar.pnm].sta.$dsh)
                  {
                     pDash = true;
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Outfits"])
            {
               if(ui && ui.mcInterface && ui.mcInterface.te && param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(!getInterface("outfitSets"))
                  {
                     toggleOutfits();
                  }
               }
            }
            if(param1.keyCode == litePreference.data.keys["Friendships UI"])
            {
               if(ui && ui.mcInterface && ui.mcInterface.te && param1.target != ui.mcInterface.te && param1.target != ui.mcInterface.ncText)
               {
                  if(!getInterface("Friendships UI"))
                  {
                     showFriendshipUI();
                  }
               }
            }
         }
      }
      
      private function hasCanceledAlready(param1:TimerEvent) : void
      {
         cancelTargetTimer.removeEventListener(TimerEvent.TIMER,hasCanceledAlready);
         stage.focus = null;
      }
      
      public function key_TextLogin(param1:KeyboardEvent) : *
      {
         if(param1.target != stage)
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               onLoginClick(null);
            }
         }
      }
      
      public function key_ChatEntry(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            chatF.submitMsg(intChatMode ? ui.mcInterface.ncText.text : ui.mcInterface.te.text,chatF.chn.cur.typ,chatF.pmNm);
         }
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            chatF.closeMsgEntry();
         }
      }
      
      public function talk(param1:*) : *
      {
         if(param1.accept)
         {
            chatF.submitMsg(param1.emote1,"emote",sfc.myUserName);
         }
         else
         {
            chatF.submitMsg(param1.emote2,"emote",sfc.myUserName);
         }
      }
      
      public function isNumpadKey(param1:uint) : Boolean
      {
         return param1 >= 96 && param1 <= 105;
      }
      
      public function key_actBar(param1:KeyboardEvent) : *
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         if(Boolean(param1.target) && param1.target.name == "btnSetKeybindActive")
         {
            return;
         }
         if(stage.focus == null || stage.focus != null && !("text" in stage.focus))
         {
            if(isNumpadKey(param1.keyCode))
            {
               param1.keyCode -= 48;
            }
            switch(param1.keyCode)
            {
               case litePreference.data.keys["Auto Attack"]:
                  _loc2_ = 0;
                  world.approachTarget();
                  return;
               case litePreference.data.keys["Skill 1"]:
                  _loc2_ = 1;
                  if(world.actionMap[_loc2_] != null)
                  {
                     _loc4_ = world.getActionByRef(world.actionMap[_loc2_]);
                     if(_loc4_.isOK)
                     {
                        world.testAction(_loc4_);
                     }
                  }
                  break;
               case litePreference.data.keys["Skill 2"]:
                  _loc2_ = 2;
                  if(world.actionMap[_loc2_] != null)
                  {
                     _loc4_ = world.getActionByRef(world.actionMap[_loc2_]);
                     if(_loc4_.isOK)
                     {
                        world.testAction(_loc4_);
                     }
                  }
                  break;
               case litePreference.data.keys["Skill 3"]:
                  _loc2_ = 3;
                  if(world.actionMap[_loc2_] != null)
                  {
                     _loc4_ = world.getActionByRef(world.actionMap[_loc2_]);
                     if(_loc4_.isOK)
                     {
                        world.testAction(_loc4_);
                     }
                  }
                  break;
               case litePreference.data.keys["Skill 4"]:
                  _loc2_ = 4;
                  if(world.actionMap[_loc2_] != null)
                  {
                     _loc4_ = world.getActionByRef(world.actionMap[_loc2_]);
                     if(_loc4_.isOK)
                     {
                        world.testAction(_loc4_);
                     }
                  }
                  break;
               case litePreference.data.keys["Skill 5"]:
                  _loc2_ = 5;
                  if(world.actionMap[_loc2_] != null)
                  {
                     _loc4_ = world.getActionByRef(world.actionMap[_loc2_]);
                     if(_loc4_.isOK)
                     {
                        world.testAction(_loc4_);
                     }
                  }
            }
         }
      }
      
      public function getKeyboardDict() : Dictionary
      {
         var _loc6_:String = null;
         var _loc1_:XML = describeType(Keyboard);
         var _loc2_:XMLList = _loc1_.constant.@name;
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:int = int(_loc2_.length());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc2_[_loc5_];
            if(_loc2_[_loc5_].indexOf("NUMBER_") > -1 || _loc2_[_loc5_].indexOf("STRING_") > -1 || _loc2_[_loc5_].indexOf("KEYNAME_") > -1)
            {
               _loc6_ = _loc2_[_loc5_].split("_")[1];
            }
            _loc3_[Keyboard[_loc2_[_loc5_]]] = _loc6_;
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function decHex(param1:*) : *
      {
         return param1.toString(16);
      }
      
      public function hexDec(param1:*) : *
      {
         return parseInt(param1,16);
      }
      
      public function modColor(param1:*, param2:*, param3:*) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc4_:* = "";
         var _loc8_:* = 0;
         while(_loc8_ < 3)
         {
            _loc5_ = hexDec(param1.substr(_loc8_ * 2,2));
            _loc6_ = hexDec(param2.substr(_loc8_ * 2,2));
            switch(param3)
            {
               case "-":
               default:
                  _loc7_ = _loc5_ - _loc6_;
                  if(_loc7_ < 0)
                  {
                     _loc7_ = 0;
                  }
                  break;
               case "+":
                  _loc7_ = _loc5_ + _loc6_;
                  if(_loc7_ > 255)
                  {
                     _loc7_ = 255;
                  }
                  _loc7_ = decHex(_loc7_);
                  break;
            }
            _loc7_ = decHex(_loc7_);
            _loc4_ += String(_loc7_.length < 2 ? "0" + _loc7_ : _loc7_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      internal function replaceString(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:String = "";
         while(true)
         {
            _loc4_ = Number(param1.indexOf(param2,_loc4_));
            if(_loc4_ == -1)
            {
               break;
            }
            _loc6_ += param1.substring(_loc5_,_loc4_) + param3;
            _loc5_ = _loc4_ = _loc4_ + param2.length;
         }
         return _loc6_ == "" ? param1 : _loc6_;
      }
      
      public function stripWhite(param1:String) : String
      {
         param1 = param1.split("\r").join("");
         param1 = param1.split("\t").join("");
         return param1.split(" ").join("");
      }
      
      public function stripWhiteStrict(param1:String) : String
      {
         param1 = stripWhite(param1);
         var _loc2_:int = 0;
         while(_loc2_ < chatF.strictComparisonChars.length)
         {
            param1 = param1.split(chatF.strictComparisonChars.substr(_loc2_,1)).join("");
            _loc2_++;
         }
         return param1;
      }
      
      public function stripWhiteStrictB(param1:String) : String
      {
         param1 = stripWhite(param1);
         var _loc2_:int = 0;
         while(_loc2_ < chatF.strictComparisonCharsB.length)
         {
            param1 = param1.split(chatF.strictComparisonCharsB.substr(_loc2_,1)).join("");
            _loc2_++;
         }
         return param1;
      }
      
      public function stripMarks(param1:String) : String
      {
         var _loc2_:int = 0;
         while(_loc2_ < chatF.markChars.length)
         {
            param1 = param1.split(chatF.markChars.substr(_loc2_,1)).join("");
            _loc2_++;
         }
         return param1;
      }
      
      public function stripDuplicateVowels(param1:String) : String
      {
         param1 = param1.replace(chatF.regExpA,"a");
         param1 = param1.replace(chatF.regExpE,"e");
         param1 = param1.replace(chatF.regExpI,"i");
         param1 = param1.replace(chatF.regExpO,"o");
         param1 = param1.replace(chatF.regExpU,"u");
         return param1.replace(chatF.regExpSPACE," ");
      }
      
      public function maskStringBetween(param1:String, param2:Array) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = "";
         if(param2.length > 0 && param2.length % 2 == 0)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               if(_loc5_ >= param2[_loc4_] && _loc5_ <= param2[_loc4_ + 1])
               {
                  if(param1.charAt(_loc5_) == " ")
                  {
                     _loc3_ += " ";
                  }
                  else
                  {
                     _loc3_ += "*";
                  }
                  if(_loc5_ == param2[_loc4_ + 1])
                  {
                     _loc4_ += 2;
                  }
               }
               else
               {
                  _loc3_ += param1.charAt(_loc5_);
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function arraySort(param1:String, param2:String) : int
      {
         if(param1 > param2)
         {
            return 1;
         }
         if(param1 < param2)
         {
            return -1;
         }
         return 0;
      }
      
      public function convertBubbleText(param1:String) : String
      {
         var _loc2_:String = null;
         _loc2_ = world.myAvatar.objData.strUsername;
         if(param1.indexOf("@name"))
         {
            param1 = param1.split("@name").join(_loc2_);
         }
         _loc2_ = String(world.myAvatar.objData.intLevel);
         if(param1.indexOf("@level"))
         {
            param1 = param1.split("@level").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strClassName;
         if(param1.indexOf("@class"))
         {
            param1 = param1.split("@class").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "Mr." : "Mrs.";
         if(param1.indexOf("@prefix"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "He" : "She";
         if(param1.indexOf("@He"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "Him" : "Her";
         if(param1.indexOf("@Him"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "His" : "Her";
         if(param1.indexOf("@His"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "he" : "she";
         if(param1.indexOf("@he"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "him" : "her";
         if(param1.indexOf("@him"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         _loc2_ = world.myAvatar.objData.strGender.toLowerCase() == "m" ? "his" : "her";
         if(param1.indexOf("@his"))
         {
            param1 = param1.split("@prefix").join(_loc2_);
         }
         return param1;
      }
      
      public function strToProperCase(param1:String) : String
      {
         return param1.slice(0,1).toUpperCase() + param1.slice(1,param1.length).toLowerCase();
      }
      
      public function strSetCharAt(param1:String, param2:int, param3:String) : String
      {
         return param1.substring(0,param2) + param3 + param1.substring(param2 + 1,param1.length);
      }
      
      public function strNumWithCommas(param1:Number) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = param1.toString();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = _loc3_.length - 1;
         while(_loc4_ > -1)
         {
            if(_loc5_ == 3)
            {
               _loc5_ = 0;
               _loc2_ = _loc3_.charAt(_loc4_) + "," + _loc2_;
            }
            else
            {
               _loc2_ = _loc3_.charAt(_loc4_) + _loc2_;
            }
            _loc5_++;
            _loc4_--;
         }
         return _loc2_;
      }
      
      public function numToStr(param1:Number, param2:int = 2) : String
      {
         var _loc3_:* = param1.toString();
         if(_loc3_.indexOf(".") == -1)
         {
            _loc3_ += ".";
         }
         var _loc4_:Array = _loc3_.split(".");
         while(_loc4_[1].length < param2)
         {
            _loc4_[1] += "0";
         }
         if(_loc4_[1].length > param2)
         {
            _loc4_[1] = _loc4_[1].substr(0,param2);
         }
         if(param2 > 0)
         {
            _loc3_ = _loc4_[0] + "." + _loc4_[1];
         }
         else
         {
            _loc3_ = _loc4_[0];
         }
         return _loc3_;
      }
      
      public function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public function copyConstructor(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Class;
      }
      
      public function distanceO(param1:*, param2:*) : Number
      {
         return Math.sqrt(Math.pow(int(param2.x - param1.x),2) + Math.pow(int(param2.y - param1.y),2));
      }
      
      public function distanceP(param1:*, param2:*, param3:*, param4:*) : Number
      {
         return Math.sqrt(Math.pow(param3 - param1,2) + Math.pow(param4 - param2,2));
      }
      
      public function distanceXY(param1:*, param2:*, param3:*, param4:*) : Object
      {
         return {
            "dx":param3 - param1,
            "dy":param4 - param2
         };
      }
      
      public function isHouseItem(param1:Object) : Boolean
      {
         return param1.sType == "House" || param1.sType == "Floor Item" || param1.sType == "Wall Item";
      }
      
      internal function validateArmor(param1:*) : *
      {
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:Object = {};
         var _loc4_:int = 0;
         var _loc5_:int = 10;
         var _loc6_:Boolean = true;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = int(param1.ItemID);
         switch(_loc9_)
         {
            case 319:
            case 2083:
               _loc7_ = true;
               _loc2_ = [16,15654,407,20,15651,409];
               break;
            case 409:
               _loc8_ = true;
               _loc2_ = [20,15651];
               break;
            case 408:
               _loc8_ = true;
               _loc2_ = [17,15653];
               break;
            case 410:
               _loc8_ = true;
               _loc2_ = [18,15652];
               break;
            case 407:
               _loc8_ = true;
               _loc2_ = [16,15654];
         }
         if(_loc7_)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc2_.length)
            {
               if(world.myAvatar.getCPByID(_loc2_[_loc10_]) < 302500)
               {
                  _loc6_ = false;
               }
               else
               {
                  _loc6_ = true;
                  if(_loc10_ < 2)
                  {
                     _loc10_ = 2;
                  }
                  if(_loc10_ < 5 && _loc10_ > 2)
                  {
                     break;
                  }
               }
               _loc10_++;
            }
            return _loc6_;
         }
         if(_loc8_)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc2_.length)
            {
               if(world.myAvatar.getCPByID(_loc2_[_loc11_]) >= param1.iReqCP)
               {
                  return true;
               }
               _loc11_++;
            }
            return false;
         }
         return !(Number(param1.iClass) > 0 && world.myAvatar.getCPByID(param1.iClass) < param1.iReqCP);
      }
      
      public function getItemInfoString(param1:Object) : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc2_:* = "<font size=\'14\'><b>" + param1.sName + "</b></font><br>";
         if(!validateArmor(param1) && param1.iClass > 0)
         {
            _loc2_ += "<font size=\'11\' color=\'#CC0000\'>";
            _loc3_ = getRankFromPoints(param1.iReqCP);
            _loc4_ = param1.iReqCP - arrRanks[_loc3_ - 1];
            if(_loc4_ > 0)
            {
               _loc2_ += "Requires " + _loc4_ + " Class Points on " + param1.sClass + ", Rank " + _loc3_ + ".";
            }
            else
            {
               _loc2_ += "Requires " + param1.sClass + ", Rank " + _loc3_ + ".";
            }
            _loc2_ += "</font><br>";
         }
         if(param1.FactionID > 1 && world.myAvatar.getRep(param1.FactionID) < param1.iReqRep)
         {
            _loc2_ += "<font size=\'11\' color=\'#CC0000\'>";
            _loc5_ = getRankFromPoints(param1.iReqRep);
            _loc6_ = param1.iReqRep - arrRanks[_loc3_ - 1];
            if(_loc6_ > 0)
            {
               _loc2_ += "Requires " + _loc6_ + " Reputation on " + param1.sFaction + ", Rank " + _loc5_ + ".";
            }
            else
            {
               _loc2_ += "Requires " + param1.sFaction + ", Rank " + _loc5_ + ".";
            }
            _loc2_ += "</font><br>";
         }
         if(param1.iQSindex >= 0 && world.getQuestValue(param1.iQSindex) < int(param1.iQSvalue))
         {
            _loc2_ += "<font size=\'11\' color=\'#CC0000\'>Requires completion of quest \"" + param1.sQuest + "\".</font><br>";
         }
         _loc2_ += "<font color=\'#009900\'><b>" + getDisplaysType(param1);
         if(param1.sES != "None" && param1.sES != "co" && param1.sES != "mi")
         {
            if(param1.EnhID > 0)
            {
               _loc2_ += ", Lvl " + param1.EnhLvl;
               if(param1.sES == "Weapon")
               {
                  _loc7_ = getBaseHPByLevel(param1.EnhLvl);
                  _loc8_ = 20;
                  _loc9_ = 1;
                  _loc10_ = param1.iRng / 100;
                  _loc11_ = 2;
                  _loc12_ = Math.round(_loc7_ / _loc8_ * _loc9_);
                  _loc13_ = Math.round(_loc12_ * _loc11_);
                  _loc14_ = Math.floor(_loc13_ - _loc13_ * _loc10_);
                  _loc15_ = Math.ceil(_loc13_ + _loc13_ * _loc10_);
                  _loc2_ += "<br>" + _loc14_ + " - " + _loc15_ + " " + param1.sElmt;
               }
            }
            else
            {
               _loc2_ += " Design";
            }
         }
         param1.sDesc = param1.sDesc.replace(regExLineSpace,"\n");
         return _loc2_ + ("</b></font>" + (litePreference.data.bDebugger ? "Item ID: " + param1.ItemID + "<br>" : "") + "<br>" + param1.sDesc + "<br>");
      }
      
      public function getItemInfoStringB(param1:Object) : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc2_:* = "<font size=\'12\'><b>" + param1.sName + "</b></font><br>";
         if(!validateArmor(param1) && param1.iClass > 0)
         {
            _loc2_ += "<font size=\'10\' color=\'#CC0000\'>";
            _loc3_ = getRankFromPoints(param1.iReqCP);
            _loc4_ = param1.iReqCP - arrRanks[_loc3_ - 1];
            if(_loc4_ > 0)
            {
               _loc2_ += "Requires " + _loc4_ + " Class Points on " + param1.sClass + ", Rank " + _loc3_ + ".";
            }
            else
            {
               _loc2_ += "Requires " + param1.sClass + ", Rank " + _loc3_ + ".";
            }
            _loc2_ += "</font><br>";
         }
         if(param1.FactionID > 1 && world.myAvatar.getRep(param1.FactionID) < param1.iReqRep)
         {
            _loc2_ += "<font size=\'10\' color=\'#CC0000\'>";
            _loc5_ = getRankFromPoints(param1.iReqRep);
            _loc6_ = param1.iReqRep - arrRanks[_loc3_ - 1];
            if(_loc6_ > 0)
            {
               _loc2_ += "Requires " + _loc6_ + " Reputation on " + param1.sFaction + ", Rank " + _loc5_ + ".";
            }
            else
            {
               _loc2_ += "Requires " + param1.sFaction + ", Rank " + _loc5_ + ".";
            }
            _loc2_ += "</font><br>";
         }
         if(param1.iQSindex >= 0 && world.getQuestValue(param1.iQSindex) < int(param1.iQSvalue))
         {
            _loc2_ += "<font size=\'11\' color=\'#CC0000\'>Requires completion of quest \"" + param1.sQuest + "\".</font><br>";
         }
         if(param1.sMeta != null && getDisplaysType(param1) == "Pet" && param1.sMeta.indexOf("Necromancer") > -1)
         {
            _loc2_ += "<font color=\'#00CCFF\'><b>Battle " + getDisplaysType(param1);
         }
         else
         {
            _loc2_ += "<font color=\'#00CCFF\'><b>" + getDisplaysType(param1);
         }
         if(param1.sType.toLowerCase() == "enhancement")
         {
            _loc2_ += ", Level " + param1.iLvl;
         }
         if(param1.sES != "None" && param1.sES != "co" && param1.sES != "pe" && param1.sES != "mi")
         {
            if(param1.EnhID > 0)
            {
               _loc2_ += ", Level " + param1.EnhLvl;
               if(param1.sES == "ar")
               {
                  _loc2_ += "<br>Rank " + getRankFromPoints(param1.iQty);
               }
            }
            else if(param1.sType.toLowerCase() != "enhancement")
            {
               _loc2_ += " Design";
            }
         }
         if(param1.iStk > 1)
         {
            _loc2_ += " - " + param1.iQty + "/" + param1.iStk;
         }
         if(param1.sES == "Weapon" || param1.sES == "co" || param1.sES == "he" || param1.sES == "ba" || param1.sES == "pe" || param1.sES == "am" || param1.sES == "mi" || param1.sES == "hi" || param1.sES == "ho")
         {
            if(param1.sType.toLowerCase() != "enhancement")
            {
               _loc2_ += "<br>" + getRarityString(param1.iRty) + " Rarity";
            }
         }
         if(param1.sType.toLowerCase() != "enhancement")
         {
            param1.sDesc = param1.sDesc.replace(regExLineSpace,"\n");
            _loc2_ += "</b></font><br><font size=\'10\' color=\'#FFFFFF\'>" + (litePreference.data.bDebugger ? "Item ID: " + param1.ItemID + "<br>" : "") + param1.sDesc + "<br></font>";
         }
         else
         {
            _loc2_ += "</b></font><br><font size=\'10\' color=\'#FFFFFF\'>";
            _loc2_ += "Enhancements are special items which can apply stats to your weapons and armor. Select a weapon or armor item from the list on the right, and click the <font color=\'#00CCFF\'>\"Enhancements\"</font> button that appears below its preview.";
         }
         return _loc2_;
      }
      
      public function getIconByType(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1.toLowerCase())
         {
            case "axe":
            case "bow":
            case "dagger":
            case "gun":
            case "mace":
            case "polearm":
            case "staff":
            case "sword":
            case "wand":
            case "armor":
               _loc2_ = "iw" + param1.toLowerCase();
               break;
            case "cape":
            case "helm":
            case "pet":
            case "class":
               _loc2_ = "ii" + param1.toLowerCase();
               break;
            default:
               _loc2_ = "iibag";
         }
         return _loc2_;
      }
      
      public function getIconBySlot(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1.toLowerCase())
         {
            case "weapon":
               _loc2_ = "iwsword";
               break;
            case "back":
            case "ba":
               _loc2_ = "iicape";
               break;
            case "head":
            case "he":
               _loc2_ = "iihelm";
               break;
            case "armor":
            case "ar":
               _loc2_ = "iiclass";
               break;
            case "class":
               _loc2_ = "iiclass";
               break;
            case "pet":
            case "pe":
               _loc2_ = "iipet";
               break;
            default:
               _loc2_ = "iibag";
         }
         return _loc2_;
      }
      
      public function getDisplaysType(param1:Object) : *
      {
         var _loc2_:String = param1.sType != null ? param1.sType : "Unknown";
         var _loc3_:String = _loc2_.toLowerCase();
         if(_loc3_ == "clientuse" || _loc3_ == "serveruse")
         {
            _loc2_ = "Item";
         }
         if(_loc3_ == "misc")
         {
            _loc2_ = "Ground";
         }
         return _loc2_;
      }
      
      public function stringToDate(param1:String) : Date
      {
         var _loc2_:* = Number(param1.substr(0,4));
         var _loc3_:* = Number(param1.substr(5,2)) - 1;
         var _loc4_:* = Number(param1.substr(8,2));
         var _loc5_:* = Number(param1.substr(11,2));
         var _loc6_:* = Number(param1.substr(14,2));
         var _loc7_:* = Number(param1.substr(17));
         return new Date(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      internal function traceObject(param1:*, param2:* = 1) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc3_:* = "";
         while(_loc3_.length < param2)
         {
            _loc3_ += " ";
         }
         param2++;
         if(typeof param1 == "object" && param1.length != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc4_++;
            }
         }
         else
         {
            for(_loc5_ in param1)
            {
               if(typeof param1[_loc5_] == "object")
               {
                  traceObject(param1[_loc5_],param2);
               }
            }
         }
      }
      
      public function max(param1:int, param2:int) : int
      {
         if(param1 > param2)
         {
            return param1;
         }
         return param2;
      }
      
      public function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public function isValidEmail(param1:String) : Boolean
      {
         return Boolean(param1.match(EMAIL_REGEX));
      }
      
      public function closeToolTip() : void
      {
         var _loc1_:* = undefined;
         try
         {
            _loc1_ = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            _loc1_.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateIcons(param1:Array, param2:Array, param3:Object = null) : *
      {
         var _loc6_:MovieClip = null;
         var _loc7_:Class = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_];
            _loc6_.cnt.removeChildAt(0);
            _loc6_.item = param3;
            if(_loc6_.item == null)
            {
               _loc6_.tQty.visible = false;
            }
            while(_loc5_ < param2.length)
            {
               _loc7_ = world.getClass(param2[_loc5_]) as Class;
               _loc8_ = new _loc7_();
               _loc9_ = _loc6_.cnt.addChild(_loc8_);
               _loc10_ = int(42 - 8 + 4 * _loc5_);
               _loc11_ = int(39 - 8 + 4 * _loc5_);
               _loc12_ = _loc9_.width;
               _loc13_ = _loc9_.height;
               if(_loc12_ > _loc13_)
               {
                  _loc9_.scaleX = _loc9_.scaleY = _loc10_ / _loc12_;
               }
               else
               {
                  _loc9_.scaleX = _loc9_.scaleY = _loc11_ / _loc13_;
               }
               _loc9_.x = _loc6_.bg.width / 2 - _loc9_.width / 2;
               _loc9_.y = _loc6_.bg.height / 2 - _loc9_.height / 2;
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function updateItemSkill() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < world.actions.active.length)
         {
            if(Boolean(world.actions.active[_loc1_]) && world.actions.active[_loc1_].ref == "i1")
            {
               updateActionObjIcon(world.actions.active[_loc1_]);
               break;
            }
            _loc1_++;
         }
      }
      
      public function updateActionObjIcon(param1:Object) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Array = world.getActIcons(param1);
         var _loc5_:* = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc5_];
            _loc4_ = _loc3_.item;
            if(_loc4_ != null)
            {
               _loc6_ = 0;
               while(_loc7_ < world.myAvatar.items.length)
               {
                  if(world.myAvatar.items[_loc7_].ItemID == _loc4_.ItemID)
                  {
                     _loc6_ = int(world.myAvatar.items[_loc7_].iQty);
                  }
                  _loc7_++;
               }
               if(_loc6_ > 0)
               {
                  _loc3_.tQty.visible = true;
                  _loc3_.tQty.text = _loc6_;
               }
               else
               {
                  world.unequipUseableItem(_loc4_);
               }
            }
            _loc5_++;
         }
      }
      
      public function drawChainsSmooth(param1:Array, param2:int, param3:MovieClip) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Point = null;
         var _loc12_:Array = null;
         var _loc13_:MovieClip = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < param1.length)
         {
            _loc4_ = new Point(0,0);
            _loc5_ = new Point(0,0);
            _loc4_ = param1[_loc6_ - 1].localToGlobal(_loc4_);
            _loc5_ = param1[_loc6_].localToGlobal(_loc5_);
            _loc7_ = [];
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = Math.ceil(Point.distance(_loc4_,_loc5_) / param2);
            if(_loc10_ % 2 == 1)
            {
               _loc10_ += 1;
            }
            _loc11_ = new Point();
            _loc12_ = [param3.fx0,param3.fx1,param3.fx2];
            _loc14_ = -1;
            _loc8_ = 0;
            while(_loc8_ < _loc12_.length)
            {
               _loc7_ = [];
               _loc14_ = Math.random() > 0.5 ? 1 : -1;
               _loc15_ = 0;
               _loc9_ = 1;
               while(_loc9_ < _loc10_)
               {
                  _loc11_ = Point.interpolate(_loc4_,_loc5_,1 - _loc9_ / _loc10_);
                  if(++_loc15_ % 2 == 1)
                  {
                     _loc11_.x += _loc14_ * Math.round(Math.random() * 30);
                     _loc11_.y += _loc14_ * Math.round(Math.random() * 30);
                     _loc14_ = -_loc14_;
                  }
                  _loc7_.push(_loc11_);
                  _loc9_++;
               }
               _loc7_.push(_loc5_);
               _loc13_ = _loc12_[_loc8_];
               _loc13_.graphics.lineStyle(2,16777215,1);
               _loc13_.graphics.moveTo(_loc4_.x,_loc4_.y);
               _loc9_ = 0;
               while(_loc9_ < _loc7_.length)
               {
                  _loc13_.graphics.curveTo(_loc7_[_loc9_].x,_loc7_[_loc9_].y,_loc7_[_loc9_ + 1].x,_loc7_[_loc9_ + 1].y);
                  _loc9_ += 2;
               }
               _loc8_++;
            }
            _loc6_++;
         }
      }
      
      public function drawChainsLinear(param1:Array, param2:int, param3:MovieClip) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Point = null;
         var _loc14_:Array = null;
         var _loc15_:MovieClip = null;
         _loc8_ = 1;
         while(_loc8_ < param1.length)
         {
            _loc6_ = param1[_loc8_ - 1];
            _loc7_ = param1[_loc8_];
            _loc4_ = new Point(0,-_loc6_.height * 0.5);
            _loc5_ = new Point(0,-_loc7_.height * 0.5);
            _loc4_ = _loc6_.localToGlobal(_loc4_);
            _loc5_ = _loc7_.localToGlobal(_loc5_);
            _loc9_ = [];
            _loc10_ = 0;
            _loc11_ = 0;
            _loc12_ = Math.ceil(Point.distance(_loc4_,_loc5_) / param2);
            _loc13_ = new Point();
            _loc14_ = [param3.fx0,param3.fx1,param3.fx2];
            _loc10_ = 0;
            while(_loc10_ < _loc14_.length)
            {
               _loc9_ = [];
               _loc11_ = 1;
               while(_loc11_ < _loc12_)
               {
                  _loc13_ = Point.interpolate(_loc4_,_loc5_,1 - _loc11_ / (_loc12_ + 1));
                  _loc13_.x += Math.round(Math.random() * 25 - 13);
                  _loc13_.y += Math.round(Math.random() * 25 - 13);
                  _loc9_.push(_loc13_);
                  _loc11_++;
               }
               _loc15_ = _loc14_[_loc10_];
               _loc15_.graphics.lineStyle(5,16777215,1);
               _loc15_.graphics.moveTo(_loc4_.x,_loc4_.y);
               _loc11_ = 0;
               while(_loc11_ < _loc9_.length)
               {
                  _loc15_.graphics.lineTo(_loc9_[_loc11_].x,_loc9_[_loc11_].y);
                  _loc11_++;
               }
               _loc15_.graphics.lineTo(_loc5_.x,_loc5_.y);
               _loc10_++;
            }
            _loc8_++;
         }
      }
      
      public function drawFunnel(param1:Array, param2:MovieClip) : void
      {
         var _loc3_:MovieClip = null;
         param2.numLines = 3;
         param2.lineThickness = 3;
         param2.lineColors = [10027178,0,2228326];
         param2.glowColors = [0];
         param2.glowStrength = 4;
         param2.glowSize = 4;
         param2.dur = 500;
         param2.del = 100;
         param2.p1StartingValue = 0.12;
         param2.p2StartingValue = 0.24;
         param2.p3StartingValue = 0.36;
         param2.p1EndingValue = 0.66;
         param2.p2EndingValue = 0.825;
         param2.p3EndingValue = 0.99;
         param2.p1ScaleFactor = 0.5;
         param2.p3ScaleFactor = 0.5;
         param2.easingExponent = 1.5;
         param2.targetMCs = param1;
         param2.filterArr = [];
         param2.fxArr = [];
         param2.ts = new Date().getTime();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.glowColors.length)
         {
            param2.filterArr.push([new GlowFilter(param2.glowColors[_loc4_],1,param2.glowSize,param2.glowSize,param2.glowStrength,1,false,false)]);
            _loc4_++;
         }
         _loc4_ = 0;
         _loc5_ = 0;
         var _loc6_:int = 0;
         while(_loc6_ < param2.numLines)
         {
            _loc3_ = param2.addChild(new MovieClip()) as MovieClip;
            _loc3_.filters = param2.filterArr[_loc4_];
            if(++_loc4_ >= param2.glowColors.length)
            {
               _loc4_ = 0;
            }
            _loc3_.lineColor = param2.lineColors[_loc5_];
            if(++_loc5_ >= param2.lineColors.length)
            {
               _loc5_ = 0;
            }
            param2.fxArr.push(_loc3_);
            _loc6_++;
         }
         param2.addEventListener(Event.ENTER_FRAME,funnelEF,false,0,true);
      }
      
      internal function funnelEF(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc17_:Point = null;
         var _loc18_:Point = null;
         var _loc19_:Point = null;
         var _loc20_:Point = null;
         var _loc21_:Point = null;
         var _loc22_:Point = null;
         var _loc26_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         var _loc4_:Number = Number(new Date().getTime());
         var _loc5_:Point = new Point();
         var _loc6_:Point = new Point();
         var _loc7_:Point = new Point();
         var _loc10_:int = 1;
         var _loc11_:MovieClip = _loc2_.targetMCs[0];
         var _loc12_:MovieClip = _loc2_.targetMCs[1];
         var _loc13_:Point = _loc11_.localToGlobal(new Point(0,-_loc11_.height / 2));
         var _loc14_:Point = _loc12_.localToGlobal(new Point(0,-_loc12_.height / 2));
         var _loc15_:* = _loc12_.width;
         var _loc16_:* = _loc12_.height;
         var _loc23_:int = -1;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc27_:Number = Math.atan2(_loc13_.y - _loc14_.y,_loc13_.x - _loc14_.x);
         _loc27_ = _loc27_ - Math.PI / 2;
         var _loc28_:int = 0;
         while(_loc28_ < _loc2_.fxArr.length)
         {
            _loc3_ = _loc2_.fxArr[_loc28_];
            _loc9_ = Number(_loc2_.ts);
            _loc8_ = _loc4_ - _loc28_ * _loc2_.del;
            if(_loc8_ > _loc9_ + _loc2_.dur)
            {
               if(_loc3_.visible)
               {
                  _loc3_.visible = false;
                  _loc3_.graphics.clear();
               }
               if(_loc28_ == _loc2_.fxArr.length - 1)
               {
                  _loc2_.removeEventListener(Event.ENTER_FRAME,funnelEF);
                  if(_loc2_.parent != null)
                  {
                     _loc2_.parent.removeChild(_loc2_);
                  }
               }
            }
            else if(_loc8_ >= _loc2_.ts)
            {
               _loc29_ = (_loc8_ - _loc9_) / _loc2_.dur;
               _loc29_ = Math.pow(1 - _loc29_,_loc2_.easingExponent);
               _loc10_ = _loc28_ % 2 == 0 ? 1 : -1;
               _loc17_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p1StartingValue).x + Point.polar(_loc10_ * (_loc12_.height / _loc2_.p1ScaleFactor),_loc27_).x,Point.interpolate(_loc13_,_loc14_,_loc2_.p1StartingValue).y + Point.polar(_loc10_ * (_loc12_.height / _loc2_.p1ScaleFactor),_loc27_).y);
               _loc18_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p1EndingValue).x,Point.interpolate(_loc13_,_loc14_,_loc2_.p1EndingValue).y);
               _loc19_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p2StartingValue).x,_loc14_.y);
               _loc20_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p2EndingValue).x,Point.interpolate(_loc13_,_loc14_,_loc2_.p2EndingValue).y);
               _loc21_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p3StartingValue).x + Point.polar(-_loc10_ * (_loc12_.height / _loc2_.p3ScaleFactor),_loc27_).x,Point.interpolate(_loc13_,_loc14_,_loc2_.p3StartingValue).y + Point.polar(-_loc10_ * (_loc12_.height / _loc2_.p3ScaleFactor),_loc27_).y);
               _loc22_ = new Point(Point.interpolate(_loc13_,_loc14_,_loc2_.p3EndingValue).x,Point.interpolate(_loc13_,_loc14_,_loc2_.p3EndingValue).y);
               _loc5_ = Point.interpolate(_loc17_,_loc18_,_loc29_);
               _loc6_ = Point.interpolate(_loc19_,_loc20_,_loc29_);
               _loc7_ = Point.interpolate(_loc21_,_loc22_,_loc29_);
               _loc26_ = Number(_loc3_.lineColor);
               _loc3_.graphics.clear();
               _loc3_.graphics.lineStyle(_loc2_.lineThickness,_loc26_,1);
               _loc3_.graphics.moveTo(_loc14_.x,_loc14_.y);
               _loc3_.graphics.curveTo(_loc5_.x,_loc5_.y,_loc6_.x,_loc6_.y);
               _loc3_.graphics.curveTo(_loc7_.x,_loc7_.y,_loc13_.x,_loc13_.y);
               _loc30_ = Math.cos((_loc8_ - _loc9_) / _loc2_.dur * Math.PI * 2);
               _loc30_ = _loc30_ / 2 + 0.5;
               _loc30_ = 1 - _loc30_;
               _loc3_.alpha = _loc30_;
            }
            _loc28_++;
         }
      }
      
      public function updateCoreValues(param1:Object) : void
      {
         if(param1.intLevelCap != null)
         {
            intLevelCap = param1.intLevelCap;
         }
         if(param1.PCstBase != null)
         {
            PCstBase = param1.PCstBase;
         }
         if(param1.PCstRatio != null)
         {
            PCstRatio = param1.PCstRatio;
         }
         if(param1.PCstGoal != null)
         {
            PCstGoal = param1.PCstGoal;
         }
         if(param1.GstBase != null)
         {
            GstBase = param1.GstBase;
         }
         if(param1.GstRatio != null)
         {
            GstRatio = param1.GstRatio;
         }
         if(param1.GstGoal != null)
         {
            GstGoal = param1.GstGoal;
         }
         if(param1.PChpBase1 != null)
         {
            PChpBase1 = param1.PChpBase1;
         }
         if(param1.PChpBase100 != null)
         {
            PChpBase100 = param1.PChpBase100;
         }
         if(param1.PChpGoal1 != null)
         {
            PChpGoal1 = param1.PChpGoal1;
         }
         if(param1.PChpGoal100 != null)
         {
            PChpGoal100 = param1.PChpGoal100;
         }
         if(param1.PChpDelta != null)
         {
            PChpDelta = param1.PChpDelta;
         }
         if(param1.intHPperEND != null)
         {
            intHPperEND = param1.intHPperEND;
         }
         if(param1.intAPtoDPS != null)
         {
            intAPtoDPS = param1.intAPtoDPS;
         }
         if(param1.intSPtoDPS != null)
         {
            intSPtoDPS = param1.intSPtoDPS;
         }
         if(param1.bigNumberBase != null)
         {
            bigNumberBase = param1.bigNumberBase;
         }
         if(param1.resistRating != null)
         {
            resistRating = param1.resistRating;
         }
         if(param1.modRating != null)
         {
            modRating = param1.modRating;
         }
         if(param1.baseDodge != null)
         {
            baseDodge = param1.baseDodge;
         }
         if(param1.baseBlock != null)
         {
            baseBlock = param1.baseBlock;
         }
         if(param1.baseParry != null)
         {
            baseParry = param1.baseParry;
         }
         if(param1.baseCrit != null)
         {
            baseCrit = param1.baseCrit;
         }
         if(param1.baseHit != null)
         {
            baseHit = param1.baseHit;
         }
         if(param1.baseHaste != null)
         {
            baseHaste = param1.baseHaste;
         }
         if(param1.baseMiss != null)
         {
            baseMiss = param1.baseMiss;
         }
         if(param1.baseResist != null)
         {
            baseResist = param1.baseResist;
         }
         if(param1.baseCritValue != null)
         {
            baseCritValue = param1.baseCritValue;
         }
         if(param1.baseBlockValue != null)
         {
            baseBlockValue = param1.baseBlockValue;
         }
         if(param1.baseResistValue != null)
         {
            baseResistValue = param1.baseResistValue;
         }
         if(param1.baseEventValue != null)
         {
            baseEventValue = param1.baseEventValue;
         }
         if(param1.PCDPSMod != null)
         {
            PCDPSMod = param1.PCDPSMod;
         }
         if(param1.curveExponent != null)
         {
            curveExponent = param1.curveExponent;
         }
         if(param1.statsExponent != null)
         {
            statsExponent = param1.statsExponent;
         }
      }
      
      internal function spaceBy(param1:int, param2:int) : String
      {
         var _loc3_:* = String(param1);
         while(_loc3_.length < param2)
         {
            _loc3_ += " ";
         }
         return _loc3_;
      }
      
      internal function spaceNumBy(param1:Number, param2:int) : String
      {
         var _loc3_:* = param1.toString();
         _loc3_ = _loc3_.substr(0,param2);
         while(_loc3_.length < param2)
         {
            _loc3_ += " ";
         }
         return _loc3_;
      }
      
      internal function showRatings() : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc1_:* = world.myAvatar.dataLeaf;
         var _loc2_:* = "";
         var _loc3_:* = 1;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         _loc3_ = 1;
         while(_loc3_ <= 35)
         {
            if(_loc3_ == 0)
            {
               _loc3_ = 1;
            }
            _loc6_ = getInnateStats(_loc3_);
            _loc7_ = getIBudget(_loc3_,1);
            _loc8_ = -1;
            _loc9_ = -1;
            _loc10_ = -1;
            _loc11_ = -1;
            _loc12_ = _loc1_.sCat;
            _loc13_ = copyObj(_loc1_.sta);
            resetTableValues(_loc13_);
            _loc14_ = getBaseHPByLevel(_loc3_);
            _loc15_ = _loc14_ / 20 * 0.7;
            _loc16_ = 2.25 * _loc15_ / (100 / intAPtoDPS) / 2;
            _loc4_ = 0;
            while(_loc4_ < stats.length)
            {
               _loc2_ = stats[_loc4_];
               _loc11_ = _loc13_["$" + _loc2_];
               switch(_loc2_)
               {
                  case "STR":
                     _loc8_ = _loc16_;
                     _loc13_.$ap += _loc11_ * 2;
                     _loc13_.$tcr += _loc11_ / _loc8_ / 100 * 0.4;
                     break;
               }
               _loc4_++;
            }
            _loc3_ += 1;
         }
      }
      
      public function applyCoreStatRatings(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 1;
         var _loc4_:* = 100;
         var _loc5_:Object = world.myAvatar.getEquippedItemBySlot("Weapon");
         if(_loc5_ != null)
         {
            if(_loc5_.EnhLvl != null)
            {
               _loc3_ = int(_loc5_.EnhLvl);
            }
            if(_loc5_.EnhDPS != null)
            {
               _loc4_ = Number(_loc5_.EnhDPS);
            }
            if(_loc4_ == 0)
            {
               _loc4_ = 100;
            }
         }
         _loc4_ /= 100;
         var _loc6_:int = int(param2.intLevel);
         var _loc7_:String = "";
         var _loc8_:int = getInnateStats(_loc6_);
         var _loc9_:Number = -1;
         var _loc10_:Number = -1;
         var _loc11_:Number = -1;
         var _loc12_:int = -1;
         var _loc13_:String = world.myAvatar.objData.sClassCat;
         var _loc14_:int = getBaseHPByLevel(_loc6_);
         var _loc15_:int = 20;
         var _loc16_:* = _loc14_ / 20 * 0.7;
         var _loc17_:Number = 2.25 * _loc16_ / (100 / intAPtoDPS) / 2;
         resetTableValues(param1);
         var _loc18_:int = 0;
         while(_loc18_ < stats.length)
         {
            _loc7_ = stats[_loc18_];
            _loc12_ = param1["_" + _loc7_] + param1["^" + _loc7_];
            switch(_loc7_)
            {
               case "STR":
                  _loc9_ = _loc17_;
                  if(_loc13_ == "M1")
                  {
                     param1.$sbm -= _loc12_ / _loc9_ / 100 * 0.3;
                  }
                  if(_loc13_ == "S1")
                  {
                     param1.$ap += Math.round(_loc12_ * 1.4);
                  }
                  else
                  {
                     param1.$ap += _loc12_ * 2;
                  }
                  if(_loc13_ == "M1" || _loc13_ == "M2" || _loc13_ == "M3" || _loc13_ == "M4" || _loc13_ == "S1")
                  {
                     if(_loc13_ == "M4")
                     {
                        param1.$tcr += _loc12_ / _loc9_ / 100 * 0.7;
                     }
                     else
                     {
                        param1.$tcr += _loc12_ / _loc9_ / 100 * 0.4;
                     }
                  }
                  break;
               case "INT":
                  _loc9_ = _loc17_;
                  param1.$cmi -= _loc12_ / _loc9_ / 100;
                  if(_loc13_.substr(0,1) == "C" || _loc13_ == "M3")
                  {
                     param1.$cmo += _loc12_ / _loc9_ / 100;
                  }
                  if(_loc13_ == "S1")
                  {
                     param1.$sp += Math.round(_loc12_ * 1.4);
                  }
                  else
                  {
                     param1.$sp += _loc12_ * 2;
                  }
                  if(_loc13_ == "C1" || _loc13_ == "C2" || _loc13_ == "C3" || _loc13_ == "M3" || _loc13_ == "S1")
                  {
                     if(_loc13_ == "C2")
                     {
                        param1.$tha += _loc12_ / _loc9_ / 100 * 0.5;
                     }
                     else
                     {
                        param1.$tha += _loc12_ / _loc9_ / 100 * 0.3;
                     }
                  }
                  break;
               case "DEX":
                  _loc9_ = _loc17_;
                  if(_loc13_ == "M1" || _loc13_ == "M2" || _loc13_ == "M3" || _loc13_ == "M4" || _loc13_ == "S1")
                  {
                     if(_loc13_.substr(0,1) != "C")
                     {
                        param1.$thi += _loc12_ / _loc9_ / 100 * 0.2;
                     }
                     if(_loc13_ == "M2" || _loc13_ == "M4")
                     {
                        param1.$tha += _loc12_ / _loc9_ / 100 * 0.5;
                     }
                     else
                     {
                        param1.$tha += _loc12_ / _loc9_ / 100 * 0.3;
                     }
                     if(_loc13_ == "M1")
                     {
                        if(param1._tbl > 0.01)
                        {
                           param1.$tbl += _loc12_ / _loc9_ / 100 * 0.5;
                        }
                     }
                  }
                  if(_loc13_ != "M2" && _loc13_ != "M3")
                  {
                     param1.$tdo += _loc12_ / _loc9_ / 100 * 0.3;
                  }
                  else
                  {
                     param1.$tdo += _loc12_ / _loc9_ / 100 * 0.5;
                  }
                  break;
               case "WIS":
                  _loc9_ = _loc17_;
                  if(_loc13_ == "C1" || _loc13_ == "C2" || _loc13_ == "C3" || _loc13_ == "S1")
                  {
                     if(_loc13_ == "C1")
                     {
                        param1.$tcr += _loc12_ / _loc9_ / 100 * 0.7;
                     }
                     else
                     {
                        param1.$tcr += _loc12_ / _loc9_ / 100 * 0.4;
                     }
                     param1.$thi += _loc12_ / _loc9_ / 100 * 0.2;
                  }
                  param1.$tdo += _loc12_ / _loc9_ / 100 * 0.3;
                  break;
               case "LCK":
                  _loc9_ = _loc17_;
                  param1.$sem += _loc12_ / _loc9_ / 100 * 2;
                  if(_loc13_ == "S1")
                  {
                     param1.$ap += Math.round(_loc12_ * 1);
                     param1.$sp += Math.round(_loc12_ * 1);
                     param1.$tcr += _loc12_ / _loc9_ / 100 * 0.3;
                     param1.$thi += _loc12_ / _loc9_ / 100 * 0.1;
                     param1.$tha += _loc12_ / _loc9_ / 100 * 0.3;
                     param1.$tdo += _loc12_ / _loc9_ / 100 * 0.25;
                     param1.$scm += _loc12_ / _loc9_ / 100 * 2.5;
                  }
                  else
                  {
                     if(_loc13_ == "M1" || _loc13_ == "M2" || _loc13_ == "M3" || _loc13_ == "M4")
                     {
                        param1.$ap += Math.round(_loc12_ * 0.7);
                     }
                     if(_loc13_ == "C1" || _loc13_ == "C2" || _loc13_ == "C3" || _loc13_ == "M3")
                     {
                        param1.$sp += Math.round(_loc12_ * 0.7);
                     }
                     param1.$tcr += _loc12_ / _loc9_ / 100 * 0.2;
                     param1.$thi += _loc12_ / _loc9_ / 100 * 0.1;
                     param1.$tha += _loc12_ / _loc9_ / 100 * 0.1;
                     param1.$tdo += _loc12_ / _loc9_ / 100 * 0.1;
                     param1.$scm += _loc12_ / _loc9_ / 100 * 5;
                  }
                  break;
            }
            _loc18_++;
         }
         param1.wDPS = Math.round(getBaseHPByLevel(_loc3_) / _loc15_ * _loc4_ * PCDPSMod) + Math.round(param1.$ap / intAPtoDPS);
         param1.mDPS = Math.round(getBaseHPByLevel(_loc3_) / _loc15_ * _loc4_ * PCDPSMod) + Math.round(param1.$sp / intSPtoDPS);
      }
      
      public function coeffToPct(param1:Number) : String
      {
         return Number(param1 * 100).toFixed(2);
      }
      
      public function getIBudget(param1:int, param2:int) : int
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > intLevelCap)
         {
            param1 = intLevelCap;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         param1 = Math.round(param1 + param2 - 1);
         return int(Math.round(GstBase + Math.pow((param1 - 1) / (intLevelCap - 1),statsExponent) * (GstGoal - GstBase)));
      }
      
      public function getInnateStats(param1:int) : int
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > intLevelCap)
         {
            param1 = intLevelCap;
         }
         return Math.round(PCstBase + Math.pow((param1 - 1) / (intLevelCap - 1),statsExponent) * (PCstGoal - PCstBase));
      }
      
      public function getBaseHPByLevel(param1:*) : *
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param1 > intLevelCap)
         {
            param1 = intLevelCap;
         }
         return Math.round(PChpBase1 + Math.pow((param1 - 1) / (intLevelCap - 1),curveExponent) * PChpDelta);
      }
      
      public function catCodeToName(param1:String) : String
      {
         switch(param1)
         {
            case "M1":
               return "Fighter";
            case "M2":
               return "Thief";
            case "M3":
               return "Hybrid";
            case "M4":
               return "Armsman";
            case "C1":
               return "Wizard";
            case "C2":
               return "Healer";
            case "C3":
               return "spellbreaker";
            case "S1":
               return "Lucky";
            default:
               return null;
         }
      }
      
      public function resetTableValues(param1:Object) : void
      {
         param1._ap = 0;
         param1.$ap = 0;
         param1._sp = 0;
         param1.$sp = 0;
         param1._tbl = 0;
         param1._tpa = 0;
         param1._tdo = 0;
         param1._tcr = 0;
         param1._thi = 0;
         param1._tha = 0;
         param1._tre = 0;
         param1.$tbl = baseBlock;
         param1.$tpa = baseParry;
         param1.$tdo = baseDodge;
         param1.$tcr = baseCrit;
         param1.$thi = baseHit;
         param1.$tha = baseHaste;
         param1.$tre = baseResist;
         param1._cpo = 1;
         param1._cpi = 1;
         param1._cao = 1;
         param1._cai = 1;
         param1._cmo = 1;
         param1._cmi = 1;
         param1._cdo = 1;
         param1._cdi = 1;
         param1._cho = 1;
         param1._chi = 1;
         param1._cmc = 1;
         param1.$cpo = 1;
         param1.$cpi = 1;
         param1.$cao = 1;
         param1.$cai = 1;
         param1.$cmo = 1;
         param1.$cmi = 1;
         param1.$cdo = 1;
         param1.$cdi = 1;
         param1.$cho = 1;
         param1.$chi = 1;
         param1.$cmc = 1;
         param1._scm = baseCritValue;
         param1._sbm = baseBlockValue;
         param1._srm = baseResistValue;
         param1._sem = baseEventValue;
         param1.$scm = baseCritValue;
         param1.$sbm = baseBlockValue;
         param1.$srm = baseResistValue;
         param1.$sem = baseEventValue;
         param1._shb = 0;
         param1._smb = 0;
         param1.$shb = 0;
         param1.$smb = 0;
      }
      
      public function getCategoryStats(param1:String, param2:int) : Object
      {
         var _loc3_:* = getInnateStats(param2);
         var _loc4_:* = classCatMap[param1].ratios;
         var _loc5_:* = {};
         var _loc6_:* = "";
         var _loc7_:int = 0;
         while(_loc7_ < stats.length)
         {
            _loc6_ = stats[_loc7_];
            _loc5_[_loc6_] = Math.round(_loc4_[_loc7_] * _loc3_);
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function applyAuraEffect(param1:*, param2:*) : *
      {
         switch(param1.typ)
         {
            case "+":
               param2["$" + param1.sta] += Number(param1.val);
               break;
            case "-":
               param2["$" + param1.sta] -= Number(param1.val);
               break;
            case "*":
               param2["$" + param1.sta] = Math.round(param2["$" + param1.sta] * Number(param1.val));
         }
      }
      
      public function removeAuraEffect(param1:*, param2:*) : *
      {
         switch(param1.typ)
         {
            case "+":
               param2["$" + param1.sta] -= Number(param1.val);
               break;
            case "-":
               param2["$" + param1.sta] += Number(param1.val);
               break;
            case "*":
               param2["$" + param1.sta] = Math.round(param2["$" + param1.sta] / Number(param1.val));
         }
      }
      
      public function getStatsA(param1:Object, param2:String) : Object
      {
         var _loc6_:Object = null;
         var _loc3_:int = param1.sType.toLowerCase() == "enhancement" ? int(param1.iLvl) : int(param1.EnhLvl);
         var _loc4_:int = param1.sType.toLowerCase() == "enhancement" ? int(param1.iRty) : int(param1.EnhRty);
         var _loc5_:int = Math.round(getIBudget(_loc3_,_loc4_) * ratiosBySlot[param2]);
         var _loc7_:* = -1;
         var _loc8_:* = ["iEND","iSTR","iINT","iDEX","iWIS","iLCK"];
         var _loc9_:* = 0;
         var _loc10_:* = "";
         var _loc11_:* = {};
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:Object = {};
         world.initPatternTree();
         if(param1.PatternID != null)
         {
            _loc6_ = world.enhPatternTree[param1.PatternID];
         }
         if(param1.EnhPatternID != null)
         {
            _loc6_ = world.enhPatternTree[param1.EnhPatternID];
         }
         if(_loc6_ != null)
         {
            _loc13_ = 0;
            while(_loc13_ < stats.length)
            {
               _loc10_ = "i" + stats[_loc13_];
               if(_loc6_[_loc10_] != null)
               {
                  _loc11_[_loc10_] = Math.round(_loc5_ * _loc6_[_loc10_] / 100);
                  _loc12_ += _loc11_[_loc10_];
               }
               _loc13_++;
            }
            _loc9_ = 0;
            while(_loc12_ < _loc5_)
            {
               _loc10_ = _loc8_[_loc9_];
               if(_loc11_[_loc10_] != null)
               {
                  ++_loc11_[_loc10_];
                  _loc12_++;
               }
               if(++_loc9_ > _loc8_.length - 1)
               {
                  _loc9_ = 0;
               }
            }
            _loc13_ = 0;
            while(_loc13_ < stats.length)
            {
               _loc7_ = _loc11_["i" + stats[_loc13_]];
               if(_loc7_ != null && _loc7_ != "0")
               {
                  _loc14_["$" + stats[_loc13_]] = _loc7_;
               }
               _loc13_++;
            }
         }
         return _loc14_;
      }
      
      public function getDisplayEnhName(param1:Object) : String
      {
         if(Boolean(param1) && Boolean(param1.hasOwnProperty("DIS")))
         {
            switch(param1.sName)
            {
               case "Vim":
               case "Examen":
               case "Pneuma":
               case "Anima":
                  return param1.sName;
               case "Hearty":
                  return "Grimskull";
               default:
                  return "Forge";
            }
         }
         else
         {
            if(param1)
            {
               return param1.sName;
            }
            return "";
         }
      }
      
      public function getDisplayEnhTraitName(param1:Object) : String
      {
         switch(param1.sName)
         {
            case "Vim":
            case "Examen":
               return "Ether";
            case "Pneuma":
            case "Anima":
               return "Clairvoyance";
            default:
               return param1.sName;
         }
      }
      
      public function getFullStatName(param1:String) : String
      {
         var _loc2_:String = "";
         param1 = param1.toLowerCase();
         if(param1.indexOf("str") > -1)
         {
            _loc2_ = "Strength";
         }
         if(param1.indexOf("int") > -1)
         {
            _loc2_ = "Intellect";
         }
         if(param1.indexOf("dex") > -1)
         {
            _loc2_ = "Dexterity";
         }
         if(param1.indexOf("wis") > -1)
         {
            _loc2_ = "Wisdom";
         }
         if(param1.indexOf("end") > -1)
         {
            _loc2_ = "Endurance";
         }
         if(param1.indexOf("lck") > -1)
         {
            _loc2_ = "Luck";
         }
         if(param1.indexOf("tha") > -1)
         {
            _loc2_ = "Haste";
         }
         if(param1.indexOf("thi") > -1)
         {
            _loc2_ = "Hit";
         }
         if(param1.indexOf("tcr") > -1)
         {
            _loc2_ = "Critcal Hit";
         }
         if(param1.indexOf("tcm") > -1)
         {
            _loc2_ = "Crit Value";
         }
         if(param1.indexOf("tdo") > -1)
         {
            _loc2_ = "Evasion";
         }
         return _loc2_;
      }
      
      public function getRarityString(param1:int) : String
      {
         var _loc3_:Object = null;
         var _loc2_:Array = [{
            "val":0,
            "sName":"Unknown"
         },{
            "val":10,
            "sName":"Unknown"
         },{
            "val":11,
            "sName":"Common"
         },{
            "val":12,
            "sName":"Weird"
         },{
            "val":13,
            "sName":"Awesome"
         },{
            "val":14,
            "sName":"1% Drop"
         },{
            "val":15,
            "sName":"5% Drop"
         },{
            "val":16,
            "sName":"Boss Drop"
         },{
            "val":17,
            "sName":"Secret"
         },{
            "val":18,
            "sName":"Junk"
         },{
            "val":19,
            "sName":"Impossible"
         },{
            "val":20,
            "sName":"Artifact"
         },{
            "val":21,
            "sName":"Limited Time Drop"
         },{
            "val":68,
            "sName":"New Collection Chest"
         },{
            "val":23,
            "sName":"Crazy"
         },{
            "val":24,
            "sName":"Expensive"
         },{
            "val":30,
            "sName":"Rare"
         },{
            "val":35,
            "sName":"Epic"
         },{
            "val":40,
            "sName":"Import Item"
         },{
            "val":50,
            "sName":"Seasonal Item"
         },{
            "val":55,
            "sName":"Seasonal Rare"
         },{
            "val":60,
            "sName":"Event Item"
         },{
            "val":65,
            "sName":"Event Rare"
         },{
            "val":70,
            "sName":"Limited Rare"
         },{
            "val":75,
            "sName":"Collector\'s Rare"
         },{
            "val":80,
            "sName":"Promotional Item"
         },{
            "val":90,
            "sName":"Ultra Rare"
         },{
            "val":95,
            "sName":"Super Mega Ultra Rare"
         },{
            "val":100,
            "sName":"Legendary Item"
         }];
         var _loc4_:int = int(_loc2_.length - 1);
         while(_loc4_ > -1)
         {
            _loc3_ = _loc2_[_loc4_];
            if(param1 >= _loc3_.val)
            {
               return _loc3_.sName;
            }
            _loc4_--;
         }
         return "Common";
      }
      
      public function toggleItemEquip(param1:Object) : Boolean
      {
         var _loc2_:* = world.getUoLeafById(world.myAvatar.uid);
         var _loc3_:Boolean = false;
         if(_loc2_.intState != 1)
         {
            MsgBox.notify("Action cannot be performed during combat!");
         }
         else if(world.bPvP)
         {
            MsgBox.notify("Items may not be equipped or unequipped during a PvP match!");
         }
         else if(param1.bEquip == 1)
         {
            if(param1.sES == "Weapon" || param1.sES == "ar")
            {
               MsgBox.notify("Selected Item cannot be unequipped!");
            }
            else
            {
               _loc3_ = true;
               if(param1.sType.toLowerCase() != "item")
               {
                  world.sendUnequipItemRequest(param1);
               }
               else
               {
                  world.unequipUseableItem(param1);
               }
            }
         }
         else if(param1.bUpg == 1 && !world.myAvatar.isUpgraded())
         {
            showUpgradeWindow();
         }
         else if(int(param1.EnhLvl) > int(world.myAvatar.objData.intLevel))
         {
            MsgBox.notify("Level requirement not met!");
         }
         else if(param1.sType.toLowerCase() != "item" && (param1.sES != "mi" && param1.sES != "co" && param1.sES != "pe" && param1.sES != "am" && param1.EnhID <= 0))
         {
            MsgBox.notify("Selected item requires enhancement!");
         }
         else if(param1.sType.toLowerCase() != "item")
         {
            _loc3_ = world.sendEquipItemRequest(param1);
         }
         else
         {
            _loc3_ = true;
            world.equipUseableItem(param1);
         }
         return _loc3_;
      }
      
      public function tryEnhance(param1:Array, param2:Object, param3:Boolean = false) : void
      {
         if(param1 != null && param2 != null)
         {
            if(param2.iLvl > world.myAvatar.objData.intLevel)
            {
               MsgBox.notify("Level requirement not met!");
            }
            else if(param1.EnhID == param2.ItemID)
            {
               MsgBox.notify("Selected Enhancement already applied to item!");
            }
            else if(param3)
            {
               world.sendEnhItemRequestShop(param1,param2);
            }
            else
            {
               world.sendEnhItemRequestLocal(param1,param2);
            }
         }
      }
      
      public function doIHaveEnhancements() : Boolean
      {
         var _loc1_:Object = null;
         for each(_loc1_ in world.myAvatar.items)
         {
            if(_loc1_.sType.toLowerCase() == "enhancement")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isItemEnhanceable(param1:Object) : Boolean
      {
         return ["Weapon","he","ba","pe","ar"].indexOf(param1.sES) >= 0;
      }
      
      public function resetInvTreeByItemID(param1:int) : *
      {
         var item:Object = null;
         var ItemID:int = param1;
         try
         {
            item = world.invTree[ItemID];
            if("EnhID" in item)
            {
               item.EnhID = -1;
            }
            if("EnhRty" in item)
            {
               item.EnhRty = -1;
            }
            if("EnhDPS" in item)
            {
               item.EnhDPS = -1;
            }
            if("EnhRng" in item)
            {
               item.EnhRng = -1;
            }
            if("EnhLvl" in item)
            {
               item.EnhLvl = -1;
            }
            if("EnhPatternID" in item)
            {
               item.EnhPatternID = -1;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function isMergeShop(param1:Object) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1.items)
         {
            if("turnin" in _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function recursiveStop(param1:MovieClip) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            if(_loc2_ is MovieClip)
            {
               param1 = MovieClip(_loc2_);
               if(param1.totalFrames > 1)
               {
                  param1.gotoAndStop(param1.totalFrames);
               }
               else
               {
                  param1.stop();
               }
               recursiveStop(MovieClip(_loc2_));
            }
            _loc3_++;
         }
      }
      
      public function getTravelMapData() : void
      {
         if(ui.getChildByName("travelLoaderMC"))
         {
            return;
         }
         travelLoaderMC = new (world.getClass("mcLoader") as Class)();
         travelLoaderMC.x = 400;
         travelLoaderMC.y = 211;
         travelLoaderMC.name = "travelLoaderMC";
         ui.addChild(travelLoaderMC);
         var _loc1_:String = "api/data/travelmap?v=" + world.objInfo["sVersion"];
         var _loc2_:URLLoader = new URLLoader();
         if(this.loaderInfo.url.toLowerCase().indexOf("file://") >= 0 || this.loaderInfo.url.toLowerCase().indexOf("cdn.aq.com") >= 0 || this.loaderInfo.url.toLowerCase().indexOf("aqworldscdn.aq.com") >= 0)
         {
            _loc1_ = "https://game.aq.com/game/" + _loc1_;
         }
         else
         {
            _loc1_ = params.sURL + _loc1_;
         }
         var _loc3_:URLRequest = new URLRequest(_loc1_);
         _loc3_.method = URLRequestMethod.GET;
         _loc2_.addEventListener(Event.COMPLETE,onTravelMapComplete,false,0,true);
         _loc2_.addEventListener(ProgressEvent.PROGRESS,onTravelMapProgress,false,0,true);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,onTravelError,false,0,true);
         _loc2_.load(_loc3_);
      }
      
      private function onTravelMapComplete(param1:Event) : void
      {
         var _loc2_:String = String(param1.target.data);
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(_loc2_);
         travelMapData = _loc3_;
         WorldMapData = new worldMap(travelMapData);
         TRAVEL_DATA_READY = true;
         ui.mcPopup.mcMap.removeChildAt(0);
         var _loc4_:Loader = new Loader();
         _loc4_.load(new URLRequest(serverFilePath + world.objInfo.sMap),new LoaderContext(false,ApplicationDomain.currentDomain));
         ui.mcPopup.mcMap.addChild(_loc4_);
      }
      
      private function onTravelMapProgress(param1:ProgressEvent) : void
      {
         bLoaded = param1.bytesLoaded;
         bTotal = param1.bytesTotal;
         var _loc2_:int = bLoaded / bTotal * 100;
         var _loc3_:Number = bLoaded / bTotal;
         travelLoaderMC.mcPct.text = _loc2_ + "%";
         if(bLoaded >= bTotal)
         {
            travelLoaderMC.parent.removeChild(travelLoaderMC);
            travelLoaderMC = null;
         }
      }
      
      private function onTravelError(param1:IOErrorEvent) : void
      {
         if(travelLoaderMC)
         {
            travelLoaderMC.parent.removeChild(travelLoaderMC);
            travelLoaderMC = null;
         }
      }
      
      public function checkPasswordStrength(param1:String) : int
      {
         var _loc2_:Number = 0;
         var _loc3_:Array = param1.split("");
         var _loc4_:Array = new Array();
         var _loc5_:uint = 0;
         var _loc6_:String = _loc3_[0];
         var _loc7_:Boolean = false;
         var _loc8_:String = param1.toLowerCase();
         var _loc9_:uint = 0;
         while(_loc9_ < weakPass.length)
         {
            if(_loc8_ == weakPass[_loc9_])
            {
               return -1;
            }
            _loc9_++;
         }
         var _loc10_:uint = 0;
         while(_loc10_ < _loc3_.length)
         {
            if(!_loc7_ && _loc6_ != _loc3_[_loc10_])
            {
               _loc7_ = true;
            }
            if(_loc10_ == 0)
            {
               _loc2_ += 4;
               _loc4_.push(_loc3_[_loc10_]);
            }
            else if(_loc10_ < 8)
            {
               if(!isRepeat(_loc4_,_loc3_[_loc10_]))
               {
                  _loc4_.push(_loc3_[_loc10_]);
                  _loc2_ += 2;
               }
               else
               {
                  _loc2_ += 2;
               }
            }
            else if(_loc10_ < 21)
            {
               if(!isRepeat(_loc4_,_loc3_[_loc10_]))
               {
                  _loc4_.push(_loc3_[_loc10_]);
                  _loc2_ += 1.5;
               }
               else
               {
                  _loc2_ += 1.5;
               }
            }
            else if(!isRepeat(_loc4_,_loc3_[_loc10_]))
            {
               _loc4_.push(_loc3_[_loc10_]);
               _loc2_ += 1;
            }
            else
            {
               _loc2_ += 1;
            }
            if(_loc5_ < 6 && !isAlphaChar(_loc3_[_loc10_]))
            {
               _loc2_++;
               _loc5_++;
            }
            _loc10_++;
         }
         return _loc7_ ? int(_loc2_) : -1;
      }
      
      private function isAlphaChar(param1:String) : Boolean
      {
         var _loc2_:uint = uint(param1.charCodeAt(0));
         return _loc2_ >= 65 && _loc2_ < 123 || _loc2_ >= 48 && _loc2_ < 58 ? true : false;
      }
      
      private function isRepeat(param1:Array, param2:String) : Boolean
      {
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function loadGameMenu() : void
      {
         var _loc1_:Loader = new Loader();
         var _loc2_:URLRequest = new URLRequest(serverFilePath + world.objInfo.gMenu);
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,gameMenuCallBack,false,0,true);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,gameMenuErrorHandler,false,0,true);
         _loc1_.load(_loc2_,assetsContext);
      }
      
      public function MenuShow() : void
      {
         try
         {
            if(!mcGameMenu)
            {
               return;
            }
            if(mcGameMenu.currentLabel == "Open")
            {
               mcGameMenu.gotoAndPlay("Close");
            }
            else
            {
               mcGameMenu.gotoAndStop("Open");
            }
         }
         catch(e:*)
         {
         }
      }
      
      private function gameMenuCallBack(param1:Event) : void
      {
         try
         {
            ui.removeChild(mcGameMenu);
         }
         catch(e:*)
         {
         }
         mcGameMenu = null;
         var _loc2_:* = assetsDomain.getDefinition("GameMenu") as Class;
         mcGameMenu = MovieClip(new _loc2_());
         mcGameMenu.name = "gameMenu";
         mcGameMenu.visible = world.strMapName != "reenstest";
         mcGameMenu.x = 750;
         ui.addChild(mcGameMenu);
      }
      
      private function gameMenuErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function menuClose() : void
      {
         try
         {
            if(firstMenu)
            {
               firstMenu = false;
            }
            else if(mcGameMenu.currentLabel != "Close")
            {
               mcGameMenu.gotoAndPlay("Close");
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function openMenu() : void
      {
         try
         {
            if(mcGameMenu.currentLabel != "Open")
            {
               mcGameMenu.gotoAndPlay("Open");
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function getFilePath() : String
      {
         return serverFilePath;
      }
      
      public function getGamePath() : String
      {
         return serverGamePath;
      }
      
      public function initWorld() : void
      {
         if(world != null)
         {
            world.killTimers();
            world.killListeners();
            this.removeChild(world);
            world = null;
         }
         world = new World(MovieClip(this));
         this.addChildAt(world,getChildIndex(ui));
      }
      
      public function grayAll(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param1 is MovieClip && param1 != this)
         {
            (param1 as MovieClip).stop();
         }
         if(param1.numChildren)
         {
            _loc4_ = param1.numChildren;
            while(_loc3_ < _loc4_)
            {
               if(param1.getChildAt(_loc3_) is DisplayObjectContainer)
               {
                  _loc2_ = param1.getChildAt(_loc3_) as DisplayObjectContainer;
                  if(_loc2_.numChildren)
                  {
                     makeGrayscale(_loc2_);
                  }
                  else if(_loc2_ is MovieClip)
                  {
                     makeGrayscale(_loc2_ as MovieClip);
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function testJSCallback() : void
      {
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         Game.root = this;
         this.stage.showDefaultContextMenu = false;
         stage.stageFocusRect = false;
         mcConnDetail = new ConnDetailMC(this);
         serverFilePath = this.loaderInfo.url.substring(0,this.loaderInfo.url.lastIndexOf("/") + 1);
         serverGamePath = serverFilePath.slice(0,serverFilePath.lastIndexOf("/gamefiles")) + "/";
         sFilePath = serverFilePath;
         gotoAndPlay(charCount() > 0 && Boolean(litePreference.data.bCharSelect) ? "Select" : "Login");
         if(userPreference.data.quality != "AUTO")
         {
            stage.quality = userPreference.data.quality;
         }
      }
      
      public function init() : void
      {
         var _loc1_:* = undefined;
         ISWEB = params.isWeb;
         extCall = new ExternalCalls(true,params.strSourceID,this as MovieClip);
         for(_loc1_ in params)
         {
         }
         if(MsgBox)
         {
            MsgBox.visible = false;
         }
         IsEU = params.isEU;
         readQueryString();
         if(Boolean(mcLogin) && Boolean(mcLogin.fbConnect))
         {
            mcLogin.fbConnect.visible = showFB;
         }
         extCall.setGameObject(swfObj);
         if(params.sURL == null)
         {
            params.sURL = "https://www.aq.com/game/";
         }
         serverPath = params.sURL;
         FacebookConnect.RegisterGame(this);
         if(params.doSignup)
         {
            params.doSignup = false;
            gotoAndPlay("Account");
         }
      }
      
      public function FBMessage(param1:*, param2:*) : *
      {
         FacebookConnect.handleFBMessage(param1,param2);
      }
      
      public function SendMessage(param1:*, param2:*) : *
      {
      }
      
      public function FB_showFeedDialog(param1:String, param2:String, param3:String) : void
      {
         if(ISWEB)
         {
            extCall.showFeedDialog(param1,param2,param3);
         }
      }
      
      public function toggleFullScreen() : void
      {
         var _loc1_:Rectangle = null;
         if(stage["displayState"] == StageDisplayState.NORMAL)
         {
            _loc1_ = new Rectangle(0,0,960,550);
            try
            {
               stage["fullScreenSourceRect"] = _loc1_;
               stage["displayState"] = StageDisplayState.FULL_SCREEN;
            }
            catch(error:Error)
            {
            }
         }
         else
         {
            stage["displayState"] = StageDisplayState.NORMAL;
         }
      }
      
      public function showBallyhooAd(param1:String) : void
      {
         stage["displayState"] = StageDisplayState.NORMAL;
         extCall.showIt(param1);
      }
      
      public function callJSFunction(param1:String) : void
      {
         extCall.callJSFunction(param1);
      }
      
      private function readQueryString() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         try
         {
            _loc1_ = "";
            if(ISWEB)
            {
               _loc1_ = extCall.getQueryString();
            }
            if(_loc1_)
            {
               _loc3_ = _loc1_.split("&");
               _loc4_ = 0;
               _loc5_ = -1;
               while(_loc4_ < _loc3_.length)
               {
                  _loc6_ = _loc3_[_loc4_];
                  _loc5_ = _loc6_.indexOf("=");
                  if(_loc5_ > 0)
                  {
                     _loc7_ = _loc6_.substring(0,_loc5_);
                     _loc8_ = _loc6_.substring(_loc5_ + 1);
                     querystring[_loc7_] = _loc8_;
                  }
                  _loc4_++;
               }
            }
            for(_loc2_ in querystring)
            {
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function initLogin() : void
      {
         var curTS:Number = NaN;
         var iDiff:Number = NaN;
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,key_StageLogin);
         mcLogin.ni.tabIndex = 1;
         mcLogin.pi.tabIndex = 2;
         mcLogin.ni.removeEventListener(FocusEvent.FOCUS_IN,onUserFocus);
         mcLogin.ni.removeEventListener(KeyboardEvent.KEY_DOWN,key_TextLogin);
         mcLogin.pi.removeEventListener(KeyboardEvent.KEY_DOWN,key_TextLogin);
         mcLogin.btnLogin.removeEventListener(MouseEvent.CLICK,onLoginClick);
         mcLogin.btnFBLogin.removeEventListener(MouseEvent.CLICK,onFBLoginClick);
         mcLogin.mcForgotPassword.removeEventListener(MouseEvent.CLICK,onForgotPassword);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,key_StageLogin);
         mcLogin.ni.addEventListener(FocusEvent.FOCUS_IN,onUserFocus);
         mcLogin.ni.addEventListener(KeyboardEvent.KEY_DOWN,key_TextLogin);
         mcLogin.pi.addEventListener(KeyboardEvent.KEY_DOWN,key_TextLogin);
         mcLogin.btnLogin.addEventListener(MouseEvent.CLICK,onLoginClick);
         mcLogin.btnFBLogin.addEventListener(MouseEvent.CLICK,onFBLoginClick);
         mcLogin.mcForgotPassword.addEventListener(MouseEvent.CLICK,onForgotPassword);
         mcLogin.mcManageAccount.addEventListener(MouseEvent.CLICK,onManageClick);
         loadUserPreference();
         mcLogin.warning.s = String("Sorry! You have been disconnected. \n You will be able to login after $s seconds.");
         mcLogin.warning.visible = false;
         mcLogin.warning.alpha = 0;
         if(params.sURL != null)
         {
            mcLogin.mcLogo.txtTitle.htmlText = "<font color=\"#FFB231\">New Release:</font> " + params.sTitle;
         }
         if("logoutWarningTS" in userPreference.data)
         {
            curTS = Number(new Date().getTime());
            iDiff = userPreference.data.logoutWarningTS + userPreference.data.logoutWarningDur * 1000 - curTS;
            if(iDiff > 60000)
            {
               userPreference.data.logoutWarningDur = 60;
               userPreference.data.logoutWarningTS = curTS;
               try
               {
                  userPreference.flush();
               }
               catch(e:Error)
               {
               }
            }
            if(iDiff > 1000)
            {
               initLoginWarning();
            }
         }
      }
      
      public function onBtnDn(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = params.test ? "https://www.aq.com/gamedesignnotes/AQW-Spider-OMGClient-PatchNotess-8456" : "https://www.aq.com/gamedesignnotes/AQW-Spider-AQWClient2-PatchNotes-8484";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      public function loadTitle() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc1_ = "Generic2.swf";
         _loc2_ = "The Skyguard";
         _loc3_ = "https://www.aq.com/game/";
         if(params.sURL != null)
         {
            _loc3_ = params.sURL;
            _loc1_ = params.sBG;
            _loc2_ = params.sTitle;
         }
         else
         {
            params.sURL = _loc3_;
         }
         BGLoader.LoadBG(_loc3_,mcLogin,_loc1_,_loc2_);
         mcLogin.testClientAssets.visible = false;
         mcLogin.testClientAssets.cVersion.text = "Version " + cVersion;
         mcLogin.testClientAssets.dnBtn.addEventListener(MouseEvent.CLICK,onBtnDn,false,0,true);
         mcLogin.testClientAssets.banner.visible = params.test as Boolean;
      }
      
      private function initLoginWarning() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc1_ = mcLogin.warning as MovieClip;
         _loc1_.visible = true;
         _loc1_.alpha = 100;
         mcLogin.btnLogin.visible = false;
         mcLogin.mcOr.visible = false;
         mcLogin.btnFBLogin.visible = false;
         mcLogin.mcForgotPassword.visible = false;
         mcLogin.mcPassword.visible = false;
         _loc2_ = Number(new Date().getTime());
         _loc3_ = Number(userPreference.data.logoutWarningTS);
         _loc4_ = Number(userPreference.data.logoutWarningDur);
         _loc1_.n = Math.round((_loc3_ + _loc4_ * 1000 - _loc2_) / 1000);
         _loc1_.ti.text = _loc1_.s.split("$s")[0] + _loc1_.n + _loc1_.s.split("$s")[1];
         _loc1_.timer = new Timer(1000);
         _loc1_.timer.addEventListener(TimerEvent.TIMER,loginWarningTimer,false,0,true);
         _loc1_.timer.start();
      }
      
      private function loginWarningTimer(param1:TimerEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = mcLogin.warning as MovieClip;
         if(_loc2_.n-- < 1)
         {
            _loc2_.visible = false;
            _loc2_.alpha = 0;
            mcLogin.mcPassword.visible = true;
            mcLogin.btnLogin.visible = true;
            mcLogin.mcOr.visible = true;
            mcLogin.btnFBLogin.visible = true;
            mcLogin.mcForgotPassword.visible = true;
            _loc2_.timer.removeEventListener(TimerEvent.TIMER,loginWarningTimer);
         }
         else
         {
            _loc2_.ti.text = _loc2_.s.split("$s")[0] + _loc2_.n + _loc2_.s.split("$s")[1];
            _loc2_.timer.reset();
            _loc2_.timer.start();
         }
      }
      
      private function onStageLeave(param1:Event) : void
      {
         stage.focus = null;
      }
      
      private function initInterface() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         updateCoreValues(coreValues);
         ctr_watermark.visible = false;
         ctr_watermark.mouseEnabled = ctr_watermark.mouseChildren = false;
         ui.mcFPS.visible = false;
         ui.mcRes.visible = false;
         ui.mcPopup.visible = false;
         ui.mcPortrait.visible = false;
         ui.mcPortrait.iconBoostXP.visible = false;
         ui.mcPortrait.iconBoostG.visible = false;
         ui.mcPortrait.iconBoostRep.visible = false;
         ui.mcPortrait.iconBoostCP.visible = false;
         ui.mcPopup.visible = false;
         hidePortraitTarget();
         ui.visible = false;
         ui.mcInterface.mcXPBar.mcXP.scaleX = 0;
         ui.mcInterface.mcRepBar.mcRep.scaleX = 0;
         ui.mcUpdates.uproto.visible = false;
         ui.mcUpdates.uproto.y = -400;
         ui.mcUpdates.mouseChildren = ui.mcUpdates.mouseEnabled = false;
         hideMCPVPQueue();
         stage.removeEventListener(Event.MOUSE_LEAVE,onStageLeave);
         stage.removeEventListener(KeyboardEvent.KEY_UP,key_actBar);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,key_StageGame);
         ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OVER,xpBarMouseOver);
         ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OUT,xpBarMouseOut);
         ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OVER,onRepBarMouseOver);
         ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OUT,onRepBarMouseOut);
         ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK,portraitClick);
         ui.mcPortrait.removeEventListener(MouseEvent.CLICK,portraitClick);
         ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OVER,oniconBoostXPOver);
         ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OVER,oniconBoostGoldOver);
         ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OVER,oniconBoostRepOver);
         ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OVER,oniconBoostCPOver);
         ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.btnTargetPortraitClose.removeEventListener(MouseEvent.CLICK,onTargetPortraitCloseClick);
         ui.btnMonster.removeEventListener(MouseEvent.CLICK,onBtnMonsterClick);
         ui.mcPVPQueue.removeEventListener(MouseEvent.CLICK,onMCPVPQueueClick);
         ui.mcInterface.tl.mouseEnabled = false;
         chatF.init();
         stage.addEventListener(Event.MOUSE_LEAVE,onStageLeave);
         stage.addEventListener(KeyboardEvent.KEY_UP,key_actBar);
         ui.mcInterface.mcXPBar.strXP.visible = false;
         ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OVER,xpBarMouseOver);
         ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OUT,xpBarMouseOut);
         ui.mcInterface.mcRepBar.strRep.visible = false;
         ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OVER,onRepBarMouseOver);
         ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OUT,onRepBarMouseOut);
         ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK,portraitClick);
         ui.mcPortrait.addEventListener(MouseEvent.CLICK,portraitClick);
         ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OVER,oniconBoostXPOver);
         ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OVER,oniconBoostGoldOver);
         ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OVER,oniconBoostRepOver);
         ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OVER,oniconBoostCPOver);
         ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OUT,oniconBoostOut);
         ui.btnTargetPortraitClose.addEventListener(MouseEvent.CLICK,onTargetPortraitCloseClick);
         ui.btnMonster.addEventListener(MouseEvent.CLICK,onBtnMonsterClick);
         ui.mcPVPQueue.addEventListener(MouseEvent.CLICK,onMCPVPQueueClick);
         ui.iconQuest.visible = false;
         ui.iconQuest.buttonMode = true;
         ui.iconQuest.addEventListener(MouseEvent.CLICK,oniconQuestClick);
         ui.mcInterface.tl.mouseEnabled = false;
         ui.mcInterface.areaList.mouseEnabled = false;
         ui.mcInterface.areaList.title.mouseEnabled = false;
         ui.mcInterface.areaList.title.bMinMax.addEventListener(MouseEvent.CLICK,areaListClick);
         if(litePreference.data.bCustomDrops)
         {
            if(cDropsUI)
            {
               cDropsUI.cleanup();
            }
            cDropsUI = new customDrops(this);
         }
         if(litePreference.data.bDebugger)
         {
            if(cMenuUI)
            {
               cMenuUI.cleanup();
            }
            cMenuUI = new cellMenu(this);
            if(pLoggerUI)
            {
               pLoggerUI.cleanup();
            }
            if(litePreference.data.dOptions["debugPacket"])
            {
               pLoggerUI = new packetlogger(this);
            }
         }
         if(Boolean(litePreference.data.bAuras) && !ui.mcInterface.getChildByName("playerAuras"))
         {
            pAurasUI = new playerAuras(this);
            ui.mcPortrait.addChild(pAurasUI);
            tAurasUI = new targetAuras(this);
            ui.mcPortraitTarget.addChild(tAurasUI);
         }
         if(intChatMode)
         {
            ui.mcInterface.bMinMax.visible = false;
            ui.mcInterface.bShortTall.visible = false;
            ui.mcInterface.bCannedChat.visible = false;
            ui.mcInterface.tt.visible = false;
            ui.mcInterface.tebg.visible = false;
            ui.mcInterface.bsend.visible = false;
            ui.nc.visible = true;
            ui.mcInterface.ncModeChat.visible = true;
            ui.mcInterface.ncCannedChat.visible = true;
            ui.mcInterface.ncHistory.visible = true;
            ui.mcInterface.ncTxtBG.visible = true;
            ui.mcInterface.ncPrefix.visible = true;
            ui.mcInterface.ncText.visible = true;
            ui.mcInterface.ncSendText.visible = true;
         }
         else
         {
            ui.mcInterface.bMinMax.visible = true;
            ui.mcInterface.bShortTall.visible = true;
            ui.mcInterface.bCannedChat.visible = true;
            ui.mcInterface.tt.visible = true;
            ui.mcInterface.tebg.visible = true;
            ui.mcInterface.bsend.visible = true;
            ui.nc.visible = false;
            ui.mcInterface.ncModeChat.visible = false;
            ui.mcInterface.ncCannedChat.visible = false;
            ui.mcInterface.ncHistory.visible = false;
            ui.mcInterface.ncTxtBG.visible = false;
            ui.mcInterface.ncPrefix.visible = false;
            ui.mcInterface.ncText.visible = false;
            ui.mcInterface.ncSendText.visible = false;
         }
         keyDict = getKeyboardDict();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = ui.mcInterface.getChildByName("keyA" + _loc1_);
            if(_loc1_ == 0)
            {
               _loc2_.text = !litePreference.data.keys["Auto Attack"] ? " " : keyDict[litePreference.data.keys["Auto Attack"]];
            }
            else
            {
               _loc2_.text = !litePreference.data.keys["Skill " + _loc1_] ? " " : keyDict[litePreference.data.keys["Skill " + _loc1_]];
            }
            _loc2_.mouseEnabled = false;
            _loc1_++;
         }
      }
      
      public function traceHack(param1:String) : void
      {
         chatF.pushMsg("server",param1,"SERVER","",0);
      }
      
      private function onUserFocus(param1:FocusEvent) : *
      {
         if(mcLogin.ni.text == "click here")
         {
            mcLogin.ni.text = "";
         }
      }
      
      private function loadUserPreference() : *
      {
         if(userPreference.data.bitCheckedUsername)
         {
            mcLogin.ni.text = TempLoginName != "" ? TempLoginName : userPreference.data.strUsername;
            mcLogin.chkUserName.bitChecked = true;
         }
         if(userPreference.data.bitCheckedPassword)
         {
            mcLogin.pi.text = TempLoginPass != "" ? TempLoginPass : userPreference.data.strPassword;
            mcLogin.chkPassword.bitChecked = true;
         }
         mcLogin.chkUserName.checkmark.visible = mcLogin.chkUserName.bitChecked;
         mcLogin.chkPassword.checkmark.visible = mcLogin.chkPassword.bitChecked;
      }
      
      private function saveUserPreference() : *
      {
         userPreference.data.bitCheckedUsername = mcLogin.chkUserName.bitChecked;
         userPreference.data.bitCheckedPassword = mcLogin.chkPassword.bitChecked;
         if(mcLogin.chkUserName.bitChecked)
         {
            userPreference.data.strUsername = mcLogin.ni.text;
         }
         else
         {
            userPreference.data.strUsername = "";
         }
         if(mcLogin.chkPassword.bitChecked)
         {
            userPreference.data.strPassword = mcLogin.pi.text;
         }
         else
         {
            userPreference.data.strPassword = "";
         }
         try
         {
            userPreference.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onCreateNewAccount(param1:MouseEvent) : void
      {
         mixer.playSound("Click");
         gotoAndPlay("Account");
      }
      
      private function onForgotPassword(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://account.aq.com/Login/Forgot"));
      }
      
      private function onManageClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://account.aq.com/"));
      }
      
      private function onAccountRecovery(param1:MouseEvent) : void
      {
         mixer.playSound("Click");
         navigateToURL(new URLRequest("https://www.aq.com/help/aw-account-recovery.asp"));
      }
      
      private function onLoginClick(param1:MouseEvent) : void
      {
         if("btnLogin" in mcLogin && Boolean(mcLogin.btnLogin.visible))
         {
            if(mcLogin.ni.text != "" && mcLogin.pi.text != "")
            {
               try
               {
                  saveUserPreference();
               }
               catch(e:*)
               {
               }
               if(FacebookConnect.isLoggedIn)
               {
                  FacebookConnect.Logout();
               }
               login(mcLogin.ni.text.toLowerCase(),mcLogin.pi.text);
            }
         }
      }
      
      public function CallFBConnect(param1:Function) : void
      {
         this.addEventListener(FacebookConnectEvent.ONCONNECT,FBLoginCreate);
         FBConnectCallback = param1;
         FacebookConnect.RequestFBConnect();
      }
      
      public function GetFBMe() : Object
      {
         return FacebookConnect.Me;
      }
      
      public function isFBLoggedIn() : Boolean
      {
         return FacebookConnect.isLoggedIn;
      }
      
      public function FBIP() : String
      {
         return FacebookConnect.IPAddr;
      }
      
      public function GetFBToken() : String
      {
         return FacebookConnect.AccessToken;
      }
      
      private function onFBLoginClick(param1:MouseEvent) : void
      {
         if("btnLogin" in mcLogin && Boolean(mcLogin.btnLogin.visible))
         {
            mcConnDetail.showConn("Connecting to Facebook");
            this.addEventListener(FacebookConnectEvent.ONCONNECT,FBLogin);
            FacebookConnect.RequestFBConnect();
         }
      }
      
      public function FBLogin(param1:FacebookConnectEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         var _loc5_:URLLoader = null;
         this.removeEventListener(FacebookConnectEvent.ONCONNECT,FBLogin);
         if(param1.params.success)
         {
            params.FBID = FacebookConnect.Me.id;
            params.token = FacebookConnect.AccessToken;
            _loc2_ = rn.rand();
            mcConnDetail.showConn("Loading Server List...");
            _loc3_ = new URLRequest(params.loginURL);
            _loc4_ = new URLVariables();
            _loc4_.fbid = FacebookConnect.Me.id;
            _loc4_.fbtoken = FacebookConnect.AccessToken;
            FacebookConnect.isLoggedIn = true;
            _loc3_.data = _loc4_;
            _loc3_.method = URLRequestMethod.POST;
            _loc5_ = new URLLoader();
            _loc5_.addEventListener(Event.COMPLETE,onLoginComplete);
            _loc5_.load(_loc3_);
         }
         else
         {
            mcConnDetail.showError(param1.params.message);
         }
      }
      
      public function FBLoginCreate(param1:FacebookConnectEvent) : void
      {
         var fbevt:FacebookConnectEvent = param1;
         this.removeEventListener(FacebookConnectEvent.ONCONNECT,FBLoginCreate);
         if(this.FBConnectCallback != null)
         {
            try
            {
               FBConnectCallback();
            }
            catch(e:Error)
            {
            }
         }
         FBConnectCallback = null;
      }
      
      public function getFBUser() : void
      {
         if(ISWEB)
         {
            extCall.getFBUser();
         }
      }
      
      public function login(param1:String, param2:String) : *
      {
         var rand:Number = NaN;
         var url:String = null;
         var request:URLRequest = null;
         var variables:URLVariables = null;
         var strUsername:String = param1;
         var strPassword:String = param2;
         var arrAllowLocal:Array = new Array("zhoom","ztest00","ztest01","ztest02","iterator","zdhz","yorumi");
         mcConnDetail.showConn("Authenticating Account Info...");
         loginInfo.strUsername = strUsername;
         loginInfo.strPassword = strPassword;
         rand = rn.rand();
         url = "cf-userlogin.asp?ran=" + rand;
         url = params.loginURL + "?ran=" + rand;
         request = new URLRequest(url);
         variables = new URLVariables();
         variables.user = strUsername;
         variables.pass = strPassword;
         variables.option = ISWEB ? "0" : "1";
         if(checkPasswordStrength(strPassword) < 18)
         {
            bPassword = false;
         }
         if(params.strSourceID == "FACEBOOK")
         {
            variables.strSourceID = params.strSourceID;
            variables.fbid = params.FBID;
            variables.fbtoken = params.token;
         }
         else if(params.strSourceID == "TAGGED")
         {
            variables.strSourceID = params.strSourceID;
            variables.SrcUserID = params.SrcUserID;
            variables.token = params.token;
         }
         request.data = variables;
         request.method = URLRequestMethod.POST;
         loginLoader.removeEventListener(Event.COMPLETE,onLoginComplete);
         loginLoader.addEventListener(Event.COMPLETE,onLoginComplete);
         loginLoader.addEventListener(IOErrorEvent.IO_ERROR,onLoginError,false,0,true);
         try
         {
            loginLoader.load(request);
         }
         catch(error:Error)
         {
         }
      }
      
      public function onLoginError(param1:Event) : void
      {
      }
      
      public function onLoginComplete(param1:Event) : void
      {
         var _obj:Object = null;
         var event:Event = param1;
         try
         {
            _obj = com.adobe.serialization.json.JSON.decode(event.target.data);
            if(_obj.login)
            {
               objLogin = _obj.login;
               objLogin.servers = _obj.servers;
               playerPollData = _obj.polldata;
            }
            else
            {
               objLogin = _obj;
            }
            loginLoader.removeEventListener(Event.COMPLETE,onLoginComplete);
            if(objLogin.bSuccess == 1)
            {
               try
               {
                  loginInfo.strUsername = objLogin.unm.toLowerCase();
               }
               catch(e:*)
               {
               }
               if(loginInfo.strUsername != null)
               {
                  if(loginInfo.strUsername.toLowerCase() == "iterator" || loginInfo.strUsername.toLowerCase() == "iterator2" || loginInfo.strUsername.toLowerCase() == "iterator3" || loginInfo.strUsername.toLowerCase() == "iterator4")
                  {
                     serialCmdMode = true;
                  }
                  else
                  {
                     serialCmdMode = false;
                  }
               }
               else
               {
                  serialCmdMode = false;
               }
               if(objLogin.FBID != null)
               {
                  if(FacebookConnect.Me == null)
                  {
                     FacebookConnect.Me = new Object();
                  }
                  FacebookConnect.Me.id = objLogin.FBID;
                  if(objLogin.FBName != null)
                  {
                     FacebookConnect.Me.name = objLogin.FBName;
                  }
               }
               if(fbL != null)
               {
                  fbL.destroy();
               }
               if(ISWEB)
               {
                  extCall.getFBUser();
               }
               mcConnDetail.hideConn();
               loginInfo.strToken = objLogin.sToken;
               sToken = loginInfo.strToken;
               strToken = loginInfo.strToken;
               if(ISWEB)
               {
                  extCall.setToken(loginInfo);
               }
               if(serialCmdMode)
               {
                  mcLogin.testClientAssets.visible = false;
                  mcLogin.gotoAndStop("Iterator");
               }
               else
               {
                  mcLogin.gotoAndStop("Servers");
               }
            }
            else if(objLogin.sMsg.indexOf("Facebook") > -1)
            {
               mcConnDetail.hideConn();
               fbL = new fbLinkWindow(mcLogin.fbConnect,this as MovieClip);
               mcLogin.fbConnect.visible = true;
            }
            else
            {
               mcConnDetail.showError(objLogin.sMsg);
            }
         }
         catch(e:*)
         {
         }
         resetsOnNewSession();
      }
      
      public function resetsOnNewSession() : void
      {
         if(Boolean(litePreference.data.bDebugger) && objLogin.iAccess < 30)
         {
            optionHandler.cmd(MovieClip(this),"@ Debugger");
         }
      }
      
      public function deepCopy(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         for(_loc3_ in param2)
         {
            if(typeof (param2 as Object)[_loc3_] == "object")
            {
               (param1 as Object)[_loc3_] = new Object();
               deepCopy((param1 as Object)[_loc3_],(param2 as Object)[_loc3_]);
            }
            else if((param2 as Object)[_loc3_])
            {
               (param1 as Object)[_loc3_] = (param2 as Object)[_loc3_];
            }
         }
      }
      
      public function deepCopyArr(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param2)
         {
            param1.push(_loc3_);
         }
      }
      
      public function saveChar() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         if(FacebookConnect.isLoggedIn || !litePreference.data.bCharSelect)
         {
            return;
         }
         _loc1_ = new Object();
         _loc1_["strGender"] = world.myAvatar.objData.strGender;
         _loc1_["strHairFilename"] = world.myAvatar.objData.strHairFilename;
         _loc1_["strHairName"] = world.myAvatar.objData.strHairName;
         _loc1_["eqp"] = {};
         deepCopy(_loc1_["eqp"],world.myAvatar.objData.eqp);
         _loc1_["intGold"] = world.myAvatar.objData.intGold;
         _loc1_["intCoins"] = world.myAvatar.objData.intCoins;
         _loc1_["strClassName"] = world.myAvatar.objData.strClassName;
         _loc1_["iCP"] = world.myAvatar.objData.iCP;
         _loc1_["intLevel"] = world.myAvatar.objData.intLevel;
         _loc1_["strUsername"] = world.myAvatar.objData.strUsername;
         _loc1_["intAccessLevel"] = world.myAvatar.objData.intAccessLevel;
         _loc1_["iUpgDays"] = world.myAvatar.objData.iUpgDays;
         _loc1_["intColorSkin"] = world.myAvatar.objData.intColorSkin;
         _loc1_["intColorHair"] = world.myAvatar.objData.intColorHair;
         _loc1_["intColorEye"] = world.myAvatar.objData.intColorEye;
         _loc1_["intColorBase"] = world.myAvatar.objData.intColorBase;
         _loc1_["intColorTrim"] = world.myAvatar.objData.intColorTrim;
         _loc1_["intColorAccessory"] = world.myAvatar.objData.intColorAccessory;
         if(world.myAvatar.objData.guild != null)
         {
            _loc1_["guild"] = {};
            _loc1_["guild"]["Name"] = world.myAvatar.objData.guild.Name;
         }
         _loc1_["showHelm"] = world.myAvatar.dataLeaf.showHelm;
         _loc1_["showCloak"] = world.myAvatar.dataLeaf.showCloak;
         if(Boolean(characters.data.users) && Boolean(characters.data.users[world.myAvatar.pnm.toLowerCase()]))
         {
            (characters.data.users[world.myAvatar.pnm.toLowerCase()] as Object).data = _loc1_;
            (characters.data.users[world.myAvatar.pnm.toLowerCase()] as Object).server = objServerInfo.sName;
         }
         else
         {
            _loc2_ = 0;
            for(_loc3_ in characters.data.users)
            {
               _loc2_++;
            }
            if(_loc2_ >= 5)
            {
               return;
            }
            (loginInfo as Object).bAsk = false;
            _loc4_ = new Object();
            deepCopy(_loc4_,loginInfo);
            characters.data.users[world.myAvatar.pnm.toLowerCase()] = {
               "index":-1,
               "data":_loc1_,
               "server":objServerInfo.sName,
               "loginInfo":_loc4_
            };
         }
         characters.flush();
      }
      
      public function charCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(!characters.data.users)
         {
            characters.data.users = new Object();
            characters.data.retro = true;
            characters.flush();
            return 0;
         }
         _loc1_ = 0;
         for(_loc2_ in characters.data.users)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function retroLowercase() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         if(charCount() == 0)
         {
            return;
         }
         if(characters.data.retro)
         {
            return;
         }
         _loc1_ = false;
         for(_loc2_ in characters.data.users)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_.charAt(_loc3_) != _loc2_.charAt(_loc3_).toLowerCase())
               {
                  _loc1_ = true;
                  break;
               }
               _loc3_++;
            }
            if(_loc1_)
            {
               break;
            }
         }
         if(_loc1_)
         {
            resetChars();
         }
         else
         {
            characters.data.retro = true;
         }
      }
      
      public function resetChars() : void
      {
         characters.data.users = null;
         delete characters.data.users;
         characters.flush();
      }
      
      private function loadExternalAssets() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:* = undefined;
         mcConnDetail.showConn("Initializing Client...");
         _loc1_ = new Loader();
         _loc2_ = new URLRequest(serverFilePath + "interface/Assets/" + world.objInfo.sAssets);
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,assetsLoaderCallback,false,0,true);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,assetsLoaderErrorHandler,false,0,true);
         _loc1_.load(_loc2_,assetsContext);
      }
      
      private function assetsLoaderCallback(param1:Event) : void
      {
         ASSETS_READY = world.objInfo.sAssets;
         resumeOnLoginResponse();
      }
      
      private function resumeOnLoginResponse() : void
      {
         var _loc1_:int = 0;
         mcConnDetail.showConn("Joining Lobby..");
         sfc.sendXtMessage("zm","firstJoin",[],"str",1);
         if(chatF.ignoreList.data.users.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < chatF.ignoreList.data.users.length)
            {
               if(chatF.ignoreList.data.users[_loc1_].toLowerCase() == loginInfo.strUsername.toLowerCase())
               {
                  chatF.ignoreList.data.users.splice(_loc1_,1);
                  break;
               }
               _loc1_++;
            }
            sfc.sendXtMessage("zm","cmd",["ignoreList",chatF.ignoreList.data.users],"str",1);
         }
         else
         {
            sfc.sendXtMessage("zm","cmd",["ignoreList","$clearAll"],"str",1);
         }
      }
      
      private function assetsLoaderErrorHandler(param1:IOErrorEvent) : void
      {
         mcConnDetail.showError("Client Initialization Failed!");
      }
      
      public function connectTo(param1:String, param2:int = 5588) : *
      {
         serverIP = param1;
         mixer.playSound("ClickBig");
         mcConnDetail.showConn("Connecting to game server...");
         if(sfc.isConnected)
         {
            sfc.disconnect();
         }
         sfc.connect(param1,param2);
         gotoAndPlay("Game");
      }
      
      public function displayCharPage(param1:String) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new _loc2_(this,param1);
         ui.addChild(_loc2_);
      }
      
      public function togglePolls() : void
      {
         requestInterface("polls/pollingsystem.swf","pollingSystem");
      }
      
      public function requestInterface(param1:String, param2:String) : void
      {
         removeDeadInterfaces();
         interfaceQueue.push({
            "nam":param2,
            "intrf":param1
         });
         if(interfaceQueue.length == 1)
         {
            checkInterfaceQueue();
         }
      }
      
      public function checkInterfaceQueue() : void
      {
         var _loc1_:Loader = null;
         if(interfaceQueue.length < 1)
         {
            return;
         }
         visualLoader = new mcLoader();
         visualLoader.x = 400;
         visualLoader.y = 211;
         this.addChild(visualLoader);
         _loc1_ = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,onInterfaceComplete,false,0,true);
         _loc1_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onInterfaceProgress,false,0,true);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onInterfaceError,false,0,true);
         _loc1_.load(new URLRequest(getFilePath() + "interface/" + interfaceQueue[0].intrf + "?v=" + world.objInfo["sVersion"]));
      }
      
      public function onInterfaceComplete(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new MovieClip();
         _loc2_.addChild(param1.currentTarget.content);
         _loc2_.name = interfaceQueue[0].nam;
         _loc3_ = this.addChild(_loc2_);
         if(interfaceRef.hasOwnProperty(interfaceQueue[0].nam))
         {
            if(interfaceRef[interfaceQueue[0].nam])
            {
               if(interfaceRef[interfaceQueue[0].nam].parent)
               {
                  MovieClip(interfaceRef[interfaceQueue[0].nam].parent).removeChild(interfaceRef[interfaceQueue[0].nam]);
               }
            }
         }
         interfaceRef[interfaceQueue[0].nam] = _loc3_;
         interfaceQueue.shift();
         checkInterfaceQueue();
         this.setChildIndex(MsgBox,numChildren - 1);
         if(_loc2_.name == "pony_engine")
         {
            world.myAvatar.swapMorphs(true);
         }
      }
      
      public function cleanupInterfaces() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in interfaceRef)
         {
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  MovieClip(_loc1_.parent).removeChild(_loc1_);
               }
            }
         }
         interfaceRef = new Object();
      }
      
      public function removeDeadInterfaces() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:* = undefined;
         _loc2_ = [];
         for(_loc1_ in interfaceRef)
         {
            _loc3_ = interfaceRef[_loc1_];
            if(_loc3_)
            {
               if(!_loc3_.parent)
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         for each(_loc1_ in _loc2_)
         {
            delete interfaceRef[_loc1_];
         }
      }
      
      public function getInterface(param1:String) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = interfaceRef[param1];
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               return _loc2_;
            }
            delete interfaceRef[param1];
         }
         return null;
      }
      
      public function onInterfaceProgress(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         interfaceLoaded = param1.bytesLoaded;
         interfaceTotal = param1.bytesTotal;
         _loc2_ = interfaceLoaded / interfaceTotal * 100;
         var _loc3_:Number = interfaceLoaded / interfaceTotal;
         visualLoader.mcPct.text = _loc2_ + "%";
         if(interfaceLoaded >= interfaceTotal)
         {
            visualLoader.parent.removeChild(visualLoader);
            visualLoader = null;
         }
      }
      
      public function onInterfaceError(param1:IOErrorEvent) : void
      {
      }
      
      public function requestAPI(param1:String, param2:*, param3:*, param4:*, param5:Boolean = false) : void
      {
         var _loc6_:URLLoader = null;
         var _loc7_:Array = null;
         var _loc8_:URLVariables = null;
         var _loc9_:URLRequest = null;
         var _loc10_:* = undefined;
         _loc6_ = new URLLoader();
         _loc6_.addEventListener(Event.COMPLETE,param3,false,0,true);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,param4,false,0,true);
         _loc7_ = [new URLRequestHeader("ccid",world.myAvatar.objData.CharID),new URLRequestHeader("token",loginInfo.strToken)];
         _loc8_ = new URLVariables();
         if(param2 != null)
         {
            for(_loc10_ in param2)
            {
               _loc8_[_loc10_] = _loc10_ == "layout" ? com.adobe.serialization.json.JSON.encode(param2[_loc10_]) : param2[_loc10_];
            }
         }
         _loc9_ = new URLRequest(serverGamePath + "api/char/" + param1 + (param5 ? "?v=" + Math.random() : ""));
         _loc9_.requestHeaders = _loc7_;
         if(param2 != null)
         {
            _loc9_.data = _loc8_;
         }
         _loc9_.method = URLRequestMethod.POST;
         _loc6_.load(_loc9_);
      }
      
      public function getBank() : void
      {
         requestAPI("bank",{"layout":{"cat":"all"}},onBankComplete,onBankError,true);
      }
      
      public function onBankComplete(param1:Event) : void
      {
         world.addItemsToBank(com.adobe.serialization.json.JSON.decode(param1.target.data));
      }
      
      public function onBankError(param1:IOErrorEvent) : void
      {
         mcConnDetail.showConn("Error loading bank information");
      }
      
      public function retrieveInfo(param1:Array) : void
      {
         var _loc2_:URLLoader = null;
         var _loc3_:* = undefined;
         if(serverGamePath.indexOf("content.aq") == -1)
         {
            for each(_loc3_ in param1)
            {
               world.objInfo[_loc3_.split("=")[0]] = _loc3_.substr(_loc3_.indexOf("=") + 1);
            }
            iMaxBagSlots = Number(world.objInfo["iMaxBagSlots"]);
            iMaxBankSlots = Number(world.objInfo["iMaxBankSlots"]);
            iMaxHouseSlots = Number(world.objInfo["iMaxHouseSlots"]);
            iMaxFriends = Number(world.objInfo["iMaxFriends"]);
            iMaxLoadoutSlots = Number(world.objInfo["iMaxLoadoutSlots"]);
            if(ASSETS_READY == param1["sAssets"])
            {
               BOOK_DATA_READY = null;
               resumeOnLoginResponse();
            }
            else
            {
               BOOK_DATA_READY = null;
               loadExternalAssets();
            }
            return;
         }
         _loc2_ = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,onInfoComplete,false,0,true);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,onInfoError,false,0,true);
         _loc2_.load(new URLRequest(serverGamePath + "api/data/clientvars?v=" + Math.random()));
      }
      
      public function retrieveBook() : void
      {
         var _loc1_:URLLoader = null;
         if(ui.getChildByName("travelLoaderMC"))
         {
            return;
         }
         travelLoaderMC = new (world.getClass("mcLoader") as Class)();
         travelLoaderMC.x = 400;
         travelLoaderMC.y = 211;
         travelLoaderMC.name = "travelLoaderMC";
         ui.addChild(travelLoaderMC);
         _loc1_ = new URLLoader();
         _loc1_.addEventListener(Event.COMPLETE,onBoLComplete,false,0,true);
         _loc1_.addEventListener(ProgressEvent.PROGRESS,onBoLProgress,false,0,true);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,onBoLError,false,0,true);
         _loc1_.load(new URLRequest(serverGamePath + "api/data/booklore?v=" + world.objInfo["sVersion"]));
      }
      
      public function onInfoComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         _loc2_ = com.adobe.serialization.json.JSON.decode(param1.target.data);
         for(_loc3_ in _loc2_)
         {
            world.objInfo[_loc3_] = _loc2_[_loc3_];
         }
         iMaxBagSlots = Number(_loc2_["iMaxBagSlots"]);
         iMaxBankSlots = Number(_loc2_["iMaxBankSlots"]);
         iMaxHouseSlots = Number(_loc2_["iMaxHouseSlots"]);
         iMaxFriends = Number(_loc2_["iMaxFriends"]);
         iMaxLoadoutSlots = Number(_loc2_["iMaxLoadoutSlots"]);
         if(ASSETS_READY == _loc2_["sAssets"])
         {
            BOOK_DATA_READY = null;
            resumeOnLoginResponse();
         }
         else
         {
            BOOK_DATA_READY = null;
            loadExternalAssets();
         }
      }
      
      public function onInfoError(param1:IOErrorEvent) : void
      {
         mcConnDetail.showConn("Error loading client vars");
      }
      
      public function onBoLComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         _loc2_ = com.adobe.serialization.json.JSON.decode(param1.target.data);
         world.bookData = _loc2_;
         BOOK_DATA_READY = _loc2_;
         ui.mcPopup.mcBook.removeChildAt(0);
         if(bolContent)
         {
            if(newInstance)
            {
               newInstance = false;
               bolContent.gotoAndStop("NavMenu");
            }
            ui.mcPopup.mcBook.addChild(bolContent);
            return;
         }
         bolLoader = new Loader();
         bolLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onBoLContentComplete,false,0,true);
         bolLoader.load(new URLRequest(Game.serverFilePath + world.objInfo.sBook),new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      public function onBoLContentComplete(param1:Event) : void
      {
         bolContent = param1.currentTarget.content;
         ui.mcPopup.mcBook.addChild(bolContent);
      }
      
      private function onBoLProgress(param1:ProgressEvent) : void
      {
         var _loc2_:int = 0;
         bLoaded = param1.bytesLoaded;
         bTotal = param1.bytesTotal;
         _loc2_ = bLoaded / bTotal * 100;
         var _loc3_:Number = bLoaded / bTotal;
         travelLoaderMC.mcPct.text = _loc2_ + "%";
         if(bLoaded >= bTotal)
         {
            travelLoaderMC.parent.removeChild(travelLoaderMC);
            travelLoaderMC = null;
         }
      }
      
      private function onBoLError(param1:IOErrorEvent) : void
      {
         if(travelLoaderMC)
         {
            travelLoaderMC.parent.removeChild(travelLoaderMC);
            travelLoaderMC = null;
         }
      }
      
      public function serialCmdInit(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = mcLogin.il;
         _loc3_ = _loc2_.cmd;
         _loc3_.btnUnselectAll.visible = false;
         _loc3_.btnSelectAll.visible = false;
         _loc3_.btnGo.visible = false;
         serialCmd.si = 0;
         serialCmd.cmd = param1;
         serialCmd.active = true;
         serialCmdNext();
      }
      
      private function serialCmdNext() : void
      {
         var _loc1_:Date = null;
         var _loc2_:* = undefined;
         var _loc4_:* = undefined;
         _loc1_ = new Date();
         _loc2_ = mcLogin.il.iClass;
         var _loc3_:* = mcLogin.il.cmd;
         if(serialCmd.si > 0)
         {
            _loc4_ = _loc2_.getServerItemByIP(serialCmd.servers[serialCmd.si - 1].sIP,serialCmd.servers[serialCmd.si - 1].iPort);
            if(_loc4_ != null)
            {
               _loc2_.serverOn(_loc4_);
               _loc4_.t3.text = (_loc1_.getTime() - serialCmd.ts) / 1000 + " s";
               _loc4_.t3.visible = true;
            }
         }
         if(serialCmd.si < serialCmd.servers.length)
         {
            sfc.connect(serialCmd.servers[serialCmd.si].sIP,serialCmd.servers[serialCmd.si].iPort);
            ++serialCmd.si;
            serialCmd.ts = _loc1_.getTime();
         }
         else
         {
            serialCmdDone();
         }
      }
      
      private function serialCmdDone() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = mcLogin.il;
         _loc2_ = _loc1_.cmd;
         _loc2_.btnUnselectAll.visible = true;
         _loc2_.btnSelectAll.visible = true;
         _loc2_.btnGo.visible = true;
         serialCmd.active = false;
      }
      
      public function readIA1Preferences() : void
      {
         uoPref.bCloak = world.getAchievement("ia1",0) == 0;
         uoPref.bHelm = world.getAchievement("ia1",1) == 0;
         uoPref.bPet = world.getAchievement("ia1",2) == 0;
         uoPref.bWAnim = world.getAchievement("ia1",3) == 0;
         uoPref.bGoto = world.getAchievement("ia1",4) == 0;
         uoPref.bMusicOn = world.getAchievement("ia1",6) == 0;
         uoPref.bFriend = world.getAchievement("ia1",7) == 0;
         uoPref.bParty = world.getAchievement("ia1",8) == 0;
         uoPref.bGuild = world.getAchievement("ia1",9) == 0;
         uoPref.bWhisper = world.getAchievement("ia1",10) == 0;
         uoPref.bTT = world.getAchievement("ia1",11) == 0;
         uoPref.bFBShare = world.getAchievement("ia1",12) == 1;
         uoPref.bDuel = world.getAchievement("ia1",13) == 0;
         world.hideAllCapes = world.getAchievement("ia1",14) == 1;
         world.hideOtherPets = world.getAchievement("ia1",15) == 1;
         world.showAnimations = world.getAchievement("ia1",17) == 0;
         uoPref.bProf = world.getAchievement("ia1",18) == 0;
         uoPref.bFBShard = false;
         mixer.stf = new SoundTransform(litePreference.data.dOptions["iSoundFX"] != null ? Number(litePreference.data.dOptions["iSoundFX"]) : 1);
         SoundMixer.soundTransform = new SoundTransform(litePreference.data.dOptions["iSoundAll"] != null ? Number(litePreference.data.dOptions["iSoundAll"]) : 1);
      }
      
      public function inituoPref() : void
      {
         uoPref.bCloak = true;
         uoPref.bHelm = true;
         uoPref.bPet = true;
         uoPref.bWAnim = true;
         uoPref.bGoto = true;
         uoPref.bMusicOn = true;
         uoPref.bFriend = true;
         uoPref.bParty = true;
         uoPref.bGuild = true;
         uoPref.bWhisper = true;
         uoPref.bTT = true;
         uoPref.bFBShare = false;
         uoPref.bDuel = true;
      }
      
      public function initKeybindPref(param1:Boolean = false) : void
      {
         if(Boolean(litePreference.data.keys) && !litePreference.data.keys["Dash"])
         {
            litePreference.data.keys["Dash"] = 32;
            litePreference.data.keys["Jump"] = null;
         }
         if(Boolean(litePreference.data.keys) && !param1)
         {
            return;
         }
         litePreference.data.keys = {};
         litePreference.data.keys["Camera Tool"] = 219;
         litePreference.data.keys["World Camera"] = 221;
         litePreference.data.keys["Target Random Monster"] = 84;
         litePreference.data.keys["Inventory"] = 73;
         litePreference.data.keys["Bank"] = 66;
         litePreference.data.keys["Quest Log"] = 76;
         litePreference.data.keys["Friends List"] = 70;
         litePreference.data.keys["Character Panel"] = 67;
         litePreference.data.keys["Player HP Bar"] = 86;
         litePreference.data.keys["Options"] = 79;
         litePreference.data.keys["Area List"] = 85;
         litePreference.data.keys["Jump"] = null;
         litePreference.data.keys["Auto Attack"] = 49;
         litePreference.data.keys["Skill 1"] = 50;
         litePreference.data.keys["Skill 2"] = 51;
         litePreference.data.keys["Skill 3"] = 52;
         litePreference.data.keys["Skill 4"] = 53;
         litePreference.data.keys["Skill 5"] = 54;
         litePreference.data.keys["Travel Menu\'s Travel"] = 89;
         litePreference.data.keys["World Camera\'s Hide"] = 72;
         litePreference.data.keys["Rest"] = 88;
         litePreference.data.keys["Hide Monsters"] = null;
         litePreference.data.keys["Hide Players"] = null;
         litePreference.data.keys["Cancel Target"] = 27;
         litePreference.data.keys["Hide UI"] = null;
         litePreference.data.keys["Battle Analyzer"] = null;
         litePreference.data.keys["Decline All Drops"] = null;
         litePreference.data.keys["Stats Overview"] = null;
         litePreference.data.keys["Battle Analyzer Toggle"] = null;
         litePreference.data.keys["Custom Drops UI"] = null;
         litePreference.data.keys["@ Debugger - Cell Menu"] = 192;
         litePreference.data.keys["@ Debugger - Packet Logger"] = null;
         litePreference.data.keys["Dash"] = 32;
         litePreference.data.keys["Outfits"] = null;
         litePreference.data.keys["Friendships UI"] = null;
      }
      
      public function debugMessage(param1:String) : void
      {
         if(!litePreference.data.bDebugger)
         {
            return;
         }
         chatF.pushMsg("warning",param1,"SERVER","",0);
      }
      
      public function initlitePref() : void
      {
         if(litePreference.data.dOptions == null)
         {
            litePreference.data.dOptions = {};
         }
         if(litePreference.data.dOptions["termsAgree"] == null)
         {
            litePreference.data.dOptions["termsAgree"] = true;
         }
         litePref = [{
            "strName":"@ Debugger",
            "bEnabled":litePreference.data.bDebugger,
            "sDesc":"Debug Mode!\nPress ` (Changeable in Keybinds) to hide/show the cell & pads menu!",
            "minAccess":30,
            "extra":[{
               "strName":"Disable Linkage Errors",
               "bEnabled":litePreference.data.dOptions["debugLinkage"],
               "sDesc":"Avoid receiving linkage error messages"
            },{
               "strName":"Disable Color Coded Items",
               "bEnabled":litePreference.data.dOptions["debugColor"],
               "sDesc":"Prevents color coding of item entries\nRed item = costs 0 ac/gold\nRed item = item is AC and > 12k\nYellow item = is staff"
            },{
               "strName":"Packet Logger",
               "bEnabled":litePreference.data.dOptions["debugPacket"],
               "sDesc":"View all packets sent to the client.\nMust be enabled to use.\nSet a keybind to hide/show the packet logger window."
            }]
         },{
            "strName":"Allow Quest Log Turn-Ins",
            "bEnabled":litePreference.data.bQuestLog,
            "sDesc":"Allows you to turn-in quests using your quest log on the bottom right screen!"
         },{
            "strName":"Auto-Untarget Dead Targets",
            "bEnabled":litePreference.data.bUntargetDead,
            "sDesc":"This will untarget targets that are dead."
         },{
            "strName":"Auto-Untarget Self",
            "bEnabled":litePreference.data.bUntargetSelf,
            "sDesc":"This will prevent you from targetting yourself."
         },{
            "strName":"Battle Analyzer",
            "extra":"btn",
            "sDesc":"This will allow you to monitor your damage dealt, gold earned, and many more!"
         },{
            "strName":"Battlepets",
            "bEnabled":litePreference.data.bBattlepet,
            "sDesc":"Allows your battlepet to fight alongside you without a battlepet class equipped."
         },{
            "strName":"Static Player Art",
            "bEnabled":litePreference.data.bCachePlayers,
            "sDesc":"Reduces the graphics of other players. \n!WARNING! Having this enabled may or may not show some of the other player\'s colors. You will not be able to see their equipment changes with this enabled either.\nYou must change rooms after turning this feature off in order for changes to take effect"
         },{
            "strName":"Char Page",
            "special":1,
            "sDesc":"Search Character Pages"
         },{
            "strName":"Character Select Screen",
            "bEnabled":litePreference.data.bCharSelect,
            "sDesc":"Allows you to replace the login screen with a character select screen."
         },{
            "strName":"Chat Settings",
            "bEnabled":litePreference.data.bChatFilter,
            "sDesc":"Allow the customization of the game\'s chat window with the options below!",
            "extra":[{
               "strName":"Timestamps",
               "bEnabled":litePreference.data.dOptions["timeStamps"],
               "sDesc":"Adding timestamps to chat messages (Server Time)\nOnly works on the old chat ui!"
            },{
               "strName":"Disable Red Messages",
               "bEnabled":litePreference.data.dOptions["disRed"],
               "sDesc":"Avoid receiving combat warning messages in chat"
            }]
         },{
            "strName":"Chat UI",
            "bEnabled":litePreference.data.bChatUI,
            "sDesc":"If enabled, you will switch to the new Chat UI.",
            "extra":[{
               "strName":"Minimal Mode",
               "bEnabled":litePreference.data.dOptions["chatMinimal"],
               "sDesc":"Less intrusive on your gameplay!\nHover over the message box to make the messages visible\nScroll over the message box to scroll!"
            },{
               "strName":"Disable AutoScroll to Bottom",
               "bEnabled":litePreference.data.dOptions["chatScroll"],
               "sDesc":"The Chat UI will not automatically scroll to the bottom on a new message"
            }]
         },{
            "strName":"Class Actives/Auras UI",
            "bEnabled":litePreference.data.bAuras,
            "sDesc":"Work in Progress. No proper stack limit and icons yet.\nAllows you to view your buffs/auras underneath your player portrait and for your enemies as well!",
            "extra":[{
               "strName":"Disable ToolTips",
               "bEnabled":litePreference.data.dOptions["disAuraTips"],
               "sDesc":"Prevents you from seeing tooltips when hovering over an aura."
            },{
               "strName":"Disable Aura Text",
               "bEnabled":litePreference.data.dOptions["disAuraText"],
               "sDesc":"Prevents you from seeing the yellow aura text on you or other players."
            }]
         },{
            "strName":"Color Sets",
            "bEnabled":litePreference.data.bColorSets,
            "sDesc":"Save your colors with this tool that appears when you go customizing your hair or armor colors!"
         },{
            "strName":"Custom Drops UI",
            "bEnabled":litePreference.data.bCustomDrops,
            "sDesc":"Shift+Click to block an item drop!\nYour bank items must be loaded to detect if you already have an item",
            "extra":[{
               "strName":"Invert Menu",
               "bEnabled":litePreference.data.dOptions["invertMenu"],
               "sDesc":"The drop menu will appear at the top of the screen rather than appearing at the bottom"
            },{
               "strName":"Warn When Declining A Drop",
               "bEnabled":litePreference.data.dOptions["warnDecline"],
               "sDesc":"A confirmation box will appear to confirm if you want to decline an item drop"
            },{
               "strName":"Hide Drop Notifications",
               "bEnabled":litePreference.data.dOptions["hideDrop"],
               "sDesc":"This will hide regular drop notifications"
            },{
               "strName":"Hide Temporary Drop Notifications",
               "bEnabled":litePreference.data.dOptions["hideTemp"],
               "sDesc":"This will hide temporary drop notifications"
            },{
               "strName":"Opened Menu",
               "bEnabled":litePreference.data.dOptions["openMenu"],
               "sDesc":"The Custom Drops UI will start up opened rather than closed"
            },{
               "strName":"Draggable Mode",
               "bEnabled":litePreference.data.dOptions["dragMode"],
               "sDesc":"The Custom Drops UI will be draggable rather than being attached to the screen"
            },{
               "strName":"Lock Position",
               "bEnabled":litePreference.data.dOptions["lockMode"],
               "sDesc":"The draggable Custom Drops UI will not be moved from where it was last placed"
            },{
               "strName":"Reset Position",
               "extra":"btn",
               "sDesc":"If the Drop UI somehow goes off-screen and you can\'t see it, then use this to get it back!\nWorks only for \"Draggable Mode\""
            },{
               "strName":"Quantity Warnings",
               "bEnabled":litePreference.data.dOptions["termsAgree"],
               "sDesc":"By disabling this feature you understand help from player support for unaccepted drops will be limited"
            }]
         },{
            "strName":"Disable Chat Scrolling",
            "bEnabled":litePreference.data.bDisChatScroll,
            "sDesc":"Prevents you from scrolling the chat\nOnly works on the old chat ui!"
         },{
            "strName":"Disable Damage Numbers",
            "bEnabled":litePreference.data.bDisDmgDisplay,
            "sDesc":"Disables all damage numbers from showing as well as the white flash/strobe effect"
         },{
            "strName":"Disable Damage Strobe",
            "bEnabled":litePreference.data.bDisDmgStrobe,
            "sDesc":"Prevents the white flash/strobe effect whenever a monster or player is damaged!"
         },{
            "strName":"Disable Monster Animations",
            "bEnabled":litePreference.data.bDisMonAnim,
            "sDesc":"Disables monster animations with the benefit of performance"
         },{
            "strName":"Disable Self Animations",
            "bEnabled":litePreference.data.bDisSelfMAnim,
            "sDesc":"Disables your player\'s movement animations except for walking for the benefit of performance"
         },{
            "strName":"Disable Skill Animations",
            "bEnabled":litePreference.data.bDisSkillAnim,
            "sDesc":"There are two types of animations: Class Skill Animations & Player Movement Animations\nThis feature disables Class Skill Animations only while the regular \"Animations\" setting will disable both Class Skill Animations & Player Movement Animations",
            "extra":[{
               "strName":"Show Your Skill Animations Only",
               "bEnabled":litePreference.data.dOptions["animSelf"],
               "sDesc":"Only works if \"Disable Skill Animations\" is enabled!\nAdds an exception to \"Disable Skill Animations\" to show your skill animations only"
            }]
         },{
            "strName":"Disable Quest Popup",
            "bEnabled":litePreference.data.bDisQPopup,
            "sDesc":"Prevent the Quest Complete Popup if it becomes too intrusive"
         },{
            "strName":"Disable Quest Tracker",
            "bEnabled":litePreference.data.bDisQTracker,
            "sDesc":"Prevent the Quest Tracker from opening"
         },{
            "strName":"Disable Weapon Animations",
            "bEnabled":litePreference.data.bDisWepAnim,
            "sDesc":"Disables weapon animations\nYou can disable a specific player\'s weapon animations by targetting them and clicking on their portrait!",
            "extra":[{
               "strName":"Keep Your Weapon Animations Only",
               "bEnabled":litePreference.data.dOptions["wepSelf"],
               "sDesc":"Only works if \"Disable Weapon Animation\" is enabled!\nHaving this enabled will allow your weapon animations to continue working while others have theirs disabled"
            }]
         },{
            "strName":"Decline All Drops",
            "extra":"btn",
            "sDesc":"Declines all the drops on your screen"
         },{
            "strName":"Display FPS",
            "extra":"btn",
            "sDesc":"Toggles the Frames Per Second Display"
         },{
            "strName":"Draggable Drops",
            "bEnabled":litePreference.data.bDraggable,
            "sDesc":"Allows you to drag, or move around, the drops on your screen\nToggling this on with drops already on your screen will not make those drops draggable\nOnly works if \"Custom Drops UI\" is not enabled"
         },{
            "strName":"Freeze / Lock Monster Position",
            "bEnabled":litePreference.data.bFreezeMons,
            "sDesc":"This will freeze monsters on the map in place to prevent players from luring/dragging monsters all over the map"
         },{
            "strName":"Invisible Monsters",
            "bEnabled":litePreference.data.bHideMons,
            "sDesc":"Make monsters invisible. You can target them by clicking on their shadow"
         },{
            "strName":"Hide Players",
            "bEnabled":litePreference.data.bHidePlayers,
            "sDesc":"This will hide players on the map\nYou can hide specific players by clicking on their portraits (targetting them)!",
            "extra":[{
               "strName":"Show Name Tags",
               "bEnabled":litePreference.data.dOptions["showNames"],
               "sDesc":"Only works if \"Hide Players\" is enabled!\nHaving this enabled will allow you to still see name tags of players even though they\'re hidden."
            },{
               "strName":"Show Shadows",
               "bEnabled":litePreference.data.dOptions["showShadows"],
               "sDesc":"Only works if \"Hide Players\" is enabled!\nHaving this enabled will allow you to still see player shadows and clicking on the shadows will target them."
            }]
         },{
            "strName":"Hide Player Names",
            "bEnabled":litePreference.data.bHideNames,
            "sDesc":"Hides player names\nHover over a player to reveal their name & guild",
            "extra":[{
               "strName":"Hide Guild Names Only",
               "bEnabled":litePreference.data.dOptions["hideGuild"],
               "sDesc":"Player names will be visible, and guild names will be hidden"
            },{
               "strName":"Hide Your Name Only",
               "bEnabled":litePreference.data.dOptions["hideSelf"],
               "sDesc":"Only your name will be hidden.\nEnabling this setting will not make \"Hide Guild Names Only\" work."
            }]
         },{
            "strName":"Hide UI",
            "bEnabled":litePreference.data.bHideUI,
            "sDesc":"Hides player & target portraits located on the top left as well as the map name & area list located on the bottom right"
         },{
            "strName":"Item Drops Block List",
            "extra":"btn",
            "sDesc":"Shift+Click dropped items while using \"Custom Drops UI\" to add items to block!"
         },{
            "strName":"Keybinds",
            "extra":"btn",
            "sDesc":"Customize game keybinds.\nYou can not bind ENTER or /.\nUse BACKSPACE to delete a bind."
         },{
            "strName":"Reaccept Quest After Turn-In",
            "bEnabled":litePreference.data.bReaccept,
            "sDesc":"After turning in a quest, it will try to reaccept the quest if possible"
         },{
            "strName":"Show Monster Type",
            "bEnabled":litePreference.data.bMonsType,
            "sDesc":"Display the monster\'s type as a tag under their name"
         },{
            "strName":"Smooth Background",
            "bEnabled":litePreference.data.bSmoothBG,
            "sDesc":"Removes map background pixelation\nYou must reload the map or move to a new area to see changes take affect"
         },{
            "strName":"Travel Menu",
            "extra":"btn",
            "sDesc":"Jump between multiple maps with a press of a button!\nThe keybind to jump maps is rebindable within \"Keybinds\"!"
         },{
            "strName":"Quest Pinner",
            "bEnabled":litePreference.data.bQuestPin,
            "sDesc":"1. Open quests from any NPC\n2. Press the \"Pin Quests\" button (left)\n3. You can now access it from anywhere by clicking on the yellow (!) quest log icon at the top left!\nShift+Click the yellow (!) quest log icon to open the Quest Tracker!\nShift+Click the quest pinner icon to clear your pinned quests!"
         },{
            "strName":"Quest Progress Notifications",
            "bEnabled":litePreference.data.bQuestNotif,
            "sDesc":"Quest Progress will continue to notify/update you even when you\'ve completed the quest"
         },{
            "strName":"Visual Skill CDs",
            "bEnabled":litePreference.data.bSkillCD,
            "sDesc":"Visual skill cooldowns!"
         },{
            "strName":"Hide Ground Items",
            "bEnabled":litePreference.data.bDisGround,
            "sDesc":"Hides the item type \'Ground\' from other players",
            "extra":[{
               "strName":"Show Your Ground Item Only",
               "bEnabled":litePreference.data.dOptions["groundSelf"],
               "sDesc":"Other players\' ground items will be hidden, while yours remains visible"
            }]
         },{
            "strName":"Hide Healing Bubbles",
            "bEnabled":litePreference.data.bDisHealBubble,
            "sDesc":"Hides the green healing bubbles above players when they\'re low on health"
         }];
      }
      
      public function isTestClient() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = undefined;
         _loc1_ = ["Dev Grotto","Dev04"];
         for each(_loc2_ in _loc1_)
         {
            if(objServerInfo.sName.toLowerCase() == _loc2_.toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      public function castSpellFX(param1:*, param2:*, param3:*, param4:*) : *
      {
         cameraToolMC.castSpellFX();
      }
      
      public function movieClipStopAll(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               try
               {
                  (param1.getChildAt(_loc2_) as MovieClip).gotoAndStop(0);
                  movieClipStopAll(param1.getChildAt(_loc2_) as MovieClip);
               }
               catch(exception:*)
               {
               }
            }
            _loc2_++;
         }
      }
      
      public function rasterizePart(param1:DisplayObject) : Bitmap
      {
         var _loc2_:Matrix = null;
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         var _loc5_:BitmapData = null;
         var _loc6_:Bitmap = null;
         _loc2_ = param1.transform.matrix;
         _loc3_ = param1.getBounds(param1.parent);
         _loc4_ = new Point(param1.x - _loc3_.left,param1.y - _loc3_.top);
         _loc2_.tx = _loc4_.x;
         _loc2_.ty = _loc4_.y;
         _loc5_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc5_.draw(param1,_loc2_,param1.transform.colorTransform,null,null,true);
         _loc6_ = new Bitmap(_loc5_);
         _loc6_.smoothing = true;
         _loc6_.x -= _loc4_.x;
         _loc6_.y -= _loc4_.y;
         return _loc6_;
      }
      
      public function rasterize(param1:MovieClip) : void
      {
         movieClipRasterizeInner(param1);
      }
      
      public function movieClipRasterizeInner(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Sprite = null;
         var _loc5_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               try
               {
                  _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
                  if(_loc3_.visible != false)
                  {
                     _loc3_.getChildAt(0).visible = false;
                     _loc4_ = new Sprite();
                     _loc4_.addChild(rasterizePart(_loc3_.getChildAt(0)));
                     _loc5_ = _loc3_.addChildAt(_loc4_,0);
                     movieClipRasterizeInner(param1.getChildAt(_loc2_) as MovieClip);
                  }
               }
               catch(exception:*)
               {
               }
            }
            _loc2_++;
         }
      }
      
      public function getQuestValidationString(param1:Object) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:* = undefined;
         if(param1.sField != null && world.getAchievement(param1.sField,param1.iIndex) != 0)
         {
            if(param1.sField == "im0")
            {
               return "Monthly Quests are only available once per month.";
            }
            if(param1.sField == "iw0")
            {
               return "Weekly Quests are only available once per week.";
            }
            return "Daily Quests are only available once per day.";
         }
         if(param1.bUpg == 1 && !world.myAvatar.isUpgraded())
         {
            return "Upgrade is required for this quest!";
         }
         if(param1.iSlot >= 0 && world.getQuestValue(param1.iSlot) < param1.iValue - 1)
         {
            return "Quest has not been unlocked!";
         }
         if(param1.iLvl > world.myAvatar.objData.intLevel)
         {
            return "Unlocks at Level " + param1.iLvl + ".";
         }
         if(param1.iClass > 0 && world.myAvatar.getCPByID(param1.iClass) < param1.iReqCP)
         {
            _loc2_ = getRankFromPoints(param1.iReqCP);
            _loc3_ = param1.iReqCP - arrRanks[_loc2_ - 1];
            if(_loc3_ > 0)
            {
               return "Requires " + _loc3_ + " Class Points on " + param1.sClass + ", Rank " + _loc2_ + ".";
            }
            return "Requires " + param1.sClass + ", Rank " + _loc2_ + ".";
         }
         if(param1.FactionID > 1 && world.myAvatar.getRep(param1.FactionID) < param1.iReqRep)
         {
            _loc4_ = getRankFromPoints(param1.iReqRep);
            _loc5_ = param1.iReqRep - arrRanks[_loc4_ - 1];
            if(_loc5_ > 0)
            {
               return "Requires " + _loc5_ + " Reputation for " + param1.sFaction + ", Rank " + _loc4_ + ".";
            }
            return "Requires " + param1.sFaction + ", Rank " + _loc4_ + ".";
         }
         if(param1.reqd != null && !hasRequiredItemsForQuest(param1))
         {
            _loc6_ = "Required Item(s): ";
            _loc7_ = 0;
            while(_loc7_ < param1.reqd.length)
            {
               _loc8_ = world.invTree[param1.reqd[_loc7_].ItemID];
               _loc9_ = int(param1.reqd[_loc7_].iQty);
               if(_loc8_.sES == "ar")
               {
                  _loc10_ = getRankFromPoints(_loc9_);
                  _loc11_ = _loc9_ - arrRanks[_loc10_ - 1];
                  if(_loc11_ > 0)
                  {
                     _loc6_ += _loc11_ + " Class Points on ";
                  }
                  _loc6_ += _loc8_.sName + ", Rank " + _loc10_;
               }
               else
               {
                  _loc6_ += _loc8_.sName;
                  if(_loc9_ > 1)
                  {
                     _loc6_ += "x" + _loc9_;
                  }
               }
               _loc6_ += ", ";
               _loc7_++;
            }
            return _loc6_.substr(0,_loc6_.length - 2) + ".";
         }
         return "";
      }
      
      private function hasRequiredItemsForQuest(param1:Object) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(param1.reqd != null && param1.reqd.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.reqd.length)
            {
               _loc3_ = param1.reqd[_loc2_].ItemID;
               _loc4_ = int(param1.reqd[_loc2_].iQty);
               if(world.invTree[_loc3_] == null || int(world.invTree[_loc3_].iQty) < _loc4_)
               {
                  return false;
               }
               _loc2_++;
            }
         }
         return true;
      }
      
      public function xTryMe(param1:Object) : *
      {
         var _loc2_:String = null;
         switch(param1.sES)
         {
            case "Weapon":
            case "he":
            case "ba":
            case "pe":
            case "ar":
            case "co":
            case "mi":
               _loc2_ = param1.sES;
               _loc2_ = _loc2_ == "ar" ? "co" : _loc2_;
               if(_loc2_ == "pe")
               {
                  if(world.myAvatar.objData.eqp["pe"])
                  {
                     world.myAvatar.unloadPet();
                  }
               }
               if(!world.myAvatar.objData.eqp[_loc2_])
               {
                  world.myAvatar.objData.eqp[_loc2_] = {};
                  world.myAvatar.objData.eqp[_loc2_].wasCreated = true;
               }
               if(Boolean(world.myAvatar.objData.eqp[_loc2_].isPreview) || Boolean(world.myAvatar.objData.eqp[_loc2_].wasCreated))
               {
                  if(world.myAvatar.objData.eqp[_loc2_].sFile == param1.sFile && world.myAvatar.objData.eqp[_loc2_].sType == param1.sType)
                  {
                     if(world.myAvatar.objData.eqp[_loc2_].wasCreated)
                     {
                        delete world.myAvatar.objData.eqp[_loc2_];
                        world.myAvatar.unloadMovieAtES(_loc2_);
                     }
                     else if(world.myAvatar.objData.eqp[_loc2_].isPreview)
                     {
                        if(_loc2_ == "pe")
                        {
                           if(world.myAvatar.objData.eqp["pe"])
                           {
                              world.myAvatar.unloadPet();
                           }
                        }
                        world.myAvatar.objData.eqp[_loc2_].sType = world.myAvatar.objData.eqp[_loc2_].oldType;
                        world.myAvatar.objData.eqp[_loc2_].sFile = world.myAvatar.objData.eqp[_loc2_].oldFile;
                        world.myAvatar.objData.eqp[_loc2_].sLink = world.myAvatar.objData.eqp[_loc2_].oldLink;
                        world.myAvatar.loadMovieAtES(_loc2_,world.myAvatar.objData.eqp[_loc2_].oldFile,world.myAvatar.objData.eqp[_loc2_].oldLink);
                        world.myAvatar.objData.eqp[_loc2_].isPreview = null;
                     }
                     return;
                  }
               }
               if(!world.myAvatar.objData.eqp[_loc2_].isPreview)
               {
                  world.myAvatar.objData.eqp[_loc2_].isPreview = true;
                  if(!world.myAvatar.objData.eqp[_loc2_].isShowable)
                  {
                     if("sType" in param1)
                     {
                        world.myAvatar.objData.eqp[_loc2_].oldType = world.myAvatar.objData.eqp[_loc2_].sType;
                     }
                     world.myAvatar.objData.eqp[_loc2_].oldFile = world.myAvatar.objData.eqp[_loc2_].sFile;
                     world.myAvatar.objData.eqp[_loc2_].oldLink = world.myAvatar.objData.eqp[_loc2_].sLink;
                  }
               }
               if("sType" in param1)
               {
                  world.myAvatar.objData.eqp[_loc2_].sType = param1.sType;
               }
               world.myAvatar.objData.eqp[_loc2_].sFile = param1.sFile == "undefined" ? "" : param1.sFile;
               world.myAvatar.objData.eqp[_loc2_].sLink = param1.sLink;
               world.myAvatar.loadMovieAtES(_loc2_,param1.sFile,param1.sLink);
               if(_loc2_ == "pe" && param1.sName.indexOf("Bank Pet") != -1)
               {
                  petDisable.addEventListener(TimerEvent.TIMER,onPetDisable,false,0,true);
                  petDisable.start();
               }
               hasPreviewed = true;
         }
      }
      
      internal function onPetDisable(param1:TimerEvent) : void
      {
         if(!world.myAvatar.petMC.mcChar)
         {
            return;
         }
         world.myAvatar.petMC.mcChar.mouseEnabled = false;
         world.myAvatar.petMC.mcChar.mouseChildren = false;
         world.myAvatar.petMC.mcChar.enabled = false;
         petDisable.reset();
         petDisable.removeEventListener(TimerEvent.TIMER,onPetDisable);
      }
      
      public function showPortrait(param1:Avatar) : *
      {
         if(litePreference.data.bHideUI)
         {
            return;
         }
         showPortraitBox(param1,ui.mcPortrait);
         world.updatePortrait(param1);
         ui.iconQuest.visible = true;
         ui.monsterIcon.visible = true;
      }
      
      public function hidePortrait() : void
      {
         ui.monsterIcon.visible = false;
         ui.mcPortrait.visible = false;
         ui.iconQuest.visible = false;
      }
      
      public function showPortraitTarget(param1:Avatar) : *
      {
         if(litePreference.data.bHideUI)
         {
            return;
         }
         showPortraitBox(Number(world.objExtra["bChar"]) == 1 ? world.myAvatar : param1,ui.mcPortraitTarget);
         ui.mcPortraitTarget.pvpIcon.visible = world.bPvP;
         world.updatePortrait(param1);
         ui.btnTargetPortraitClose.visible = true;
      }
      
      public function hidePortraitTarget() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:DisplayObject = null;
         _loc1_ = ui.mcPortraitTarget.mcHead as MovieClip;
         _loc2_ = _loc1_.head.getChildByName("face");
         if(_loc2_ != null)
         {
            _loc1_.head.removeChild(_loc2_);
         }
         while(_loc1_.backhair.numChildren > 0)
         {
            _loc1_.backhair.removeChildAt(0);
         }
         while(_loc1_.head.hair.numChildren > 0)
         {
            _loc1_.head.hair.removeChildAt(0);
         }
         while(_loc1_.head.helm.numChildren > 0)
         {
            _loc1_.head.helm.removeChildAt(0);
         }
         ui.mcPortraitTarget.visible = false;
         ui.btnTargetPortraitClose.visible = false;
      }
      
      public function showPortraitBox(param1:Avatar, param2:MovieClip) : *
      {
         var AssetClass:Class = null;
         var mc:MovieClip = null;
         var child:DisplayObject = null;
         var bBackHair:Boolean = false;
         var sSkinLink:String = null;
         var AssetClass2:Class = null;
         var avt:Avatar = param1;
         var mcPortraitBox:MovieClip = param2;
         mc = mcPortraitBox.mcHead as MovieClip;
         bBackHair = false;
         mcPortraitBox.pAV = avt;
         if(avt.npcType == "monster")
         {
            AssetClass = world.getClass("mcHead" + avt.objData.strLinkage);
            child = mc.head.getChildByName("face");
            if(child != null)
            {
               mc.head.removeChild(child);
            }
            mc.head.addChildAt(new AssetClass(),0).name = "face";
            mc.head.hair.visible = false;
            mc.head.helm.visible = false;
            mc.backhair.visible = false;
         }
         else
         {
            try
            {
               sSkinLink = avt.objData.eqp.ar.sLink;
               if(avt.objData.eqp.co != null)
               {
                  sSkinLink = avt.objData.eqp.co.sLink;
               }
               AssetClass = world.getClass(sSkinLink + avt.objData.strGender + "Head");
               child = mc.head.getChildByName("face");
               if(child != null)
               {
                  mc.head.removeChild(child);
               }
               mc.head.addChildAt(new AssetClass(),0).name = "face";
            }
            catch(err:Error)
            {
               AssetClass = world.getClass("mcHead" + avt.objData.strGender);
               child = mc.head.getChildByName("face");
               if(child != null)
               {
                  mc.head.removeChild(child);
               }
               mc.head.addChildAt(new AssetClass(),0).name = "face";
            }
            AssetClass = world.getClass(avt.objData.strHairName + avt.objData.strGender + "Hair");
            while(mc.head.hair.numChildren > 0)
            {
               mc.head.hair.removeChildAt(0);
            }
            try
            {
               mc.head.hair.addChild(new AssetClass());
            }
            catch(e:Error)
            {
            }
            mc.head.hair.visible = true;
            try
            {
               AssetClass = world.getClass(avt.objData.strHairName + avt.objData.strGender + "HairBack");
               while(mc.backhair.numChildren > 0)
               {
                  mc.backhair.removeChildAt(0);
               }
               mc.backhair.addChild(new AssetClass());
               mc.backhair.visible = true;
               bBackHair = true;
            }
            catch(err:Error)
            {
               mc.backhair.visible = false;
            }
            if(avt.objData.eqp.he != null && avt.objData.eqp.he.sLink != null)
            {
               try
               {
                  AssetClass = world.getClass(avt.objData.eqp.he.sLink);
                  AssetClass2 = world.getClass(avt.objData.eqp.he.sLink + "_backhair") as Class;
                  while(mc.head.helm.numChildren > 0)
                  {
                     mc.head.helm.removeChildAt(0);
                  }
                  mc.head.helm.addChild(new AssetClass());
                  mc.head.helm.visible = avt.dataLeaf.showHelm;
                  mc.head.hair.visible = !mc.head.helm.visible;
                  if(AssetClass2 != null)
                  {
                     if(avt.dataLeaf.showHelm)
                     {
                        if(mc.backhair.numChildren > 0)
                        {
                           mc.backhair.removeChildAt(0);
                        }
                        mc.backhair.visible = true;
                        mc.backhair.addChild(new AssetClass2());
                     }
                  }
                  else
                  {
                     mc.backhair.visible = mc.head.hair.visible && bBackHair;
                  }
               }
               catch(err:Error)
               {
                  mc.head.helm.visible = false;
               }
            }
            else
            {
               mc.head.helm.visible = false;
            }
         }
         mcPortraitBox.visible = true;
         ui.mcPortrait.iconDrops.initRoot(this);
         ui.mcPortrait.iconDrops.visible = litePreference.data.bCustomDrops;
      }
      
      public function oniconQuestClick(param1:MouseEvent) : void
      {
         if(litePreference.data.bQuestPin)
         {
            if(param1.shiftKey)
            {
               ui.mcQTracker.toggle();
               return;
            }
            world.showQuests(pinnedQuests,"q");
         }
         else
         {
            ui.mcQTracker.toggle();
         }
      }
      
      public function manageXPBoost(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         ui.mcPortrait.iconBoostXP.visible = param1.op == "+";
         if(param1.op == "+")
         {
            world.myAvatar.objData.iBoostXP = param1.iSecsLeft;
            ui.mcPortrait.iconBoostXP.boostTS = new Date().getTime();
            ui.mcPortrait.iconBoostXP.iBoostXP = param1.iSecsLeft;
            ui.mcPortrait.iconBoostXP.bShowShop = param1.bShowShop;
            addUpdate("You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds.");
            chatF.pushMsg("server","You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds. " + Math.ceil(param1.iSecsLeft / 60) + " minute(s) remaining.","SERVER","",0);
         }
         else
         {
            delete world.myAvatar.objData.iBoostXP;
            delete ui.mcPortrait.iconBoostXP.boostTS;
            delete ui.mcPortrait.iconBoostXP.iBoostXP;
            addUpdate("The Experience Boost has faded!  Experience rewards are no longer doubled.");
            chatF.pushMsg("server","The Experience Boost has faded!  Experience rewards are no longer doubled.","SERVER","",0);
            if(ui.mcPortrait.iconBoostXP.bShowShop != null && Boolean(ui.mcPortrait.iconBoostXP.bShowShop))
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Your Experience Boost has faded!\tExperience rewards are no longer doubled.  Would you like to purchase a new Experience Boost?";
               _loc3_.params = {};
               _loc3_.callback = openExpBoostStore;
               _loc3_.glow = "red,medium";
               ui.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
         }
      }
      
      public function manageGBoost(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         ui.mcPortrait.iconBoostG.visible = param1.op == "+";
         if(param1.op == "+")
         {
            world.myAvatar.objData.iBoostG = param1.iSecsLeft;
            ui.mcPortrait.iconBoostG.boostTS = new Date().getTime();
            ui.mcPortrait.iconBoostG.iBoostG = param1.iSecsLeft;
            ui.mcPortrait.iconBoostG.bShowShop = param1.bShowShop;
            addUpdate("You have activated the Gold Boost!  All Gold rewards are doubled while the effect holds.");
            chatF.pushMsg("server","You have activated the Gold Boost!  All Gold rewards are doubled while the effect holds. " + Math.ceil(param1.iSecsLeft / 60) + " minute(s) remaining.","SERVER","",0);
         }
         else
         {
            delete world.myAvatar.objData.iBoostG;
            delete ui.mcPortrait.iconBoostG.boostTS;
            delete ui.mcPortrait.iconBoostG.iBoostG;
            addUpdate("The Gold Boost has faded!  Gold rewards are no longer doubled.");
            chatF.pushMsg("server","The Gold Boost has faded!  Gold rewards are no longer doubled.","SERVER","",0);
            if(ui.mcPortrait.iconBoostG.bShowShop != null && Boolean(ui.mcPortrait.iconBoostG.bShowShop))
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Your Gold Boost has faded!  Gold rewards are no longer doubled.  Would you like to purchase a new Gold Boost?";
               _loc3_.params = {};
               _loc3_.callback = openExpBoostStore;
               _loc3_.glow = "red,medium";
               ui.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
         }
      }
      
      public function manageRepBoost(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         ui.mcPortrait.iconBoostRep.visible = param1.op == "+";
         if(param1.op == "+")
         {
            world.myAvatar.objData.iBoostRep = param1.iSecsLeft;
            ui.mcPortrait.iconBoostRep.boostTS = new Date().getTime();
            ui.mcPortrait.iconBoostRep.iBoostRep = param1.iSecsLeft;
            ui.mcPortrait.iconBoostRep.bShowShop = param1.bShowShop;
            addUpdate("You have activated the Reputation Boost!  All Reputation rewards are doubled while the effect holds.");
            chatF.pushMsg("server","You have activated the Reputation Boost!  All Reputation rewards are doubled while the effect holds. " + Math.ceil(param1.iSecsLeft / 60) + " minute(s) remaining.","SERVER","",0);
         }
         else
         {
            delete world.myAvatar.objData.iBoostRep;
            delete ui.mcPortrait.iconBoostRep.boostTS;
            delete ui.mcPortrait.iconBoostRep.iBoostRep;
            addUpdate("The Reputation Boost has faded!  Reputation rewards are no longer doubled.");
            chatF.pushMsg("server","The Reputation Boost has faded!  Reputation rewards are no longer doubled.","SERVER","",0);
            if(ui.mcPortrait.iconBoostRep.bShowShop != null && Boolean(ui.mcPortrait.iconBoostRep.bShowShop))
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Your Reputation Boost has faded!\tReputation rewards are no longer doubled.  Would you like to purchase a new Reputation Boost?";
               _loc3_.params = {};
               _loc3_.callback = openExpBoostStore;
               _loc3_.glow = "red,medium";
               ui.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
         }
      }
      
      public function manageCPBoost(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         ui.mcPortrait.iconBoostCP.visible = param1.op == "+";
         if(param1.op == "+")
         {
            world.myAvatar.objData.iBoostCP = param1.iSecsLeft;
            ui.mcPortrait.iconBoostCP.boostTS = new Date().getTime();
            ui.mcPortrait.iconBoostCP.iBoostCP = param1.iSecsLeft;
            ui.mcPortrait.iconBoostCP.bShowShop = param1.bShowShop;
            addUpdate("You have activated the ClassPoint Boost!  All ClassPoint rewards are doubled while the effect holds.");
            chatF.pushMsg("server","You have activated the ClassPoint Boost!  All ClassPoint rewards are doubled while the effect holds. " + Math.ceil(param1.iSecsLeft / 60) + " minute(s) remaining.","SERVER","",0);
         }
         else
         {
            delete world.myAvatar.objData.iBoostCP;
            delete ui.mcPortrait.iconBoostCP.boostTS;
            delete ui.mcPortrait.iconBoostCP.iBoostCP;
            addUpdate("The ClassPoint Boost has faded!  ClassPoint rewards are no longer doubled.");
            chatF.pushMsg("server","The ClassPoint Boost has faded!  ClassPoint rewards are no longer doubled.","SERVER","",0);
            if(ui.mcPortrait.iconBoostCP.bShowShop != null && Boolean(ui.mcPortrait.iconBoostCP.bShowShop))
            {
               _loc2_ = new ModalMC();
               _loc3_ = {};
               _loc3_.strBody = "Your ClassPoint Boost has faded!\tClassPoint rewards are no longer doubled.  Would you like to purchase a new ClassPoint Boost?";
               _loc3_.params = {};
               _loc3_.callback = openExpBoostStore;
               _loc3_.glow = "red,medium";
               ui.ModalStack.addChild(_loc2_);
               _loc2_.init(_loc3_);
            }
         }
      }
      
      public function oniconBoostXPOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = Number(new Date().getTime());
         _loc4_ = Math.max(_loc2_.boostTS + _loc2_.iBoostXP * 1000 - _loc3_,0);
         _loc5_ = 0;
         _loc6_ = "All Experience gains are doubled.\n";
         if(_loc4_ < 120000)
         {
            _loc5_ = Math.floor(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minute(s), ");
            _loc5_ = Math.round(_loc4_ % 60000 / 1000);
            _loc6_ += String(_loc5_ + " second(s) remaining.");
         }
         else
         {
            _loc5_ = Math.round(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minutes remaining.");
         }
         ui.ToolTip.openWith({"str":_loc6_});
      }
      
      public function oniconBoostGoldOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = Number(new Date().getTime());
         _loc4_ = Math.max(_loc2_.boostTS + _loc2_.iBoostG * 1000 - _loc3_,0);
         _loc5_ = 0;
         _loc6_ = "All Gold gains are doubled.\n";
         if(_loc4_ < 120000)
         {
            _loc5_ = Math.floor(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minute(s), ");
            _loc5_ = Math.round(_loc4_ % 60000 / 1000);
            _loc6_ += String(_loc5_ + " second(s) remaining.");
         }
         else
         {
            _loc5_ = Math.round(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minutes remaining.");
         }
         ui.ToolTip.openWith({"str":_loc6_});
      }
      
      public function oniconBoostRepOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = Number(new Date().getTime());
         _loc4_ = Math.max(_loc2_.boostTS + _loc2_.iBoostRep * 1000 - _loc3_,0);
         _loc5_ = 0;
         _loc6_ = "All Reputation gains are doubled.\n";
         if(_loc4_ < 120000)
         {
            _loc5_ = Math.floor(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minute(s), ");
            _loc5_ = Math.round(_loc4_ % 60000 / 1000);
            _loc6_ += String(_loc5_ + " second(s) remaining.");
         }
         else
         {
            _loc5_ = Math.round(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minutes remaining.");
         }
         ui.ToolTip.openWith({"str":_loc6_});
      }
      
      public function oniconBoostCPOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = Number(new Date().getTime());
         _loc4_ = Math.max(_loc2_.boostTS + _loc2_.iBoostCP * 1000 - _loc3_,0);
         _loc5_ = 0;
         _loc6_ = "All ClassPoint gains are doubled.\n";
         if(_loc4_ < 120000)
         {
            _loc5_ = Math.floor(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minute(s), ");
            _loc5_ = Math.round(_loc4_ % 60000 / 1000);
            _loc6_ += String(_loc5_ + " second(s) remaining.");
         }
         else
         {
            _loc5_ = Math.round(_loc4_ / 60000);
            _loc6_ += String(_loc5_ + " minutes remaining.");
         }
         ui.ToolTip.openWith({"str":_loc6_});
      }
      
      public function openExpBoostStore(param1:Object) : void
      {
         if(param1.accept)
         {
            world.sendLoadShopRequest(184);
         }
      }
      
      public function oniconBoostOut(param1:MouseEvent) : void
      {
         ui.ToolTip.close();
      }
      
      public function updateXPBar() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = world.myAvatar.objData.intExp / world.myAvatar.objData.intExpToLevel;
         ui.mcInterface.mcXPBar.mcXP.scaleX = _loc1_ > 1 ? 1 : _loc1_;
         _loc2_ = world.myAvatar.objData;
         _loc3_ = _loc2_.intExp;
         _loc4_ = _loc2_.intExpToLevel;
         _loc5_ = int(_loc3_ / _loc4_ * 100);
         if(_loc5_ >= 100)
         {
            _loc5_ = 100;
         }
         ui.mcInterface.mcXPBar.strXP.text = "Level " + world.myAvatar.objData.intLevel + " : " + _loc3_ + " / " + _loc4_ + "  (" + _loc5_ + "%)";
      }
      
      public function xpBarMouseOver(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).strXP.visible = true;
      }
      
      public function xpBarMouseOut(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).strXP.visible = false;
      }
      
      public function updateRepBar() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = world.myAvatar.objData.iCurCP;
         _loc2_ = world.myAvatar.objData.iCPToRank;
         if(_loc2_ <= 0)
         {
            ui.mcInterface.mcRepBar.mcRep.scaleX = 0.1;
            ui.mcInterface.mcRepBar.mcRep.visible = false;
            ui.mcInterface.mcRepBar.strRep.text = world.myAvatar.objData.strClassName + ", Rank " + world.myAvatar.objData.iRank;
         }
         else
         {
            _loc3_ = int(_loc1_ / _loc2_ * 100);
            if(_loc3_ >= 100)
            {
               _loc3_ = 100;
            }
            ui.mcInterface.mcRepBar.mcRep.scaleX = _loc1_ / _loc2_;
            ui.mcInterface.mcRepBar.mcRep.visible = true;
            ui.mcInterface.mcRepBar.strRep.text = world.myAvatar.objData.strClassName + ", Rank " + world.myAvatar.objData.iRank + " : " + _loc1_ + "/" + _loc2_ + "  (" + _loc3_ + "%)";
         }
      }
      
      public function onRepBarMouseOver(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).strRep.visible = true;
      }
      
      public function onRepBarMouseOut(param1:MouseEvent) : *
      {
         MovieClip(param1.currentTarget).strRep.visible = false;
      }
      
      public function disabledDelay(param1:TimerEvent) : void
      {
      }
      
      public function actIconClick(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget).actObj;
         if(_loc2_.auto != null && _loc2_.auto == true)
         {
            world.approachTarget();
         }
         else
         {
            world.testAction(_loc2_);
         }
      }
      
      public function determineIndex(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         _loc2_ = 10;
         if(param1 <= 3)
         {
            _loc2_ = param1;
         }
         else if(param1 == 4)
         {
            _loc2_ = 5;
         }
         else if(param1 <= 6)
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      public function actIconOver(param1:MouseEvent) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         var _loc4_:* = null;
         _loc2_ = MovieClip(param1.currentTarget);
         if(Boolean(uoPref.bTT) || world.myAvatar.dataLeaf.intState != 2)
         {
            if(_loc2_.item == null)
            {
               _loc3_ = _loc2_.actObj;
               if(_loc3_ != null)
               {
                  _loc3_.desc = _loc3_.desc.replace(regExLineSpace,"\n");
                  _loc4_ = "<b>" + _loc3_.nam + "</b>\n";
                  if(!_loc3_.isOK)
                  {
                     _loc4_ += "<font color=\'#FF0000\'>Unlocks at Rank " + String(determineIndex(_loc2_.actionIndex)) + "!</font>\n";
                  }
                  if(_loc3_.typ != "passive")
                  {
                     if(_loc3_.mp > 0)
                     {
                        _loc4_ += "<font color=\'#0033AA\'>" + _loc3_.mp + "</font> mana, ";
                     }
                     _loc4_ += "<font color=\'#AA3300\'>" + _loc3_.cd / 1000 + "</font> sec cooldown" + "\n";
                  }
                  switch(_loc3_.typ)
                  {
                     case "p":
                     case "ph":
                     case "aa":
                        _loc4_ += "Physical";
                        break;
                     case "m":
                        _loc4_ += "Magical";
                        break;
                     case "ma":
                        _loc4_ += "True Damage";
                        break;
                     case "pm":
                     case "mp":
                        _loc4_ += "Hybrid";
                        break;
                     case "passive":
                        _loc4_ += "<font color=\'#0033AA\'>Passive Ability</font>";
                  }
                  _loc4_ += "\n";
                  if(_loc3_.typ != "passive")
                  {
                     if(_loc3_.range <= 301)
                     {
                        _loc4_ += "A <font color=\'#AA3300\'>short range</font> ";
                     }
                     else if(_loc3_.range >= 3000)
                     {
                        _loc4_ += "An <font color=\'#0033AA\'>infinite range</font> ";
                     }
                     else if(_loc3_.range >= 808)
                     {
                        _loc4_ += "A <font color=\'#0033AA\'>long range</font> ";
                     }
                     else
                     {
                        _loc4_ += "A <font color=\'#AA3300\'>medium range</font> ";
                     }
                     if(!_loc3_.damage)
                     {
                        _loc4_ += "status skill that applies to ";
                     }
                     else
                     {
                        _loc4_ += (_loc3_.damage < 0 ? "skill" : "attack") + " that " + (_loc3_.damage < 0 ? "heals " : "deals damage to ");
                     }
                     if(_loc3_.tgt == "f")
                     {
                        _loc4_ += "<font color=\'#0033AA\'>" + (_loc3_.tgtMax || 1);
                        _loc4_ = _loc4_ + (_loc3_.tgtMax > 1 ? " friendly targets.</font>" : " target.</font>");
                     }
                     else if(_loc3_.tgt == "s")
                     {
                        _loc4_ += "<font color=\'#0033AA\'>yourself.</font>";
                     }
                     else
                     {
                        _loc4_ += "<font color=\'#AA3300\'>" + (_loc3_.tgtMax || 1);
                        _loc4_ = _loc4_ + (_loc3_.tgtMax > 1 ? " hostile targets.</font>" : " target.</font>");
                     }
                     _loc4_ += "\n\n";
                  }
                  if(_loc3_.sArg2 != "")
                  {
                     _loc4_ += _loc3_.sArg2;
                  }
                  else
                  {
                     _loc4_ += _loc3_.desc;
                  }
                  ui.ToolTip.openWith({
                     "str":_loc4_,
                     "lowerright":true
                  });
               }
            }
            else
            {
               ui.ToolTip.openWith({
                  "str":_loc2_.item.sName + "\n" + "<font color=\'#AA3300\'>" + _loc2_.actObj.cd / 1000 + "</font> sec cooldown\n" + _loc2_.item.sDesc,
                  "lowerright":true
               });
            }
         }
      }
      
      public function actIconOut(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = MovieClip(stage.getChildAt(0)).ui.ToolTip;
         _loc2_.close();
      }
      
      public function portraitClick(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         if(_loc2_.pAV.npcType == "player")
         {
            _loc3_ = {};
            _loc3_.ID = _loc2_.pAV.objData.CharID;
            _loc3_.strUsername = _loc2_.pAV.objData.strUsername;
            if(_loc2_.pAV != world.myAvatar)
            {
               ui.cMenu.fOpenWith("user",_loc3_);
            }
            else
            {
               ui.cMenu.fOpenWith("self",_loc3_);
            }
         }
         else if(_loc2_.pAV.npcType == "monster")
         {
            _loc3_ = {};
            _loc3_.ID = _loc2_.pAV.objData.MonMapID;
            _loc3_.strUsername = _loc2_.pAV.objData.strMonName;
            _loc3_.target = world.getMonster(_loc3_.ID).pMC;
            ui.cMenu.fOpenWith("mons",_loc3_);
         }
      }
      
      private function onTargetPortraitCloseClick(param1:MouseEvent) : void
      {
         world.cancelTarget();
      }
      
      private function onBtnMonsterClick(param1:MouseEvent) : void
      {
         world.toggleMonsters();
      }
      
      public function showMap() : void
      {
         ui.mcInterface.mcMenu.mcMenuButtons.visible = true;
         ui.mcPopup.fOpen("Map");
      }
      
      public function logout() : void
      {
         if(Boolean(intChatMode) && Boolean(chatF.bTall))
         {
            ui.mcInterface.ncModeChat.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(litePreference.data.bCharSelect)
         {
            saveChar();
         }
         sfc.sendXtMessage("zm","cmd",["logout"],"str",1);
      }
      
      public function showServerList() : void
      {
         if(Boolean(intChatMode) && Boolean(chatF.bTall))
         {
            ui.mcInterface.ncModeChat.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(litePreference.data.bCharSelect)
         {
            saveChar();
         }
         showServers = true;
         sfc.sendXtMessage("zm","cmd",["logout"],"str",1);
      }
      
      public function showUpgradeWindow(param1:Object = null) : void
      {
         var _loc2_:MovieClip = null;
         if(mcUpgradeWindow == null)
         {
            mcUpgradeWindow = new MCUpgradeWindow();
         }
         _loc2_ = mcUpgradeWindow as MovieClip;
         var _loc3_:* = param1 != null ? param1 : world.myAvatar.objData;
         _loc2_.btnClose.addEventListener(MouseEvent.CLICK,hideUpgradeWindow,false,0,true);
         _loc2_.btnClose2.addEventListener(MouseEvent.CLICK,hideUpgradeWindow,false,0,true);
         _loc2_.btnBuy.addEventListener(MouseEvent.CLICK,onUpgradeClick,false,0,true);
         addChild(mcUpgradeWindow);
         try
         {
            ui.mouseChildren = false;
            world.mouseChildren = false;
         }
         catch(e:Error)
         {
         }
         try
         {
            mcLogin.sl.mouseChildren = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function hideUpgradeWindow(param1:MouseEvent) : void
      {
         removeChild(mcUpgradeWindow);
         try
         {
            ui.mouseChildren = true;
            world.mouseChildren = true;
         }
         catch(e:Error)
         {
         }
         try
         {
            mcLogin.sl.mouseChildren = true;
         }
         catch(e:Error)
         {
         }
      }
      
      public function onUpgradeClick(param1:Event) : void
      {
         var _loc2_:String = null;
         mixer.playSound("Click");
         if(ISWEB)
         {
            extCall.setUpPayment(sToken);
         }
         else
         {
            _loc2_ = "https://www.aq.com/order-now/direct/default.asp?cid=" + world.myAvatar.objData.CharID + "&token=" + loginInfo.strToken;
            navigateToURL(new URLRequest(_loc2_),"_blank");
         }
      }
      
      public function showACWindow() : void
      {
         var _loc1_:MovieClip = null;
         if(mcACWindow == null)
         {
            mcACWindow = new MCACWindow();
         }
         _loc1_ = mcACWindow as MovieClip;
         _loc1_.btnClose.addEventListener(MouseEvent.CLICK,hideACWindow,false,0,true);
         _loc1_.btnClose2.addEventListener(MouseEvent.CLICK,hideACWindow,false,0,true);
         _loc1_.btnBuy.addEventListener(MouseEvent.CLICK,onUpgradeClick,false,0,true);
         _loc1_.btnUpgrade.addEventListener(MouseEvent.CLICK,onUpgradeClick,false,0,true);
         addChild(mcACWindow);
         try
         {
            ui.mouseChildren = false;
            world.mouseChildren = false;
         }
         catch(e:Error)
         {
         }
         try
         {
            mcLogin.sl.mouseChildren = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function hideACWindow(param1:MouseEvent) : void
      {
         removeChild(mcACWindow);
         try
         {
            ui.mouseChildren = true;
            world.mouseChildren = true;
         }
         catch(e:Error)
         {
         }
         try
         {
            mcLogin.sl.mouseChildren = true;
         }
         catch(e:Error)
         {
         }
      }
      
      public function initArrHP() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:* = undefined;
         _loc1_ = 100;
         _loc2_ = 550;
         _loc3_ = 275;
         _loc4_ = 0.8;
         _loc5_ = 720;
         _loc6_ = 200;
         _loc7_ = 0.92;
         _loc8_ = 350;
         _loc9_ = 3650;
         _loc10_ = 1.1;
         _loc11_ = 0;
         while(_loc11_ < _loc1_)
         {
            if(_loc11_ > 19)
            {
               arrHP.push(Math.round(_loc8_ + Math.pow(_loc11_ / _loc1_,_loc10_) * _loc9_));
            }
            else if(_loc11_ > 7)
            {
               arrHP.push(Math.round(_loc5_ + Math.pow(_loc11_ / 20,_loc7_) * _loc6_));
            }
            else
            {
               arrHP.push(Math.round(_loc2_ + Math.pow(_loc11_ / 8,_loc4_) * _loc3_));
            }
            _loc11_++;
         }
      }
      
      public function initArrRep() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 1;
         while(_loc2_ < 10)
         {
            _loc1_ = Math.pow(_loc2_ + 1,3) * 100;
            if(_loc2_ > 1)
            {
               arrRanks.push(_loc1_ + arrRanks[_loc2_ - 1]);
            }
            else
            {
               arrRanks.push(_loc1_ + 100);
            }
            _loc2_++;
         }
      }
      
      public function getRankFromPoints(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         _loc2_ = 1;
         if(param1 < 0)
         {
            param1 = 0;
         }
         _loc3_ = 1;
         while(_loc3_ < arrRanks.length)
         {
            if(param1 < arrRanks[_loc3_])
            {
               return _loc2_;
            }
            _loc2_++;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function attachOnModalStack(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Class = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = world.getClass(param1) as Class;
         _loc4_ = true;
         if(ui.ModalStack.numChildren)
         {
            _loc2_ = MovieClip(ui.ModalStack.getChildAt(0));
            _loc5_ = _loc2_.constructor as Class;
            if(_loc5_ == _loc3_)
            {
               _loc4_ = false;
            }
         }
         if(_loc4_)
         {
            clearModalStack();
            _loc2_ = MovieClip(ui.ModalStack.addChild(new _loc3_()));
            ui.ModalStack.mouseChildren = true;
         }
         return _loc2_;
      }
      
      public function getInstanceFromModalStack(param1:String) : MovieClip
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < ui.ModalStack.numChildren)
         {
            if(getQualifiedClassName(ui.ModalStack.getChildAt(_loc2_) == param1))
            {
               return ui.ModalStack.getChildAt(_loc2_);
            }
            _loc2_++;
         }
         return null;
      }
      
      public function isDialoqueUp() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < world.FG.numChildren)
         {
            _loc2_ = world.FG.getChildAt(_loc1_);
            _loc3_ = String(_loc2_ as MovieClip);
            if(_loc3_.indexOf("dlg_") > -1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function clearModalStack() : Boolean
      {
         var _loc1_:int = 0;
         if(isGreedyModalInStack())
         {
            return false;
         }
         _loc1_ = 0;
         while(ui.ModalStack.numChildren > 0 && _loc1_ < 100)
         {
            _loc1_++;
            ui.ModalStack.removeChildAt(0);
         }
         stage.focus = null;
         return true;
      }
      
      public function closeModalByStrBody(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < ui.ModalStack.numChildren)
         {
            _loc3_ = ui.ModalStack.getChildAt(_loc2_) as MovieClip;
            if(_loc3_.cnt.strBody.htmlText.indexOf(param1) > -1 && _loc3_.currentLabel != "out")
            {
               _loc3_.fClose();
            }
            _loc2_++;
         }
      }
      
      public function isGreedyModalInStack() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         _loc1_ = 0;
         while(_loc1_ < ui.ModalStack.numChildren)
         {
            _loc2_ = ui.ModalStack.getChildAt(_loc1_) as MovieClip;
            if("greedy" in _loc2_ && _loc2_.greedy != null && _loc2_.greedy == true)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function clearPopups(param1:Array = null) : void
      {
         if(ui.mcPopup.currentLabel == "House")
         {
            ui.mcPopup.mcHouseMenu.hideItemHandle();
         }
         if(param1 == null || param1.indexOf(ui.mcPopup.currentLabel) < 0)
         {
            ui.mcPopup.onClose();
         }
         world.removeMovieFront();
         clearModalStack();
      }
      
      public function clearPopupsQ() : void
      {
         if(ui.mcPopup.currentLabel != "House" && ui.mcPopup.currentLabel != "HouseShop")
         {
            ui.mcPopup.onClose();
         }
      }
      
      public function addUpdate(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         _loc3_ = ui.mcUpdates;
         _loc4_ = _loc3_.addChildAt(new uProto(),1) as MovieClip;
         _loc4_.y = 0;
         _loc4_.x = _loc3_.uproto.x;
         _loc4_.t1.ti.text = param1;
         if(param2)
         {
            _loc4_.t1.ti.textColor = 16711680;
         }
         _loc4_.gotoAndPlay("in");
         _loc5_ = 2;
         if(_loc3_.numChildren > 2)
         {
            _loc5_ = 2;
            while(_loc5_ < _loc3_.numChildren)
            {
               if(_loc5_ < 4)
               {
                  _loc3_.getChildAt(_loc5_).y = _loc3_.getChildAt(_loc5_).y - 18;
               }
               else
               {
                  MovieClip(_loc3_.getChildAt(_loc5_)).stop();
                  _loc3_.removeChildAt(_loc5_);
                  _loc5_--;
               }
               _loc5_++;
            }
         }
      }
      
      public function clearUpdates() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = ui.mcUpdates;
         while(_loc1_.numChildren > 1)
         {
            _loc1_.removeChildAt(1);
         }
      }
      
      public function showItemDrop(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         if(Boolean(litePreference.data.bCustomDrops) && (param1.bTemp == 0 && param2))
         {
            cDropsUI.showItem(param1);
            return;
         }
         if(Boolean(litePreference.data.dOptions["hideDrop"]) && Boolean(litePreference.data.bCustomDrops) && param1.bTemp == 0)
         {
            return;
         }
         if(Boolean(litePreference.data.dOptions["hideTemp"]) && Boolean(litePreference.data.bCustomDrops) && param1.bTemp != 0)
         {
            return;
         }
         if(Boolean(litePreference.data.bCustomDrops) && (param1.bTemp == 0 && !param2))
         {
            _loc3_ = new DFrameMC(param1);
            ui.dropStack.addChild(_loc3_);
            _loc3_.init();
            _loc3_.fY = _loc3_.y = -(_loc3_.fHeight + 8);
            _loc3_.fX = _loc3_.x = -(_loc3_.fWidth / 2);
            cleanDropStack();
            return;
         }
         if(param1.bTemp != 0 || !param2)
         {
            _loc3_ = new DFrameMC(param1);
         }
         else
         {
            _loc3_ = new DFrame2MC(param1);
         }
         ui.dropStack.addChild(_loc3_);
         _loc3_.init();
         _loc3_.fY = _loc3_.y = -(_loc3_.fHeight + 8);
         _loc3_.fX = _loc3_.x = -(_loc3_.fWidth / 2);
         cleanDropStack();
      }
      
      public function cleanDropStack() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         _loc1_ = null;
         _loc2_ = null;
         _loc3_ = ui.dropStack.numChildren - 2;
         while(_loc3_ > -1)
         {
            _loc1_ = ui.dropStack.getChildAt(_loc3_) as MovieClip;
            _loc2_ = ui.dropStack.getChildAt(_loc3_ + 1) as MovieClip;
            _loc1_.fY = _loc1_.y = _loc2_.fY - (_loc2_.fHeight + 8);
            _loc3_--;
         }
      }
      
      public function dropStackBoost() : void
      {
         ui.dropStack.y = 438;
      }
      
      public function dropStackReset() : void
      {
         ui.dropStack.y = 493;
      }
      
      public function showAchievement(param1:String, param2:int) : void
      {
         var _loc3_:mcAchievement = null;
         var _loc4_:MovieClip = null;
         _loc3_ = new mcAchievement();
         _loc4_ = ui.dropStack.addChild(_loc3_) as MovieClip;
         _loc4_.cnt.tBody.text = param1;
         _loc4_.cnt.tPts.text = param2;
         _loc4_.fWidth = 348;
         _loc4_.fHeight = 90;
         _loc4_.fX = _loc4_.x = -(_loc4_.fWidth / 2);
         _loc4_.fY = _loc4_.y = -(_loc4_.fHeight + 8);
         cleanDropStack();
      }
      
      public function showQuestpopup(param1:Object) : void
      {
         var _loc2_:mcQuestpopup = null;
         var _loc3_:MovieClip = null;
         var _loc4_:* = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         if(litePreference.data.bDisQPopup)
         {
            return;
         }
         _loc2_ = new mcQuestpopup();
         _loc2_.cnt.mcAC.visible = false;
         _loc3_ = ui.dropStack.addChild(_loc2_) as MovieClip;
         _loc3_.cnt.tName.text = param1.sName;
         _loc3_.cnt.rewards.tRewards.htmlText = "";
         _loc4_ = "";
         _loc5_ = param1.rewardObj;
         if("intCoins" in _loc5_ && _loc5_.intCoins > 0)
         {
            _loc4_ = "<font color=\'#FFFFFF\'>" + _loc5_.intCoins + "</font>";
            _loc4_ = _loc4_ + "<font color=\'#FFCC00\'>ac</font>";
         }
         if("intGold" in _loc5_ && _loc5_.intGold > 0)
         {
            if(_loc4_.length > 0)
            {
               _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
            }
            _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.intGold + "</font>";
            _loc4_ = _loc4_ + "<font color=\'#FFCC00\'>g</font>";
         }
         if("intExp" in _loc5_ && _loc5_.intExp > 0)
         {
            if(_loc4_.length > 0)
            {
               _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
            }
            _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.intExp + "</font>";
            _loc4_ = _loc4_ + "<font color=\'#FF00FF\'>xp</font>";
         }
         if("iRep" in _loc5_ && _loc5_.iRep > 0)
         {
            if(_loc4_.length > 0)
            {
               _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
            }
            _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.iRep + "</font>";
            _loc4_ = _loc4_ + "<font color=\'#00CCFF\'>rep</font>";
         }
         if("guildRep" in _loc5_ && _loc5_.guildRep > 0)
         {
            if(_loc4_.length > 0)
            {
               _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
            }
            _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.guildRep + "</font>";
            _loc4_ = _loc4_ + "<font color=\'#00CCFF\'>guild rep</font>";
         }
         _loc3_.cnt.rewards.tRewards.htmlText = _loc4_;
         _loc3_.fWidth = 240;
         _loc3_.fHeight = 70;
         _loc6_ = _loc3_.cnt.rewards.tRewards.x + _loc3_.cnt.rewards.tRewards.textWidth;
         _loc3_.cnt.rewards.x = Math.round(_loc3_.fWidth / 2 - _loc6_ / 2);
         _loc3_.fX = _loc3_.x = -(_loc3_.fWidth / 2);
         _loc3_.fY = _loc3_.y = -(_loc3_.fHeight + 8);
         mixer.playSound("Good");
         cleanDropStack();
      }
      
      public function toggleCharpanel(param1:String = "") : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = ui.mcPopup;
         if(!isGreedyModalInStack())
         {
            if(_loc2_.currentLabel != "Charpanel")
            {
               clearPopups();
               clearPopupsQ();
               _loc2_.fData = {"typ":param1};
               _loc2_.visible = true;
               _loc2_.gotoAndPlay("Charpanel");
            }
            else
            {
               _loc2_.mcCharpanel.fClose();
            }
         }
      }
      
      public function toggleStatspanel(param1:String = "") : void
      {
         if(ui.getChildByName("mcStatsPanel"))
         {
            mcStatsPanel.cleanup();
            mcStatsPanel = null;
            return;
         }
         mcStatsPanel = new statsPanel(this);
         ui.addChild(mcStatsPanel);
         mcStatsPanel.name = "mcStatsPanel";
         mcStatsPanel.x = 474;
         mcStatsPanel.y = 240;
      }
      
      public function toggleOutfits(param1:String = "") : void
      {
         if(world.myAvatar.dataLeaf.intState != 1)
         {
            return;
         }
         if(world.bPvP)
         {
            return;
         }
         requestInterface("OutfitSets/outfitsetsr2.swf","outfitSets");
      }
      
      public function showFriendshipUI(param1:String = "") : void
      {
         if(!world.coolDown("friendshipStats"))
         {
            return;
         }
         requestInterface("friendship/friendship_ui.swf","friendship_ui");
      }
      
      public function togglePVPPanel(param1:String = "") : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = ui.mcPopup;
         if(!isGreedyModalInStack())
         {
            if(_loc2_.currentLabel != "PVPPanel")
            {
               clearPopups();
               clearPopupsQ();
               _loc2_.fData = {"typ":param1};
               _loc2_.visible = true;
               _loc2_.gotoAndPlay("PVPPanel");
            }
            else
            {
               _loc2_.onClose();
            }
         }
      }
      
      public function showPVPScore() : void
      {
         var bar:MovieClip = null;
         var i:int = 0;
         var o:Object = null;
         var a:Array = null;
         var bx:int = 0;
         ui.mcPVPScore.visible = true;
         ui.mcPVPScore.y = 2;
         i = 0;
         a = [{"sName":"Team A"},{"sName":"Team B"}];
         bx = 200;
         if(world.PVPFactions.length > 0)
         {
            a = world.PVPFactions;
         }
         i = 0;
         while(i < a.length)
         {
            o = a[i];
            try
            {
               bar = ui.mcPVPScore.getChildByName("bar" + i);
               bar.tTeam.text = o.sName;
               if(bar.tTeam.x + bar.tTeam.width - bar.tTeam.textWidth - 6 < bx)
               {
                  bx = Math.round(bar.tTeam.x + bar.tTeam.width - bar.tTeam.textWidth - 6);
               }
            }
            catch(e:Error)
            {
            }
            i++;
         }
         i = 0;
         while(i < a.length)
         {
            o = a[i];
            try
            {
               bar = ui.mcPVPScore.getChildByName("bar" + i);
               bar.cap.x = bx;
            }
            catch(e:Error)
            {
            }
            i++;
         }
      }
      
      public function hidePVPScore() : void
      {
         ui.mcPVPScore.visible = false;
         ui.mcPVPScore.y = -300;
      }
      
      public function showMCPVPQueue() : void
      {
         var _loc1_:Object = null;
         _loc1_ = world.getWarzoneByWarzoneName(world.PVPQueue.warzone);
         ui.mcPVPQueue.t1.text = _loc1_.nam;
         ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME,MCPVPQueueEF);
         ui.mcPVPQueue.t2label.visible = false;
         ui.mcPVPQueue.t2.visible = false;
         if(world.PVPQueue.avgWait > -1)
         {
            ui.mcPVPQueue.t2label.visible = true;
            ui.mcPVPQueue.t2.visible = true;
            ui.mcPVPQueue.addEventListener(Event.ENTER_FRAME,MCPVPQueueEF,false,0,true);
         }
         ui.mcPVPQueue.visible = true;
         ui.mcPVPQueue.y = 84;
      }
      
      public function hideMCPVPQueue() : void
      {
         ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME,MCPVPQueueEF);
         ui.mcPVPQueue.visible = false;
         ui.mcPVPQueue.y = -300;
      }
      
      public function onMCPVPQueueClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = {};
         try
         {
            _loc2_.strUsername = world.myAvatar.objData.strUsername;
            ui.cMenu.fOpenWith("pvpqueue",_loc2_);
         }
         catch(e:Error)
         {
         }
      }
      
      public function MCPVPQueueEF(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = undefined;
         _loc2_ = Number(new Date().getTime());
         _loc3_ = Math.ceil((world.PVPQueue.avgWait * 1000 - (_loc2_ - world.PVPQueue.ts)) / 1000 / 60);
         ui.mcPVPQueue.t2.htmlText = "<font color=\"#FFFFFF\"" + _loc3_ + "</font><font color=\"#999999\"m</font>";
         if(_loc3_ <= 1)
         {
            ui.mcPVPQueue.t2.htmlText = "<" + ui.mcPVPQueue.t2.htmlText;
         }
      }
      
      public function updatePVPScore(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = {};
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_];
            _loc3_ = ui.mcPVPScore.getChildByName("bar" + _loc4_) as MovieClip;
            if(_loc3_ != null)
            {
               _loc3_.ti.text = _loc2_.v + "/1000";
               _loc5_ = int(_loc2_.v / 1000 * _loc3_.bar.width);
               _loc5_ = Math.max(Math.min(_loc5_,_loc3_.bar.width),0);
               _loc3_.bar.x = -_loc3_.bar.width + _loc5_;
            }
            _loc4_++;
         }
      }
      
      public function relayPVPEvent(param1:Object) : void
      {
         if(param1.typ == "kill")
         {
            if(param1.team == world.myAvatar.dataLeaf.pvpTeam)
            {
               if(param1.val == "Restorer")
               {
                  addUpdate(getPVPMessage(param1.val,true));
               }
               if(param1.val == "Brawler")
               {
                  addUpdate(getPVPMessage(param1.val,true));
               }
               if(param1.val == "Captain")
               {
                  addUpdate(getPVPMessage(param1.val,true));
               }
               if(param1.val == "General")
               {
                  addUpdate("Victory! The enemy general has been defeated!");
               }
               if(param1.val == "Knight")
               {
                  addUpdate("A knight of the enemy has fallen! Victory draws closer!");
               }
            }
            else
            {
               if(param1.val == "Restorer")
               {
                  addUpdate(getPVPMessage(param1.val,false),true);
               }
               if(param1.val == "Brawler")
               {
                  addUpdate(getPVPMessage(param1.val,false),true);
               }
               if(param1.val == "Captain")
               {
                  addUpdate(getPVPMessage(param1.val,false),true);
               }
               if(param1.val == "General")
               {
                  addUpdate("Oh no!  Our general has been defeated!",true);
               }
               if(param1.val == "Knight")
               {
                  addUpdate("A knight has fallen to the enemy!");
               }
            }
         }
      }
      
      private function getPVPMessage(param1:String, param2:Boolean) : String
      {
         switch(param1)
         {
            case "Restorer":
               if(param2)
               {
                  return world.strMapName == "dagepvp" ? "An enemy Blade Master has been defeated! Dage\'s healing powers are waning!" : "An enemy Restorer has been defeated! The Captain\'s healing powers are waning!";
               }
               return world.strMapName == "dagepvp" ? "A Blade Master has been defeated!\t Dage\'s healing powers are waning!" : "A Restorer has been defeated!\t Our Captain\'s healing powers are waning!";
               break;
            case "Brawler":
               if(param2)
               {
                  return world.strMapName == "dagepvp" ? "An enemy Legion Guard has been defeated!  Dage\'s attacks grow weaker!" : "An enemy Brawler has been defeated!  The Captain\'s attacks grow weaker!";
               }
               return world.strMapName == "dagepvp" ? "A Legion Guard has been defeated!\tRally to Dage\'s defense!" : "A Brawler has been defeated!\tRally to the Captain\'s defense!";
               break;
            case "Captain":
               if(param2)
               {
                  return world.strMapName == "dagepvp" ? "Dage has been defeated!" : "The enemy captain has been defeated!";
               }
               return world.strMapName == "dagepvp" ? "Dage has been fallen to the enemy!" : "Our Captain has been fallen to the enemy!";
               break;
            default:
               return "";
         }
      }
      
      public function mcSetColor(param1:MovieClip, param2:String, param3:String) : *
      {
         var _loc4_:MovieClip = null;
         var _loc6_:String = null;
         if(currentLabel == "Select")
         {
            mcCharSelect.mcSetColor(param1,param2,param3);
            return;
         }
         _loc4_ = param1;
         var _loc5_:Boolean = false;
         _loc6_ = "none";
         while(_loc4_ != null && _loc4_.parent != null && _loc4_.parent != _loc4_.stage)
         {
            if("pAV" in _loc4_)
            {
               if(_loc4_.name.indexOf("previewMC") > -1)
               {
                  _loc6_ = "e";
               }
               else if(_loc4_.name.indexOf("Dummy") > -1)
               {
                  _loc6_ = "d";
               }
               else if(_loc4_.name.indexOf("mcPortraitTarget") > -1)
               {
                  _loc6_ = "c";
               }
               else if(_loc4_.name.indexOf("mcPortrait") > -1)
               {
                  _loc6_ = "b";
               }
               else
               {
                  _loc6_ = "a";
               }
               break;
            }
            _loc4_ = MovieClip(_loc4_.parent);
         }
         if(_loc6_ != "none")
         {
            if(_loc4_.pAV == undefined)
            {
               world.myAvatar.pMC.setColor(param1,_loc6_,param2,param3);
            }
            else
            {
               _loc4_.pAV.pMC.setColor(param1,_loc6_,param2,param3);
            }
         }
      }
      
      public function registerAttackFrame(param1:MovieClip) : *
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1;
         while(_loc2_ != null && _loc2_.parent != null && _loc2_.parent != _loc2_.stage)
         {
            if("pAV" in _loc2_)
            {
               break;
            }
            _loc2_ = MovieClip(_loc2_.parent);
         }
         if("pAV" in _loc2_)
         {
            if(!("attackFrames" in _loc2_.pAV.pMC))
            {
               return;
            }
            if(Boolean(_loc2_.pAV.pMC.attackFrames) && _loc2_.pAV.pMC.attackFrames.indexOf(param1) != -1)
            {
               _loc2_.pAV.pMC.attackFrames.splice(_loc2_.pAV.pMC.attackFrames.indexOf(param1),1);
            }
            _loc2_.pAV.pMC.attackFrames.push(param1);
         }
      }
      
      public function areaListClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget.parent.parent);
         switch(_loc2_.currentLabel)
         {
            case "init":
               _loc2_.gotoAndPlay("in");
               break;
            case "hold":
               _loc2_.gotoAndPlay("out");
         }
      }
      
      public function updateAreaName() : void
      {
         var _loc1_:* = null;
         _loc1_ = String(world.areaUsers.length) + " player";
         if(world.areaUsers.length > 1)
         {
            _loc1_ += "(s)";
         }
         _loc1_ += " in <font color =\'#FFFF00\'>";
         if(world.strAreaName.indexOf(":") > -1)
         {
            _loc1_ += world.strAreaName.split(":")[0] + " (party)";
         }
         else
         {
            _loc1_ += world.strAreaName;
         }
         _loc1_ += "</font>";
         ui.mcInterface.areaList.title.t1.htmlText = _loc1_;
      }
      
      public function areaListGet() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         _loc1_ = {};
         _loc2_ = sfc.getRoom(world.curRoom).getUserList();
         for(_loc3_ in _loc2_)
         {
            _loc4_ = world.uoTree[_loc2_[_loc3_].getName()];
            if(_loc4_ != null)
            {
               _loc1_[_loc3_] = {
                  "strUsername":_loc4_.strUsername,
                  "intLevel":_loc4_.intLevel
               };
            }
         }
         areaListShow(_loc1_);
      }
      
      public function areaListNameClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = {};
         _loc3_.ID = _loc2_.objData.ID;
         _loc3_.strUsername = _loc2_.objData.strUsername;
         if(_loc2_.objData.strUsername == world.myAvatar.objData.strUsername)
         {
            ui.cMenu.fOpenWith("self",_loc3_);
         }
         else
         {
            ui.cMenu.fOpenWith("user",_loc3_);
         }
      }
      
      public function areaListShow(param1:Object) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         _loc2_ = ui.mcInterface.areaList;
         if(_loc2_.currentLabel == "hold")
         {
            while(_loc2_.cnt.numChildren > 0)
            {
               _loc2_.cnt.removeChildAt(0);
            }
         }
         _loc3_ = 0;
         for(_loc4_ in param1)
         {
            _loc5_ = _loc2_.cnt.addChild(new aProto());
            _loc5_.objData = param1[_loc4_];
            _loc5_.txtName.text = param1[_loc4_].strUsername;
            _loc5_.txtLevel.text = param1[_loc4_].intLevel;
            _loc5_.addEventListener(MouseEvent.CLICK,areaListNameClick,false,0,true);
            _loc5_.buttonMode = true;
            _loc5_.y = -int(_loc3_ * 14);
            _loc3_++;
         }
         _loc2_.cnt.iproto.visible = _loc2_.currentLabel == "hold";
         _loc2_.visible = true;
      }
      
      public function showFBShare(param1:Object) : void
      {
         var fbTab:FacebookTabMC = null;
         var o:Object = param1;
         var mc:MovieClip = MovieClip(o.parent);
         var FBShareTabClass:Class = getDefinitionByName("FacebookTabMC") as Class;
         if(Boolean(uoPref.bFBShare) && Boolean(o.isActive))
         {
            try
            {
               fbTab = o.parent.getChildByName("fbTab") as FacebookTabMC;
            }
            catch(error:Error)
            {
            }
            if(fbTab == null)
            {
               fbTab = new FBShareTabClass();
               fbTab.name = "fbTab";
               fbTab.filters = [new GlowFilter(12892822,1,10,10,2,2,false,false)];
               o.parent.addChild(fbTab);
            }
            fbTab.init(o);
            fbTab.visible = true;
            if("position" in o)
            {
               fbTab.positionBy(o);
            }
         }
         else
         {
            try
            {
               o.parent.getChildByName("fbTab").visible = false;
            }
            catch(error:Error)
            {
            }
         }
      }
      
      public function closeFBC() : void
      {
         if(fbc != null)
         {
            fbc.fClose();
         }
      }
      
      public function getAppName() : String
      {
         return Game.FB_APP_NAME;
      }
      
      public function getAppID() : String
      {
         return Game.FB_APP_ID;
      }
      
      public function getAppSec() : String
      {
         return Game.FB_APP_SEC;
      }
      
      public function getAppURL() : String
      {
         return Game.FB_APP_URL;
      }
      
      public function getUserName() : String
      {
         if(world != null && world.myAvatar != null && world.myAvatar.objData != null && "strUserName" in world.myAvatar.objData)
         {
            return world.myAvatar.objData.strUserName;
         }
         return "";
      }
      
      public function toggleFaction() : void
      {
         if(ui.mcPopup.currentLabel != "Faction")
         {
            ui.mcPopup.fOpen("Faction");
         }
         else if("cnt" in MovieClip(ui.mcPopup))
         {
            MovieClip(MovieClip(ui.mcPopup).cnt).xClick();
         }
      }
      
      public function hideInterface() : void
      {
         ui.visible = false;
      }
      
      public function showInterface() : void
      {
         ui.visible = true;
      }
      
      public function loadExternalSWF(param1:String) : void
      {
         if(param1.indexOf("https://") == -1 || param1.indexOf("https://") == -1)
         {
            if(param1.length > 1 && param1.charAt(0) == "/")
            {
               param1 = param1.substr(1,param1.length - 1);
            }
            param1 = "maps/" + param1;
         }
         ldrMC.loadFile(mcExtSWF,param1,"Game Files");
         hideInterface();
         world.visible = false;
      }
      
      public function clearExternamSWF() : void
      {
         while(mcExtSWF.numChildren > 0)
         {
            mcExtSWF.removeChildAt(0);
         }
         world.visible = true;
         showInterface();
      }
      
      public function openCharacterCustomize() : void
      {
         ui.mcPopup.fOpen("Customize");
      }
      
      public function openArmorCustomize() : void
      {
         ui.mcPopup.fOpen("ArmorColor");
      }
      
      public function showFactionInterface() : void
      {
         ui.mcPopup.fOpen("Faction");
      }
      
      public function showConfirmtaionBox(param1:String, param2:Function) : void
      {
         var modal:* = undefined;
         var modalO:* = undefined;
         var sMsg:String = param1;
         var fHandler:Function = param2;
         modal = new ModalMC();
         modalO = {};
         modalO.strBody = sMsg;
         modalO.btns = "dual";
         modalO.params = {};
         modalO.callback = function(param1:Object):*
         {
            fHandler(param1.accept);
         };
         ui.ModalStack.addChild(modal);
         modal.init(modalO);
      }
      
      public function showMessageBox(param1:String, param2:Function = null) : void
      {
         var modal:* = undefined;
         var modalO:* = undefined;
         var sMsg:String = param1;
         var fHandler:Function = param2;
         modal = new ModalMC();
         modalO = {};
         modalO.strBody = sMsg;
         modalO.btns = "mono";
         modalO.params = {};
         modalO.callback = function(param1:Object):*
         {
            if(fHandler != null)
            {
               fHandler();
            }
         };
         ui.ModalStack.addChild(modal);
         modal.init(modalO);
      }
      
      public function getServerTime() : Date
      {
         var _loc1_:Date = null;
         var _loc2_:* = undefined;
         _loc1_ = new Date();
         _loc2_ = ts_login_server + (_loc1_.getTime() - ts_login_client);
         return new Date(_loc2_);
      }
      
      public function get date_server() : Date
      {
         return getServerTime();
      }
      
      public function showTracking(param1:String) : void
      {
         var _loc2_:* = undefined;
         try
         {
            _loc2_ = objLogin.userid != null ? objLogin.userid : 0;
            extCall.logQuestProgress(_loc2_,param1);
         }
         catch(e:*)
         {
         }
      }
      
      public function removeApop() : void
      {
         if(apop == null)
         {
            return;
         }
         apop_ = null;
         world.removeMovieFront();
      }
      
      public function createApop() : void
      {
         if(apop_ != null)
         {
            removeApop();
         }
         apop_ = new apopCore(this as MovieClip,apopTree[curID]);
         apop_.x = 270;
         apop_.y = 20;
         world.FG.addChild(apop_);
         world.FG.mouseChildren = true;
      }
      
      public function rand(param1:Number = 0, param2:Number = 1) : Number
      {
         return rn.rand(param1,param2);
      }
      
      public function get TravelMap() : Object
      {
         return travelMapData;
      }
      
      public function get apop() : apopCore
      {
         return apop_;
      }
      
      public function get objWorldMap() : *
      {
         return WorldMapData;
      }
      
      public function getLogin() : Object
      {
         return objLogin;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
         init();
         showTracking("2");
      }
      
      internal function frame13() : *
      {
         loadTitle();
         if(showServers)
         {
            if(FacebookConnect.isLoggedIn && loginInfo.strPassword == null && ISWEB)
            {
               extCall.fbLogin();
            }
            else
            {
               login(loginInfo.strUsername,loginInfo.strPassword);
            }
            showServers = false;
         }
         else if(csShowServers)
         {
            mcLogin.gotoAndPlay("Servers");
            csShowServers = false;
         }
         stop();
      }
      
      internal function frame22() : *
      {
         initInterface();
         initWorld();
         stop();
      }
      
      internal function frame32() : *
      {
         if(params.vars != null)
         {
            loadAccountCreation("newuser/" + params.vars.sCharCreate);
         }
         else
         {
            loadAccountCreation("newuser/AQW-Landing-MERGETEST.swf");
         }
         stop();
      }
      
      internal function frame43() : *
      {
         init();
         if(mcCharSelect)
         {
            mcCharSelect = null;
         }
         loader = new mcLoader();
         loader.x = 400;
         loader.y = 211;
         this.addChild(loader);
         csLoader = new Loader();
         csLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCSComplete);
         csLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onCSProgress);
         csLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onCSError);
         csLoader.load(new URLRequest(getFilePath() + "interface/CharSelect/charselect.swf?v=" + params.vars.sVersion));
         csbLoaded = 0;
         csbTotal = 0;
         stop();
      }
   }
}

