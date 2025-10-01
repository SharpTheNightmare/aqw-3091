package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.external.*;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextFormat;
   import flash.utils.*;
   
   public class World extends MovieClip
   {
      
      public static var currentInstance:World;
      
      public var uiLock:Boolean = false;
      
      public var objSession:Object = new Object();
      
      public var objResponse:Object = new Object();
      
      public var objQuestString:*;
      
      public var objInfo:Object = new Object();
      
      internal var FEATURE_COLLISION:Boolean = true;
      
      internal var CELL_MODE:String = "normal";
      
      public var SCALE:Number = 1;
      
      public var WALKSPEED:Number = 8;
      
      public var bitWalk:Boolean = false;
      
      internal var lastWalk:Date = new Date();
      
      public var strAreaName:String;
      
      public var strMapName:String;
      
      public var strMapFileName:String;
      
      public var intType:int;
      
      public var intKillCount:int;
      
      public var objLock:*;
      
      public var objExtra:*;
      
      public var objHouseData:*;
      
      public var objGuildData:*;
      
      public var returnInfo:Object;
      
      public var strFrame:String = "";
      
      public var strPad:String = "";
      
      public var spawnPoint:Object = new Object();
      
      public var FG:MovieClip;
      
      public var CHARS:MovieClip;
      
      public var TRASH:MovieClip;
      
      public var map:MovieClip;
      
      public var mapBoundsMC:MovieClip = null;
      
      public var zSortArr:Array = new Array();
      
      public var ldr_map:Loader = new Loader();
      
      internal var preLMC:*;
      
      internal var zManager:MovieClip;
      
      public var EFAO:Object = {
         "zc":0,
         "zn":1,
         "xpc":0,
         "xpn":50,
         "xpb":false
      };
      
      public var arrEvent:Array;
      
      public var arrEventR:Array;
      
      public var arrSolid:Array;
      
      public var arrSolidR:Array;
      
      public var avatars:Object = new Object();
      
      public var myAvatar:Avatar;
      
      public var mondef:Array;
      
      public var monswf:Array;
      
      public var monmap:Array;
      
      public var monsters:Array = new Array();
      
      public var combatAnims:Array = ["Attack1","Attack2","Attack3","Attack4","Hit","Knockout","Getup","Stab","Thrash","Castgood","Cast1","Cast2","Cast3","Sword/ShieldFight","Sword/ShieldAttack1","Sword/ShieldAttack2","ShieldBlock","DuelWield/DaggerFight","DuelWield/DaggerAttack1","DuelWield/DaggerAttack2","FistweaponFight","FistweaponAttack1","FistweaponAttack2","PolearmFight","PolearmAttack1","PolearmAttack2","RangedFight","RangedAttack1","UnarmedFight","UnarmedAttack1","UnarmedAttack2","KickAttack","FlipAttack","Dodge"];
      
      public var staticAnims:Array = ["Fall","Knockout","Die"];
      
      public var bankController:BankController;
      
      public var shopinfo:Object;
      
      public var shopBuyItem:Object;
      
      public var enhShopID:int = -1;
      
      public var enhShopItems:Array;
      
      public var enhItem:Object;
      
      public var hairshopinfo:Object;
      
      public var mapEvents:Object;
      
      public var adData:Object;
      
      public var cellMap:Object;
      
      private var tbmd:BitmapData;
      
      public var scrollData:Object;
      
      public var loaderD:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
      
      public var loaderC:LoaderContext = new LoaderContext(false,loaderD);
      
      public var loaderContents:* = [];
      
      public var loaderContentsFileNames:* = [];
      
      public var loaderQueue:Array = [];
      
      public var playerDomains:Object = {};
      
      public var loaderManager:Object = {
         "i0":{
            "n":"i0",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         },
         "i1":{
            "n":"i1",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         },
         "i2":{
            "n":"i2",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         },
         "i3":{
            "n":"i3",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         },
         "i4":{
            "n":"i4",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         },
         "i5":{
            "n":"i5",
            "loaderData":null,
            "timer":new Timer(5000,1),
            "ldr":new Loader(),
            "free":true,
            "url":""
         }
      };
      
      public var mapLoadInProgress:Boolean = false;
      
      private var mapW:int = 960;
      
      private var mapH:int = 550;
      
      private var mapNW:int = mapW;
      
      private var mapNH:int = mapH;
      
      private var mapBmps:Array = [];
      
      private var mapTimer:Timer = new Timer(2000);
      
      public var actions:Object = new Object();
      
      internal var restTimer:Timer = new Timer(2000,1);
      
      internal var AATestTimer:Timer = new Timer(700,1);
      
      internal var connTestTimer:Timer = new Timer(5000,1);
      
      internal var autoActionTimer:Timer = new Timer(2000,1);
      
      internal var mvTimer:Timer = new Timer(500,1);
      
      internal var mvTimerObj:Object;
      
      internal var actionTimer:Timer;
      
      internal var actionMap:Array = new Array();
      
      internal var autoAction:Object;
      
      internal var actionReady:Boolean = false;
      
      internal var actionResults:Array = new Array();
      
      internal var actionResultsAura:Array = new Array();
      
      internal var actionResultsMon:Array = new Array();
      
      internal var actionID:Number = 0;
      
      internal var actionIDLimit:Number = 30;
      
      internal var actionDamage:*;
      
      internal var actionRangeSpamTS:Number = 0;
      
      internal var minLatencyOneWay:* = 20;
      
      internal var TcpAckDel:* = 170;
      
      internal var connMsgOut:* = false;
      
      public var mData:mapData;
      
      public var cHandle:cutsceneHandler;
      
      public var sController:soundController;
      
      public var chaosNames:Array = new Array();
      
      public var hideAllCapes:Boolean = false;
      
      public var hideOtherPets:Boolean = false;
      
      public var showAnimations:Boolean = true;
      
      public var showMonsters:Boolean = true;
      
      public var charMonster:MovieClip;
      
      public var lock:Object = {
         "loadShop":{
            "cd":3000,
            "ts":0
         },
         "loadEnhShop":{
            "cd":3000,
            "ts":0
         },
         "loadHairShop":{
            "cd":3000,
            "ts":0
         },
         "equipItem":{
            "cd":1500,
            "ts":0
         },
         "unequipItem":{
            "cd":1500,
            "ts":0
         },
         "buyItem":{
            "cd":1000,
            "ts":0
         },
         "sellItem":{
            "cd":1000,
            "ts":0
         },
         "getMapItem":{
            "cd":1000,
            "ts":0
         },
         "tryQuestComplete":{
            "cd":1250,
            "ts":0
         },
         "acceptQuest":{
            "cd":1000,
            "ts":0
         },
         "doIA":{
            "cd":1000,
            "ts":0
         },
         "rest":{
            "cd":1900,
            "ts":0
         },
         "who":{
            "cd":3000,
            "ts":0
         },
         "tfer":{
            "cd":3000,
            "ts":0
         },
         "wearItem":{
            "cd":1500,
            "ts":0
         },
         "unwearItem":{
            "cd":1500,
            "ts":0
         },
         "addLoadout":{
            "cd":1500,
            "ts":0
         },
         "removeLoadout":{
            "cd":1500,
            "ts":0
         },
         "wearLoadout":{
            "cd":3000,
            "ts":0
         },
         "equipLoadout":{
            "cd":3000,
            "ts":0
         },
         "friendshipTalk":{
            "cd":1000,
            "ts":0
         },
         "friendshipChoice":{
            "cd":1000,
            "ts":0
         },
         "friendshipInfo":{
            "cd":1500,
            "ts":0
         },
         "friendshipGift":{
            "cd":1500,
            "ts":0
         },
         "friendshipStats":{
            "cd":3000,
            "ts":0
         },
         "dungeonQueue":{
            "cd":5000,
            "ts":0
         },
         "dungeonRejoin":{
            "cd":5000,
            "ts":0
         },
         "dungeonMTC":{
            "cd":1000,
            "ts":0
         }
      };
      
      public var invTree:Object = {};
      
      public var uoTree:Object = {};
      
      public var monTree:Object = {};
      
      public var waveTree:Object = {};
      
      public var questTree:Object = {};
      
      public var enhPatternTree:Object;
      
      public var enhp:Array = [{
         "ID":1,
         "sName":"Adventurer",
         "sDesc":"none",
         "iSTR":16,
         "iDEX":16,
         "iEND":18,
         "iINT":16,
         "iWIS":16,
         "iLCK":0
      },{
         "ID":2,
         "sName":"Fighter",
         "sDesc":"M1",
         "iSTR":44,
         "iDEX":13,
         "iEND":43,
         "iINT":0,
         "iWIS":0,
         "iLCK":0
      },{
         "ID":3,
         "sName":"Thief",
         "sDesc":"M2",
         "iSTR":30,
         "iDEX":45,
         "iEND":25,
         "iINT":0,
         "iWIS":0,
         "iLCK":0
      },{
         "ID":4,
         "sName":"Armsman",
         "sDesc":"M4",
         "iSTR":38,
         "iDEX":36,
         "iEND":26,
         "iINT":0,
         "iWIS":0,
         "iLCK":0
      },{
         "ID":5,
         "sName":"Hybrid",
         "sDesc":"M3",
         "iSTR":28,
         "iDEX":20,
         "iEND":25,
         "iINT":27,
         "iWIS":0,
         "iLCK":0
      },{
         "ID":6,
         "sName":"Wizard",
         "sDesc":"C1",
         "iSTR":0,
         "iDEX":0,
         "iEND":10,
         "iINT":50,
         "iWIS":20,
         "iLCK":20
      },{
         "ID":7,
         "sName":"Healer",
         "sDesc":"C2",
         "iSTR":0,
         "iDEX":0,
         "iEND":40,
         "iINT":45,
         "iWIS":15,
         "iLCK":0
      },{
         "ID":8,
         "sName":"Spellbreaker",
         "sDesc":"C3",
         "iSTR":0,
         "iDEX":0,
         "iEND":20,
         "iINT":40,
         "iWIS":30,
         "iLCK":10
      },{
         "ID":9,
         "sName":"Lucky",
         "sDesc":"S1",
         "iSTR":10,
         "iDEX":10,
         "iEND":10,
         "iINT":10,
         "iWIS":10,
         "iLCK":50
      },{
         "ID":23,
         "sName":"Depths",
         "sDesc":"S1",
         "iSTR":0,
         "iDEX":0,
         "iEND":0,
         "iINT":50,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,132,133,131,0)
      },{
         "ID":10,
         "sName":"Forge",
         "sDesc":"Blacksmith",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0)
      },{
         "ID":11,
         "sName":"Absolution",
         "sDesc":"Smith",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0),
         "DIS":true
      },{
         "ID":12,
         "sName":"Avarice",
         "sDesc":"Smith",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0),
         "DIS":true
      },{
         "ID":24,
         "sName":"Vainglory",
         "sDesc":"Smith",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0),
         "DIS":true
      },{
         "ID":25,
         "sName":"Vim",
         "sDesc":"SmithP2",
         "iSTR":10,
         "iDEX":130,
         "iEND":-90,
         "iINT":0,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,57,255,20,0),
         "DIS":true
      },{
         "ID":26,
         "sName":"Examen",
         "sDesc":"SmithP2",
         "iSTR":0,
         "iDEX":0,
         "iEND":-90,
         "iINT":10,
         "iWIS":130,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,181,145,2,0),
         "DIS":true
      },{
         "ID":27,
         "sName":"Pneuma",
         "sDesc":"SmithP2",
         "iSTR":24,
         "iDEX":24,
         "iEND":-90,
         "iINT":118,
         "iWIS":24,
         "iLCK":0,
         "COLOR":new ColorTransform(1,1,1,1,3,150,161,0),
         "DIS":true
      },{
         "ID":28,
         "sName":"Anima",
         "sDesc":"SmithP2",
         "iSTR":134,
         "iDEX":24,
         "iEND":-90,
         "iINT":16,
         "iWIS":16,
         "iLCK":0,
         "COLOR":new ColorTransform(1,1,1,1,254,34,0,0),
         "DIS":true
      },{
         "ID":29,
         "sName":"Penitence",
         "sDesc":"SmithP2",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0),
         "DIS":true
      },{
         "ID":30,
         "sName":"Lament",
         "sDesc":"SmithP2",
         "iSTR":25,
         "iDEX":0,
         "iEND":0,
         "iINT":25,
         "iWIS":0,
         "iLCK":50,
         "COLOR":new ColorTransform(1,1,1,1,255,103,0,0),
         "DIS":true
      },{
         "ID":32,
         "sName":"Hearty",
         "sDesc":"Grimskull Troll Enhancement",
         "iSTR":-20,
         "iDEX":-20,
         "iEND":150,
         "iINT":-20,
         "iWIS":-20,
         "iLCK":-20,
         "COLOR":new ColorTransform(1,1,1,1,220,0,220,0),
         "DIS":true
      }];
      
      public var defaultCT:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      
      public var whiteCT:ColorTransform = new ColorTransform(1,1,1,1,255,255,255,0);
      
      public var iconCT:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,-50,-50,-50,0);
      
      public var rarityCA:Array = [6710886,16777215,6749952,2663679,16711935,16763904,16711680];
      
      public var deathCT:ColorTransform = new ColorTransform(0.7,0.7,1,1,-20,-20,20,0);
      
      public var monCT:ColorTransform = new ColorTransform(1,1,1,1,30,0,0,0);
      
      public var avtCT:ColorTransform = new ColorTransform(1,1,1,1,40,40,70,0);
      
      public var avtWCT:ColorTransform = new ColorTransform(0,0,0,0,255,255,255,0);
      
      public var avtMCT:ColorTransform = new ColorTransform(0,0,0,0,30,0,0,0);
      
      public var avtPCT:ColorTransform = new ColorTransform(0,0,0,0,40,40,70,0);
      
      public var statusPoisonCT:ColorTransform = new ColorTransform(-0.3,-0.3,-0.3,0,0,20,0,0);
      
      public var statusStoneCT:ColorTransform = new ColorTransform(-1.3,-1.3,-1.3,0,100,100,100,0);
      
      public var GCD:int = 1500;
      
      public var GCDO:int = 1500;
      
      public var GCDTS:Number = 0;
      
      public var curRoom:int = 1;
      
      public var modID:int = -1;
      
      public var partyID:int = -1;
      
      public var guildID:int = -1;
      
      public var bPvP:Boolean = false;
      
      public var partyMembers:Array = [];
      
      public var partyOwner:String = "";
      
      public var areaUsers:Array = [];
      
      public var showHPBar:Boolean = false;
      
      public var rootClass:MovieClip;
      
      public var PVPMaps:Array = [{
         "nam":"It\'s Us Or Them",
         "desc":"This cozy PvP map is ideal for players new to PvP in AQW.",
         "warzone":"usorthem",
         "label":"usorthem",
         "icon":"tower",
         "hidden":true
      },{
         "nam":"Bludrut Brawl!",
         "desc":"A larger map requiring communication, coordination, and a whole lot of DPS.",
         "warzone":"bludrutbrawl",
         "label":"bludrutbrawl",
         "icon":"swords",
         "hidden":false
      },{
         "nam":"Chaos Brawl!",
         "desc":"A larger map requiring communication, coordination, and a whole lot of DPS.",
         "warzone":"chaosbrawl",
         "label":"chaosbrawl",
         "icon":"swords",
         "hidden":false
      },{
         "nam":"Frost Brawl!",
         "desc":"A larger map requiring communication, coordination, and a whole lot of DPS.",
         "warzone":"frostbrawl",
         "label":"frostbrawl",
         "icon":"swords",
         "hidden":false
      },{
         "nam":"Darkovia Brawl!",
         "desc":"Join in the ancient war between werewolves and vampires!",
         "warzone":"darkoviapvp",
         "label":"darkoviapvp",
         "icon":"swords",
         "hidden":true
      },{
         "nam":"Dage PVP!",
         "desc":"Needs Description!",
         "warzone":"dagepvp",
         "label":"dagepvp",
         "icon":"swords",
         "hidden":true
      },{
         "nam":"Dage 1V1!",
         "desc":"Needs Description!",
         "warzone":"dage1v1",
         "label":"dage1v1",
         "icon":"swords",
         "hidden":true
      },{
         "nam":"Doomwood Arena",
         "desc":"This arena is for one on one duels.",
         "warzone":"doomarena",
         "label":"doomarena",
         "icon":"swords",
         "hidden":true
      }];
      
      public var PVPQueue:Object = {
         "warzone":"",
         "ts":-1,
         "avgWait":-1
      };
      
      public var PVPResults:Object = {
         "pvpScore":[],
         "team":0
      };
      
      public var PVPFactions:Array = [];
      
      public var bookData:Object;
      
      public var lockdownPots:Boolean = false;
      
      private var speed:Number;
      
      private var clickPts:int = 0;
      
      private var mva:Array = [new Date().getTime()];
      
      private var justRan:Boolean;
      
      public var CarolingMonsterKillCount:Number = 0;
      
      public var CarolingPad:String;
      
      public var TrickOrTreatMonsterDead:Boolean = false;
      
      public var TrickOrTreatPad:String;
      
      private var player_npc_pos:Point;
      
      public var hasModified:Boolean = false;
      
      public var frameCopy:Array;
      
      private var houseFrame:String = "";
      
      private var imbalancedHouseCells:Array = [];
      
      private var houseJson:Object;
      
      private var finishedCells:Array;
      
      private var convertTimer:Timer;
      
      private var activeCell:String;
      
      public var arrHouseItemQueue:* = [];
      
      public var ldr_House:Loader = new Loader();
      
      private const TICK_MAX:* = 24;
      
      private var ticksum:Number = 0;
      
      private var ticklist:* = new Array();
      
      private var bfps:Boolean = false;
      
      private var fpsTS:Number = 0;
      
      private var fpsQualityCounter:int = 0;
      
      private var fpsArrayQuality:Array = new Array();
      
      internal var arrQuality:Array = new Array("LOW","MEDIUM","HIGH");
      
      private var combatDisplayTime:uint;
      
      public function World(param1:MovieClip)
      {
         super();
         rootClass = param1;
         currentInstance = this;
         bankController = new BankController();
         map = new MovieClip();
         this.addChild(map);
         CHARS = new MovieClip();
         var _loc2_:DisplayObject = this.addChild(CHARS);
         CHARS.mouseEnabled = false;
         _loc2_.x = 0;
         _loc2_.y = 0;
         rootClass.ui.monsterIcon.redX.visible = false;
         TRASH = new MovieClip();
         this.addChild(TRASH);
         TRASH.mouseEnabled = false;
         TRASH.visible = false;
         TRASH.y = -1000;
         zManager = new MovieClip();
         this.addChild(zManager);
         FG = new MovieClip();
         this.addChild(FG);
         zManager.removeEventListener(Event.ENTER_FRAME,onZmanagerEnterFrame);
         autoActionTimer.removeEventListener("timer",autoActionHandler);
         restTimer.removeEventListener("timer",restRequest);
         AATestTimer.removeEventListener("timer",AATest);
         connTestTimer.removeEventListener("timer",connTest);
         mvTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,mvTimerHandler);
         mapTimer.removeEventListener(TimerEvent.TIMER,mapResizeCheck);
         zManager.addEventListener(Event.ENTER_FRAME,onZmanagerEnterFrame,false,0,true);
         autoActionTimer.addEventListener(TimerEvent.TIMER_COMPLETE,autoActionHandler);
         restTimer.addEventListener("timer",restRequest);
         AATestTimer.addEventListener("timer",AATest);
         connTestTimer.addEventListener("timer",connTest);
         mvTimer.addEventListener(TimerEvent.TIMER_COMPLETE,mvTimerHandler);
         mapTimer.addEventListener(TimerEvent.TIMER,mapResizeCheck,false,0,true);
         mapTimer.start();
         initLoaders();
         initCutscenes();
      }
      
      public static function get GameRoot() : MovieClip
      {
         return currentInstance.rootClass;
      }
      
      public static function get Bank() : BankController
      {
         return currentInstance.bankController;
      }
      
      public function initPatternTree() : void
      {
         var _loc1_:* = undefined;
         enhPatternTree = {};
         for each(_loc1_ in enhp)
         {
            enhPatternTree[_loc1_.ID] = _loc1_;
         }
      }
      
      public function initGuildhallData(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            for(_loc3_ in param1[_loc2_])
            {
            }
            _loc2_++;
         }
      }
      
      public function killTimers() : void
      {
         autoActionTimer.reset();
         restTimer.reset();
         AATestTimer.reset();
         connTestTimer.reset();
         rootClass.chatF.mute.timer.reset();
         autoActionTimer.removeEventListener("timer",autoActionHandler);
         restTimer.removeEventListener("timer",restRequest);
         AATestTimer.removeEventListener("timer",AATest);
         connTestTimer.removeEventListener("timer",connTest);
         mvTimer.removeEventListener("timer",mvTimerHandler);
         rootClass.chatF.mute.timer.removeEventListener("timer",rootClass.chatF.unmuteMe);
      }
      
      public function killListeners() : void
      {
         zManager.removeEventListener(Event.ENTER_FRAME,onZmanagerEnterFrame);
         removeChild(zManager);
      }
      
      public function queueLoad(param1:*) : *
      {
         param1.retries = 1;
         loaderQueue.push(param1);
         var _loc2_:* = getFreeLoader();
         if(_loc2_ != null)
         {
            loadNext(_loc2_);
         }
      }
      
      public function loaderCallback(param1:Event) : *
      {
         var _loc2_:* = param1.target.loader;
         var _loc3_:* = getLoaderHost(_loc2_);
         if(_loc3_ != null)
         {
            if(_loc3_.callBackA != null)
            {
               _loc3_.callBackA(param1);
            }
         }
         closeLoader(_loc3_,true);
      }
      
      public function loaderHTTP(param1:HTTPStatusEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         if(param1.status != 200 && Boolean(rootClass.litePreference.data.bDebugger))
         {
            _loc2_ = getLoaderHostByLoaderInfo(param1.currentTarget);
            _loc3_ = "Queue: " + _loc2_.url + ";" + param1.status;
            rootClass.debugMessage(_loc3_);
            closeLoader(_loc2_,false,false);
         }
      }
      
      public function loaderErrorHandler(param1:IOErrorEvent) : *
      {
         var _loc2_:String = param1.toString();
         var _loc3_:String = _loc2_.substr(_loc2_.indexOf("URL: ") + 5);
         _loc3_ = _loc3_.substr(0,_loc3_.length - 1);
         var _loc4_:* = getLoaderHostByURL(_loc3_);
         rootClass.debugMessage("Failed to load, Linkage: " + _loc4_.loaderData.sES + ", File: " + _loc4_.loaderData.sFile);
         if(_loc4_ != null)
         {
            if(_loc4_.callBackB != null)
            {
               _loc4_.callBackB(param1);
            }
         }
         closeLoader(_loc4_,false,false);
      }
      
      private function loaderProgressHandler(param1:Event) : *
      {
         var _loc2_:* = param1.currentTarget;
         var _loc3_:* = getLoaderHostByLoaderInfo(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.isOpen = true;
         }
      }
      
      private function loaderTimerComplete(param1:TimerEvent) : void
      {
         var _loc2_:* = getLoaderHostByTimer(Timer(param1.currentTarget));
         if(_loc2_ != null)
         {
            _loc2_.timer.reset();
            if(!_loc2_.isOpen)
            {
               if(_loc2_.loaderData.retries-- > 0)
               {
                  loaderQueue.push(_loc2_.loaderData);
               }
               closeLoader(_loc2_,false,true);
            }
         }
      }
      
      public function getLoaderHost(param1:*) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            if(loaderManager[_loc2_].ldr == param1)
            {
               return loaderManager[_loc2_];
            }
         }
         return null;
      }
      
      public function getLoaderHostByLoaderInfo(param1:*) : Object
      {
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            if(loaderManager[_loc2_].ldr.contentLoaderInfo == param1)
            {
               return loaderManager[_loc2_];
            }
         }
         return null;
      }
      
      public function getLoaderHostByTimer(param1:Timer) : Object
      {
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            if(loaderManager[_loc2_].timer == param1)
            {
               return loaderManager[_loc2_];
            }
         }
         return null;
      }
      
      public function getLoaderHostByURL(param1:String) : Object
      {
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            if(param1.indexOf(loaderManager[_loc2_].url) > -1)
            {
               return loaderManager[_loc2_];
            }
         }
         return null;
      }
      
      public function getFreeLoader() : Object
      {
         var _loc1_:* = undefined;
         if(loaderQueue.length > 0)
         {
            for(_loc1_ in loaderManager)
            {
               if(loaderManager[_loc1_].free)
               {
                  loaderManager[_loc1_].free = false;
                  return loaderManager[_loc1_];
               }
            }
            return null;
         }
         return null;
      }
      
      public function closeLoader(param1:Object, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         if(param3)
         {
            try
            {
               param1.ldr.unload();
            }
            catch(e:Error)
            {
            }
         }
         param1.free = true;
         param1.isOpen = false;
         param1.loaderData = null;
         param1.timer.reset();
         var _loc5_:* = getFreeLoader();
         if(_loc5_ != null && param4)
         {
            loadNext(_loc5_);
         }
      }
      
      public function initLoaders() : void
      {
         var _loc1_:Object = null;
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            _loc1_ = loaderManager[_loc2_];
            _loc1_.timer.addEventListener(TimerEvent.TIMER_COMPLETE,loaderTimerComplete,false,0,true);
            _loc1_.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCallback,false,0,true);
            _loc1_.ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loaderErrorHandler,false,0,true);
            _loc1_.ldr.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,loaderHTTP,false,0,true);
            _loc1_.ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loaderProgressHandler,false,0,true);
         }
      }
      
      public function clearLoaders(param1:Boolean = false) : *
      {
         var lmi:Object = null;
         var i:* = undefined;
         var clearPlayerDomains:Boolean = param1;
         for(i in loaderManager)
         {
            lmi = loaderManager[i];
            try
            {
               lmi.ldr.close();
            }
            catch(e:Error)
            {
            }
            try
            {
               lmi.ldr.unload();
            }
            catch(e:Error)
            {
            }
            lmi.free = true;
            lmi.isOpen = false;
            lmi.loaderData = null;
            lmi.timer.reset();
            lmi.callBackA = null;
            lmi.callBackB = null;
         }
         if(clearPlayerDomains)
         {
            playerDomains = {};
         }
         loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
         loaderC = new LoaderContext(false,loaderD);
         loaderQueue = [];
      }
      
      public function killLoaders() : *
      {
         var _loc1_:Object = null;
         var _loc2_:* = undefined;
         for(_loc2_ in loaderManager)
         {
            _loc1_ = loaderManager[_loc2_];
            _loc1_.free = true;
            _loc1_.isOpen = false;
            _loc1_.loaderData = null;
            _loc1_.timer.reset();
            _loc1_.callBackA = null;
            _loc1_.callBackB = null;
         }
         loaderQueue = [];
      }
      
      public function loadNext(param1:Object) : *
      {
         if(loaderQueue.length > 0)
         {
            loadNextWith(param1,loaderQueue.shift());
         }
      }
      
      private function loadNextWith(param1:Object, param2:Object) : void
      {
         var _loc3_:URLRequest = null;
         var _loc4_:LoaderContext = loaderC;
         if(param1 != null)
         {
            param1.free = false;
            if(param2.callBackA != null)
            {
               param1.callBackA = param2.callBackA;
            }
            else
            {
               param1.callBackA = null;
            }
            if(param2.callBackB != null)
            {
               param1.callBackB = param2.callBackB;
            }
            else
            {
               param1.callBackB = null;
            }
            if(param2.avt != null && param2.avt == myAvatar && param2.sES != null)
            {
               _loc4_ = mapPlayerAssetClass(param2.sES);
            }
            _loc3_ = new URLRequest(param2.strFile);
            param1.ldr.load(_loc3_,_loc4_);
            param1.url = _loc3_.url;
            param1.isOpen = false;
            param1.loaderData = param2;
            param1.timer.reset();
            param1.timer.start();
         }
      }
      
      private function mapPlayerAssetClass(param1:String) : LoaderContext
      {
         if(playerDomains[param1] == null)
         {
            playerDomains[param1] = {};
            playerDomains[param1].loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            playerDomains[param1].loaderC = new LoaderContext(false,playerDomains[param1].loaderD);
         }
         return playerDomains[param1].loaderC;
      }
      
      public function getClass(param1:String) : Class
      {
         var _loc3_:Class = null;
         var _loc4_:String = null;
         var _loc2_:Object = {};
         try
         {
            _loc3_ = getDefinitionByName(param1) as Class;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            _loc3_ = rootClass.assetsDomain.getDefinition(param1) as Class;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            _loc3_ = loaderD.getDefinition(param1) as Class;
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         catch(e:Error)
         {
         }
         for(_loc4_ in playerDomains)
         {
            if(playerDomains[_loc4_].loaderD.hasDefinition(param1))
            {
               return playerDomains[_loc4_].loaderD.getDefinition(param1) as Class;
            }
         }
         if(!rootClass.litePreference.data.dOptions["debugLinkage"])
         {
            rootClass.debugMessage("Failed to find Linkage: " + param1);
         }
         return null;
      }
      
      public function loadMap(param1:String) : *
      {
         if(param1.indexOf("cdn.aq.com") == -1)
         {
            param1 = rootClass.getFilePath() + "maps/" + param1;
         }
         rootClass.mcConnDetail.showConn("Loading Map Files...");
         if(map != null)
         {
            map.gotoAndStop("Wait");
            this.removeChild(map);
            map = null;
         }
         ldr_map.contentLoaderInfo.removeEventListener(Event.COMPLETE,onMapLoadComplete);
         ldr_map.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onMapLoadError);
         ldr_map.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,onMapHTTPError);
         ldr_map.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onMapLoadProgress);
         ldr_map = new Loader();
         ldr_map.contentLoaderInfo.addEventListener(Event.COMPLETE,onMapLoadComplete,false,0,true);
         ldr_map.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onMapLoadError,false,0,true);
         ldr_map.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,onMapHTTPError,false,0,true);
         ldr_map.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onMapLoadProgress,false,0,true);
         ldr_map.load(new URLRequest(param1));
         rootClass.clearPopups();
      }
      
      public function removeMapListeners() : void
      {
         ldr_map.contentLoaderInfo.removeEventListener(Event.COMPLETE,onMapLoadComplete);
         ldr_map.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onMapLoadError);
         ldr_map.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,onMapHTTPError);
         ldr_map.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onMapLoadProgress);
      }
      
      private function onMapHTTPError(param1:HTTPStatusEvent) : void
      {
         var _loc2_:String = null;
         if(param1.status != 200 && Boolean(rootClass.litePreference.data.bDebugger))
         {
            mapLoadInProgress = false;
            _loc2_ = "Map File: " + ldr_map.contentLoaderInfo.url + ";" + param1.status;
            rootClass.debugMessage(_loc2_);
            removeMapListeners();
            rootClass.mcConnDetail.showError(_loc2_);
         }
      }
      
      private function onMapLoadProgress(param1:ProgressEvent) : void
      {
         var _loc2_:int = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
         rootClass.mcConnDetail.showConn("Loading Map... " + _loc2_ + "%");
      }
      
      private function onMapLoadError(param1:IOErrorEvent) : *
      {
         mapLoadInProgress = false;
         if(rootClass.litePreference.data.bDebugger)
         {
            rootClass.debugMessage("Failed to load Map: " + param1);
         }
         else
         {
            rootClass.mcConnDetail.showError("Loading Map Files... Failed!");
         }
      }
      
      private function onMapLoadComplete(param1:Event) : *
      {
         rootClass.ui.visible = true;
         mapLoadInProgress = false;
         map = MovieClip(ldr_map.content);
         addChildAt(map,0).x = 0;
         CHARS.x = 0;
         resetSpawnPoint();
         if(mondef != null && Boolean(mondef.length))
         {
            initMonsters(mondef,monmap);
         }
         else
         {
            enterMap();
         }
         if(isMyHouse())
         {
            rootClass.ui.mcPopup.fOpen("House");
         }
         if(Boolean(rootClass.cMenuUI) && Boolean(rootClass.cMenuUI.isMenuOpen()))
         {
            rootClass.cMenuUI.reDraw();
         }
      }
      
      public function reloadCurrentMap() : void
      {
         clearMonstersAndProps();
         loadMap(strMapFileName + "?" + Math.random());
      }
      
      public function enterMap() : void
      {
         var _loc1_:* = uoTreeLeaf(rootClass.sfc.myUserName);
         if(intType == 0 || returnInfo == null)
         {
            moveToCell(_loc1_.strFrame,_loc1_.strPad);
         }
         else
         {
            moveToCell(returnInfo.strCell,returnInfo.strPad);
            returnInfo = null;
         }
         initMapEvents();
         rootClass.mcConnDetail.hideConn();
         if(!rootClass.litePreference.data.bHideUI)
         {
            rootClass.ui.mcInterface.areaList.visible = true;
         }
         if(myAvatar != null)
         {
            rootClass.showPortrait(myAvatar);
         }
         if(isMyHouse())
         {
            initMassConvert();
         }
      }
      
      public function setReturnInfo(param1:String, param2:String, param3:String) : void
      {
         returnInfo = new Object();
         returnInfo.strMap = param1;
         returnInfo.strCell = param2;
         returnInfo.strPad = param3;
      }
      
      public function exitCell() : void
      {
         mvTimerKill();
         exitCombat();
         rootClass.clearPopups(["House"]);
         if(myAvatar != null)
         {
            myAvatar.targets = {};
            if(myAvatar.pMC != null)
            {
               myAvatar.pMC.stopWalking();
            }
            if(myAvatar.petMC != null)
            {
               myAvatar.petMC.stopWalking();
            }
            if(myAvatar.target != null)
            {
               setTarget(null);
            }
         }
         if(strFrame != "Wait")
         {
            clearMonstersAndProps();
            hideAllAvatars();
         }
         rootClass.sfcSocial = false;
         rootClass.ui.mcInterface.areaList.gotoAndStop("init");
      }
      
      public function moveToCell(param1:String, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(strMapName == "trickortreat" && param1 != "Enter")
         {
            if(!TrickOrTreatMonsterDead)
            {
               return;
            }
         }
         if(strMapName == "caroling" && param1 != "Enter")
         {
            if(CarolingMonsterKillCount < 5)
            {
               return;
            }
         }
         afkPostpone();
         if(objLock == null || objLock[param1] == null || objLock[param1] <= intKillCount)
         {
            if(uoTree[rootClass.sfc.myUserName].freeze == null)
            {
               _loc4_ = [];
               actionReady = false;
               bitWalk = false;
               _loc5_ = {};
               _loc5_.strFrame = param1;
               _loc5_.strPad = param2;
               if(param2.toLowerCase() != "none")
               {
                  _loc5_.tx = 0;
                  _loc5_.ty = 0;
               }
               uoTreeLeafSet(rootClass.sfc.myUserName,_loc5_);
               strFrame = param1;
               strPad = param2;
               if(strAreaName.indexOf("battleon") < 0 || strAreaName.indexOf("battleontown") > -1)
               {
                  rootClass.menuClose();
               }
               if(!param3)
               {
                  rootClass.sfc.sendXtMessage("zm","moveToCell",[param1,param2],"str",curRoom);
               }
               exitCell();
               map.gotoAndPlay("Blank");
               if(Boolean(rootClass.cMenuUI) && Boolean(rootClass.cMenuUI.isMenuOpen()))
               {
                  rootClass.cMenuUI.reDraw();
               }
               if(strMapName == "house" && isMyHouse() && rootClass.ui.mcPopup.currentLabel != "House")
               {
                  rootClass.ui.mcPopup.fOpen("House");
               }
            }
         }
      }
      
      public function moveToCellByIDa(param1:int) : void
      {
         if(bPvP && !isMoveOK(myAvatar.dataLeaf))
         {
            return;
         }
         rootClass.sfc.sendXtMessage("zm","mtcid",[param1],"str",curRoom);
      }
      
      public function moveToCellByIDb(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         while(_loc3_ < arrEvent.length)
         {
            _loc2_ = arrEvent[_loc3_] as MovieClip;
            if("tID" in _loc2_ && _loc2_.tID == param1 || _loc2_.name.indexOf("ia") == 0 && int(_loc2_.name.substr(2)) == param1)
            {
               moveToCell(_loc2_.tCell,_loc2_.tPad,true);
            }
            _loc3_++;
         }
      }
      
      public function hideAllAvatars() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in avatars)
         {
            if(avatars[_loc1_] != null && avatars[_loc1_].pMC != null)
            {
               avatars[_loc1_].hideMC();
            }
         }
      }
      
      public function clearAllAvatars() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in avatars)
         {
            destroyAvatar(Number(_loc1_));
         }
         avatars = new Object();
      }
      
      public function clearMonstersAndProps() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CHARS.numChildren)
         {
            _loc2_ = CHARS.getChildAt(_loc1_);
            if(Boolean(_loc2_.hasOwnProperty("isProp")) && Boolean(MovieClip(_loc2_).isProp))
            {
               CHARS.removeChild(_loc2_);
               _loc1_--;
            }
            else if(Boolean(_loc2_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc2_).isHouseItem))
            {
               _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,onHouseItemClick);
               CHARS.removeChild(_loc2_);
               _loc1_--;
            }
            else if(Boolean(_loc2_.hasOwnProperty("isMonster")) && Boolean(MovieClip(_loc2_).isMonster))
            {
               MovieClip(_loc2_).fClose();
               _loc1_--;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TRASH.numChildren)
         {
            _loc2_ = TRASH.getChildAt(_loc1_);
            if(Boolean(_loc2_.hasOwnProperty("isMonster")) && Boolean(MovieClip(_loc2_).isMonster))
            {
               MovieClip(_loc2_).fClose();
               _loc1_--;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < monsters.length)
         {
            monsters[_loc1_].pMC = null;
            _loc1_++;
         }
         while(rootClass.ui.mcPadNames.numChildren)
         {
            _loc3_ = rootClass.ui.mcPadNames.getChildAt(0);
            MovieClip(_loc3_).stop();
            rootClass.ui.mcPadNames.removeChild(_loc3_);
         }
      }
      
      public function setMapEvents(param1:Object) : void
      {
         mapEvents = param1;
      }
      
      public function initMapEvents() : void
      {
         if("eventUpdate" in map && mapEvents != null)
         {
            map.eventUpdate({
               "cmd":"event",
               "args":mapEvents
            });
         }
         mapEvents = null;
      }
      
      public function setCellMap(param1:Object) : void
      {
         cellMap = param1;
      }
      
      public function updateCellMap(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc2_:Object = {};
         for(_loc3_ in cellMap)
         {
            _loc2_ = cellMap[_loc3_];
            if(_loc2_.ias != null && _loc2_.ias[param1.ID] != null)
            {
               for(_loc5_ in param1)
               {
                  _loc2_.ias[param1.ID][_loc5_] = param1[_loc5_];
               }
            }
         }
         try
         {
            _loc4_ = MovieClip(CHARS.getChildByName("ia" + param1.ID));
            _loc4_.update();
            return;
         }
         catch(e:Error)
         {
         }
         try
         {
            _loc4_ = MovieClip(map.getChildByName("ia" + param1.ID));
            _loc4_.update();
         }
         catch(e:Error)
         {
         }
      }
      
      public function onWalkClick() : void
      {
         var aura:Object = null;
         var p:Point = null;
         var now:* = undefined;
         var mvPT:* = undefined;
         var fellDown:Array = null;
         var cLeaf:Object = myAvatar.dataLeaf;
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
         p = new Point(mouseX,mouseY);
         if(bitWalk)
         {
            afkPostpone();
            if(mouseX >= 0 && mouseX <= 960 && mouseY >= 0 && mouseY <= 500)
            {
               p = CHARS.globalToLocal(p);
               p.x = Math.round(p.x);
               p.y = Math.round(p.y);
               speed = WALKSPEED;
               now = new Date().getTime();
               if(Boolean(rootClass.pDash) && !justRan)
               {
                  speed *= 3;
                  justRan = true;
                  rootClass.pDash = false;
               }
               mvPT = myAvatar.pMC.simulateTo(p.x,p.y,speed);
               if(mvPT != null)
               {
                  if(!bPvP)
                  {
                     if(clickPts >= 5)
                     {
                        fellDown = ["Feign","Dazed"];
                        myAvatar.pMC.gotoAndPlay(fellDown[Math.floor(Math.random() * 2)]);
                        return;
                     }
                     myAvatar.pMC.walkTo(mvPT.x,mvPT.y,speed);
                  }
                  if(bPvP)
                  {
                     if(now - mva[0] <= 300 * mva.length)
                     {
                        myAvatar.pMC.walkTo(myAvatar.pMC.tp.x,myAvatar.pMC.tp.y,speed);
                        return;
                     }
                     mva.push(now);
                     if(mva.length > 5)
                     {
                        mva.shift();
                     }
                     myAvatar.pMC.walkTo(mvPT.x,mvPT.y,speed);
                     pushMove(myAvatar.pMC,mvPT.x,mvPT.y,speed);
                  }
                  else if(clickOnEventTest(mvPT.x,mvPT.y))
                  {
                     pushMove(myAvatar.pMC,mvPT.x,mvPT.y,speed);
                  }
                  else
                  {
                     ++clickPts;
                     moveRequest({
                        "mc":myAvatar.pMC,
                        "tx":mvPT.x,
                        "ty":mvPT.y,
                        "sp":speed
                     });
                  }
               }
            }
         }
      }
      
      public function clickOnEventTest(param1:int, param2:int) : Boolean
      {
         var _loc3_:Rectangle = myAvatar.pMC.shadow.getBounds(this);
         var _loc4_:Rectangle = new Rectangle();
         _loc3_.x = param1 - _loc3_.width / 2;
         _loc3_.y = param2 - _loc3_.height / 2;
         var _loc5_:int = 0;
         while(_loc5_ < arrEvent.length)
         {
            _loc4_ = arrEvent[_loc5_].shadow.getBounds(this);
            if(_loc3_.intersects(_loc4_))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function moveRequest(param1:Object) : void
      {
         if(!mvTimer.running)
         {
            pushMove(param1.mc,param1.tx,param1.ty,param1.sp);
            mvTimer.reset();
            mvTimer.start();
         }
         else
         {
            mvTimerObj = param1;
         }
      }
      
      public function mvTimerHandler(param1:TimerEvent) : void
      {
         var _loc2_:Object = {};
         if(mvTimerObj != null)
         {
            pushMove(mvTimerObj.mc,mvTimerObj.tx,mvTimerObj.ty,mvTimerObj.sp);
            mvTimerObj = null;
         }
      }
      
      public function mvTimerKill() : void
      {
         mvTimer.reset();
         mvTimerObj = null;
      }
      
      public function pushMove(param1:MovieClip, param2:int, param3:int, param4:int) : *
      {
         var _loc6_:* = undefined;
         clickPts = 0;
         var _loc5_:* = {};
         _loc5_.tx = int(param2);
         _loc5_.ty = int(param3);
         _loc5_.sp = int(param4);
         uoTreeLeafSet(rootClass.sfc.myUserName,_loc5_);
         if(justRan)
         {
            if(myAvatar.dataLeaf.intSP < uoTree[myAvatar.pnm].sta.$dsh)
            {
               speed = WALKSPEED;
               justRan = false;
            }
         }
         else
         {
            speed = WALKSPEED;
         }
         if(bitWalk)
         {
            rootClass.sfc.sendXtMessage("zm","mv",[param2,param3,speed],"str",curRoom);
         }
         if(justRan)
         {
            _loc6_ = Math.max(0,myAvatar.dataLeaf.intSP - uoTree[myAvatar.pnm].sta.$dsh);
            myAvatar.dataLeaf.intSP = _loc6_;
            myAvatar.objData["intSP"] = _loc6_;
            updatePortrait(myAvatar);
            updateActBar();
            justRan = false;
         }
      }
      
      public function monstersToPads() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         for(_loc1_ in monsters)
         {
            _loc2_ = monsters[_loc1_];
            if(_loc2_.objData != null && _loc2_.objData.strFrame == strFrame)
            {
               _loc2_.pMC.walkTo(_loc2_.pMC.ox,_loc2_.pMC.oy,WALKSPEED * 1.4);
            }
         }
      }
      
      public function updatePadNames() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         while(_loc1_ < rootClass.ui.mcPadNames.numChildren)
         {
            _loc2_ = MovieClip(rootClass.ui.mcPadNames.getChildAt(_loc1_));
            if(objLock == null || objLock[_loc2_.tCell] == null || objLock[_loc2_.tCell] <= intKillCount)
            {
               _loc2_.cnt.lock.visible = false;
            }
            else
            {
               _loc2_.cnt.lock.visible = true;
            }
            _loc1_++;
         }
      }
      
      public function cellSetup(param1:Number, param2:Number, param3:String) : void
      {
         var _loc4_:Bitmap = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:uint = 0;
         var _loc11_:DisplayObject = null;
         var _loc12_:* = undefined;
         var _loc13_:Array = null;
         var _loc14_:Avatar = null;
         var _loc15_:* = undefined;
         var _loc16_:int = 0;
         var _loc17_:MovieClip = null;
         CELL_MODE = param3;
         SCALE = param1;
         WALKSPEED = param2;
         arrSolid = new Array();
         arrEvent = new Array();
         var _loc5_:BitmapData = new BitmapData(960,550,true,0);
         var _loc6_:Array = [];
         var _loc7_:* = Number(objExtra["bMonName"]) == 1;
         var _loc8_:int = 0;
         while(_loc8_ < map.numChildren)
         {
            _loc9_ = map.getChildAt(_loc8_);
            if(_loc9_ is MovieClip)
            {
               if(MovieClip(_loc9_).hasPads)
               {
                  _loc10_ = 0;
                  while(_loc10_ < MovieClip(_loc9_).numChildren)
                  {
                     _loc11_ = MovieClip(_loc9_).getChildAt(_loc10_);
                     if(_loc11_ is MovieClip && MovieClip(_loc11_).isEvent && !MovieClip(_loc11_).isProp)
                     {
                        arrEvent.push(MovieClip(_loc11_));
                     }
                     if(_loc11_ is MovieClip && Boolean(MovieClip(_loc11_).isSolid))
                     {
                        arrSolid.push(MovieClip(_loc9_));
                     }
                     _loc10_++;
                  }
               }
            }
            if(_loc9_ is MovieClip && Boolean(MovieClip(_loc9_).isSolid))
            {
               arrSolid.push(MovieClip(_loc9_));
            }
            if(_loc9_ is MovieClip && "walk" in _loc9_)
            {
               MovieClip(_loc9_).btnWalkingArea.useHandCursor = false;
            }
            if(_loc9_ is MovieClip && MovieClip(_loc9_).isEvent && !MovieClip(_loc9_).isProp)
            {
               arrEvent.push(MovieClip(_loc9_));
            }
            if(strMapName != "trickortreat" && strMapName != "caroling")
            {
               if(_loc9_ is MovieClip && Boolean(MovieClip(_loc9_).isMonster))
               {
                  _loc12_ = [];
                  _loc13_ = getMonsters(MovieClip(_loc9_).MonMapID);
                  for each(_loc14_ in _loc13_)
                  {
                     if(_loc14_ != null)
                     {
                        _loc14_.pMC = createMonsterMC(MovieClip(_loc9_),_loc14_.objData.MonID,_loc7_);
                        _loc14_.pMC.scale(SCALE);
                        _loc14_.pMC.pAV = _loc14_;
                        _loc14_.pMC.setData();
                        if(_loc14_.dataLeaf == null)
                        {
                           TRASH.addChild(_loc14_.pMC);
                        }
                        else if(rootClass.litePreference.data.bMonsType)
                        {
                           _loc14_.pMC.pname.typ.text = "< " + _loc14_.pMC.pAV.objData.sRace + " >";
                           _loc14_.pMC.pname.typ.visible = _loc14_.pMC.pAV.objData.sRace != "None";
                        }
                        else
                        {
                           _loc14_.pMC.pname.typ.visible = false;
                        }
                     }
                  }
               }
            }
            if(_loc9_ is MovieClip && Boolean(MovieClip(_loc9_).isProp))
            {
               _loc15_ = CHARS.addChild(_loc9_);
               if(MovieClip(_loc15_).isEvent)
               {
                  arrEvent.push(MovieClip(_loc15_));
                  MovieClip(_loc15_).isEvent = false;
               }
               _loc8_--;
            }
            if(_loc9_ is MovieClip && _loc9_.width > 700 && !("isSolid" in _loc9_) && !("walk" in _loc9_) && !("btnSkip" in _loc9_))
            {
               MovieClip(_loc9_).mouseEnabled = false;
               MovieClip(_loc9_).mouseChildren = false;
            }
            if(_loc9_ is MovieClip && _loc9_.width >= 960 && !("isSolid" in _loc9_) && !("walk" in _loc9_) && !("btnSkip" in _loc9_))
            {
            }
            _loc8_++;
         }
         if(strFrame == "Enter" && strMapName == "trickortreat")
         {
            if(TrickOrTreatMonsterDead && !CHARS.getChildByName("mcPlayerNPCTrickOrTreat"))
            {
               loadPlayerNPC();
            }
            else
            {
               TrickOrTreatPad = "Spawn";
               _loc16_ = 0;
               while(_loc16_ < map.numChildren)
               {
                  _loc17_ = map.getChildAt(_loc16_) as MovieClip;
                  if(_loc17_ != null && _loc17_.toString().indexOf("Pad") != -1)
                  {
                     if(_loc17_.name != "Spawn")
                     {
                        TrickOrTreatPad = _loc17_.name;
                        break;
                     }
                  }
                  _loc16_++;
               }
               _loc12_ = [];
               _loc13_ = getMonsters(1);
               for each(_loc14_ in _loc13_)
               {
                  _loc14_.pMC = createMonsterMC(map[TrickOrTreatPad],_loc14_.objData.MonID,_loc7_);
                  _loc14_.pMC.scale(SCALE);
                  _loc14_.pMC.pAV = _loc14_;
                  _loc14_.pMC.setData();
                  if(_loc14_.dataLeaf == null)
                  {
                     TRASH.addChild(_loc14_.pMC);
                  }
                  else if(rootClass.litePreference.data.bMonsType)
                  {
                     _loc14_.pMC.pname.typ.text = "< " + _loc14_.pMC.pAV.objData.sRace + " >";
                     _loc14_.pMC.pname.typ.visible = _loc14_.pMC.pAV.objData.sRace != "None";
                  }
                  else
                  {
                     _loc14_.pMC.pname.typ.visible = false;
                  }
               }
               player_npc_pos = new Point(map[TrickOrTreatPad].x,map[TrickOrTreatPad].y);
            }
         }
         if(strFrame == "Enter" && strMapName == "caroling")
         {
            if(CarolingMonsterKillCount >= 5 && !CHARS.getChildByName("mcPlayerNPCCaroling"))
            {
               loadPlayerNPC();
            }
            else
            {
               CarolingPad = "Spawn";
               _loc16_ = 0;
               while(_loc16_ < map.numChildren)
               {
                  _loc17_ = map.getChildAt(_loc16_) as MovieClip;
                  if(_loc17_ != null && _loc17_.toString().indexOf("Pad") != -1)
                  {
                     if(_loc17_.name != "Spawn")
                     {
                        CarolingPad = _loc17_.name;
                        break;
                     }
                  }
                  _loc16_++;
               }
               _loc12_ = [];
               _loc13_ = getMonsters(1);
               var _loc18_:int = 0;
               var _loc19_:* = _loc13_;
               for each(_loc14_ in _loc19_)
               {
                  _loc14_.pMC = createMonsterMC(map[CarolingPad],_loc14_.objData.MonID,_loc7_);
                  _loc14_.pMC.scale(SCALE);
                  _loc14_.pMC.pAV = _loc14_;
                  _loc14_.pMC.setData();
                  if(_loc14_.dataLeaf == null)
                  {
                     TRASH.addChild(_loc14_.pMC);
                  }
                  else if(rootClass.litePreference.data.bMonsType)
                  {
                     _loc14_.pMC.pname.typ.text = "< " + _loc14_.pMC.pAV.objData.sRace + " >";
                     _loc14_.pMC.pname.typ.visible = _loc14_.pMC.pAV.objData.sRace != "None";
                  }
                  else
                  {
                     _loc14_.pMC.pname.typ.visible = false;
                  }
               }
               player_npc_pos = new Point(map[CarolingPad].x,map[CarolingPad].y);
            }
         }
         buildBoundingRects();
         if(map.bounds != null)
         {
            mapBoundsMC = map.getChildByName("bounds") as MovieClip;
         }
         if(!rootClass.litePreference.data.bSmoothBG)
         {
            rebuildMapBMP(map);
         }
         playerInit();
         updateMonsters();
         updatePadNames();
         if(objHouseData != null)
         {
            updateHouseItems();
         }
      }
      
      public function loadPlayerNPC() : void
      {
         if(strMapName == "caroling")
         {
            if(loaderD.hasDefinition("PlayerNPCCaroling"))
            {
               onPlayerNPCComplete();
               return;
            }
         }
         else if(loaderD.hasDefinition("PlayerNPCTrickOrTreat"))
         {
            onPlayerNPCComplete();
            return;
         }
         var _loc1_:Loader = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,onPlayerNPCComplete,false,0,true);
         if(strMapName == "caroling")
         {
            _loc1_.load(new URLRequest(rootClass.getFilePath() + "items/house/PlayerNPC_Caroling.swf"),loaderC);
         }
         else
         {
            _loc1_.load(new URLRequest(rootClass.getFilePath() + "items/house/PlayerNPC_TrickOrTreat.swf"),loaderC);
         }
      }
      
      private function onPlayerNPCComplete(param1:Event = null) : void
      {
         var _loc2_:Class = null;
         if(strMapName == "caroling")
         {
            _loc2_ = loaderD.getDefinition("PlayerNPCCaroling") as Class;
         }
         else
         {
            _loc2_ = loaderD.getDefinition("PlayerNPCTrickOrTreat") as Class;
         }
         var _loc3_:* = new _loc2_();
         _loc3_.x = player_npc_pos.x;
         _loc3_.y = player_npc_pos.y;
         if(_loc3_.x > myAvatar.pMC.x)
         {
            _loc3_.scaleX *= -1;
         }
         var _loc4_:MovieClip = CHARS.addChild(_loc3_) as MovieClip;
         _loc4_.name = "mc" + getQualifiedClassName(_loc4_);
         _loc4_.isProp = true;
      }
      
      private function buildBoundingRects() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         arrEventR = [];
         arrSolidR = [];
         _loc1_ = 0;
         while(_loc1_ < arrEvent.length)
         {
            _loc3_ = arrEvent[_loc1_];
            _loc2_ = _loc3_.getBounds(rootClass.stage);
            arrEventR.push(_loc2_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < arrSolid.length)
         {
            _loc3_ = arrSolid[_loc1_];
            _loc2_ = _loc3_.getBounds(rootClass.stage);
            arrSolidR.push(_loc2_);
            _loc1_++;
         }
      }
      
      public function killWalkObjects() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < map.numChildren)
         {
            _loc2_ = map.getChildAt(_loc1_);
            if(_loc2_ is MovieClip && Boolean(MovieClip(_loc2_).isEvent))
            {
               removeEventListener("enter",MovieClip(_loc2_).onEnter);
            }
            _loc1_++;
         }
      }
      
      public function exitQuest() : void
      {
         if(returnInfo != null)
         {
            rootClass.sfc.sendXtMessage("zm","cmd",["tfer",rootClass.sfc.myUserName,returnInfo.strMap,returnInfo.strCell,returnInfo.strPad],"str",curRoom);
         }
      }
      
      public function gotoTown(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:* = uoTree[rootClass.sfc.myUserName];
         if(_loc4_.intState == 0)
         {
            rootClass.chatF.pushMsg("warning","You are dead!","SERVER","",0);
         }
         else if(!rootClass.world.myAvatar.invLoaded || !rootClass.world.myAvatar.pMC.artLoaded())
         {
            rootClass.MsgBox.notify("Character still being loaded.");
         }
         else if(coolDown("tfer"))
         {
            rootClass.MsgBox.notify("Joining " + param1);
            setReturnInfo(param1,param2,param3);
            rootClass.sfc.sendXtMessage("zm","cmd",["tfer",rootClass.sfc.myUserName,param1,param2,param3],"str",curRoom);
            if(strAreaName.indexOf("battleon") < 0 || strAreaName.indexOf("battleontown") > -1)
            {
               rootClass.menuClose();
            }
         }
         else
         {
            rootClass.MsgBox.notify("You must wait 5 seconds before joining another map.");
         }
      }
      
      public function gotoQuest(param1:String, param2:String, param3:String) : void
      {
         gotoTown(param1,param2,param3);
      }
      
      public function openApop(param1:*) : *
      {
         var _loc2_:MovieClip = null;
         if(isMovieFront("Apop") || (!("frame" in param1) || "frame" in param1 && "cnt" in param1))
         {
            rootClass.menuClose();
            _loc2_ = attachMovieFront("Apop");
            _loc2_.update(param1);
         }
      }
      
      public function setSpawnPoint(param1:*, param2:*) : void
      {
         spawnPoint.strFrame = param1;
         spawnPoint.strPad = param2;
      }
      
      public function resetSpawnPoint() : void
      {
         spawnPoint.strFrame = "Enter";
         spawnPoint.strPad = "Spawn";
      }
      
      public function initObjExtra(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         objExtra = new Object();
         if(param1 != null && param1 != "")
         {
            _loc2_ = param1.split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_].split("=");
               objExtra[_loc4_[0]] = _loc4_[1];
               _loc3_++;
            }
         }
      }
      
      public function initObjInfo(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         objInfo = new Object();
         if(param1 != null && param1 != "")
         {
            _loc2_ = param1.split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_].split("=");
               objInfo[_loc4_[0]] = _loc4_[1];
               _loc3_++;
            }
         }
      }
      
      private function rasterize(param1:Array, param2:Boolean = false) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Point = null;
         var _loc7_:Matrix = null;
         var _loc8_:String = null;
         var _loc9_:DisplayObject = null;
         mapNW = rootClass.stage.stageWidth;
         var _loc3_:Number = mapNW / mapW;
         var _loc4_:int = 0;
         mapNH = Math.round(mapH * _loc3_);
         for each(_loc5_ in param1)
         {
            _loc5_.child.x = _loc5_.x;
            if(_loc5_.bmd != null)
            {
               _loc5_.bmd.dispose();
            }
            _loc5_.bmd = new BitmapData(mapNW,mapNH,true,10066329);
            _loc6_ = new Point(0,0);
            _loc6_ = _loc5_.child.globalToLocal(_loc6_);
            _loc7_ = new Matrix(_loc3_ * _loc5_.child.transform.matrix.a,0,0,_loc3_ * _loc5_.child.transform.matrix.d,-(_loc6_.x * _loc3_ * _loc5_.child.transform.matrix.a),-(_loc6_.y * _loc3_ * _loc5_.child.transform.matrix.d));
            _loc5_.bmd.draw(_loc5_.child,_loc7_,_loc5_.child.transform.colorTransform,null,new Rectangle(0,0,mapNW,mapNH),false);
            _loc5_.bm = new Bitmap(_loc5_.bmd);
            _loc8_ = String("bmp" + _loc4_);
            _loc9_ = _loc5_.child.parent.getChildByName(_loc8_);
            if(_loc9_ != null)
            {
               _loc5_.child.parent.removeChild(_loc9_);
            }
            _loc5_.bmDO = _loc5_.child.parent.addChildAt(_loc5_.bm,_loc5_.child.parent.getChildIndex(_loc5_.child) + 1);
            _loc5_.bmDO.name = _loc8_;
            _loc5_.bmDO.width = mapW;
            _loc5_.bmDO.height = mapH;
            _loc5_.child.visible = false;
            if(param2)
            {
               _loc5_.child.x += 1200;
            }
            _loc4_++;
         }
      }
      
      private function rebuildMapBMP(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         clearMapBmps();
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_) as MovieClip;
            if(_loc2_ is MovieClip && _loc2_.width >= 960 && _loc2_.name.toLowerCase().indexOf("bmp") == -1 && _loc2_.name.toLowerCase().indexOf("cs") == -1 && _loc2_.name.toLowerCase().indexOf("bounds") == -1 && (_loc2_ as MovieClip == null || MovieClip(_loc2_).totalFrames < 15) && !("isSolid" in _loc2_) && !("isFloor" in _loc2_) && !("isWall" in _loc2_) && !("walk" in _loc2_) && !("btnSkip" in _loc2_) && !("noBmp" in _loc2_))
            {
               mapBmps.push({
                  "child":_loc2_,
                  "x":_loc2_.x,
                  "bmDO":null
               });
            }
            _loc3_++;
         }
         rasterize(mapBmps);
      }
      
      private function mapResizeCheck(param1:TimerEvent) : void
      {
         if(map != null && mapBmps.length > 0)
         {
            if(mapNW != rootClass.stage.stageWidth)
            {
               rasterize(mapBmps);
            }
         }
      }
      
      private function clearMapBmps() : void
      {
         var _loc1_:Object = null;
         if(mapBmps.length > 0)
         {
            for each(_loc1_ in mapBmps)
            {
               _loc1_.bmDO.parent.removeChild(_loc1_.bmDO);
               if(_loc1_.bmd != null)
               {
                  _loc1_.bmd.dispose();
               }
               _loc1_.child = null;
               _loc1_.bmd = null;
               _loc1_.bm = null;
            }
         }
         mapBmps = [];
      }
      
      public function initMap() : mapData
      {
         mData = new mapData(rootClass);
         return mData;
      }
      
      public function initCutscenes() : cutsceneHandler
      {
         cHandle = new cutsceneHandler(rootClass);
         return cHandle;
      }
      
      public function initSound(param1:Sound) : soundController
      {
         sController = new soundController(param1,rootClass);
         return sController;
      }
      
      public function gotoHouse(param1:String) : void
      {
         param1 = param1.toLowerCase();
         if(objHouseData != null && objHouseData.unm == param1 && strMapName == "house")
         {
            return;
         }
         rootClass.sfc.sendXtMessage("zm","house",[param1],"str",1);
      }
      
      public function isHouseEquipped() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < myAvatar.houseitems.length)
         {
            if(myAvatar.houseitems[_loc1_].bEquip)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function isMyHouse() : *
      {
         return objHouseData != null && objHouseData.unm == myAvatar.objData.strUsername.toLowerCase() && strMapName == "house";
      }
      
      public function showHouseOptions(param1:String) : void
      {
         var _loc2_:MovieClip = rootClass.ui.mcPopup.mcHouseOptions;
         switch(param1)
         {
            case "default":
            case "save":
            default:
               _loc2_.visible = true;
               _loc2_.bg.x = 0;
               _loc2_.cnt.x = 0;
               _loc2_.tTitle.x = 5;
               _loc2_.bExpand.x = 190;
               _loc2_.bg.visible = true;
               _loc2_.cnt.visible = true;
               _loc2_.tTitle.visible = true;
               _loc2_.bExpand.visible = false;
               break;
            case "hide":
               _loc2_.visible = true;
               _loc2_.bg.x = 181;
               _loc2_.cnt.x = 181;
               _loc2_.tTitle.x = 186;
               _loc2_.bExpand.x = 120;
               _loc2_.bg.visible = false;
               _loc2_.cnt.visible = false;
               _loc2_.tTitle.visible = false;
               _loc2_.bExpand.visible = true;
         }
      }
      
      public function hideHouseOptions() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = rootClass.ui.mcPopup.mcHouseOptions;
         if(_loc1_.visible)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.numChildren)
            {
               _loc1_.getChildAt(_loc2_).x = 190;
               _loc2_++;
            }
         }
         _loc1_.visible = false;
      }
      
      public function onHouseOptionsDesignClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         toggleHouseEdit();
      }
      
      public function onHouseOptionsSaveClick(param1:MouseEvent) : void
      {
         if(hasModified)
         {
            rootClass.mixer.playSound("Click");
            saveHouseSetup();
         }
      }
      
      public function onHouseOptionsHideClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         showHouseOptions("hide");
      }
      
      public function onHouseOptionsExpandClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         showHouseOptions("default");
      }
      
      public function onHouseOptionsFloorClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         showHouseInventory(70);
      }
      
      public function onHouseOptionsWallClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         showHouseInventory(72);
      }
      
      public function onHouseOptionsMiscClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         showHouseInventory(73);
      }
      
      public function onHouseOptionsHouseReset(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         var _loc2_:* = new ModalMC();
         var _loc3_:* = {};
         _loc3_.params = {};
         _loc3_.strBody = "Are you sure you want to reset the entire house?";
         _loc3_.callback = confirmClear;
         _loc3_.btns = "dual";
         rootClass.ui.ModalStack.addChild(_loc2_);
         _loc2_.init(_loc3_);
      }
      
      public function confirmClear(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         if(param1.accept)
         {
            _loc2_ = 0;
            while(_loc2_ < CHARS.numChildren)
            {
               _loc3_ = CHARS.getChildAt(_loc2_);
               if(Boolean(_loc3_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc3_).isHouseItem))
               {
                  CHARS.removeChild(_loc3_);
                  _loc2_--;
               }
               _loc2_++;
            }
            objHouseData.sHouseInfo = "";
            objHouseData.arrPlacement = new Array();
            initEquippedItems(objHouseData.arrPlacement);
            sendSaveHouseSetup(objHouseData.sHouseInfo);
            rootClass.requestAPI("HouseSaveRoom",{"frame":"*"},callbackC,callbackB,true);
         }
      }
      
      public function callbackC(param1:Event) : void
      {
         if(param1.target.data == "cleared")
         {
            rootClass.addUpdate("House cleared successfully.");
            rootClass.chatF.pushMsg("server","House cleared successfully.","SERVER","",0);
            cleanEverything();
         }
         else
         {
            rootClass.chatF.pushMsg("warning","Error clearing your house. (CODE: " + param1.target.data + ")","SERVER","",0);
         }
      }
      
      public function cleanEverything() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = 0;
         while(_loc1_ < CHARS.numChildren)
         {
            _loc2_ = CHARS.getChildAt(_loc1_);
            if(Boolean(_loc2_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc2_).isHouseItem))
            {
               CHARS.removeChild(_loc2_);
               _loc1_--;
            }
            _loc1_++;
         }
         objHouseData.sHouseInfo = "";
         objHouseData.sData = new Object();
         objHouseData.arrPlacement = new Array();
         initEquippedItems(objHouseData.arrPlacement);
      }
      
      public function onHouseOptionsHouseClick(param1:MouseEvent) : void
      {
         rootClass.mixer.playSound("Click");
         gotoTown("buyhouse","Enter","Spawn");
      }
      
      public function showHouseInventory(param1:int) : *
      {
         if(myAvatar.houseitems != null)
         {
            sendLoadShopRequest(param1);
         }
      }
      
      public function discardHouseChanges(param1:Object) : *
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         if(param1.accept)
         {
            saveHouseSetup();
         }
         else
         {
            hasModified = false;
            if(rootClass.ui.mcPopup.mcHouseItemHandle.visible)
            {
               rootClass.ui.mcPopup.mcHouseItemHandle.tgt = null;
               rootClass.ui.mcPopup.mcHouseItemHandle.x = 1000;
               rootClass.ui.mcPopup.mcHouseItemHandle.visible = false;
            }
            _loc3_ = 0;
            while(_loc3_ < CHARS.numChildren)
            {
               _loc2_ = CHARS.getChildAt(_loc3_);
               if(Boolean(_loc2_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc2_).isHouseItem))
               {
                  CHARS.removeChild(_loc2_);
                  _loc3_--;
               }
               _loc3_++;
            }
            if(isLegacy())
            {
               _loc3_ = 0;
               while(_loc3_ < objHouseData.arrPlacement.length)
               {
                  if(strFrame == objHouseData.arrPlacement[_loc3_].c)
                  {
                     objHouseData.arrPlacement.splice(_loc3_,1);
                     _loc3_--;
                  }
                  _loc3_++;
               }
               for each(_loc4_ in frameCopy)
               {
                  objHouseData.arrPlacement.push(_loc4_);
               }
            }
            else
            {
               objHouseData.arrPlacement[strFrame] = new Object();
               objHouseData.arrPlacement[strFrame]["xi"] = new Array();
               _loc5_ = 0;
               for each(_loc4_ in frameCopy)
               {
                  objHouseData.arrPlacement[strFrame]["xi"].push(_loc4_);
                  _loc5_++;
               }
               if(_loc5_ == 0)
               {
                  objHouseData.arrPlacement[strFrame] = null;
               }
            }
            updateHouseItems();
         }
         if(!hasModified && Boolean(rootClass.ui.mcPopup.mcHouseMenu.visible))
         {
            toggleHouseEdit();
         }
      }
      
      public function toggleHouseEdit() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:* = undefined;
         if(isMyHouse() && myAvatar.houseitems != null)
         {
            if(rootClass.ui.mcPopup.mcHouseMenu.visible)
            {
               if(hasModified)
               {
                  _loc1_ = new ModalMC();
                  _loc2_ = {};
                  _loc2_.params = {};
                  _loc2_.strBody = "Do you want to Save (Yes) or Undo (No) the room?";
                  _loc2_.callback = discardHouseChanges;
                  _loc2_.btns = "dual";
                  rootClass.ui.ModalStack.addChild(_loc1_);
                  _loc1_.init(_loc2_);
                  return;
               }
               rootClass.ui.mcPopup.mcHouseMenu.hideEditMenu();
               setEditMode(false);
            }
            else
            {
               if(arrHouseItemQueue.length > 0)
               {
                  rootClass.showMessageBox("Please wait for your house items to finish loading on your screen before being able to edit them.");
                  return;
               }
               if(isLegacy())
               {
                  frameCopy = new Array();
                  _loc3_ = 0;
                  while(_loc3_ < CHARS.numChildren)
                  {
                     _loc4_ = CHARS.getChildAt(_loc3_);
                     if(Boolean(_loc4_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc4_).isHouseItem))
                     {
                        if(MovieClip(_loc4_).isStable)
                        {
                           frameCopy.push({
                              "c":strFrame,
                              "ID":MovieClip(_loc4_).ItemID,
                              "x":_loc4_.x,
                              "y":_loc4_.y
                           });
                        }
                     }
                     _loc3_++;
                  }
               }
               else
               {
                  frameCopy = new Array();
                  if(objHouseData.arrPlacement[strFrame])
                  {
                     for each(_loc5_ in objHouseData.arrPlacement[strFrame]["xi"])
                     {
                        frameCopy.push(_loc5_);
                     }
                  }
               }
               rootClass.ui.mcPopup.mcHouseMenu.showEditMenu();
               setEditMode(true);
            }
         }
         else if(strMapName == "buyhouse")
         {
            if(!rootClass.ui.mcPopup.mcHouseMenu.visible)
            {
               rootClass.ui.mcPopup.mcHouseMenu.showEditMenu();
            }
            else
            {
               rootClass.ui.mcPopup.mcHouseMenu.hideEditMenu();
            }
         }
      }
      
      private function houseBounds(param1:Event) : void
      {
         if(!isMyHouse() || strFrame != houseFrame || bitWalk || strMapName != "house")
         {
            houseFrame = "";
            this.removeEventListener(Event.ENTER_FRAME,houseBounds);
            toggleHouseEdit();
            setEditMode(false);
         }
      }
      
      public function setEditMode(param1:Boolean) : *
      {
         var _loc2_:* = undefined;
         if(param1)
         {
            houseFrame = strFrame;
            for each(_loc2_ in avatars)
            {
               if(_loc2_.pMC)
               {
                  _loc2_.pMC.visible = false;
                  _loc2_.unloadPet();
               }
            }
            myAvatar.isWorldCamera = true;
            bitWalk = false;
            this.addEventListener(Event.ENTER_FRAME,houseBounds,false,0,true);
         }
         else
         {
            for each(_loc2_ in avatars)
            {
               if(_loc2_.pMC)
               {
                  _loc2_.pMC.visible = true;
                  _loc2_.loadPet();
               }
            }
            myAvatar.isWorldCamera = false;
            bitWalk = true;
         }
      }
      
      public function loadHouseInventory() : *
      {
         rootClass.sfc.sendXtMessage("zm","loadHouseInventory",[],"str",curRoom);
      }
      
      public function updateHouseItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         if(objHouseData != null)
         {
            if(isMyHouse())
            {
               initEquippedItems(objHouseData.arrPlacement);
            }
            arrHouseItemQueue = [];
            try
            {
               ldr_House.close();
            }
            catch(e:*)
            {
            }
            if(isLegacy())
            {
               _loc1_ = 0;
               while(_loc1_ < objHouseData.arrPlacement.length)
               {
                  if(strFrame == objHouseData.arrPlacement[_loc1_].c)
                  {
                     _loc2_ = getHouseItem(objHouseData.arrPlacement[_loc1_].ID);
                     if(_loc2_ != null)
                     {
                        loadHouseItem(_loc2_,objHouseData.arrPlacement[_loc1_].x,objHouseData.arrPlacement[_loc1_].y);
                     }
                  }
                  _loc1_++;
               }
            }
            else
            {
               for(_loc3_ in objHouseData.arrPlacement)
               {
                  if(strFrame == _loc3_)
                  {
                     if(objHouseData.arrPlacement[_loc3_])
                     {
                        _loc1_ = 0;
                        while(_loc1_ < objHouseData.arrPlacement[_loc3_]["xi"].length)
                        {
                           _loc2_ = getHouseItem(objHouseData.arrPlacement[_loc3_]["xi"][_loc1_]["ID"]);
                           if(_loc2_ != null)
                           {
                              loadHouseItem(_loc2_,objHouseData.arrPlacement[_loc3_]["xi"][_loc1_]["x"],objHouseData.arrPlacement[_loc3_]["xi"][_loc1_]["y"],objHouseData.arrPlacement[_loc3_]["xi"][_loc1_]["f"]);
                           }
                           _loc1_++;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function attachHouseItem(param1:Object) : void
      {
         var _loc2_:Class = loaderD.getDefinition(param1.item.sLink) as Class;
         var _loc3_:* = new _loc2_();
         _loc3_.f = param1.f;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         _loc3_.ItemID = param1.item.ItemID;
         _loc3_.item = param1.item;
         _loc3_.isHouseItem = true;
         _loc3_.isStable = false;
         _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,onHouseItemClick,false,0,true);
         if(_loc3_.f)
         {
            _loc3_.scaleX *= -1;
         }
         var _loc4_:MovieClip = CHARS.addChild(_loc3_) as MovieClip;
         _loc4_.name = "mc" + getQualifiedClassName(_loc4_);
         houseItemValidate(_loc3_);
      }
      
      public function onHouseItemClick(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(isMyHouse() && Boolean(rootClass.ui.mcPopup.mcHouseMenu.visible))
         {
            rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(MovieClip(param1.currentTarget));
            rootClass.ui.mcPopup.mcHouseMenu.onHandleMoveClick(param1.clone());
         }
         else if(_loc2_.btnButton == null || !_loc2_.btnButton.hasEventListener(MouseEvent.CLICK))
         {
            onWalkClick();
         }
      }
      
      public function houseItemValidate(param1:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc2_:* = getHouseItem(param1.ItemID);
         if(_loc2_ == null)
         {
            MovieClip(param1.parent).removeChild(param1);
            return;
         }
         if(_loc2_.sType == "Floor Item")
         {
            param1.isStable = false;
            param1.addEventListener(Event.ENTER_FRAME,onHouseItemEnterFrame,false,0,true);
         }
         else if(_loc2_.sType == "Wall Item")
         {
            param1.isStable = true;
            _loc3_ = 0;
            while(_loc3_ < map.numChildren)
            {
               _loc4_ = map.getChildAt(_loc3_);
               if(_loc4_ is MovieClip && MovieClip(_loc4_).isFloor && MovieClip(_loc4_).hitTestObject(param1))
               {
                  param1.isStable = false;
                  break;
               }
               _loc3_++;
            }
            if(!param1.isStable)
            {
               param1.transform.colorTransform = new ColorTransform(1,1,1,1,150,0,0,0);
            }
            else
            {
               param1.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
            }
         }
      }
      
      public function onHouseItemEnterFrame(param1:Event) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc5_:Rectangle = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!_loc2_)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,onHouseItemEnterFrame);
         }
         var _loc3_:int = 0;
         while(_loc3_ < map.numChildren)
         {
            _loc4_ = map.getChildAt(_loc3_);
            if(_loc4_ is MovieClip && MovieClip(_loc4_).isFloor && MovieClip(_loc4_).hitTestPoint(_loc2_.x,_loc2_.y))
            {
               _loc2_.removeEventListener(Event.ENTER_FRAME,onHouseItemEnterFrame);
               _loc2_.isStable = true;
               break;
            }
            _loc3_++;
         }
         if(!_loc2_.isStable)
         {
            _loc5_ = _loc2_.getBounds(rootClass.stage);
            if(_loc5_.y + _loc5_.height / 2 > 495)
            {
               _loc2_.isStable = true;
               _loc2_.y = Math.ceil(_loc5_.y - (_loc5_.y - _loc2_.y));
               _loc2_.removeEventListener(Event.ENTER_FRAME,onHouseItemEnterFrame);
            }
            else
            {
               _loc2_.y += 10;
            }
            if(Boolean(rootClass.ui.mcPopup.mcHouseMenu) && Boolean(rootClass.ui.mcPopup.mcHouseMenu.visible))
            {
               rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(_loc2_);
            }
         }
      }
      
      public function isLegacy() : Boolean
      {
         if(objHouseData != null && (objHouseData.sData == "" && objHouseData.sHouseInfo == ""))
         {
            return false;
         }
         return !(objHouseData != null && objHouseData.sData != "");
      }
      
      public function initHouseData(param1:Object) : void
      {
         objHouseData = param1;
         if(objHouseData != null)
         {
            if(!isLegacy())
            {
               if(isMyHouse())
               {
                  searchForInequalities();
               }
               objHouseData.arrPlacement = objHouseData.sData;
               if(objHouseData.sData == "")
               {
                  objHouseData.arrPlacement = {};
               }
               if(isMyHouse())
               {
                  rootClass.chatF.pushMsg("server","Your house data has been upgraded.","SERVER","",0);
               }
            }
            else
            {
               objHouseData.arrPlacement = createItemPlacementArray(objHouseData.sHouseInfo);
               if(isMyHouse())
               {
                  rootClass.chatF.pushMsg("server","Your house data needs to be upgraded. Upgrading will start shortly.","SERVER","",0);
               }
            }
            verifyItemQty();
         }
         if(isMyHouse() && imbalancedHouseCells.length > 0)
         {
            massAutoSave();
         }
      }
      
      public function massAutoSave() : void
      {
         convertTimer = new Timer(500,1);
         convertTimer.addEventListener(TimerEvent.TIMER,onAutoSave,false,0,true);
         convertTimer.start();
      }
      
      public function onAutoSave(param1:TimerEvent) : void
      {
         var _loc2_:String = imbalancedHouseCells.shift();
         rootClass.mcConnDetail.showConn("Upgrading room " + _loc2_ + "...",false,true);
         rootClass.chatF.pushMsg("server","Saving room " + _loc2_ + "...","SERVER","",0);
         rootClass.requestAPI("HouseSaveRoom",{
            "frame":_loc2_,
            "layout":objHouseData.sData[_loc2_]
         },callbackA,callbackB,true);
         if(imbalancedHouseCells.length < 1)
         {
            rootClass.mcConnDetail.hideConn();
            convertTimer.removeEventListener(TimerEvent.TIMER,onSendConvert);
            convertTimer.reset();
            convertTimer = null;
         }
      }
      
      public function searchForInequalities() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc1_:* = {};
         for(_loc2_ in objHouseData.sData)
         {
            if(objHouseData.sData[_loc2_])
            {
               _loc4_ = 0;
               while(_loc4_ < objHouseData.sData[_loc2_]["xi"].length)
               {
                  _loc7_ = objHouseData.sData[_loc2_]["xi"][_loc4_]["ID"];
                  if(_loc1_[_loc7_] == null)
                  {
                     _loc1_[_loc7_] = 1;
                  }
                  else
                  {
                     ++_loc1_[_loc7_];
                  }
                  _loc4_++;
               }
            }
         }
         _loc3_ = [];
         _loc4_ = 0;
         while(_loc4_ < myAvatar.houseitems.length)
         {
            _loc8_ = myAvatar.houseitems[_loc4_];
            if(Number(_loc1_[_loc8_.ItemID]) > Number(_loc8_.iQty))
            {
               _loc3_.push(_loc8_.ItemID);
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            return;
         }
         imbalancedHouseCells = [];
         var _loc5_:Boolean = false;
         for(_loc6_ in objHouseData.sData)
         {
            _loc5_ = false;
            _loc9_ = 0;
            while(_loc9_ < objHouseData.sData[_loc6_]["xi"].length)
            {
               if(_loc3_.indexOf(objHouseData.sData[_loc6_]["xi"][_loc9_]["ID"]) > -1)
               {
                  objHouseData.sData[_loc6_]["xi"].splice(_loc9_,1);
                  _loc9_--;
                  _loc5_ = true;
               }
               _loc9_++;
            }
            if(_loc5_)
            {
               imbalancedHouseCells.push(_loc6_);
            }
         }
      }
      
      public function initMassConvert() : void
      {
         if(objHouseData != null)
         {
            if(objHouseData.sHouseInfo != "")
            {
               if(isLegacy())
               {
                  massConvert();
               }
            }
         }
      }
      
      public function verifyItemQty() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:* = {};
         if(isLegacy())
         {
            _loc2_ = 0;
            while(_loc2_ < objHouseData.arrPlacement.length)
            {
               _loc3_ = objHouseData.arrPlacement[_loc2_].ID;
               if(_loc1_[_loc3_] == null)
               {
                  _loc1_[_loc3_] = 1;
               }
               else
               {
                  ++_loc1_[_loc3_];
               }
               _loc2_++;
            }
         }
         else
         {
            for(_loc4_ in objHouseData.arrPlacement)
            {
               if(_loc4_ == strFrame)
               {
                  if(objHouseData.arrPlacement[_loc4_])
                  {
                     _loc2_ = 0;
                     while(_loc2_ < objHouseData.arrPlacement[_loc4_]["xi"].length)
                     {
                        _loc3_ = objHouseData.arrPlacement[_loc4_]["xi"][_loc2_]["ID"];
                        if(_loc1_[_loc3_] == null)
                        {
                           _loc1_[_loc3_] = 1;
                        }
                        else
                        {
                           ++_loc1_[_loc3_];
                        }
                        _loc2_++;
                     }
                  }
               }
            }
         }
      }
      
      public function getHouseItem(param1:int) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(isMyHouse())
         {
            _loc2_ = 0;
            while(_loc2_ < myAvatar.houseitems.length)
            {
               if(myAvatar.houseitems[_loc2_].ItemID == param1)
               {
                  return myAvatar.houseitems[_loc2_];
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < objHouseData.items.length)
            {
               if(objHouseData.items[_loc3_].ItemID == param1)
               {
                  return objHouseData.items[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function removeSelectedItem() : void
      {
         var _loc1_:MovieClip = null;
         if(objHouseData.selectedMC == null)
         {
            rootClass.MsgBox.notify("Please selected an item to be removed.");
         }
         else
         {
            _loc1_ = objHouseData.selectedMC;
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,onHouseItemClick);
            unequipHouseItem(_loc1_.ItemID);
            CHARS.removeChild(_loc1_);
            delete objHouseData.selectedMC;
         }
      }
      
      public function equipHouse(param1:Object) : void
      {
         var _loc2_:* = new ModalMC();
         var _loc3_:* = {};
         _loc3_.strBody = "Are you sure you want to equip \'" + param1.sName + "\'?";
         _loc3_.params = {"item":param1};
         _loc3_.callback = equipHouseRequest;
         rootClass.ui.ModalStack.addChild(_loc2_);
         _loc2_.init(_loc3_);
      }
      
      public function equipHouseRequest(param1:*) : void
      {
         if(param1.accept)
         {
            rootClass.world.sendEquipItemRequest(param1.item);
            rootClass.world.equipHouseByID(param1.item.ItemID);
         }
      }
      
      public function equipHouseByID(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < myAvatar.houseitems.length)
         {
            myAvatar.houseitems[_loc2_].bEquip = myAvatar.houseitems[_loc2_].ItemID == param1 ? 1 : 0;
            _loc2_++;
         }
         if(rootClass.ui.mcPopup.currentLabel == "HouseInventory")
         {
            MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshItems"});
         }
      }
      
      public function massConvert() : void
      {
         var _loc1_:* = undefined;
         houseJson = new Object();
         for each(_loc1_ in createItemPlacementArray(objHouseData.sHouseInfo))
         {
            if(_loc1_.c)
            {
               if(frameExists(_loc1_.c))
               {
                  if(!houseJson.hasOwnProperty(_loc1_.c))
                  {
                     houseJson[_loc1_.c] = new Object();
                     houseJson[_loc1_.c]["xi"] = new Array();
                  }
                  houseJson[_loc1_.c]["xi"].push({
                     "ID":parseInt(_loc1_.ID),
                     "x":parseInt(_loc1_.x),
                     "y":parseInt(_loc1_.y)
                  });
               }
            }
         }
         finishedCells = new Array();
         retrieveUnsentCell();
         convertTimer = new Timer(500,1);
         convertTimer.addEventListener(TimerEvent.TIMER,onSendConvert,false,0,true);
         convertTimer.start();
      }
      
      public function retrieveUnsentCell() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in houseJson)
         {
            if(finishedCells.indexOf(_loc1_) == -1)
            {
               activeCell = _loc1_;
               finishedCells.push(_loc1_);
               return;
            }
         }
         rootClass.mcConnDetail.hideConn();
         if(convertTimer)
         {
            convertTimer.removeEventListener(TimerEvent.TIMER,onSendConvert);
            convertTimer.reset();
            convertTimer = null;
         }
      }
      
      public function onSendConvert(param1:TimerEvent) : void
      {
         var _loc2_:* = undefined;
         rootClass.mcConnDetail.showConn("Converting frame " + activeCell + " from legacy house data...",false,true);
         rootClass.chatF.pushMsg("server","Saving room " + activeCell + "...","SERVER","",0);
         rootClass.requestAPI("HouseSaveRoom",{
            "frame":activeCell,
            "layout":houseJson[activeCell]
         },callbackA,callbackB,true);
         for each(_loc2_ in houseJson[activeCell]["xi"])
         {
         }
         retrieveUnsentCell();
      }
      
      public function saveHouseSetup() : void
      {
         var _loc1_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc4_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < CHARS.numChildren)
         {
            _loc3_ = CHARS.getChildAt(_loc1_);
            if(Boolean(_loc3_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc3_).isHouseItem))
            {
               if(!MovieClip(_loc3_).isStable)
               {
                  rootClass.showMessageBox(MovieClip(_loc3_).item.sName + " is not properly placed!");
                  return;
               }
            }
            _loc1_++;
         }
         var _loc2_:Object = new Object();
         _loc2_["xi"] = new Array();
         _loc1_ = 0;
         while(_loc1_ < CHARS.numChildren)
         {
            _loc3_ = CHARS.getChildAt(_loc1_);
            if(Boolean(_loc3_.hasOwnProperty("isHouseItem")) && Boolean(MovieClip(_loc3_).isHouseItem))
            {
               if(MovieClip(_loc3_).isStable)
               {
                  _loc4_ = {
                     "ID":int(MovieClip(_loc3_).ItemID),
                     "x":int(_loc3_.x),
                     "y":int(_loc3_.y)
                  };
                  if(MovieClip(_loc3_).scaleX < 0)
                  {
                     _loc4_["f"] = 1;
                  }
                  _loc2_["xi"].push(_loc4_);
               }
               else
               {
                  rootClass.chatF.pushMsg("warning",MovieClip(_loc3_).item.sName + " was removed for being in an invalid position.","SERVER","",0);
                  unequipHouseItem(MovieClip(_loc3_).ItemID);
                  _loc3_.removeEventListener(MouseEvent.MOUSE_DOWN,onHouseItemClick);
                  CHARS.removeChild(_loc3_);
               }
            }
            _loc1_++;
         }
         objHouseData.arrPlacement[strFrame] = _loc2_;
         rootClass.requestAPI("HouseSaveRoom",{
            "frame":strFrame,
            "layout":_loc2_
         },callbackA,callbackB,true);
         hasModified = false;
      }
      
      public function callbackA(param1:Event) : void
      {
         if(param1.target.data == "success")
         {
            rootClass.addUpdate("House saved successfully.");
            rootClass.chatF.pushMsg("server","House saved successfully.","SERVER","",0);
            if(convertTimer)
            {
               convertTimer.start();
            }
         }
         else
         {
            rootClass.chatF.pushMsg("warning","Error saving your house. (CODE: " + param1.target.data + ")","SERVER","",0);
            convertTimer.removeEventListener(TimerEvent.TIMER,onSendConvert);
            convertTimer.reset();
            convertTimer = null;
            rootClass.mcConnDetail.hideConn();
         }
      }
      
      public function callbackB(param1:IOErrorEvent) : void
      {
         rootClass.chatF.pushMsg("warning","IOError occurred.","SERVER","",0);
      }
      
      public function createItemPlacementString(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:* = "";
         if(param1.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               for(_loc4_ in param1[_loc3_])
               {
                  _loc2_ = _loc2_ + _loc4_ + ":" + param1[_loc3_][_loc4_] + ",";
               }
               _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
               _loc2_ += "|";
               _loc3_++;
            }
            _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
         }
         return _loc2_;
      }
      
      public function createItemPlacementArray(param1:String) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc2_:Array = [];
         if(param1.length > 0)
         {
            _loc3_ = param1.split("|");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = {};
               _loc6_ = _loc3_[_loc4_].split(",");
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc5_[_loc6_[_loc7_].split(":")[0]] = _loc6_[_loc7_].split(":")[1];
                  _loc7_++;
               }
               if(getHouseItem(parseInt(_loc5_["ID"])) != null)
               {
                  _loc2_.push(_loc5_);
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public function sendSaveHouseSetup(param1:*) : void
      {
         rootClass.sfc.sendXtMessage("zm","housesave",[param1],"str",1);
      }
      
      public function frameExists(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         if(!param1)
         {
            return false;
         }
         for each(_loc2_ in rootClass.world.map.currentScene.labels)
         {
            if(_loc2_.name == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function initEquippedItems(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         if(!objHouseData)
         {
            return;
         }
         if(isLegacy())
         {
            _loc2_ = 0;
            while(_loc2_ < myAvatar.houseitems.length)
            {
               if(myAvatar.houseitems[_loc2_].sType != "House")
               {
                  myAvatar.houseitems[_loc2_].bEquip = 0;
                  _loc3_ = 0;
                  while(_loc3_ < param1.length)
                  {
                     if(myAvatar.houseitems[_loc2_].ItemID == param1[_loc3_].ID && frameExists(param1[_loc3_].c))
                     {
                        myAvatar.houseitems[_loc2_].bEquip += 1;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < myAvatar.houseitems.length)
            {
               if(myAvatar.houseitems[_loc2_].sType != "House")
               {
                  myAvatar.houseitems[_loc2_].bEquip = 0;
                  for(_loc4_ in param1)
                  {
                     if(frameExists(_loc4_))
                     {
                        if(param1[_loc4_])
                        {
                           _loc3_ = 0;
                           while(_loc3_ < param1[_loc4_]["xi"].length)
                           {
                              if(myAvatar.houseitems[_loc2_].ItemID == param1[_loc4_]["xi"][_loc3_].ID)
                              {
                                 myAvatar.houseitems[_loc2_].bEquip += 1;
                              }
                              _loc3_++;
                           }
                        }
                     }
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function initHouseInventory(param1:*) : void
      {
         myAvatar.houseitems = param1.items == null ? [] : param1.items;
         initEquippedItems(createItemPlacementArray(param1.sHouseInfo));
         var _loc2_:Array = myAvatar.houseitems;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_].iQty = int(_loc2_[_loc3_].iQty);
            rootClass.world.invTree[_loc2_[_loc3_].ItemID] = _loc2_[_loc3_];
            _loc3_++;
         }
      }
      
      public function unequipHouseItem(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < myAvatar.houseitems.length)
         {
            if(myAvatar.houseitems[_loc2_].ItemID == param1)
            {
               --myAvatar.houseitems[_loc2_].bEquip;
            }
            _loc2_++;
         }
      }
      
      public function loadHouseItem(param1:Object, param2:int, param3:int, param4:int = 0) : void
      {
         var item:Object = param1;
         var x:int = param2;
         var y:int = param3;
         var f:int = param4;
         try
         {
            attachHouseItem({
               "item":item,
               "x":x,
               "y":y,
               "f":f
            });
         }
         catch(err:Error)
         {
            arrHouseItemQueue.push({
               "item":item,
               "typ":"A",
               "x":x,
               "y":y,
               "f":f
            });
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItem();
            }
         }
      }
      
      public function loadNextHouseItem() : void
      {
         ldr_House.load(new URLRequest(rootClass.getFilePath() + arrHouseItemQueue[0].item.sFile),loaderC);
         if(!ldr_House.hasEventListener(Event.COMPLETE))
         {
            ldr_House.contentLoaderInfo.addEventListener(Event.COMPLETE,onHouseItemComplete);
            ldr_House.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onHouseItemError);
         }
      }
      
      public function onHouseItemError(param1:IOErrorEvent) : void
      {
         rootClass.debugMessage(param1.text);
         var _loc2_:* = arrHouseItemQueue[0];
         if(_loc2_.typ == "A")
         {
            arrHouseItemQueue.splice(0,1);
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItem();
            }
         }
         else
         {
            arrHouseItemQueue.splice(0,1);
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItemB();
            }
         }
      }
      
      public function onHouseItemComplete(param1:Event) : void
      {
         var _loc2_:* = arrHouseItemQueue[0];
         if(_loc2_.typ == "A")
         {
            attachHouseItem(_loc2_);
            arrHouseItemQueue.splice(0,1);
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItem();
            }
         }
         else
         {
            rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem(_loc2_);
            arrHouseItemQueue.splice(0,1);
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItemB();
            }
         }
      }
      
      public function loadHouseItemB(param1:Object) : void
      {
         var item:Object = param1;
         try
         {
            rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem({"item":item});
         }
         catch(err:Error)
         {
            rootClass.ui.mcPopup.mcHouseMenu.preview.t2.visible = true;
            rootClass.ui.mcPopup.mcHouseMenu.preview.cnt.visible = false;
            rootClass.ui.mcPopup.mcHouseMenu.preview.bAdd.visible = false;
            arrHouseItemQueue.push({
               "item":item,
               "typ":"B"
            });
            if(arrHouseItemQueue.length > 0)
            {
               loadNextHouseItemB();
            }
         }
      }
      
      public function loadNextHouseItemB() : void
      {
         var _loc1_:Object = arrHouseItemQueue[0].item;
         var _loc2_:* = _loc1_.sFile;
         if(_loc1_.sType == "House")
         {
            _loc2_ = "maps/" + _loc1_.sFile.substr(0,-4) + "_preview.swf";
         }
         ldr_House.load(new URLRequest(rootClass.getFilePath() + _loc2_),loaderC);
         if(!ldr_House.hasEventListener(Event.COMPLETE))
         {
            ldr_House.contentLoaderInfo.addEventListener(Event.COMPLETE,onHouseItemComplete);
            ldr_House.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onHouseItemError);
         }
      }
      
      public function playerInit() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc1_:* = rootClass.sfc.getAllRooms();
         for(_loc2_ in _loc1_)
         {
         }
         _loc3_ = rootClass.sfc.getRoom(curRoom).getUserList();
         _loc5_ = [];
         _loc6_ = 0;
         for(_loc4_ in _loc3_)
         {
            _loc5_.push(_loc3_[_loc4_].getId());
         }
         if(_loc5_.length > 0)
         {
            objectByIDArray(_loc5_);
         }
         myAvatar = avatars[rootClass.sfc.myUserId];
         myAvatar.isMyAvatar = true;
         myAvatar.pMC.disablePNameMouse();
         rootClass.sfcSocial = true;
      }
      
      public function objectByIDArray(param1:Array) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = int(param1[_loc2_]);
            _loc6_ = getUoLeafById(_loc3_);
            if(_loc6_ != null)
            {
               _loc5_ = _loc6_.uoName;
               _loc7_ = String(_loc6_.strFrame);
               if(_loc3_ == rootClass.sfc.myUserId)
               {
                  _loc7_ = strFrame;
               }
               if(avatars[_loc3_] == null)
               {
                  avatars[_loc3_] = new Avatar(rootClass);
                  avatars[_loc3_].uid = _loc3_;
                  avatars[_loc3_].pnm = _loc5_;
               }
               avatars[_loc3_].dataLeaf = _loc6_;
               if(avatars[_loc3_].pMC == null && _loc7_ == strFrame)
               {
                  avatars[_loc3_].pMC = createAvatarMC(_loc3_);
                  _loc8_.push(_loc3_);
               }
               updateUserDisplay(_loc3_);
            }
            _loc2_++;
         }
         if(_loc8_.length > 0)
         {
            getUserDataByIds(_loc8_);
         }
      }
      
      public function objectByID(param1:Number) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:* = getUoLeafById(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.uoName;
            _loc4_ = String(_loc2_.strFrame);
            if(param1 == rootClass.sfc.myUserId)
            {
               _loc4_ = strFrame;
            }
            if(avatars[param1] == null)
            {
               avatars[param1] = new Avatar(rootClass);
               avatars[param1].uid = param1;
               avatars[param1].pnm = _loc3_;
            }
            avatars[param1].dataLeaf = _loc2_;
            if(avatars[param1].pMC == null && _loc4_ == strFrame)
            {
               avatars[param1].pMC = createAvatarMC(param1);
               getUserDataById(param1);
            }
            updateUserDisplay(param1);
         }
      }
      
      public function createAvatarMC(param1:Number) : AvatarMC
      {
         var _loc2_:AvatarMC = new AvatarMC();
         _loc2_.name = "a" + param1;
         _loc2_.x = -600;
         _loc2_.y = 0;
         _loc2_.pAV = avatars[param1];
         _loc2_.world = this;
         return _loc2_;
      }
      
      public function destroyAvatar(param1:Number) : *
      {
         if(avatars[param1] != null)
         {
            if(avatars[param1].pMC != null)
            {
               if(!avatars[param1].isMyAvatar)
               {
                  avatars[param1].pMC.fClose();
                  delete avatars[param1];
               }
            }
         }
      }
      
      public function updateUserDisplay(param1:Number) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = getMCByUserID(param1);
         var _loc3_:* = getUoLeafById(param1);
         var _loc4_:* = String(_loc3_.strFrame);
         if(_loc4_ == strFrame)
         {
            _loc2_.mvts = Number(_loc3_.mvts);
            _loc2_.mvtd = Number(_loc3_.mvtd);
            _loc2_.px = int(_loc3_.px);
            _loc2_.py = int(_loc3_.py);
            _loc2_.tx = int(_loc3_.tx);
            _loc2_.ty = int(_loc3_.ty);
            _loc2_.sp = int(_loc3_.sp);
            _loc5_ = int(_loc3_.intState);
            _loc6_ = null;
            if("strPad" in _loc3_ && _loc3_.strPad.toLowerCase() != "none" && _loc3_.strPad in map)
            {
               _loc6_ = map[_loc3_.strPad];
            }
            if(_loc2_.tx != 0 || _loc2_.ty != 0)
            {
               if(bPvP)
               {
                  _loc2_.mcChar.onMove = true;
               }
               else if(!testTxTy(new Point(_loc2_.tx,_loc2_.ty),_loc2_))
               {
                  _loc7_ = solveTxTy(new Point(_loc2_.tx,_loc2_.ty),_loc2_);
                  if(_loc7_ != null)
                  {
                     _loc2_.x = _loc7_.x;
                     _loc2_.y = _loc7_.y;
                  }
                  else
                  {
                     _loc2_.x = int(960 / 2);
                     _loc2_.y = int(550 / 2);
                  }
               }
               else
               {
                  _loc2_.x = _loc2_.tx;
                  _loc2_.y = _loc2_.ty;
               }
            }
            else
            {
               if(bPvP)
               {
                  _loc2_.destroyWalkFrame();
                  _loc2_.resetSyncVars();
               }
               if(_loc6_ != null)
               {
                  _loc2_.x = int(_loc6_.x + int(Math.random() * 10) - 5);
                  _loc2_.y = int(_loc6_.y + int(Math.random() * 10) - 5);
               }
               else
               {
                  _loc2_.x = int(960 / 2);
                  _loc2_.y = int(550 / 2);
               }
            }
            _loc2_.scale(SCALE);
            if(_loc5_)
            {
               _loc2_.mcChar.gotoAndStop("Idle");
            }
            else
            {
               _loc2_.mcChar.gotoAndStop("Dead");
            }
            if(showHPBar)
            {
               _loc2_.showHPBar();
            }
            else
            {
               _loc2_.hideHPBar();
            }
            if(param1 == rootClass.sfc.myUserId)
            {
               bitWalk = true;
            }
            if(CELL_MODE == "normal" || param1 == rootClass.sfc.myUserId)
            {
               _loc2_.pAV.showMC();
            }
            else
            {
               _loc2_.pAV.hideMC();
            }
            if(bPvP && _loc3_.pvpTeam != null && _loc3_.pvpTeam > -1)
            {
               _loc2_.mcChar.pvpFlag.visible = true;
               _loc2_.mcChar.pvpFlag.gotoAndStop(new Array("a","b","c")[_loc3_.pvpTeam]);
            }
            else
            {
               _loc2_.mcChar.pvpFlag.visible = false;
            }
            if(_loc2_.isLoaded)
            {
               _loc2_.gotoAndPlay("in2");
            }
            else
            {
               _loc2_.gotoAndPlay("hold");
            }
            if(_loc2_.isLoaded)
            {
               _loc2_.pAV.isMyAvatar = param1 == rootClass.sfc.myUserId;
               _loc2_.handleAfterAvatarLoad();
            }
         }
      }
      
      public function repairAvatars() : void
      {
         var _loc1_:Avatar = null;
         rootClass.chatF.pushMsg("server","Attempting to repair incomplete Avatars...","SERVER","",0);
         var _loc2_:Boolean = false;
         for each(_loc1_ in avatars)
         {
            if(!_loc1_.pMC.isLoaded)
            {
               _loc2_ = true;
               if(_loc1_.objData != null)
               {
                  rootClass.chatF.pushMsg("server"," > repairing " + _loc1_.objData.strUsername,"SERVER","",0);
                  _loc1_.initAvatar(_loc1_.objData);
               }
               else if(_loc1_.pnm != null)
               {
                  rootClass.chatF.pushMsg("warning"," *> Data load incomplete for " + _loc1_.pnm + ", repair cannot continue.","SERVER","",0);
               }
               else
               {
                  rootClass.chatF.pushMsg("warning"," *> Avatar instantiated but no data exists at all!","SERVER","",0);
               }
            }
         }
         if(!_loc2_)
         {
            rootClass.chatF.pushMsg("server"," > No incomplete Avatars found!","SERVER","",0);
         }
      }
      
      private function solveTxTy(param1:Point, param2:MovieClip) : Point
      {
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc10_:int = 0;
         var _loc3_:int = 20;
         var _loc4_:int = 960 / _loc3_;
         var _loc5_:int = 550 / _loc3_;
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ <= _loc4_)
         {
            _loc10_ = 0;
            while(_loc10_ <= _loc5_)
            {
               _loc6_ = new Point(_loc9_ * _loc3_,_loc10_ * _loc3_);
               if(testTxTy(_loc6_,param2))
               {
                  _loc8_.push({
                     "x":_loc6_.x,
                     "y":_loc6_.y,
                     "d":Math.abs(Point.distance(param1,_loc6_))
                  });
               }
               _loc10_++;
            }
            _loc9_++;
         }
         if(_loc8_.length)
         {
            _loc8_.sortOn(["d"],[Array.NUMERIC]);
            _loc7_ = new Point(_loc8_[0].x + int(Math.random() * 10) - 5,_loc8_[0].y + int(Math.random() * 10) - 5);
            while(!testTxTy(_loc7_,param2))
            {
               _loc7_ = new Point(_loc8_[0].x + int(Math.random() * 10) - 5,_loc8_[0].y + int(Math.random() * 10) - 5);
            }
            return _loc7_;
         }
         return null;
      }
      
      private function testTxTy(param1:Point, param2:MovieClip) : Boolean
      {
         var _loc3_:int = int(param2.shadow.width);
         var _loc4_:int = int(param2.shadow.height);
         var _loc5_:int = param1.x - _loc3_ / 2;
         var _loc6_:int = param1.y - _loc4_ / 2;
         var _loc7_:Rectangle = new Rectangle(_loc5_,_loc6_,_loc3_,_loc4_);
         var _loc8_:Rectangle = null;
         var _loc9_:MovieClip = null;
         var _loc10_:* = false;
         var _loc11_:int = 0;
         while(_loc11_ < arrSolid.length)
         {
            _loc9_ = MovieClip(arrSolid[_loc11_].shadow);
            _loc8_ = new Rectangle(_loc9_.x,_loc9_.y,_loc9_.width,_loc9_.height);
            _loc10_ = !_loc8_.intersects(_loc7_);
            _loc11_++;
         }
         return _loc10_;
      }
      
      public function updatePortrait(param1:Avatar) : *
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != myAvatar)
         {
            _loc2_ = [rootClass.ui.mcPortraitTarget];
         }
         else if(param1 == myAvatar.target)
         {
            _loc2_ = [rootClass.ui.mcPortraitTarget,rootClass.ui.mcPortrait];
         }
         else
         {
            _loc2_ = [rootClass.ui.mcPortrait];
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = {};
            _loc3_ = _loc2_[_loc4_];
            _loc3_.strName.mouseEnabled = false;
            _loc3_.strClass.mouseEnabled = false;
            if(param1.npcType == "monster")
            {
               _loc7_ = monTree[param1.objData.MonMapID];
               _loc3_.strName.text = param1.objData.strMonName.toUpperCase();
               _loc3_.strClass.text = param1.objData.sRace != "None" ? param1.objData.sRace : "Monster";
               if("stars" in _loc3_)
               {
                  _loc6_ = Math.round(Math.pow(param1.objData.intLevel * 1.3,0.5) / 2);
                  _loc5_ = 1;
                  while(_loc5_ < 6)
                  {
                     if(_loc5_ <= _loc6_)
                     {
                        _loc3_.stars.getChildByName("s" + _loc5_).visible = true;
                     }
                     else
                     {
                        _loc3_.stars.getChildByName("s" + _loc5_).visible = false;
                     }
                     _loc5_++;
                  }
               }
            }
            if(param1.npcType == "player")
            {
               _loc7_ = uoTree[param1.pnm];
               _loc3_.strName.text = param1.objData.strUsername.toUpperCase();
               _loc3_.strClass.text = param1.objData.strClassName + ", Rank " + param1.objData.iRank;
               if("stars" in _loc3_)
               {
                  _loc5_ = 1;
                  while(_loc5_ < 6)
                  {
                     _loc3_.stars.getChildByName("s" + _loc5_).visible = false;
                     _loc5_++;
                  }
               }
            }
            if(param1.npcType == "monster" || param1.npcType == "player")
            {
               _loc3_.strLevel.text = param1.objData.intLevel;
               _loc8_ = 0;
               _loc9_ = 0;
               _loc10_ = null;
               _loc8_ = _loc7_.intHP;
               _loc9_ = _loc7_.intHPMax;
               _loc10_ = _loc3_.HP;
               if(_loc7_.intHP >= 0)
               {
                  _loc10_.strIntHP.text = String(_loc7_.intHP);
               }
               else
               {
                  _loc10_.strIntHP.text = "X";
               }
               if(_loc8_ < 0)
               {
                  _loc8_ = 0;
               }
               if(_loc8_ > _loc9_)
               {
                  _loc8_ = _loc9_;
               }
               _loc10_.intHPbar.x = Math.min(-(_loc10_.intHPbar.width * (1 - _loc8_ / _loc9_)),0);
               _loc8_ = _loc7_.intMP;
               _loc9_ = _loc7_.intMPMax;
               _loc10_ = _loc3_.MP;
               if(_loc7_.intMP >= 0)
               {
                  _loc10_.strIntMP.text = String(_loc7_.intMP);
               }
               else
               {
                  _loc10_.strIntMP.text = "X";
               }
               if(_loc8_ < 0)
               {
                  _loc8_ = 0;
               }
               if(_loc8_ > _loc9_)
               {
                  _loc8_ = _loc9_;
               }
               _loc10_.intMPbar.x = Math.min(-(_loc10_.intMPbar.width * (1 - _loc8_ / _loc9_)),0);
               if(param1.isMyAvatar && Boolean(_loc3_.SP))
               {
                  _loc8_ = _loc7_.intSP;
                  _loc9_ = 100;
                  _loc10_ = _loc3_.SP;
                  if(_loc7_.intSP >= 0)
                  {
                     _loc10_.strIntSP.text = String(_loc7_.intSP);
                  }
                  else
                  {
                     _loc10_.strIntSP.text = "100";
                  }
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 0;
                  }
                  if(_loc8_ > _loc9_)
                  {
                     _loc8_ = _loc9_;
                  }
                  _loc10_.intSPbar.x = Math.min(-(_loc10_.intSPbar.width * (1 - _loc8_ / _loc9_)),0);
               }
            }
            _loc4_++;
         }
      }
      
      public function getAvatarByUserID(param1:int) : Avatar
      {
         var _loc2_:String = String(param1);
         if(_loc2_ in avatars)
         {
            return avatars[_loc2_];
         }
         return null;
      }
      
      public function getAvatarByUserName(param1:String) : Avatar
      {
         var _loc2_:String = null;
         for(_loc2_ in avatars)
         {
            if(avatars[_loc2_] != null && avatars[_loc2_].pnm != null && avatars[_loc2_].pnm.toLowerCase() == param1.toLowerCase())
            {
               return avatars[_loc2_];
            }
         }
         return null;
      }
      
      public function getMCByUserName(param1:*) : AvatarMC
      {
         var _loc2_:String = null;
         for(_loc2_ in avatars)
         {
            if(avatars[_loc2_] != null && avatars[_loc2_].pnm != null && avatars[_loc2_].pnm.toLowerCase() == param1.toLowerCase())
            {
               if(avatars[_loc2_].pMC != null)
               {
                  return avatars[_loc2_].pMC;
               }
            }
         }
         return null;
      }
      
      public function getMCByUserID(param1:*) : AvatarMC
      {
         if(avatars[param1] != undefined && avatars[param1].pMC != null)
         {
            return avatars[param1].pMC;
         }
         return null;
      }
      
      public function getUserByName(param1:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:Array = rootClass.sfc.getAllRooms();
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_];
            for(_loc5_ in _loc4_.getUserList())
            {
               _loc6_ = _loc4_.getUserList()[_loc5_];
               if(String(_loc6_.getName()) == param1)
               {
                  return _loc6_;
               }
            }
         }
         return null;
      }
      
      public function getUserById(param1:Number) : *
      {
         return rootClass.sfc.getRoom(curRoom).getUser(Number(param1));
      }
      
      public function getUoLeafById(param1:*) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in uoTree)
         {
            if(_loc2_.entID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getUoLeafByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         param1 = param1.toLowerCase();
         for each(_loc2_ in uoTree)
         {
            if(_loc2_.uoName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getUserDataById(param1:*) : *
      {
         rootClass.sfc.sendXtMessage("zm","retrieveUserData",[param1],"str",curRoom);
      }
      
      public function getUserDataByIds(param1:Array) : *
      {
         rootClass.sfc.sendXtMessage("zm","retrieveUserDatas",param1,"str",curRoom);
      }
      
      public function getUsersByCell(param1:String) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for(_loc3_ in avatars)
         {
            if(avatars[_loc3_].dataLeaf.strFrame == param1)
            {
               _loc2_.push(avatars[_loc3_]);
            }
         }
         return _loc2_;
      }
      
      public function getAllAvatarsInCell() : Array
      {
         var _loc1_:Array = [];
         _loc1_ = getMonstersByCell(myAvatar.dataLeaf.strFrame);
         return _loc1_.concat(getUsersByCell(myAvatar.dataLeaf.strFrame));
      }
      
      private function lookAtValue(param1:String, param2:int) : Number
      {
         return parseInt(param1.charAt(param2),36);
      }
      
      private function updateValue(param1:*, param2:int, param3:Number) : String
      {
         var _loc4_:String = null;
         if(param3 >= 0 && param3 < 10)
         {
            _loc4_ = String(param3);
         }
         else if(param3 >= 10 && param3 < 36)
         {
            _loc4_ = String.fromCharCode(param3 + 55);
         }
         else
         {
            _loc4_ = "0";
         }
         return rootClass.strSetCharAt(param1,param2,_loc4_);
      }
      
      public function getQuestValue(param1:Number) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(myAvatar != null && myAvatar.objData != null)
         {
            _loc2_ = param1 / 100;
            _loc3_ = _loc2_ > 0 ? "strQuests" + (_loc2_ + 1) : "strQuests";
            if(myAvatar.objData[_loc3_] == null)
            {
               return -1;
            }
            return lookAtValue(myAvatar.objData[_loc3_],param1 - _loc2_ * 100);
         }
         return -1;
      }
      
      public function setQuestValue(param1:Number, param2:Number) : void
      {
         var _loc3_:int = param1 / 100;
         var _loc4_:String = _loc3_ > 0 ? "strQuests" + (_loc3_ + 1) : "strQuests";
         if(_loc4_ in myAvatar.objData)
         {
            myAvatar.objData[_loc4_] = updateValue(myAvatar.objData[_loc4_],param1 - _loc3_ * 100,param2);
         }
      }
      
      public function sendUpdateQuestRequest(param1:Number, param2:Number) : void
      {
         rootClass.sfc.sendXtMessage("zm","updateQuest",[param1,param2],"str",curRoom);
      }
      
      public function setHomeTownCurrent() : void
      {
         rootClass.sfc.sendXtMessage("zm","setHomeTown",[],"str",curRoom);
         myAvatar.objData.strHomeTown = myAvatar.objData.strMapName;
      }
      
      public function setHomeTown(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","setHomeTown",[param1],"str",curRoom);
         myAvatar.objData.strHomeTown = param1;
      }
      
      private function isHouseOrRegularFull() : Boolean
      {
         return rootClass.ui.mcPopup.currentLabel == "Bank" && myAvatar.items.length >= myAvatar.objData.iBagSlots || rootClass.ui.mcPopup.currentLabel == "HouseBank" && myAvatar.houseitems.length >= myAvatar.objData.iHouseSlots;
      }
      
      public function sendBankFromInvRequest(param1:Object) : *
      {
         var _loc2_:ModalMC = null;
         var _loc3_:Object = null;
         if(param1.bEquip)
         {
            _loc2_ = new ModalMC();
            _loc3_ = {};
            _loc3_.strBody = "You must unequip the item before storing it in the bank!";
            _loc3_.params = {};
            _loc3_.glow = "red,medium";
            _loc3_.btns = "mono";
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
         else if(param1.bCoins == 0 && myAvatar.iBankCount >= myAvatar.objData.iBankSlots)
         {
            _loc2_ = new ModalMC();
            _loc3_ = {};
            _loc3_.strBody = "You have exceeded your maximum bank storage for non-AC items!";
            _loc3_.params = {};
            _loc3_.glow = "red,medium";
            _loc3_.btns = "mono";
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","bankFromInv",[param1.ItemID,param1.CharItemID],"str",curRoom);
         }
      }
      
      public function sendBankToInvRequest(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(isHouseOrRegularFull())
         {
            _loc2_ = new ModalMC();
            _loc3_ = {};
            _loc3_.strBody = "You have exceeded your maximum inventory storage!";
            _loc3_.params = {};
            _loc3_.glow = "red,medium";
            _loc3_.btns = "mono";
            rootClass.ui.ModalStack.addChild(_loc2_);
            _loc2_.init(_loc3_);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","bankToInv",[param1.ItemID,param1.CharItemID],"str",curRoom);
         }
      }
      
      public function sendBankSwapInvRequest(param1:Object, param2:Object) : *
      {
         var _loc3_:ModalMC = null;
         var _loc4_:Object = null;
         if(param2.bEquip)
         {
            _loc3_ = new ModalMC();
            _loc4_ = {};
            _loc4_.strBody = "You must unequip the item before storing it in the bank!";
            _loc4_.params = {};
            _loc4_.glow = "red,medium";
            _loc4_.btns = "mono";
            rootClass.ui.ModalStack.addChild(_loc3_);
            _loc3_.init(_loc4_);
         }
         else if(param2.bCoins == 0 && param1.bCoins == 1 && myAvatar.iBankCount >= myAvatar.objData.iBankSlots)
         {
            _loc3_ = new ModalMC();
            _loc4_ = {};
            _loc4_.strBody = "You have exceeded your maximum bank storage for non-AC items!";
            _loc4_.params = {};
            _loc4_.glow = "red,medium";
            _loc4_.btns = "mono";
            rootClass.ui.ModalStack.addChild(_loc3_);
            _loc3_.init(_loc4_);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","bankSwapInv",[param2.ItemID,param2.CharItemID,param1.ItemID,param1.CharItemID],"str",curRoom);
         }
      }
      
      public function getInventory(param1:*) : *
      {
         rootClass.sfc.sendXtMessage("zm","retrieveInventory",[param1],"str",curRoom);
      }
      
      public function sendChangeColorRequest(param1:int, param2:int, param3:int, param4:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","changeColor",[param1,param2,param3,param4,hairshopinfo.HairShopID],"str",curRoom);
      }
      
      public function sendChangeArmorColorRequest(param1:int, param2:int, param3:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","changeArmorColor",[param1,param2,param3],"str",curRoom);
      }
      
      public function sendLoadBankRequest(param1:Array = null) : void
      {
         if(param1[0] == "*")
         {
            param1 = ["All"];
         }
         bankinfo.addRequestedTypes(param1);
         rootClass.sfc.sendXtMessage("zm","loadBank",param1,"str",curRoom);
      }
      
      public function sendReloadShopRequest(param1:int) : void
      {
         if(shopinfo != null && shopinfo.ShopID == param1 && shopinfo.bLimited != null)
         {
            rootClass.sfc.sendXtMessage("zm","reloadShop",[param1],"str",curRoom);
         }
      }
      
      public function sendLoadShopRequest(param1:int) : void
      {
         if(shopinfo == null || (shopinfo.ShopID != param1 || shopinfo.bLimited))
         {
            if(coolDown("loadShop"))
            {
               rootClass.menuClose();
               rootClass.sfc.sendXtMessage("zm","loadShop",[param1],"str",curRoom);
            }
         }
         else
         {
            rootClass.menuClose();
            if(shopinfo.bHouse == 1)
            {
               rootClass.ui.mcPopup.fOpen("HouseShop");
            }
            else if(rootClass.isMergeShop(shopinfo))
            {
               rootClass.ui.mcPopup.fOpen("MergeShop");
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("Shop");
            }
         }
      }
      
      public function sendLoadHairShopRequest(param1:int) : void
      {
         if(hairshopinfo == null || hairshopinfo.HairShopID != param1)
         {
            rootClass.sfc.sendXtMessage("zm","loadHairShop",[param1],"str",curRoom);
         }
         else
         {
            rootClass.openCharacterCustomize();
         }
      }
      
      public function sendLoadEnhShopRequest(param1:int) : void
      {
         var _loc2_:ModalMC = new ModalMC();
         var _loc3_:Object = {};
         _loc3_.strBody = "Old enhancement shops are disabled on the PTR.  Please visit Battleon for the new shops.";
         _loc3_.params = {};
         _loc3_.btns = "mono";
         rootClass.ui.ModalStack.addChild(_loc2_);
         _loc2_.init(_loc3_);
      }
      
      public function sendEnhItemRequest(param1:Object) : void
      {
         enhItem = param1;
         rootClass.sfc.sendXtMessage("zm","enhanceItem",[param1.ItemID,param1.EnhID,enhShopID],"str",curRoom);
      }
      
      public function sendEnhItemRequestShop(param1:Array, param2:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(coolDown("buyItem"))
         {
            enhItem = param1;
            if(myAvatar.objData.intGold < param2.iCost * param1.length)
            {
               rootClass.MsgBox.notify("Insufficient Funds!");
               return;
            }
            _loc3_ = new ModalMC();
            _loc4_ = {};
            _loc4_.params = {
               "item":param1,
               "enh":param2
            };
            _loc4_.strBody = "Are you sure you want to enhance " + param1.length + " item(s) for " + rootClass.strNumWithCommas(param2.iCost * param1.length) + " gold?";
            _loc4_.callback = confirmSendEnhItemRequestShop;
            _loc4_.glow = "white,medium";
            _loc4_.greedy = true;
            rootClass.ui.ModalStack.addChild(_loc3_);
            _loc3_.init(_loc4_);
         }
      }
      
      public function confirmSendEnhItemRequestShop(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","enhanceItemShop",[param1.item,param1.enh.ItemID,shopinfo.ShopID],"str",curRoom);
         }
      }
      
      public function sendEnhItemRequestLocal(param1:Array, param2:Object) : void
      {
         if(coolDown("buyItem"))
         {
            enhItem = param1;
            rootClass.sfc.sendXtMessage("zm","enhanceItemLocal",[param1[0],param2.ItemID],"str",curRoom);
         }
      }
      
      public function sendBuyItemRequest(param1:Object) : void
      {
         if(coolDown("buyItem"))
         {
            if(param1.bStaff == 1 && myAvatar.objData.intAccessLevel < 40)
            {
               rootClass.MsgBox.notify("Test Item: Cannot be purchased yet!");
            }
            else if(shopinfo.sField != "" && getAchievement(shopinfo.sField,shopinfo.iIndex) != 1)
            {
               rootClass.MsgBox.notify("Item Locked: Special requirement not met.");
            }
            else if(param1.bUpg == 1 && !myAvatar.isUpgraded())
            {
               rootClass.showUpgradeWindow();
            }
            else if(param1.FactionID > 1 && myAvatar.getRep(param1.FactionID) < param1.iReqRep)
            {
               rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
            }
            else if(!rootClass.validateArmor(param1))
            {
               rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
            }
            else if(param1.iQSindex >= 0 && getQuestValue(param1.iQSindex) < int(param1.iQSvalue))
            {
               rootClass.MsgBox.notify("Item Locked: Quest Requirement not met.");
            }
            else if((myAvatar.isItemInInventory(param1.ItemID) || myAvatar.isItemInBank(param1.ItemID)) && myAvatar.isItemStackMaxed(param1.ItemID))
            {
               rootClass.MsgBox.notify("You cannot have more than " + param1.iStk + " of that item!");
            }
            else if(param1.bCoins == 0 && param1.iCost > myAvatar.objData.intGold)
            {
               rootClass.MsgBox.notify("Insufficient Funds!");
            }
            else if(param1.bCoins == 1 && param1.iCost > myAvatar.objData.intCoins)
            {
               rootClass.MsgBox.notify("Insufficient Funds!");
            }
            else if(!rootClass.isHouseItem(param1) && myAvatar.items.length >= myAvatar.objData.iBagSlots || rootClass.isHouseItem(param1) && myAvatar.houseitems.length >= myAvatar.objData.iHouseSlots)
            {
               rootClass.MsgBox.notify("Inventory Full!");
            }
            else
            {
               if(shopBuyItem == null || shopBuyItem.ShopItemID != param1.ShopItemID)
               {
                  shopBuyItem = param1;
               }
               rootClass.sfc.sendXtMessage("zm","buyItem",[shopBuyItem.ItemID,shopinfo.ShopID,shopBuyItem.ShopItemID],"str",curRoom);
            }
         }
      }
      
      public function sendBuyItemRequestWithQuantity(param1:Object) : *
      {
         if(param1.accept)
         {
            shopBuyItem = param1.iSel;
            rootClass.sfc.sendXtMessage("zm","buyItem",[param1.iSel.ItemID,shopinfo.ShopID,param1.iSel.ShopItemID,param1.iQty],"str",curRoom);
         }
      }
      
      public function maximumShopBuys(param1:Object) : int
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(param1 == null)
         {
            return 0;
         }
         var _loc2_:* = myAvatar.getItemByID(param1.ItemID);
         if(param1.sES == "ar")
         {
            return 1;
         }
         var _loc3_:Number = _loc2_ != null ? param1.iStk - _loc2_.iQty : Number(param1.iStk);
         if(_loc3_ < 1)
         {
            return 0;
         }
         if(param1.iCost > 0)
         {
            _loc4_ = param1.bCoins == 1 ? Math.floor(myAvatar.objData.intCoins / param1.iCost) : Math.floor(myAvatar.objData.intGold / param1.iCost);
            _loc3_ = Math.min(_loc4_,_loc3_);
         }
         if(param1.turnin != null)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.turnin.length)
            {
               _loc6_ = param1.turnin[_loc5_];
               _loc7_ = myAvatar.getItemByID(_loc6_.ItemID);
               if(_loc7_ == null)
               {
                  return 0;
               }
               _loc8_ = Math.floor(_loc7_.iQty / _loc6_.iQty);
               if(_loc8_ == 0)
               {
                  return 0;
               }
               _loc3_ = Math.min(_loc3_,_loc8_);
               _loc5_++;
            }
            _loc3_ *= param1.iQty;
         }
         _loc3_ = Math.min(_loc3_,100000);
         return Math.min(_loc3_,_loc2_ != null ? param1.iStk - _loc2_.iQty : Number(param1.iStk));
      }
      
      public function sendSellItemRequest(param1:Object) : void
      {
         if(coolDown("sellItem"))
         {
            rootClass.sfc.sendXtMessage("zm","sellItem",[param1.ItemID,param1.iQty,param1.CharItemID],"str",curRoom);
         }
      }
      
      public function sendSellItemRequestWithQuantity(param1:Object) : *
      {
         if(param1.accept)
         {
            if(coolDown("sellItem"))
            {
               rootClass.sfc.sendXtMessage("zm","sellItem",[param1.iSel.ItemID,param1.iQty,param1.iSel.CharItemID],"str",curRoom);
            }
         }
      }
      
      public function maximumShopSells(param1:Object) : int
      {
         if(param1.sES == "ar")
         {
            return 1;
         }
         var _loc2_:* = myAvatar.getItemByID(param1.ItemID);
         return _loc2_ == null ? 0 : int(_loc2_.iQty);
      }
      
      public function sendRemoveItemRequest(param1:Object, param2:int = 1) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 == 1)
         {
            rootClass.sfc.sendXtMessage("zm","removeItem",[param1.ItemID,param1.CharItemID],"str",curRoom);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","removeItem",[param1.ItemID,param1.CharItemID,param2],"str",curRoom);
         }
      }
      
      public function sendRemoveTempItemRequest(param1:int, param2:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","removeTempItem",[param1,param2],"str",curRoom);
         myAvatar.removeTempItem(param1,param2);
      }
      
      public function sendEquipItemRequest(param1:Object) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1 != null && !myAvatar.isItemEquipped(param1.ItemID))
         {
            if(coolDown("equipItem"))
            {
               rootClass.sfc.sendXtMessage("zm","equipItem",[param1.ItemID],"str",curRoom);
            }
            else
            {
               _loc2_ = false;
            }
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function sendForceEquipRequest(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","forceEquipItem",[param1],"str",curRoom);
      }
      
      public function sendUnequipItemRequest(param1:Object) : void
      {
         if(param1 != null && myAvatar.isItemEquipped(param1.ItemID))
         {
            if(coolDown("unequipItem"))
            {
               rootClass.sfc.sendXtMessage("zm","unequipItem",[param1.ItemID],"str",curRoom);
            }
         }
      }
      
      public function sendChangeClassRequest(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","changeClass",[param1],"str",curRoom);
      }
      
      public function selfMute(param1:int = 1) : void
      {
         rootClass.sfc.sendXtMessage("zm","cmd",["mute",param1,myAvatar.objData.strUsername.toLowerCase()],"str",rootClass.world.curRoom);
      }
      
      public function equipUseableItem(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Object = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < actions.active.length)
         {
            if(Boolean(actions.active[_loc3_]) && actions.active[_loc3_].ref == "i1")
            {
               _loc2_ = actions.active[_loc3_];
            }
            _loc3_++;
         }
         _loc2_.sArg1 = String(param1.ItemID);
         _loc2_.sArg2 = String(param1.sDesc);
         rootClass.updateIcons(getActIcons(_loc2_),[param1.sFile],param1);
         rootClass.updateActionObjIcon(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < myAvatar.items.length)
         {
            _loc4_ = myAvatar.items[_loc3_];
            if(_loc4_.sType.toLowerCase() == "item" && _loc4_.sLink.toLowerCase() != "none")
            {
               if(_loc4_.ItemID == param1.ItemID)
               {
                  _loc4_.bEquip = 1;
                  lockdownPots = true;
                  rootClass.sfc.sendXtMessage("zm","geia",[_loc4_.sLink,_loc4_.sMeta,param1.ItemID],"str",rootClass.world.curRoom);
               }
               else
               {
                  _loc4_.bEquip = 0;
               }
            }
            _loc3_++;
         }
         if(rootClass.ui.mcPopup.mcInventory != null)
         {
            rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
            rootClass.ui.mcPopup.mcInventory.refreshDetail();
         }
      }
      
      public function unequipUseableItem(param1:Object = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < actions.active.length)
         {
            if(Boolean(actions.active[_loc4_]) && actions.active[_loc4_].ref == "i1")
            {
               _loc2_ = actions.active[_loc4_];
            }
            _loc4_++;
         }
         _loc2_.sArg1 = "";
         _loc2_.sArg2 = "";
         rootClass.updateIcons(getActIcons(_loc2_),["icu1"],null);
         if(param1 == null)
         {
            _loc4_ = 0;
            while(_loc4_ < myAvatar.items.length)
            {
               _loc3_ = myAvatar.items[_loc4_];
               if(String(_loc3_.ItemID) == _loc2_.sArg1)
               {
                  param1 = _loc3_;
               }
               _loc4_++;
            }
         }
         param1.bEquip = 0;
         if(rootClass.ui.mcPopup.mcInventory != null)
         {
            rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
            rootClass.ui.mcPopup.mcInventory.refreshDetail();
         }
      }
      
      public function tryUseItem(param1:Object) : void
      {
         if(param1.sType.toLowerCase() == "clientuse")
         {
            var _loc2_:* = param1.sLink;
            switch(0)
            {
            }
         }
         else if(param1.sType.toLowerCase() == "serveruse")
         {
            sendUseItemRequest(param1);
         }
      }
      
      public function sendUseItemRequest(param1:Object) : void
      {
         rootClass.sfc.sendXtMessage("zm","serverUseItem",["+",param1.ItemID],"str",-1);
      }
      
      public function sendUseItemArrayRequest(param1:Array) : void
      {
         rootClass.sfc.sendXtMessage("zm","serverUseItem",param1,"str",-1);
      }
      
      public function bankHasRequested(param1:Array) : Boolean
      {
         return bankinfo.hasRequested(param1);
      }
      
      public function addItemsToBank(param1:Array) : void
      {
         bankinfo.addItemsToBank(param1);
      }
      
      public function toggleBank() : void
      {
         if(myAvatar.bank == null)
         {
            rootClass.getBank();
         }
         if(!uiLock)
         {
            if(rootClass.ui.mcPopup.currentLabel == "Bank")
            {
               MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).fClose();
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("Bank");
            }
         }
      }
      
      public function toggleHouseBank() : void
      {
         if(myAvatar.bank == null)
         {
            rootClass.getBank();
         }
         if(!uiLock)
         {
            if(rootClass.ui.mcPopup.currentLabel == "HouseBank")
            {
               MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).fClose();
            }
            else
            {
               rootClass.ui.mcPopup.fOpen("HouseBank");
            }
         }
      }
      
      public function sendReport(param1:Array) : void
      {
         rootClass.sfc.sendXtMessage("zm","cmd",param1,"str",rootClass.world.curRoom);
      }
      
      public function sendWhoRequest() : void
      {
         if(coolDown("who"))
         {
            rootClass.sfc.sendXtMessage("zm","cmd",["who"],"str",curRoom);
         }
      }
      
      public function sendRewardReferralRequest(param1:*) : void
      {
         rootClass.sfc.sendXtMessage("zm","rewardReferral",[],"str",curRoom);
      }
      
      public function sendGetAdDataRequest() : void
      {
         if(rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap)
         {
            rootClass.sfc.sendXtMessage("zm","getAdData",[],"str",curRoom);
         }
      }
      
      public function sendGetAdRewardRequest() : void
      {
         if(rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap)
         {
            rootClass.sfc.sendXtMessage("zm","getAdReward",[],"str",curRoom);
         }
      }
      
      public function sendWarVarsRequest() : void
      {
         rootClass.sfc.sendXtMessage("zm","loadWarVars",[],"str",curRoom);
      }
      
      public function loadQuestStringData() : void
      {
         rootClass.sfc.sendXtMessage("zm","loadQuestStringData",[],"str",curRoom);
      }
      
      public function buyBagSlots(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","buyBagSlots",[param1],"str",curRoom);
      }
      
      public function buyBankSlots(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","buyBankSlots",[param1],"str",curRoom);
      }
      
      public function buyHouseSlots(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","buyHouseSlots",[param1],"str",curRoom);
      }
      
      public function sendLoadFriendsListRequest() : *
      {
         rootClass.sfc.sendXtMessage("zm","loadFriendsList",[],"str",curRoom);
      }
      
      public function sendLoadFactionRequest() : *
      {
         rootClass.sfc.sendXtMessage("zm","loadFactions",[],"str",curRoom);
      }
      
      public function initAchievements() : void
      {
         with(myAvatar.objData)
         {
            ip0 = uint(ip0);
            ia0 = uint(ia0);
            ia1 = uint(ia1);
            id0 = uint(id0);
            id1 = uint(id1);
            id2 = uint(id2);
            im0 = uint(im0);
            iq0 = uint(iq0);
         }
      }
      
      public function getAchievement(param1:String, param2:int) : int
      {
         if(param2 < 0 || param2 > 31)
         {
            return -1;
         }
         var _loc3_:* = myAvatar.objData[param1];
         if(_loc3_ == null)
         {
            return -1;
         }
         return (_loc3_ & Math.pow(2,param2)) == 0 ? 0 : 1;
      }
      
      public function setAchievement(param1:String, param2:int, param3:int = 1) : void
      {
         var _loc4_:* = ["ia0","iq0"];
         if(_loc4_.indexOf(param1) >= 0 && param2 >= 0 && param2 < 32 && getAchievement(param1,param2) != param3)
         {
            rootClass.sfc.sendXtMessage("zm","setAchievement",[param1,param2,param3],"str",curRoom);
         }
      }
      
      public function updateAchievement(param1:String, param2:int, param3:int) : void
      {
         if(param3 == 0)
         {
            myAvatar.objData[param1] &= ~Math.pow(2,param2);
         }
         else if(param3 == 1)
         {
            myAvatar.objData[param1] |= Math.pow(2,param2);
         }
         rootClass.readIA1Preferences();
      }
      
      public function showFriendsList() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(myAvatar.friends != null && myAvatar.friendsLoaded && (new Date().getTime() - myAvatar.friendsLoaded) / 1000 < 30)
         {
            _loc1_ = {};
            _loc1_.typ = "userListFriends";
            for each(_loc2_ in myAvatar.friends)
            {
               _loc2_.bOffline = _loc2_.sServer == rootClass.objServerInfo.sName ? 0 : (_loc2_.sServer == "Offline" ? 2 : 1);
            }
            myAvatar.friends.sortOn("sName",Array.CASEINSENSITIVE);
            myAvatar.friends.sortOn(["bOffline","sServer","sName"],[Array.NUMERIC,Array.CASEINSENSITIVE,Array.CASEINSENSITIVE]);
            _loc1_.ul = myAvatar.friends;
            rootClass.ui.mcOFrame.fOpenWith(_loc1_);
         }
         else
         {
            myAvatar.friendsLoaded = new Date().getTime();
            rootClass.sfc.sendXtMessage("zm","getfriendlist",[],"str",-1);
         }
      }
      
      public function showGuildList() : void
      {
         if(myAvatar.objData.guild != null)
         {
            rootClass.ui.mcPopup.fOpen("GuildPanelNew");
         }
         else
         {
            rootClass.MsgBox.notify("You need to create or join a guild first.");
         }
      }
      
      public function showIgnoreList() : void
      {
         var _loc1_:Object = null;
         if(rootClass.chatF.ignoreList.data.users != null && rootClass.chatF.ignoreList.data.users.length > 0)
         {
            _loc1_ = {};
            _loc1_.typ = "userListIgnore";
            rootClass.ui.mcOFrame.fOpenWith(_loc1_);
         }
         else
         {
            rootClass.chatF.pushMsg("warning","Your ignore list is empty.","SERVER","",0);
         }
      }
      
      public function isModerator(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","isModerator",[param1],"str",-1);
      }
      
      public function toggleName(param1:*, param2:String) : *
      {
         if(param2 == "on")
         {
            getMCByUserID(param1).pname.visible = true;
         }
         if(param2 == "off")
         {
            getMCByUserID(param1).pname.visible = false;
         }
      }
      
      public function toggleHPBar() : void
      {
         var _loc1_:String = null;
         var _loc2_:MovieClip = null;
         var _loc3_:Avatar = null;
         showHPBar = !showHPBar;
         for(_loc1_ in avatars)
         {
            _loc3_ = avatars[_loc1_];
            if(_loc3_.pMC != null)
            {
               _loc2_ = _loc3_.pMC;
               if(showHPBar)
               {
                  _loc2_.showHPBar();
               }
               else
               {
                  _loc2_.hideHPBar();
               }
            }
         }
      }
      
      public function resPlayer() : *
      {
         afkPostpone();
         rootClass.sfc.sendXtMessage("zm","resPlayerTimed",[rootClass.sfc.myUserId],"str",curRoom);
      }
      
      public function showResCounter() : *
      {
         var _loc1_:* = MovieClip(rootClass.ui.mcRes);
         if(_loc1_.currentLabel == "in")
         {
            return;
         }
         _loc1_.gotoAndPlay("in");
         _loc1_.resC = 10;
         if(_loc1_.resTimer == null)
         {
            _loc1_.resTimer = new Timer(1000);
            _loc1_.resTimer.addEventListener("timer",resTimer);
         }
         else
         {
            _loc1_.resTimer.reset();
         }
         _loc1_.resTimer.start();
      }
      
      public function resTimer(param1:TimerEvent) : *
      {
         var _loc2_:* = MovieClip(rootClass.ui.mcRes);
         --_loc2_.resC;
         if(_loc2_.resC > 0)
         {
            _loc2_.mcTomb.ti.text = "0" + _loc2_.resC;
         }
         else
         {
            _loc2_.mcTomb.ti.text = "00";
            param1.target.reset();
            _loc2_.visible = false;
            _loc2_.gotoAndStop(1);
            resPlayer();
         }
      }
      
      public function danceRequest(param1:*) : *
      {
         var _loc2_:* = undefined;
         if(param1.accept)
         {
            rootClass.chatF.submitMsg(param1.emote1,"emote",rootClass.sfc.myUserName);
         }
         else
         {
            _loc2_ = {};
            _loc2_.typ = "danceDenied";
            _loc2_.cell = strFrame;
            rootClass.sfc.sendObjectToGroup(_loc2_,[param1.sender.getId()],curRoom);
         }
      }
      
      public function rest() : void
      {
         if(myAvatar.dataLeaf.intState != 1)
         {
            return;
         }
         if(!restTimer.running)
         {
            rootClass.sfc.sendXtMessage("zm","restRequest",[""],"str",1);
            myAvatar.pMC.mcChar.gotoAndPlay("Rest");
            rootClass.sfc.sendXtMessage("zm","emotea",["rest"],"str",1);
            restStart();
         }
      }
      
      public function restStart() : *
      {
         afkPostpone();
         restTimer.reset();
         restTimer.start();
      }
      
      public function restRequest(param1:TimerEvent) : *
      {
         var _loc2_:* = getUoLeafById(myAvatar.uid);
         if((_loc2_.intHP != _loc2_.intHPMax || _loc2_.intMP != _loc2_.intMPMax || _loc2_.intSP != 100) && myAvatar.pMC.mcChar.currentLabel == "Rest" && _loc2_.intState == 1)
         {
            if(coolDown("rest"))
            {
               restTimer.reset();
            }
            else
            {
               restStart();
            }
         }
         else
         {
            restTimer.reset();
         }
      }
      
      public function afkToggle() : void
      {
         var _loc1_:* = uoTree[rootClass.sfc.myUserName];
         if(_loc1_ != null)
         {
            rootClass.sfc.sendXtMessage("zm","afk",[!_loc1_.afk],"str",1);
         }
      }
      
      public function afkTimerHandler(param1:Event) : void
      {
         var _loc2_:* = uoTree[rootClass.sfc.myUserName];
         if(_loc2_ != null)
         {
            rootClass.sfc.sendXtMessage("zm","afk",[true],"str",1);
         }
      }
      
      public function afkPostpone() : void
      {
         var _loc1_:* = new Date().getTime();
         var _loc2_:* = uoTree[rootClass.sfc.myUserName];
         if(_loc2_ != null && _loc2_.afk && (_loc2_.afkts == null || _loc1_ > _loc2_.afkts + 500))
         {
            rootClass.sfc.sendXtMessage("zm","afk",[false],"str",1);
            _loc2_.afkts = _loc1_;
         }
      }
      
      public function hideAllPets(param1:Boolean = true) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in avatars)
         {
            if(!(!param1 && avatars[_loc2_] == myAvatar))
            {
               if(avatars[_loc2_] != null)
               {
                  avatars[_loc2_].unloadPet();
               }
            }
         }
      }
      
      public function showAllPets(param1:Boolean = true) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         for(_loc2_ in avatars)
         {
            if(!(!param1 && avatars[_loc2_] == myAvatar))
            {
               _loc3_ = getUoLeafById(_loc2_);
               _loc4_ = String(_loc3_.strFrame);
               if(_loc4_ == strFrame)
               {
                  avatars[_loc2_].loadPet();
               }
            }
         }
      }
      
      public function updateMonsters() : *
      {
         var _loc1_:int = 0;
         if(monmap != null)
         {
            _loc1_ = 0;
            while(_loc1_ < monmap.length)
            {
               if(monmap[_loc1_].strFrame == strFrame)
               {
                  updateMonster(monmap[_loc1_]);
               }
               _loc1_++;
            }
         }
      }
      
      public function updateMonster(param1:Object) : void
      {
         var _loc2_:* = getMonsterDefinition(param1.MonID);
         var _loc3_:* = getMonster(param1.MonMapID);
         if(_loc3_.pMC == null)
         {
            return;
         }
         _loc3_.objData.intMPMax = int(_loc3_.objData.intMPMax);
         _loc3_.objData.intHPMax = int(_loc3_.objData.intMPMax);
         var _loc4_:* = monTree[param1.MonMapID];
         if(_loc4_.MonID != _loc3_.objData.MonID || _loc4_.intState == 0)
         {
            _loc3_.pMC.visible = false;
         }
         if(_loc3_.pMC.x < myAvatar.pMC.x && _loc4_.intState == 1)
         {
            _loc3_.pMC.turn("right");
         }
         else if(_loc4_.intState == 1)
         {
            _loc3_.pMC.turn("left");
         }
         _loc3_.pMC.updateNamePlate();
      }
      
      public function createMonsterMC(param1:MovieClip, param2:int, param3:Boolean = false) : MonsterMC
      {
         var _loc5_:MonsterMC = null;
         var _loc6_:int = 0;
         var _loc7_:Class = null;
         var _loc4_:* = getMonsterDefinition(param2);
         if(param3)
         {
            _loc6_ = Math.round(Math.random() * (chaosNames.length - 1));
            if(chaosNames[_loc6_] != rootClass.world.myAvatar.objData.strUsername)
            {
               _loc5_ = new MonsterMC(chaosNames[_loc6_]);
            }
            else
            {
               _loc6_ = _loc6_ == 0 ? ++_loc6_ : --_loc6_;
               _loc5_ = new MonsterMC(chaosNames[_loc6_]);
            }
         }
         else if(Number(objExtra["bChar"]) == 1)
         {
            _loc5_ = new MonsterMC(myAvatar.objData.strUsername);
         }
         else
         {
            _loc5_ = new MonsterMC(_loc4_.strMonName);
         }
         CHARS.addChild(_loc5_);
         _loc5_.x = param1.x;
         _loc5_.y = param1.y;
         _loc5_.ox = _loc5_.x;
         _loc5_.oy = _loc5_.y;
         if(Number(objExtra["bChar"]) == 1)
         {
            _loc5_.removeChildAt(1);
            _loc5_.addChildAt(new dummyMC() as MovieClip,1);
            copyAvatarMC(_loc5_.getChildAt(1) as MovieClip);
         }
         else
         {
            _loc7_ = loaderD.getDefinition(_loc4_.strLinkage) as Class;
            _loc5_.removeChildAt(1);
            _loc5_.addChildAt(new _loc7_(),1);
         }
         _loc5_.mouseEnabled = false;
         _loc5_.bubble.mouseEnabled = _loc5_.bubble.mouseChildren = false;
         _loc5_.init();
         if("strDir" in param1)
         {
            if(param1.strDir.toLowerCase() == "static")
            {
               _loc5_.isStatic = true;
            }
         }
         if("noMove" in param1)
         {
            _loc5_.noMove = param1.noMove;
         }
         if(rootClass.litePreference.data.bFreezeMons)
         {
            _loc5_.noMove = true;
         }
         if(rootClass.litePreference.data.bMonsType)
         {
            _loc5_.pname.typ.text = "< " + _loc4_.sRace + " >";
            _loc5_.pname.typ.visible = _loc4_.sRace != "None";
         }
         else
         {
            _loc5_.pname.typ.visible = false;
         }
         return _loc5_;
      }
      
      public function getMonDataById() : *
      {
      }
      
      public function retrieveMonData() : *
      {
         rootClass.sfc.sendXtMessage("zm","retrieveMonData",[],"str",1);
      }
      
      private function getMonID(param1:int) : int
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         for(_loc2_ in monTree)
         {
            _loc3_ = monTree[_loc2_];
            if(_loc3_.MonMapID == param1)
            {
               return _loc3_.MonID;
            }
         }
         return -1;
      }
      
      private function getMonsterDefinition(param1:int) : Object
      {
         var _loc2_:int = 0;
         while(_loc2_ < mondef.length)
         {
            if(mondef[_loc2_].MonID == param1)
            {
               return mondef[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getMonster(param1:int) : Avatar
      {
         var _loc2_:int = 0;
         while(_loc2_ < monsters.length)
         {
            if(monsters[_loc2_].objData.MonMapID == param1 && monsters[_loc2_].objData.MonID == monTree[param1].MonID)
            {
               return monsters[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getMonsters(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < monsters.length)
         {
            if(monsters[_loc3_].objData.MonMapID == param1)
            {
               _loc2_.push(monsters[_loc3_]);
            }
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function getMonsterCluster(param1:int) : Array
      {
         var _loc2_:* = [];
         var _loc3_:int = 0;
         while(_loc3_ < monsters.length)
         {
            if(monsters[_loc3_].objData.MonMapID == param1)
            {
               _loc2_.push(monsters[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getMonstersByCell(param1:String) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < monsters.length)
         {
            if(monsters[_loc3_].dataLeaf != null && monsters[_loc3_].dataLeaf.strFrame == param1)
            {
               _loc2_.push(monsters[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function initMonsters(param1:Array, param2:Array) : *
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc3_:int = 0;
         if(param1 != null && param2 != null)
         {
            monswf = new Array();
            monsters = new Array();
            _loc4_ = null;
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               _loc5_ = 0;
               while(_loc5_ < param1.length)
               {
                  if(param2[_loc3_].MonID == param1[_loc5_].MonID)
                  {
                     _loc4_ = param1[_loc5_];
                  }
                  _loc5_++;
               }
               monsters.push(new Avatar(rootClass));
               _loc6_ = monsters[monsters.length - 1];
               _loc6_.npcType = "monster";
               if(_loc6_.objData == null)
               {
                  _loc6_.objData = {};
               }
               for(_loc7_ in _loc4_)
               {
                  _loc6_.objData[_loc7_] = _loc4_[_loc7_];
               }
               for(_loc7_ in param2[_loc3_])
               {
                  _loc6_.objData[_loc7_] = param2[_loc3_][_loc7_];
               }
               _loc8_ = monTree[String(_loc6_.objData.MonMapID)];
               _loc8_.strFrame = String(_loc6_.objData.strFrame);
               if(_loc8_.MonID == _loc6_.objData.MonID)
               {
                  _loc6_.dataLeaf = monTree[_loc6_.objData.MonMapID];
               }
               else
               {
                  _loc6_.dataLeaf = null;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               queueLoad({
                  "strFile":rootClass.getFilePath() + "mon/" + param1[_loc3_].strMonFileName,
                  "callBackA":onMonLoadComplete
               });
               _loc3_++;
            }
         }
      }
      
      private function onMonLoadComplete(param1:Event) : *
      {
         monswf.push(MovieClip(Loader(param1.target.loader).content));
         if(monswf.length == mondef.length)
         {
            enterMap();
         }
      }
      
      public function toggleMonsters() : *
      {
         var _loc1_:DisplayObject = null;
         rootClass.ui.monsterIcon.redX.visible = showMonsters;
         showMonsters = !showMonsters;
         var _loc2_:int = 0;
         while(_loc2_ < CHARS.numChildren)
         {
            _loc1_ = CHARS.getChildAt(_loc2_);
            if(Boolean(_loc1_.hasOwnProperty("isMonster")) && Boolean(MovieClip(_loc1_).isMonster))
            {
               MovieClip(_loc1_).setVisible();
            }
            _loc2_++;
         }
      }
      
      public function setTarget(param1:*) : *
      {
         if(strMapName == "caroling" && CarolingMonsterKillCount >= 5)
         {
            if(param1 != null && param1.npcType != "player")
            {
               return;
            }
         }
         if(myAvatar != null && param1 != null && param1.npcType == "player" && Boolean(param1.isMyAvatar))
         {
            if(rootClass.litePreference.data.bUntargetSelf)
            {
               return;
            }
         }
         if(myAvatar != null && myAvatar.target != param1)
         {
            if(myAvatar.target != null)
            {
               if(myAvatar.target.npcType == "monster")
               {
                  if(bPvP && myAvatar.target.dataLeaf.react != null && myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)
                  {
                     myAvatar.target.pMC.modulateColor(avtPCT,"-");
                  }
                  else
                  {
                     myAvatar.target.pMC.modulateColor(avtMCT,"-");
                  }
               }
               if(myAvatar.target.npcType == "player")
               {
                  if(bPvP && myAvatar.target.dataLeaf.pvpTeam != myAvatar.dataLeaf.pvpTeam)
                  {
                     myAvatar.target.pMC.modulateColor(avtMCT,"-");
                  }
                  else
                  {
                     myAvatar.target.pMC.modulateColor(avtPCT,"-");
                  }
               }
            }
            if(param1 != null)
            {
               if(!bPvP && param1.npcType == "player")
               {
                  if(autoActionTimer != null)
                  {
                     cancelAutoAttack();
                  }
               }
               myAvatar.target = param1;
               if(myAvatar.target.npcType == "monster")
               {
                  if(bPvP && myAvatar.target.dataLeaf.react != null && myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)
                  {
                     myAvatar.target.pMC.modulateColor(avtPCT,"+");
                  }
                  else
                  {
                     myAvatar.target.pMC.modulateColor(avtMCT,"+");
                  }
               }
               if(myAvatar.target.npcType == "player")
               {
                  if(bPvP && myAvatar.target.dataLeaf.pvpTeam != myAvatar.dataLeaf.pvpTeam)
                  {
                     myAvatar.target.pMC.modulateColor(avtMCT,"+");
                  }
                  else
                  {
                     myAvatar.target.pMC.modulateColor(avtPCT,"+");
                  }
               }
               rootClass.showPortraitTarget(param1);
            }
            else
            {
               rootClass.hidePortraitTarget();
               if(myAvatar.dataLeaf.intState > 0)
               {
                  exitCombat();
               }
               myAvatar.target = null;
            }
         }
      }
      
      public function cancelTarget() : void
      {
         if(autoActionTimer != null && autoActionTimer.running)
         {
            cancelAutoAttack();
            myAvatar.pMC.mcChar.gotoAndStop("Idle");
            return;
         }
         if(myAvatar.target != null)
         {
            setTarget(null);
            return;
         }
      }
      
      public function approachTarget() : *
      {
         var _loc3_:Object = null;
         var _loc5_:* = false;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Array = null;
         var _loc23_:Array = null;
         var _loc1_:Boolean = true;
         var _loc2_:Object = uoTree[rootClass.sfc.myUserName];
         var _loc4_:Object = getAutoAttack();
         if(myAvatar.target != null)
         {
            if(myAvatar.target.npcType == "monster")
            {
               _loc3_ = monTree[myAvatar.target.objData.MonMapID];
            }
            else if(myAvatar.target.npcType == "player")
            {
               _loc3_ = myAvatar.target.dataLeaf;
            }
            if(_loc3_ == null || _loc2_.intState == 0 || _loc3_.intState == 0)
            {
               _loc1_ = false;
            }
            if(bPvP && (_loc3_.react != null && _loc3_.react[_loc2_.pvpTeam] == 1 || _loc2_.pvpTeam == _loc3_.pvpTeam) || !bPvP && myAvatar.target.npcType == "player")
            {
               _loc1_ = false;
            }
            if(_loc1_)
            {
               if(_loc4_ != null)
               {
                  if(actionRangeCheck(_loc4_))
                  {
                     testAction(_loc4_);
                  }
                  else
                  {
                     actionReady = true;
                     _loc5_ = false;
                     _loc6_ = myAvatar.pMC.mcChar.localToGlobal(new Point(0,0));
                     _loc7_ = myAvatar.target.pMC.mcChar.localToGlobal(new Point(0,0));
                     if(_loc4_.range > 301)
                     {
                        _loc8_ = Point.distance(_loc6_,_loc7_);
                        _loc9_ = _loc4_.range * SCALE;
                        _loc9_ = _loc9_ * 0.9;
                        if(_loc9_ < _loc8_)
                        {
                           _loc7_ = Point.interpolate(_loc6_,_loc7_,_loc9_ / _loc8_);
                        }
                        _loc5_ = !padHit(_loc7_.x,_loc7_.y,myAvatar.pMC.shadow.getBounds(rootClass.stage));
                     }
                     else
                     {
                        _loc10_ = 0;
                        while(_loc10_ < 100 && !_loc5_)
                        {
                           _loc11_ = int(50 + Math.random() * 110);
                           if(_loc10_ > 50)
                           {
                              _loc11_ *= -1;
                           }
                           _loc12_ = _loc7_.x - _loc6_.x >= 0 ? int(-_loc11_) : _loc11_;
                           _loc13_ = Math.random() * 40 - 20;
                           _loc12_ = Math.ceil(_loc12_ * SCALE);
                           _loc13_ = Math.floor(_loc13_ * SCALE);
                           _loc14_ = _loc7_.x + _loc12_;
                           _loc15_ = _loc7_.y + _loc13_;
                           _loc5_ = !padHit(_loc14_,_loc15_,myAvatar.pMC.shadow.getBounds(rootClass.stage));
                           _loc10_++;
                        }
                        _loc7_.x += _loc12_;
                        _loc7_.y += _loc13_;
                     }
                     if(_loc5_)
                     {
                        _loc16_ = myAvatar.objData.strClassName.toLowerCase();
                        if(_loc16_.indexOf("archmage") == 0 || _loc16_.indexOf("deathknight") == 0)
                        {
                           rootClass.mixer.playSound("ClickBig");
                        }
                        if(bPvP)
                        {
                           myAvatar.pMC.walkTo(_loc7_.x,_loc7_.y,WALKSPEED);
                           pushMove(myAvatar.pMC,_loc7_.x,_loc7_.y,WALKSPEED);
                        }
                        else
                        {
                           myAvatar.pMC.walkTo(_loc7_.x,_loc7_.y,WALKSPEED * 2);
                           pushMove(myAvatar.pMC,_loc7_.x,_loc7_.y,WALKSPEED * 2);
                        }
                     }
                     else
                     {
                        rootClass.chatF.pushMsg("server","No path found!","SERVER","",0);
                     }
                  }
               }
            }
         }
         else
         {
            _loc17_ = myAvatar;
            _loc18_ = null;
            _loc19_ = null;
            _loc20_ = "tgtMin" in _loc4_ ? int(_loc4_.tgtMin) : 1;
            _loc21_ = "tgtMax" in _loc4_ ? int(_loc4_.tgtMax) : 1;
            _loc22_ = [];
            _loc23_ = getAllAvatarsInCell();
            for each(_loc18_ in _loc23_)
            {
               _loc3_ = _loc18_.dataLeaf;
               if(_loc3_ != null && (!bPvP && _loc18_.npcType == "monster" || bPvP && _loc18_.npcType == "player" && _loc2_.pvpTeam != _loc3_.pvpTeam || bPvP && _loc18_.npcType == "monster" && _loc3_.react != null && _loc3_.react[_loc2_.pvpTeam] == 0) && actionRangeCheck(_loc4_,_loc18_))
               {
                  setTarget(_loc18_);
                  testAction(_loc4_);
                  return;
               }
            }
            rootClass.chatF.pushMsg("warning","No target selected!","SERVER","",0);
         }
      }
      
      public function padHit(param1:int, param2:int, param3:Rectangle) : Boolean
      {
         var _loc5_:Rectangle = null;
         var _loc6_:MovieClip = null;
         var _loc4_:int = 0;
         if(param1 < 0 || param1 > 960 || param2 < 10 || param2 > 530)
         {
            return false;
         }
         param3.x = int(param1 - param3.width / 2);
         param3.y = int(param2 - param3.height / 2);
         _loc4_ = 0;
         while(_loc4_ < arrEvent.length)
         {
            _loc6_ = arrEvent[_loc4_];
            if("strSpawnCell" in _loc6_ || "tCell" in _loc6_)
            {
               _loc5_ = arrEventR[_loc4_];
               if(param3.intersects(_loc5_))
               {
                  return true;
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      public function drawRects(param1:Array) : void
      {
         var _loc5_:Rectangle = null;
         var _loc2_:Array = [16711680,65280,255];
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Graphics = _loc3_.graphics;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_ = param1[_loc6_];
            _loc4_.moveTo(_loc5_.x,_loc5_.y);
            _loc4_.beginFill(_loc2_[_loc6_],0.3);
            _loc4_.lineTo(_loc5_.x + _loc5_.width,_loc5_.y);
            _loc4_.lineTo(_loc5_.x + _loc5_.width,_loc5_.y + _loc5_.height);
            _loc4_.lineTo(_loc5_.x,_loc5_.y + _loc5_.height);
            _loc4_.lineTo(_loc5_.x,_loc5_.y);
            _loc4_.endFill();
            _loc6_++;
         }
      }
      
      public function testAction(param1:Object, param2:Boolean = false) : *
      {
         var a:int = 0;
         var b:int = 0;
         var c:int = 0;
         var cLeaf:Object = null;
         var tLeaf:Object = null;
         var cAvt:* = undefined;
         var tAvt:* = undefined;
         var pAvt:* = undefined;
         var tgtMin:int = 0;
         var tgtMax:int = 0;
         var targets:Array = null;
         var scan:Array = null;
         var errMsg:String = null;
         var forceAAloop:Boolean = false;
         var aura:Object = null;
         var pet:* = undefined;
         var tgtOK:Boolean = false;
         var sAvt:Avatar = null;
         var to:Object = null;
         var now:Number = NaN;
         var actionObj:Object = param1;
         var forceAARangeError:Boolean = param2;
         if(strMapName == "caroling" && CarolingMonsterKillCount >= 5)
         {
            return;
         }
         a = 0;
         b = 0;
         c = 0;
         cLeaf = uoTreeLeaf(rootClass.sfc.myUserName);
         cAvt = myAvatar;
         tAvt = null;
         pAvt = null;
         tgtMin = "tgtMin" in actionObj ? int(actionObj.tgtMin) : 1;
         tgtMax = "tgtMax" in actionObj ? int(actionObj.tgtMax) : 1;
         targets = [];
         scan = getAllAvatarsInCell();
         a = 0;
         while(a < scan.length)
         {
            tAvt = scan[a];
            if(tAvt.dataLeaf == null || tAvt.dataLeaf.intState == 0 || (tAvt.pMC == null || tAvt.pMC.x == null))
            {
               scan.splice(a,1);
               a--;
               if(tAvt == myAvatar.target)
               {
                  setTarget(null);
               }
            }
            a++;
         }
         a = 0;
         tAvt = null;
         if(myAvatar.target != null && scan.indexOf(myAvatar.target) > -1)
         {
            scan.unshift(scan.splice(scan.indexOf(myAvatar.target),1)[0]);
         }
         afkPostpone();
         errMsg = "none";
         forceAAloop = false;
         if(actionObj.ref == "i1" && lockdownPots)
         {
            errMsg = "The potion is not quite ready yet.";
         }
         if(!actionTimeCheck(actionObj))
         {
            errMsg = "Ability \'" + actionObj.nam + "\' is not ready yet.";
         }
         if(errMsg == "none" && actionObj.mp != null && Math.round(actionObj.mp * cLeaf.sta["$cmc"]) > cLeaf.intMP)
         {
            errMsg = "Not enough mana!";
         }
         if(errMsg == "none" && actionObj.sp != null)
         {
            if(!checkSP(actionObj.sp,cLeaf))
            {
               errMsg = "Not Enough Spirit Power!";
            }
         }
         if(errMsg == "none" && actionObj.ref == "i1" && actionObj.sArg1 == "")
         {
            errMsg = "No item assigned to that slot!";
         }
         if(errMsg == "none" && myAvatar.target != null && "filter" in actionObj && "sRace" in myAvatar.target.objData && myAvatar.target.objData.sRace.toLowerCase() != actionObj.filter.toLowerCase())
         {
            errMsg = "Target is not a " + actionObj.filter + "!";
         }
         if(errMsg == "none")
         {
            for each(aura in cLeaf.auras)
            {
               try
               {
                  if(aura.cat != null)
                  {
                     if(aura.cat == "stun")
                     {
                        errMsg = "Cannot act while stunned!";
                     }
                     if(aura.cat == "stone")
                     {
                        errMsg = "Cannot act while petrified!";
                     }
                     if(aura.cat == "disabled")
                     {
                        errMsg = "Cannot act while disabled!";
                     }
                     if(errMsg != "none")
                     {
                        forceAAloop = true;
                     }
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
         if(errMsg == "none")
         {
            if(actionObj.pet != null)
            {
               pet = cAvt.getItemByEquipSlot("pe");
               if(cAvt.getItemByEquipSlot("pe") == null)
               {
                  if(cAvt.checkTempItem(actionObj.pet,1))
                  {
                     summonPet(actionObj.pet,true);
                  }
                  else
                  {
                     summonPet(actionObj.pet,false);
                  }
               }
            }
            else if(actionObj.checkPet != null)
            {
               if(cAvt.getItemByEquipSlot("pe").sMeta.indexOf(actionObj.checkPet) == -1)
               {
                  errMsg = "No battle pet equipped.";
               }
            }
         }
         if(errMsg == "none" || forceAAloop)
         {
            if(myAvatar.target != null)
            {
               tAvt = myAvatar.target;
               if(myAvatar.target.npcType == "monster")
               {
                  tLeaf = monTree[tAvt.objData.MonMapID];
               }
               else if(tAvt.npcType == "player")
               {
                  tLeaf = tAvt.dataLeaf;
               }
            }
            switch(actionObj.tgt)
            {
               case "h":
                  if(tAvt == null)
                  {
                     if(tgtMin > 0)
                     {
                        for each(tAvt in scan)
                        {
                           tLeaf = tAvt.dataLeaf;
                           if(tLeaf != null && (!bPvP && tAvt.npcType == "monster" || bPvP && tAvt.npcType == "player" && cLeaf.pvpTeam != tLeaf.pvpTeam || bPvP && tAvt.npcType == "monster" && tLeaf.react != null && tLeaf.react[cLeaf.pvpTeam] == 0) && actionRangeCheck(actionObj,tAvt))
                           {
                              setTarget(tAvt);
                              testAction(actionObj);
                              return;
                           }
                        }
                        errMsg = "No target selected!";
                        if(actionObj.typ == "aa")
                        {
                           cancelAutoAttack();
                        }
                     }
                  }
                  else
                  {
                     if(!bPvP && tAvt.npcType == "player" || bPvP && tAvt.npcType == "player" && cLeaf.pvpTeam == tLeaf.pvpTeam || bPvP && tAvt.npcType == "monster" && tLeaf.react != null && tLeaf.react[cLeaf.pvpTeam] == 1)
                     {
                        errMsg = "Can\'t attack that target!";
                        if(actionObj.typ == "aa")
                        {
                           cancelAutoAttack();
                        }
                     }
                     if(tgtMin > 0 && tAvt.dataLeaf.intState == 0)
                     {
                        errMsg = "Your target is dead!";
                     }
                  }
                  break;
               case "f":
                  if(tAvt == null)
                  {
                     setTarget(myAvatar);
                     tAvt = myAvatar;
                     tLeaf = tAvt.dataLeaf;
                  }
                  if(!bPvP && tAvt.npcType == "monster" || bPvP && cLeaf.pvpTeam != tLeaf.pvpTeam || bPvP && tAvt.npcType == "monster" && tLeaf.react != null && tLeaf.react[cLeaf.pvpTeam] == 1)
                  {
                     tAvt = myAvatar;
                  }
                  tLeaf = tAvt.dataLeaf;
                  break;
               case "s":
                  if(tAvt == null)
                  {
                     setTarget(myAvatar);
                     tAvt = myAvatar;
                  }
                  if(tAvt != null && tAvt != myAvatar)
                  {
                     tAvt = myAvatar;
                  }
                  tLeaf = tAvt.dataLeaf;
            }
            pAvt = tAvt;
            if(errMsg == "none" && !actionRangeCheck(actionObj,pAvt) || forceAAloop)
            {
               if(!forceAAloop)
               {
                  errMsg = "You are out of range!  Move closer to your target!";
               }
               if(actionObj.typ == "aa")
               {
                  autoActionTimer.delay = 500;
                  autoActionTimer.reset();
                  autoActionTimer.start();
               }
            }
            tgtOK = true;
            if(errMsg == "none")
            {
               while(scan.length > 0)
               {
                  tAvt = scan[0];
                  tLeaf = tAvt.dataLeaf;
                  tgtOK = true;
                  if(tLeaf.intState == 0)
                  {
                     tgtOK = false;
                  }
                  if(tAvt != null && "filter" in actionObj && "sRace" in tAvt.objData)
                  {
                     if(tAvt.objData.sRace.toLowerCase() != actionObj.filter.toLowerCase())
                     {
                        tgtOK = false;
                     }
                  }
                  switch(actionObj.tgt)
                  {
                     case "h":
                        if(!bPvP && tAvt.npcType == "player" || bPvP && tAvt.npcType == "player" && cLeaf.pvpTeam == tLeaf.pvpTeam || bPvP && tAvt.npcType == "monster" && tLeaf.react != null && tLeaf.react[cLeaf.pvpTeam] == 1)
                        {
                           tgtOK = false;
                        }
                        break;
                     case "f":
                        if(!bPvP && tAvt.npcType == "monster" || bPvP && cLeaf.pvpTeam != tLeaf.pvpTeam || bPvP && tAvt.npcType == "monster" && tLeaf.react != null && tLeaf.react[cLeaf.pvpTeam] == 1)
                        {
                           tgtOK = false;
                        }
                        break;
                     case "s":
                        if(tAvt != null && tAvt != myAvatar)
                        {
                           tgtOK = false;
                        }
                  }
                  if(tgtOK)
                  {
                     sAvt = myAvatar;
                     if(actionObj.fx == "c" && targets.length > 0)
                     {
                        sAvt = targets[targets.length - 1].avt;
                     }
                     a = Math.abs(tAvt.pMC.x - sAvt.pMC.x);
                     b = Math.abs(tAvt.pMC.y - sAvt.pMC.y);
                     c = Math.pow(a * a + b * b,0.5);
                     if(actionRangeCheck(actionObj,tAvt))
                     {
                        targets.push({
                           "avt":tAvt,
                           "d":c,
                           "hp":tLeaf.intHP
                        });
                     }
                  }
                  scan.shift();
               }
            }
            targets.sortOn("hp",Array.NUMERIC);
            if(pAvt != null)
            {
               a = 0;
               while(a < targets.length)
               {
                  to = targets[a];
                  if(to.avt == pAvt)
                  {
                     targets.unshift(targets.splice(a,1)[0]);
                  }
                  a++;
               }
            }
            if(targets.length > tgtMax)
            {
               targets = targets.splice(0,tgtMax);
            }
            if(targets.length > 0)
            {
               if(pAvt != null)
               {
                  if(targets[0].avt != null && targets[0].avt.dataLeaf != null)
                  {
                     tAvt = targets[0].avt;
                     tLeaf = tAvt.dataLeaf;
                  }
                  else
                  {
                     tAvt = null;
                     tLeaf = null;
                  }
               }
               else
               {
                  tAvt = null;
                  tLeaf = null;
               }
            }
         }
         if(errMsg == "none")
         {
            if(cLeaf.intState != 0)
            {
               if(!actionObj.lock && (tLeaf == null || tLeaf.intState != 0) && targets.length >= tgtMin)
               {
                  doAction(actionObj,targets);
               }
               if(myAvatar.target == null || (tLeaf == null || tLeaf.intState == 0))
               {
                  exitCombat();
               }
            }
         }
         else
         {
            now = Number(new Date().getTime());
            if(errMsg == "You are out of range!  Move closer to your target!" && (actionObj.typ != "aa" || forceAARangeError))
            {
               if(now - actionRangeSpamTS > 3000)
               {
                  actionRangeSpamTS = now;
                  rootClass.chatF.pushMsg("warning",errMsg,"SERVER","",0);
               }
            }
            else if(actionObj.typ != "aa")
            {
               rootClass.chatF.pushMsg("warning",errMsg,"SERVER","",0);
            }
         }
      }
      
      public function summonPet(param1:int, param2:Boolean) : *
      {
         if(param2)
         {
            rootClass.sfc.sendXtMessage("zm","equipItem",[param1],"str",curRoom);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","summonPet",[param1],"str",curRoom);
         }
      }
      
      public function autoActionHandler(param1:TimerEvent) : *
      {
         if(rootClass.litePreference.data.bUntargetDead && !myAvatar.target.isMyAvatar && myAvatar.target != null && myAvatar.target.dataLeaf.intState == 0)
         {
            cancelTarget();
            return;
         }
         if(myAvatar.dataLeaf != null && myAvatar.dataLeaf.intState != 0 && myAvatar.target != null && myAvatar.target.dataLeaf != null && myAvatar.target.dataLeaf.intState != 0)
         {
            testAction(getAutoAttack(),true);
         }
         else
         {
            exitCombat();
         }
      }
      
      public function getAutoAttack() : Object
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < actions.active.length)
         {
            if(actions.active[_loc1_] != null && actions.active[_loc1_].auto != null && actions.active[_loc1_].auto == true)
            {
               return actions.active[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function exitCombat() : *
      {
         var _loc1_:int = 0;
         actionReady = false;
         if(actions != null && actions.active != null)
         {
            _loc1_ = 0;
            while(_loc1_ < actions.active.length)
            {
               if(actions.active[_loc1_])
               {
                  actions.active[_loc1_].lock = false;
               }
               _loc1_++;
            }
         }
         if(myAvatar != null)
         {
            if(myAvatar.pMC != null && myAvatar.pMC.mcChar != null && !myAvatar.pMC.mcChar.onMove && myAvatar.pMC.mcChar.currentLabel != "Rest")
            {
               myAvatar.pMC.mcChar.gotoAndStop("Idle");
            }
            if(myAvatar.dataLeaf != null)
            {
               myAvatar.dataLeaf.targets = {};
            }
            cancelAutoAttack();
            myAvatar.pMC.clearQueue();
         }
      }
      
      public function cancelAutoAttack() : *
      {
         var icon:MovieClip = null;
         var i:* = undefined;
         if(autoActionTimer != null)
         {
            autoActionTimer.reset();
         }
         if(AATestTimer != null)
         {
            AATestTimer.reset();
         }
         i = 0;
         while(i < actionMap.length)
         {
            try
            {
               if(actionMap[i] == "aa")
               {
                  icon = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName("i" + (i + 1)));
                  icon.bg.gotoAndStop(1);
               }
            }
            catch(e:Error)
            {
            }
            i++;
         }
      }
      
      public function doAction(param1:*, param2:*) : *
      {
         var _loc3_:Avatar = null;
         var _loc4_:int = 0;
         afkPostpone();
         if(param2.length > 0)
         {
            _loc3_ = param2[0].avt;
            if(_loc3_ != myAvatar)
            {
               if(_loc3_.pMC.x - myAvatar.pMC.x >= 0)
               {
                  myAvatar.pMC.turn("right");
               }
               else
               {
                  myAvatar.pMC.turn("left");
               }
            }
         }
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_].avt;
            switch(_loc3_.npcType)
            {
               case "monster":
                  if(myAvatar.dataLeaf.targets[_loc3_.objData.MonMapID] == null)
                  {
                     myAvatar.dataLeaf.targets[_loc3_.objData.MonMapID] = "m";
                  }
                  break;
               case "player":
                  if(myAvatar.dataLeaf.targets[_loc3_.objData.uid] == null)
                  {
                     myAvatar.dataLeaf.targets[_loc3_.objData.uid] = "p";
                  }
                  break;
            }
            _loc4_++;
         }
         getActionResult(param1,param2);
      }
      
      public function aggroMap(param1:String, param2:String, param3:*) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         _loc4_ = param1.split(":")[0];
         _loc5_ = param1.split(":")[1];
         _loc6_ = param2.split(":")[0];
         _loc7_ = param2.split(":")[1];
         var _loc8_:String = "";
         var _loc9_:String = "";
         _loc10_ = {};
         _loc11_ = {};
         if(_loc4_ == "p")
         {
            _loc10_ = getUoLeafById(_loc5_);
         }
         else
         {
            _loc10_ = monTree[_loc5_];
         }
         if(_loc6_ == "p")
         {
            _loc11_ = getUoLeafById(_loc7_);
         }
         else
         {
            _loc11_ = monTree[_loc7_];
         }
         if(!("targets" in _loc10_))
         {
            _loc10_.targets = {};
         }
         if(!("targets" in _loc11_))
         {
            _loc11_.targets = {};
         }
         if(_loc6_ == "m")
         {
            if(!(_loc7_ in _loc10_.targets))
            {
               _loc10_.targets[_loc7_] = _loc6_;
            }
            if(!(_loc5_ in _loc11_.targets))
            {
               _loc11_.targets[_loc5_] = _loc4_;
            }
         }
         if(_loc4_ == "p" && _loc6_ == "p" && param3)
         {
            for(_loc12_ in monTree)
            {
               _loc13_ = monTree[_loc12_];
               if(_loc13_.targets[_loc7_] != null && !(_loc5_ in _loc13_.targets))
               {
                  _loc13_.targets[_loc5_] = _loc4_;
               }
            }
         }
      }
      
      public function actionTimeCheck(param1:*, param2:Boolean = false) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         _loc3_ = Number(new Date().getTime());
         _loc4_ = 1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha,-1),0.5);
         if(param1.auto)
         {
            if(autoActionTimer.running)
            {
               return false;
            }
            return true;
         }
         if(!param2)
         {
            if(_loc3_ - GCDTS < GCD)
            {
               return false;
            }
         }
         if(param1.OldCD != null)
         {
            _loc5_ = Math.round(param1.OldCD * _loc4_);
         }
         else
         {
            _loc5_ = Math.round(param1.cd * _loc4_);
         }
         if(_loc3_ - param1.ts >= _loc5_)
         {
            delete param1.OldCD;
            return true;
         }
         return false;
      }
      
      private function actionRangeCheck(param1:*, param2:Avatar = null) : Boolean
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(param2 == null && myAvatar.target != null)
         {
            param2 = myAvatar.target;
         }
         if(param2 == myAvatar)
         {
            return true;
         }
         if("tgtMin" in param1 && param1.tgtMin == 0)
         {
            return true;
         }
         if(param2 == null)
         {
            return false;
         }
         _loc3_ = myAvatar.pMC.mcChar.localToGlobal(new Point(0,0));
         _loc4_ = param2.pMC.mcChar.localToGlobal(new Point(0,0));
         _loc5_ = Math.abs(_loc4_.x - _loc3_.x);
         _loc6_ = Math.abs(_loc4_.y - _loc3_.y);
         _loc7_ = Math.pow(_loc5_ * _loc5_ + _loc6_ * _loc6_,0.5);
         _loc8_ = param1.range * SCALE;
         if(param1.range <= 301)
         {
            if(bPvP && _loc5_ <= _loc8_ * 1.15 && _loc6_ <= 30 * 1.15 * SCALE || !bPvP && _loc5_ <= _loc8_ && _loc6_ <= 30 * SCALE)
            {
               return true;
            }
            return false;
         }
         if(_loc7_ <= _loc8_)
         {
            return true;
         }
         return false;
      }
      
      public function aggroAllMon() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = [];
         for(_loc2_ in monTree)
         {
            if(monTree[_loc2_].strFrame == strFrame)
            {
               _loc1_.push(_loc2_);
            }
         }
         aggroMons(_loc1_);
      }
      
      public function aggroMon(param1:*) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = [];
         _loc2_.push(param1);
         aggroMons(_loc2_);
      }
      
      public function aggroMons(param1:*) : *
      {
         if(param1.length)
         {
            rootClass.sfc.sendXtMessage("zm","aggroMon",param1,"str",curRoom);
         }
      }
      
      public function castSpellFX(param1:*, param2:*, param3:*, param4:int = 0) : *
      {
         var tAvt:Avatar = null;
         var AssetClass:Class = null;
         var spellFX:* = undefined;
         var targetMCs:Array = null;
         var i:int = 0;
         var cAvt:* = param1;
         var spFX:* = param2;
         var spell:* = param3;
         var dur:int = param4;
         try
         {
            if(cAvt && Boolean(cAvt.isCameraTool))
            {
               cAvt.pMC.clearSpFXQueue();
               return;
            }
            if(!showAnimations || cAvt && !cAvt.isMyAvatar && !cAvt.pMC.mcChar.visible)
            {
               cAvt.pMC.clearSpFXQueue();
               return;
            }
            if(rootClass.litePreference.data.bDisSkillAnim)
            {
               if(!rootClass.litePreference.data.dOptions["animSelf"] || rootClass.litePreference.data.dOptions["animSelf"] && cAvt && !cAvt.isMyAvatar)
               {
                  cAvt.pMC.clearSpFXQueue();
                  return;
               }
            }
            if(spFX.strl != null && spFX.strl != "" && spFX.avts != null)
            {
               targetMCs = [];
               i = 0;
               if(spFX.fx == "c")
               {
                  if(spFX.strl == "lit1")
                  {
                     targetMCs.push(cAvt.pMC.mcChar);
                     i = 0;
                     while(i < spFX.avts.length)
                     {
                        tAvt = spFX.avts[i];
                        if(tAvt != null && tAvt.pMC != null && tAvt.pMC.mcChar != null)
                        {
                           targetMCs.push(tAvt.pMC.mcChar);
                        }
                        i++;
                     }
                     if(targetMCs.length > 1)
                     {
                        AssetClass = getClass("sp_C1") as Class;
                        if(AssetClass != null)
                        {
                           spellFX = new AssetClass();
                           spellFX.mouseEnabled = false;
                           spellFX.mouseChildren = false;
                           spellFX.visible = true;
                           spellFX.world = MovieClip(this);
                           spellFX.strl = spFX.strl;
                           rootClass.drawChainsLinear(targetMCs,33,MovieClip(CHARS.addChild(spellFX)));
                        }
                     }
                  }
               }
               else if(spFX.fx == "f")
               {
                  targetMCs.push(cAvt.pMC.mcChar);
                  tAvt = spFX.avts[0];
                  if(tAvt != null && tAvt.pMC != null && tAvt.pMC.mcChar != null)
                  {
                     targetMCs.push(tAvt.pMC.mcChar);
                  }
                  if(targetMCs.length > 1)
                  {
                     spellFX = new MovieClip();
                     spellFX.mouseEnabled = false;
                     spellFX.mouseChildren = false;
                     spellFX.visible = true;
                     spellFX.world = MovieClip(this);
                     spellFX.strl = spFX.strl;
                     rootClass.drawFunnel(targetMCs,MovieClip(CHARS.addChild(spellFX)));
                  }
               }
               else
               {
                  i = 0;
                  while(i < spFX.avts.length)
                  {
                     tAvt = spFX.avts[i];
                     if(tAvt != null)
                     {
                        if(tAvt.pMC != null)
                        {
                           AssetClass = getClass(spFX.strl) as Class;
                           if(AssetClass != null)
                           {
                              spellFX = new AssetClass();
                              spellFX.spellDur = dur;
                              if(spell != null)
                              {
                                 spellFX.transform = spell.transform;
                              }
                              CHARS.addChild(spellFX);
                              spellFX.mouseEnabled = false;
                              spellFX.mouseChildren = false;
                              spellFX.visible = true;
                              spellFX.world = MovieClip(this);
                              spellFX.strl = spFX.strl;
                              spellFX.tMC = tAvt.pMC;
                              switch(spFX.fx)
                              {
                                 case "p":
                                    spellFX.x = cAvt.pMC.x;
                                    spellFX.y = cAvt.pMC.y - cAvt.pMC.mcChar.height * 0.5;
                                    spellFX.dir = tAvt.pMC.x - cAvt.pMC.x >= 0 ? 1 : -1;
                                    break;
                                 case "w":
                                    spellFX.x = spellFX.tMC.x;
                                    spellFX.y = spellFX.tMC.y + 3;
                                    if(cAvt != null)
                                    {
                                       if(spellFX.tMC.x < cAvt.pMC.x)
                                       {
                                          spellFX.scaleX *= -1;
                                       }
                                    }
                              }
                           }
                        }
                     }
                     i++;
                  }
               }
            }
            if(cAvt)
            {
               cAvt.pMC.spFX.strl = "";
               cAvt.pMC.canCastSpFX();
            }
         }
         catch(e:*)
         {
            cAvt.pMC.clearSpFXQueue();
         }
      }
      
      public function showSpellFXHit(param1:*) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = {};
         switch(param1.strl)
         {
            case "sp_ice1":
               _loc2_.strl = "sp_ice2";
               break;
            case "sp_el3":
               _loc2_.strl = "sp_el2";
               break;
            case "sp_ed3":
               _loc2_.strl = "sp_ed1";
               break;
            case "sp_ef1":
            case "sp_ef6":
               _loc2_.strl = "sp_ef2";
         }
         _loc2_.fx = "w";
         _loc2_.avts = [param1.tMC.pAV];
         castSpellFX(null,_loc2_,null);
      }
      
      public function doCastIA(param1:Object) : void
      {
      }
      
      public function getActionByActID(param1:int) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < actions.active.length)
         {
            if(Boolean(actions.active[_loc3_]) && actions.active[_loc3_].actID == param1)
            {
               _loc2_ = actions.active[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getActionByRef(param1:String) : Object
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in actions.active)
         {
            if(_loc2_ && _loc2_.ref == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in actions.passive)
         {
            if(_loc2_.ref == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function handleSAR(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         _loc2_ = {};
         _loc3_ = "";
         _loc4_ = -1;
         var _loc5_:String = "";
         var _loc6_:int = -1;
         if(param1.iRes == 1)
         {
            if(rootClass.bAnalyzer)
            {
               if(rootClass.bAnalyzer.isRunning)
               {
                  _loc7_ = param1.actionResult.cInf.split(":");
                  _loc8_ = param1.actionResult.tInf.split(":");
                  if(_loc7_[0] == "p")
                  {
                     if(_loc7_[1] == rootClass.sfc.myUserId)
                     {
                        if(param1.actionResult.hp >= 0)
                        {
                           rootClass.bAnalyzer.addDamage(param1.actionResult.hp);
                        }
                        else
                        {
                           rootClass.bAnalyzer.addHeal(param1.actionResult.hp * -1);
                        }
                     }
                  }
                  else if(_loc8_[0] == "p")
                  {
                     if(_loc8_[1] == rootClass.sfc.myUserId)
                     {
                        if(param1.actionResult.hp >= 0)
                        {
                           rootClass.bAnalyzer.addReceived(param1.actionResult.hp);
                        }
                        else
                        {
                           rootClass.bAnalyzer.addHeal(param1.actionResult.hp * -1);
                        }
                     }
                  }
               }
            }
            if(param1.actionResult.typ == "d")
            {
               actionResultsAura.push(param1.actionResult);
               _loc2_ = rootClass.copyObj(param1.actionResult);
               _loc2_.a = [rootClass.copyObj(param1.actionResult)];
            }
            else
            {
               aggroMap(param1.actionResult.cInf,param1.actionResult.tInf,param1.actionResult.hp >= 0);
               _loc3_ = param1.actionResult.cInf.split(":")[0];
               _loc4_ = int(param1.actionResult.cInf.split(":")[1]);
               _loc5_ = param1.actionResult.tInf.split(":")[0];
               _loc6_ = int(param1.actionResult.tInf.split(":")[1]);
               _loc2_ = rootClass.copyObj(param1.actionResult);
               _loc2_.a = [rootClass.copyObj(param1.actionResult)];
               if(_loc3_ == "p" && _loc4_ == rootClass.sfc.myUserId)
               {
                  showActionResult(_loc2_,_loc2_.actID);
               }
               else
               {
                  showIncomingAttackResult(_loc2_);
               }
            }
         }
         if(param1.iRes == 0)
         {
            switch(param1.actionResult.cInf.split(":")[0])
            {
               case "p":
                  showActionResult(null,param1.actID);
            }
         }
      }
      
      public function handleSARS(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc2_:Object = {};
         _loc3_ = "";
         _loc4_ = -1;
         var _loc5_:String = "";
         var _loc6_:int = -1;
         _loc7_ = param1.cInf;
         _loc7_ = param1.cInf;
         _loc3_ = _loc7_.split(":")[0];
         _loc4_ = int(_loc7_.split(":")[1]);
         _loc8_ = {};
         if(param1.iRes == 1)
         {
            _loc9_ = [];
            _loc10_ = 0;
            while(_loc10_ < param1.a.length)
            {
               if(rootClass.bAnalyzer)
               {
                  if(rootClass.bAnalyzer.isRunning)
                  {
                     if(_loc3_ == "p")
                     {
                        if(_loc4_ == rootClass.sfc.myUserId)
                        {
                           if(param1.a[_loc10_].hp >= 0)
                           {
                              rootClass.bAnalyzer.addDamage(param1.a[_loc10_].hp);
                           }
                           else
                           {
                              rootClass.bAnalyzer.addHeal(param1.a[_loc10_].hp * -1);
                           }
                        }
                     }
                     else if(param1.a[_loc10_].tInf.split(":")[0] == "p")
                     {
                        if(param1.a[_loc10_].tInf.split(":")[1] == rootClass.sfc.myUserId)
                        {
                           if(param1.a[_loc10_].hp >= 0)
                           {
                              rootClass.bAnalyzer.addReceived(param1.a[_loc10_].hp);
                           }
                           else
                           {
                              rootClass.bAnalyzer.addHeal(param1.a[_loc10_].hp * -1);
                           }
                        }
                     }
                  }
               }
               _loc8_ = param1.a[_loc10_];
               aggroMap(_loc7_,_loc8_.tInf,_loc8_.hp >= 0);
               _loc10_++;
            }
            if(_loc3_ == "p" && _loc4_ == rootClass.sfc.myUserId)
            {
               showActionResult(rootClass.copyObj(param1),param1.actID);
            }
            else
            {
               showIncomingAttackResult(rootClass.copyObj(param1));
            }
         }
         if(param1.iRes == 0)
         {
            switch(_loc7_.split(":")[0])
            {
               case "p":
                  showActionResult(null,param1.actID);
            }
         }
      }
      
      public function getActionResult(param1:*, param2:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = null;
         var _loc6_:Avatar = null;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:* = undefined;
         _loc3_ = [];
         _loc4_ = "gar";
         _loc5_ = "";
         _loc7_ = 0;
         _loc3_.push(actionID);
         if(param2.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < param2.length)
            {
               _loc6_ = param2[_loc7_].avt;
               if(_loc7_ > 0)
               {
                  _loc5_ += ",";
               }
               _loc5_ += param1.ref + ">";
               if(_loc6_.npcType == "monster")
               {
                  _loc5_ += "m:" + _loc6_.objData.MonMapID;
               }
               if(_loc6_.npcType == "player")
               {
                  _loc5_ += "p:" + _loc6_.uid;
               }
               _loc7_++;
            }
         }
         else
         {
            _loc5_ += param1.ref + ">";
         }
         _loc3_.push(_loc5_);
         if(param1.ref == "i1")
         {
            _loc3_.push(param1.sArg1);
         }
         _loc3_.push("wvz");
         rootClass.sfc.sendXtMessage("zm",_loc4_,_loc3_,"str",1);
         if(map.getAction != null && map.getAction == true)
         {
            try
            {
               map.sendAction(param1.ref);
            }
            catch(e:*)
            {
            }
         }
         _loc8_ = Number(new Date().getTime());
         param1.lock = true;
         param1.actID = actionID;
         ++actionID;
         if(actionID > actionIDLimit)
         {
            actionID = 0;
         }
         param1.lastTS = param1.ts;
         param1.ts = _loc8_;
         if(param1.typ != "aa")
         {
            coolDownAct(param1);
            globalCoolDownExcept(param1);
            if(!autoActionTimer.running && param1.tgt == "h")
            {
               testAction(getAutoAttack());
            }
         }
         else
         {
            if(rootClass.litePreference.data.bSkillCD)
            {
               coolDownAct(param1);
            }
            else
            {
               _loc7_ = 0;
               while(_loc7_ < actionMap.length)
               {
                  if(actionMap[_loc7_] == param1.ref)
                  {
                     _loc9_ = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName("i" + (_loc7_ + 1)));
                     if(_loc9_.bg.currentLabel != "pulse")
                     {
                        _loc9_.bg.gotoAndPlay("pulse");
                     }
                  }
                  _loc7_++;
               }
            }
            actionReady = false;
         }
      }
      
      public function showActionResult(param1:*, param2:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         _loc3_ = new Date();
         _loc4_ = getActionByActID(param2);
         if(_loc4_ != null)
         {
            _loc4_.lock = false;
            _loc4_.actID = -1;
            _loc5_ = _loc4_.ts;
            _loc6_ = _loc3_.getTime();
            _loc7_ = int((_loc6_ - _loc5_) / 2);
            if(_loc4_.typ == "aa")
            {
               _loc8_ = Math.round(_loc4_.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha,-1),0.5)));
               _loc9_ = _loc8_ - int(_loc6_ - _loc5_);
               if(_loc9_ > _loc8_)
               {
                  _loc9_ = _loc8_;
               }
               if(_loc9_ < _loc8_ - 100)
               {
                  _loc9_ = _loc8_ - 100;
               }
               autoActionTimer.delay = _loc9_;
               autoActionTimer.reset();
               autoActionTimer.start();
            }
            if(param1 == null)
            {
               _loc4_.ts = _loc4_.lastTS;
            }
            else
            {
               _loc4_.ts = Math.max(int(_loc6_ - _loc7_),_loc5_ + minLatencyOneWay);
               unlockActionsExcept(_loc4_);
               rootClass.updateActionObjIcon(_loc4_);
            }
         }
         if(param1 != null)
         {
            playActionSound(param1);
            if(param1.type != "none")
            {
               try
               {
                  if(actionResults.length > 30)
                  {
                     actionResults.shift();
                  }
               }
               catch(e:*)
               {
               }
               actionResults.push(param1);
            }
         }
      }
      
      public function showIncomingAttackResult(param1:Object) : void
      {
         playActionSound(param1);
         actionResultsMon.push(param1);
      }
      
      public function playActionSound(param1:Object) : void
      {
         var _loc2_:Object = null;
         if(param1.a.length > 0 && param1.a[0].type != null)
         {
            _loc2_ = param1.a[0];
            switch(_loc2_.type)
            {
               case "hit":
                  if(_loc2_.hp >= 0)
                  {
                     if(Math.random() < 0.5)
                     {
                        rootClass.mixer.playSound("Hit1");
                     }
                     else
                     {
                        rootClass.mixer.playSound("Hit2");
                     }
                  }
                  else
                  {
                     rootClass.mixer.playSound("Heal");
                  }
                  break;
               case "crit":
                  if(_loc2_.hp >= 0)
                  {
                     rootClass.mixer.playSound("Hit3");
                  }
                  else
                  {
                     rootClass.mixer.playSound("Heal");
                  }
                  break;
               case "miss":
                  rootClass.mixer.playSound("Miss");
                  break;
               case "none":
                  rootClass.mixer.playSound("Good");
            }
         }
      }
      
      public function showActionImpact(param1:*) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:TextFormat = null;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:Object = null;
         if(rootClass.litePreference.data.bDisDmgDisplay)
         {
            return;
         }
         _loc3_ = null;
         _loc4_ = null;
         _loc5_ = "";
         _loc6_ = 0;
         var _loc7_:Array = ["GOOD","GREAT!","MASSIVE!!"];
         _loc8_ = [16777215,16777215,16777215];
         var _loc9_:Array = [2381688,0,0];
         _loc10_ = 0;
         _loc11_ = new TextFormat();
         _loc12_ = 0;
         _loc13_ = param1.a;
         _loc14_ = {};
         _loc12_ = 0;
         while(_loc12_ < _loc13_.length)
         {
            _loc14_ = _loc13_[_loc12_];
            _loc5_ = _loc14_.tInf.split(":")[0];
            _loc6_ = int(_loc14_.tInf.split(":")[1]);
            switch(_loc5_)
            {
               case "p":
                  _loc2_ = avatars[_loc6_].pMC;
                  break;
               case "m":
                  _loc2_ = getMonster(_loc6_).pMC;
            }
            if(_loc2_ != null && _loc2_.pAV != null && _loc2_.pAV.dataLeaf != null)
            {
               switch(_loc14_.type)
               {
                  case "hit":
                     _loc4_ = new hitDisplay();
                     _loc4_.t.ti.autoSize = "center";
                     if(_loc14_.hp >= 0)
                     {
                        _loc10_ = 0;
                        _loc4_.t.ti.text = _loc14_.hp;
                        _loc4_.t.ti.textColor = _loc8_[_loc10_];
                        _loc4_.t.ti.filters = [new GlowFilter(0,1,5,5,5,1,false,false)];
                        _loc4_.t.ti.setTextFormat(_loc11_);
                     }
                     else
                     {
                        _loc4_.t.ti.text = "+" + -_loc14_.hp + "+";
                        _loc4_.t.ti.textColor = 65450;
                     }
                     wound(_loc2_,"damage");
                     break;
                  case "crit":
                     _loc4_ = new critDisplay();
                     _loc4_.t.ti.autoSize = "center";
                     if(_loc14_.hp > 0)
                     {
                        _loc4_.t.ti.text = _loc14_.hp;
                        _loc4_.t.ti.textColor = 16750916;
                        _loc4_.t.ti.filters = [new GlowFilter(3342336,1,5,5,5,1,false,false)];
                     }
                     else
                     {
                        _loc4_.t.ti.text = -_loc14_.hp;
                        _loc4_.t.ti.textColor = 65450;
                     }
                     wound(_loc2_,"damage");
                     break;
                  case "miss":
                     _loc4_ = new avoidDisplay();
                     _loc4_.t.ti.text = "Miss!";
                     break;
                  case "dodge":
                     _loc4_ = new avoidDisplay();
                     _loc4_.t.ti.text = "Dodge!";
                     if(isMoveOK(_loc2_.pAV.dataLeaf))
                     {
                        _loc2_.queueAnim("Dodge");
                     }
                     break;
                  case "parry":
                     _loc4_ = new avoidDisplay();
                     _loc4_.t.ti.text = "Parry!";
                     if(isMoveOK(_loc2_.pAV.dataLeaf))
                     {
                        _loc2_.queueAnim("Dodge");
                     }
                     break;
                  case "block":
                     _loc4_ = new avoidDisplay();
                     _loc4_.t.ti.text = "Block!";
                     if(isMoveOK(_loc2_.pAV.dataLeaf))
                     {
                        _loc2_.queueAnim("Block");
                     }
                     break;
                  case "none":
               }
               if(_loc4_ != null)
               {
                  _loc2_.addChild(_loc4_);
                  _loc4_.x = _loc2_.mcChar.x;
                  _loc4_.y = _loc2_.pname.y + 10;
               }
               if(_loc3_ != null)
               {
                  _loc2_.addChild(_loc3_);
                  _loc3_.x = _loc2_.mcChar.x;
                  _loc3_.y = _loc2_.pname.y + _loc2_.mcChar.height / 2;
               }
            }
            _loc12_++;
         }
      }
      
      public function showAuraImpact(param1:*) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(rootClass.litePreference.data.bDisDmgDisplay)
         {
            return;
         }
         _loc3_ = param1.tInf.split(":")[0];
         _loc4_ = int(param1.tInf.split(":")[1]);
         _loc5_ = null;
         switch(_loc3_)
         {
            case "p":
               if(avatars[_loc4_] != null && "pMC" in avatars[_loc4_] && avatars[_loc4_].pMC != null)
               {
                  _loc2_ = avatars[_loc4_].pMC;
               }
               break;
            case "m":
               if(getMonster(_loc4_) != null && "pMC" in getMonster(_loc4_) && getMonster(_loc4_).pMC != null)
               {
                  _loc2_ = getMonster(_loc4_).pMC;
               }
         }
         if(_loc2_ != null)
         {
            _loc5_ = new dotDisplay();
            _loc5_.hpDisplay = param1.hp;
            _loc5_.init();
            _loc2_.addChild(_loc5_);
            _loc5_.x = _loc2_.mcChar.x;
            _loc5_.y = _loc2_.pname.y + 10;
         }
      }
      
      public function showAuraChange(param1:Object, param2:Avatar, param3:Object) : *
      {
         var tMC:MovieClip = null;
         var actionDamage:* = undefined;
         var cLeaf:Object = null;
         var i:int = 0;
         var nc:int = 0;
         var gap:int = 0;
         var child:DisplayObject = null;
         var cTyp:String = null;
         var cID:int = 0;
         var tTyp:String = null;
         var tID:int = 0;
         var aura:Object = null;
         var existingAura:Object = null;
         var dateObj:Date = null;
         var isOK:Boolean = false;
         var tFilters:Array = null;
         var tFilter:* = undefined;
         var auras:* = undefined;
         var ai:* = undefined;
         var actObj:* = undefined;
         var icon1:* = undefined;
         var filterIndex:int = 0;
         var resObj:Object = param1;
         var tAvt:Avatar = param2;
         var tLeaf:Object = param3;
         tMC = tAvt.pMC;
         actionDamage = null;
         var cAvt:Avatar = null;
         cLeaf = null;
         if(tMC != null)
         {
            i = 0;
            nc = tMC.numChildren;
            gap = 1;
            if(resObj.cInf != null)
            {
               cTyp = String(resObj.cInf.split(":")[0]);
               cID = int(resObj.cInf.split(":")[1]);
               switch(cTyp)
               {
                  case "p":
                     cAvt = getAvatarByUserID(cID);
                     cLeaf = getUoLeafById(cID);
                     break;
                  case "m":
                     cAvt = getMonster(cID);
                     cLeaf = monTree[cID];
               }
            }
            if(resObj.auras != null)
            {
               gap = int(resObj.auras.length);
            }
            i = 0;
            while(i < nc)
            {
               child = tMC.getChildAt(i);
               if(child != null && child.toString() != null && child.toString().indexOf("auraDisplay") > -1)
               {
                  child.y -= int(child.height + 3) * gap;
               }
               i++;
            }
            aura = {};
            existingAura = {};
            dateObj = new Date();
            isOK = true;
            if(tLeaf.auras == null)
            {
               tLeaf.auras = [];
            }
            if(tLeaf.passives == null)
            {
               tLeaf.passives = [];
            }
            switch(resObj.cmd)
            {
               case "aura+":
               case "aura++":
               case "aura+p":
                  i = 0;
                  while(i < resObj.auras.length)
                  {
                     aura = resObj.auras[i];
                     aura.cLeaf = cLeaf;
                     if(resObj.cmd == "aura+p")
                     {
                        aura.passive = true;
                     }
                     else
                     {
                        aura.passive = false;
                     }
                     if(!aura.passive)
                     {
                        if(aura.t != null)
                        {
                           aura.ts = dateObj.getTime();
                        }
                        if(tAvt == myAvatar || tAvt == myAvatar.target || tLeaf.targets != null && tLeaf.targets[rootClass.sfc.myUserId] != null || resObj.cmd == "aura++")
                        {
                           if(aura.potionType != null)
                           {
                              if(aura.potionType.toLowerCase() == "tonic")
                              {
                                 tAvt.objData.Tonic = true;
                              }
                              if(aura.potionType.toLowerCase() == "elixir")
                              {
                                 tAvt.objData.Elixir = true;
                              }
                           }
                           if(aura.nam == "Skill Locked")
                           {
                              ai = 0;
                              while(ai < actions.active.length)
                              {
                                 actObj = actions.active[ai];
                                 if(actObj)
                                 {
                                    if(actObj.nam == aura.val)
                                    {
                                       icon1 = rootClass.ui.mcInterface.actBar.getChildByName("i" + (ai + 1));
                                       icon1.actObj.skillLock = true;
                                    }
                                 }
                                 ai++;
                              }
                           }
                           if(!(Boolean(rootClass.litePreference.data.bAuras) && Boolean(rootClass.litePreference.data.dOptions["disAuraText"])))
                           {
                              actionDamage = new auraDisplay();
                              actionDamage.t.ti.text = aura.nam + "!";
                              if(aura.nam == "Spirit Power")
                              {
                                 actionDamage.t.ti.text = aura.nam + " " + aura.val;
                              }
                              tMC.addChild(actionDamage);
                              actionDamage.x = tMC.mcChar.scaleX < 0 ? 35 : -actionDamage.t.ti.textWidth - 35;
                              actionDamage.y = tMC.pname.y + 25 + (actionDamage.height + 3) * i;
                           }
                           if(aura.fx != null)
                           {
                              addAuraFX(tMC,aura.fx);
                           }
                        }
                        if(aura.s != null)
                        {
                           switch(aura.s)
                           {
                              case "s":
                                 if(tMC.mcChar.currentLabel != "Fall")
                                 {
                                    tMC.clearQueue();
                                    tMC.mcChar.gotoAndPlay("Fall");
                                 }
                           }
                        }
                        if(aura.cat != null)
                        {
                           isOK = true;
                           for each(existingAura in tLeaf.auras)
                           {
                              try
                              {
                                 if(existingAura.cat != null && existingAura.cat == aura.cat)
                                 {
                                    isOK = false;
                                 }
                              }
                              catch(e:Error)
                              {
                              }
                           }
                           if(isOK)
                           {
                              switch(aura.cat)
                              {
                                 case "paralyze":
                                 case "stone":
                                    tMC.modulateColor(statusStoneCT,"+");
                                    tMC.mcChar.stop();
                                    break;
                                 case "clean":
                                    tFilters = tMC.mcChar.filters;
                                    tFilters.push(new GlowFilter(16777215,1,30,30,2,2));
                                    tMC.mcChar.filters = tFilters;
                              }
                           }
                        }
                        if(aura.animOn != null && (cLeaf == null || cLeaf.intState == 2))
                        {
                           if(aura.animOn.indexOf("fadeFX:") > -1)
                           {
                              removeAuraFX(tMC,aura.animOn.split(":")[1],"fade");
                           }
                           else if(aura.animOn.indexOf("useFX:") > -1)
                           {
                              removeAuraFX(tMC,aura.animOn.split(":")[1],"use");
                           }
                           else if(aura.animOn.indexOf("removeFX:") > -1)
                           {
                              removeAuraFX(tMC,aura.animOn.split(":")[1]);
                           }
                           else
                           {
                              tMC.mcChar.gotoAndPlay(aura.animOn);
                           }
                        }
                        if(aura.msgOn != null)
                        {
                           if(aura.msgOn.charAt(0) == "@")
                           {
                              if(tAvt == myAvatar)
                              {
                                 rootClass.addUpdate(aura.msgOn.substr(1));
                              }
                           }
                           else
                           {
                              rootClass.addUpdate(aura.msgOn);
                           }
                        }
                        if(aura.isNew)
                        {
                           tLeaf.auras.push(aura);
                        }
                        else
                        {
                           updateAuraData(cLeaf,aura,tLeaf);
                        }
                     }
                     else
                     {
                        tLeaf.passives.push(aura);
                     }
                     i++;
                  }
                  break;
               case "aura-":
               case "aura--":
                  auras = [];
                  if(resObj.auras != null)
                  {
                     auras = resObj.auras;
                  }
                  else if(resObj.aura != null)
                  {
                     auras = [resObj.aura];
                  }
                  i = 0;
                  while(i < auras.length)
                  {
                     aura = auras[i];
                     if(removeAura(aura,tLeaf,tMC))
                     {
                        if(tAvt == myAvatar || tAvt == myAvatar.target || tLeaf.targets != null && tLeaf.targets[rootClass.sfc.myUserId] != null || resObj.cmd == "aura--")
                        {
                           if(!(Boolean(rootClass.litePreference.data.bAuras) && Boolean(rootClass.litePreference.data.dOptions["disAuraText"])))
                           {
                              actionDamage = new auraDisplay();
                              actionDamage.t.ti.text = "*" + aura.nam + " fades*";
                              actionDamage.t.ti.textColor = 10066329;
                              tMC.addChild(actionDamage);
                              actionDamage.x = tMC.mcChar.scaleX < 0 ? 35 : -actionDamage.t.ti.textWidth - 35;
                              actionDamage.y = tMC.pname.y + 25;
                           }
                        }
                        if(aura.potionType != null)
                        {
                           if(aura.potionType.toLowerCase() == "tonic")
                           {
                              tAvt.objData.Tonic = false;
                           }
                           if(aura.potionType.toLowerCase() == "elixir")
                           {
                              tAvt.objData.Elixir = false;
                           }
                        }
                        if(aura.s != null)
                        {
                           switch(aura.s)
                           {
                              case "s":
                                 if(tMC.mcChar.currentLabel == "Fall")
                                 {
                                    if(isStatusGone("s",tLeaf))
                                    {
                                       tMC.mcChar.gotoAndPlay("Getup");
                                    }
                                 }
                           }
                        }
                        if(aura.cat != null)
                        {
                           isOK = true;
                           for each(existingAura in tLeaf.auras)
                           {
                              try
                              {
                                 if(existingAura.cat != null && existingAura.cat == aura.cat)
                                 {
                                    isOK = false;
                                 }
                              }
                              catch(e:Error)
                              {
                              }
                           }
                           if(isOK)
                           {
                              switch(aura.cat)
                              {
                                 case "stone":
                                    tMC.modulateColor(statusStoneCT,"-");
                                    tMC.mcChar.play();
                                    break;
                                 case "clean":
                                    tFilters = tMC.mcChar.filters;
                                    filterIndex = 0;
                                    while(filterIndex < tFilters.length)
                                    {
                                       tFilter = tFilters[filterIndex];
                                       if(tFilter is GlowFilter && GlowFilter(tFilter).color == 16777215)
                                       {
                                          tFilters.splice(filterIndex,1);
                                          filterIndex--;
                                       }
                                       filterIndex++;
                                    }
                                    tMC.mcChar.filters = tFilters;
                              }
                           }
                        }
                        if(aura.nam == "Skill Locked")
                        {
                           ai = 0;
                           while(ai < actions.active.length)
                           {
                              actObj = actions.active[ai];
                              if(actObj)
                              {
                                 if(actObj.nam == aura.val)
                                 {
                                    icon1 = rootClass.ui.mcInterface.actBar.getChildByName("i" + (ai + 1));
                                    icon1.actObj.skillLock = false;
                                    icon1.cnt.alpha = 1;
                                 }
                              }
                              ai++;
                           }
                        }
                        if(aura.animOff != null)
                        {
                           tMC.mcChar.gotoAndPlay(aura.animOff);
                        }
                        if(aura.msgOff != null)
                        {
                           if(aura.msgOff.charAt(0) == "@")
                           {
                              if(tAvt == myAvatar)
                              {
                                 rootClass.addUpdate(aura.msgOff.substr(1));
                              }
                           }
                           else
                           {
                              rootClass.addUpdate(aura.msgOff);
                           }
                        }
                     }
                     i++;
                  }
                  break;
               case "aura*":
                  actionDamage = new auraDisplay();
                  actionDamage.t.ti.text = "* IMMUNE *";
                  tMC.addChild(actionDamage);
                  actionDamage.x = tMC.mcChar.scaleX < 0 ? 35 : -actionDamage.t.ti.textWidth - 35;
                  actionDamage.y = tMC.pname.y + 25 + (actionDamage.height + 3) * i;
            }
         }
      }
      
      public function updateAuraData(param1:Object, param2:Object, param3:Object) : void
      {
         var _loc4_:Object = null;
         for each(_loc4_ in param3.auras)
         {
            if(_loc4_.nam == param2.nam && _loc4_.cLeaf == param1)
            {
               _loc4_.dur = param2.dur;
               _loc4_.val = param2.val;
            }
         }
      }
      
      public function handleAuraEvent(param1:String, param2:Object) : void
      {
         var cLeaf:Object = null;
         var tLeaf:Object = null;
         var cAvt:Avatar = null;
         var tAvt:Avatar = null;
         var cTyp:String = null;
         var cID:int = 0;
         var tTyp:String = null;
         var tID:int = 0;
         var forceAura:Boolean = false;
         var cmd:String = param1;
         var resObj:Object = param2;
         if(rootClass.sfcSocial)
         {
            forceAura = false;
            if(cmd.indexOf("++") > -1 || cmd.indexOf("--") > -1)
            {
               forceAura = true;
            }
            cAvt = null;
            tAvt = null;
            if(resObj.cInf != null)
            {
               cTyp = String(resObj.cInf.split(":")[0]);
               cID = int(resObj.cInf.split(":")[1]);
               switch(cTyp)
               {
                  case "p":
                     cAvt = getAvatarByUserID(cID);
                     cLeaf = getUoLeafById(cID);
                     break;
                  case "m":
                     cAvt = getMonster(cID);
                     cLeaf = monTree[cID];
               }
            }
            if(resObj.tInf != null)
            {
               tTyp = String(resObj.tInf.split(":")[0]);
               tID = int(resObj.tInf.split(":")[1]);
               switch(tTyp)
               {
                  case "p":
                     try
                     {
                        tAvt = getAvatarByUserID(tID);
                        tLeaf = getUoLeafById(tID);
                        if(forceAura || tLeaf.strFrame == strFrame)
                        {
                           if(rootClass.sfcSocial)
                           {
                              showAuraChange(resObj,tAvt,tLeaf);
                           }
                        }
                     }
                     catch(e:Error)
                     {
                     }
                     break;
                  case "m":
                     try
                     {
                        tAvt = getMonster(tID);
                        tLeaf = monTree[tID];
                        if(forceAura || (cLeaf == null || cLeaf.targets[tID] != null && tLeaf.strFrame == strFrame))
                        {
                           if(rootClass.sfcSocial)
                           {
                              showAuraChange(resObj,tAvt,tLeaf);
                           }
                        }
                     }
                     catch(e:Error)
                     {
                     }
               }
            }
         }
      }
      
      public function removeAura(param1:Object, param2:Object, param3:MovieClip) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         if(rootClass.sfcSocial)
         {
            _loc4_ = false;
            _loc5_ = 0;
            _loc5_ = 0;
            while(_loc5_ < param2.auras.length)
            {
               if(param2.auras[_loc5_].nam == param1.nam)
               {
                  if(param3 != null && param2.auras[_loc5_].fx != null)
                  {
                     removeAuraFX(param3,param2.auras[_loc5_].fx,"fade");
                  }
                  param2.auras.splice(_loc5_,1);
                  _loc5_ = int(param2.auras.length);
                  _loc4_ = true;
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < param2.passives.length)
            {
               if(param2.passives[_loc5_].nam == param1.nam)
               {
                  param2.passives.splice(_loc5_,1);
                  _loc5_ = int(param2.passives.length);
                  _loc4_ = false;
               }
               _loc5_++;
            }
            return _loc4_;
         }
         return false;
      }
      
      public function addAuraFX(param1:MovieClip, param2:String) : void
      {
         var c:Class = null;
         var fx:MovieClip = null;
         var tMC:MovieClip = param1;
         var fxName:String = param2;
         try
         {
            if(tMC.fx.getChildByName(fxName) == null)
            {
               c = getClass(fxName);
               fx = MovieClip(tMC.fx.addChild(new c()));
               fx.name = fxName;
               fx.y = -30;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function removeAuraFX(param1:MovieClip, param2:String, param3:String = null) : void
      {
         var i:int = 0;
         var fx:MovieClip = null;
         var tMC:MovieClip = param1;
         var fxName:String = param2;
         var fxLabel:String = param3;
         i = 0;
         i = 0;
         while(i < tMC.fx.numChildren)
         {
            fx = MovieClip(tMC.fx.getChildAt(i));
            if(fxName == "all" || fx.name == fxName)
            {
               if(fxLabel != null)
               {
                  try
                  {
                     MovieClip(fx.getChildByName("inner")).gotoAndPlay(fxLabel);
                  }
                  catch(fxe:Error)
                  {
                  }
               }
               else
               {
                  MovieClip(tMC.fx.removeChildAt(i)).stop();
                  i--;
               }
            }
            i++;
         }
      }
      
      public function isStatusGone(param1:String, param2:Object) : Boolean
      {
         var _loc3_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < param2.auras.length)
         {
            if(param2.auras[_loc3_].s != null && param2.auras[_loc3_].s == param1)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function isMoveOK(param1:Object) : Boolean
      {
         var isOK:Boolean = false;
         var aura:Object = null;
         var tLeaf:Object = param1;
         isOK = true;
         aura = {};
         if(tLeaf.auras != null)
         {
            for each(aura in tLeaf.auras)
            {
               try
               {
                  if(aura.cat != null)
                  {
                     if(aura.cat == "stun")
                     {
                        isOK = false;
                     }
                     if(aura.cat == "stone")
                     {
                        isOK = false;
                     }
                     if(aura.cat == "disabled")
                     {
                        isOK = false;
                     }
                  }
               }
               catch(e:Error)
               {
               }
            }
            return isOK;
         }
         return false;
      }
      
      public function wound(param1:*, param2:*) : *
      {
         var _loc3_:* = undefined;
         if(rootClass.litePreference.data.bDisDmgStrobe)
         {
            return;
         }
         if(param2 == "damage")
         {
            _loc3_ = new MovieClip();
            _loc3_.name = "flickermc";
            _loc3_.maxF = 3;
            _loc3_.curF = 0;
            _loc3_.addEventListener(Event.ENTER_FRAME,flickerFrame);
            if(param1.contains(_loc3_))
            {
               param1.flickermc.removeEventListener(Event.ENTER_FRAME,flickerFrame);
               param1.removeChild(_loc3_);
            }
            param1.addChild(_loc3_);
         }
      }
      
      public function flickerFrame(param1:Event) : *
      {
         var _loc2_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         if(_loc2_.parent != null && _loc2_.parent.stage != null)
         {
            if(_loc2_.curF == 0)
            {
               _loc2_.parent.modulateColor(avtWCT,"+");
            }
            if(_loc2_.curF == 1)
            {
               _loc2_.parent.modulateColor(avtWCT,"-");
            }
            if(_loc2_.curF == 2)
            {
               _loc2_.parent.modulateColor(avtWCT,"+");
            }
            if(_loc2_.curF >= _loc2_.maxF)
            {
               _loc2_.parent.modulateColor(avtWCT,"-");
               _loc2_.removeEventListener(Event.ENTER_FRAME,flickerFrame);
               _loc2_.parent.removeChild(_loc2_);
            }
            ++_loc2_.curF;
         }
         else
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,flickerFrame);
         }
      }
      
      public function unlockActionsExcept(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = [];
         _loc3_ = 0;
         _loc3_ = 0;
         while(_loc3_ < actions.active.length)
         {
            _loc5_ = actions.active[_loc3_];
            if(_loc5_)
            {
               if(_loc5_.ref != param1.ref && _loc5_.lock == true && _loc5_.ts < param1.ts)
               {
                  _loc6_ = 0;
                  while(_loc6_ < actionMap.length)
                  {
                     if(actionMap[_loc6_] == _loc5_.ref)
                     {
                        _loc2_.push("i" + (_loc6_ + 1));
                     }
                     _loc6_++;
                  }
               }
            }
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = rootClass.ui.mcInterface.actBar.getChildByName(_loc2_[_loc4_]);
            if(_loc7_.actObj != null)
            {
               _loc7_.actObj.lock = false;
            }
            _loc4_++;
         }
      }
      
      public function unlockActions() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < actions.active.length)
         {
            _loc2_ = actions.active[_loc1_];
            if(_loc2_)
            {
               _loc2_.lock = false;
            }
            _loc1_++;
         }
      }
      
      public function updateActBar() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(myAvatar != null && myAvatar.dataLeaf != null && myAvatar.dataLeaf.sta != null)
         {
            _loc1_ = 0;
            while(_loc1_ < rootClass.ui.mcInterface.actBar.numChildren)
            {
               _loc2_ = rootClass.ui.mcInterface.actBar.getChildAt(_loc1_);
               if("actObj" in _loc2_ && _loc2_.actObj != null)
               {
                  _loc3_ = _loc2_.actObj.skillLock;
                  _loc3_ = _loc3_ == null ? false : _loc3_;
                  if(myAvatar.dataLeaf.intMP >= Math.round(_loc2_.actObj.mp * myAvatar.dataLeaf.sta["$cmc"]) && !_loc3_)
                  {
                     if(_loc2_.cnt.alpha < 1)
                     {
                        _loc2_.cnt.alpha = 1;
                     }
                  }
                  else if(_loc2_.cnt.alpha == 1)
                  {
                     _loc2_.cnt.alpha = 0.4;
                  }
               }
               _loc1_++;
            }
         }
      }
      
      public function getActIcons(param1:Object) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:* = undefined;
         _loc2_ = [];
         _loc4_ = 0;
         while(_loc4_ < actionMap.length)
         {
            if(actionMap[_loc4_] == param1.ref)
            {
               _loc3_ = rootClass.ui.mcInterface.actBar.getChildByName("i" + (_loc4_ + 1)) as MovieClip;
               if(_loc3_ != null)
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function globalCoolDownExcept(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:MovieClip = null;
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         _loc2_ = Number(new Date().getTime());
         for each(_loc4_ in actions.active)
         {
            if(_loc4_)
            {
               _loc3_ = getActIcons(_loc4_)[0];
               if(_loc3_ != null)
               {
                  try
                  {
                     _loc5_ = Math.round(_loc4_.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha,-1),0.5)));
                     if(_loc4_ != param1 && _loc4_.ref != "aa" && (!("icon2" in _loc3_) || _loc3_.icon2 == null || _loc4_.ts + _loc5_ > _loc2_ && _loc4_.ts + _loc5_ - _loc2_ < GCD))
                     {
                        coolDownAct(_loc4_,GCD + 300,_loc2_);
                     }
                  }
                  catch(e:Error)
                  {
                     continue;
                  }
               }
            }
         }
         GCDTS = _loc2_;
      }
      
      public function checkCooldown(param1:Object) : *
      {
         var _loc2_:Array = null;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = getActIcons(param1);
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.icon2 != null)
            {
               _loc3_.bitmapData.dispose();
               _loc5_ = new BitmapData(50,50,true,0);
               _loc5_.draw(_loc3_,null,iconCT);
               _loc6_ = new Bitmap(_loc5_);
               _loc7_ = rootClass.ui.mcInterface.actBar.addChild(_loc6_);
               _loc3_.icon2 = _loc7_;
            }
            _loc4_++;
         }
      }
      
      public function coolDownAct(param1:Object, param2:int = -1, param3:Number = -1) : *
      {
         var _loc4_:Array = null;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:MovieClip = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:DisplayObject = null;
         _loc4_ = getActIcons(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc6_];
            _loc7_ = null;
            _loc8_ = null;
            if(_loc5_.icon2 == null)
            {
               _loc9_ = new BitmapData(50,50,true,0);
               _loc9_.draw(_loc5_,null,iconCT);
               _loc10_ = new Bitmap(_loc9_);
               _loc7_ = rootClass.ui.mcInterface.actBar.addChild(_loc10_);
               _loc5_.icon2 = _loc7_;
               if(param2 == -1)
               {
                  _loc12_ = rootClass.ui.mcInterface.actBar.addChild(new iconFlare());
                  _loc7_.transform = _loc12_.transform = _loc5_.transform;
                  _loc5_.ts = param1.ts;
                  _loc5_.cd = param1.cd;
               }
               else
               {
                  _loc7_.transform = _loc5_.transform;
                  _loc5_.ts = param3;
                  _loc5_.cd = param2;
               }
               _loc8_ = rootClass.ui.mcInterface.actBar.addChild(new ActMask()) as MovieClip;
               _loc8_.scaleX = 0.33;
               _loc8_.scaleY = 0.33;
               _loc8_.x = int(_loc7_.x + _loc7_.width / 2 - _loc8_.width / 2);
               _loc8_.y = int(_loc7_.y + _loc7_.height / 2 - _loc8_.height / 2);
               _loc11_ = 0;
               while(_loc11_ < 4)
               {
                  _loc8_["e" + _loc11_ + "oy"] = _loc8_["e" + _loc11_].y;
                  _loc11_++;
               }
               _loc7_.mask = _loc8_;
            }
            else
            {
               _loc7_ = _loc5_.icon2;
               _loc8_ = _loc7_.mask;
               if(param2 == -1)
               {
                  _loc5_.ts = param1.ts;
                  _loc5_.cd = param1.cd;
               }
               else
               {
                  _loc5_.ts = param3;
                  _loc5_.cd = param2;
               }
            }
            if(param2 == -1 && Boolean(rootClass.litePreference.data.bSkillCD))
            {
               switch(param1.ref)
               {
                  case "aa":
                     _loc5_.ref = "txtCD0";
                     break;
                  case "i1":
                     _loc5_.ref = "txtCD5";
                     break;
                  default:
                     _loc5_.ref = "txtCD" + param1.ref.slice(1);
               }
               rootClass.ui.mcInterface.actBar.setChildIndex(rootClass.ui.mcInterface.actBar.getChildByName(_loc5_.ref),rootClass.ui.mcInterface.actBar.numChildren - 1);
               rootClass.ui.mcInterface.actBar.getChildByName(_loc5_.ref).text = String(Number(_loc5_.cd / 1000).toFixed(1));
               rootClass.ui.mcInterface.actBar.getChildByName(_loc5_.ref).visible = true;
            }
            _loc8_.e0.stop();
            _loc8_.e1.stop();
            _loc8_.e2.stop();
            _loc8_.e3.stop();
            _loc5_.removeEventListener(Event.ENTER_FRAME,countDownAct);
            _loc5_.addEventListener(Event.ENTER_FRAME,countDownAct,false,0,true);
            _loc6_++;
         }
      }
      
      public function countDownAct(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         _loc2_ = new Date();
         _loc3_ = _loc2_.getTime();
         _loc4_ = MovieClip(param1.target);
         _loc5_ = _loc4_.icon2;
         _loc6_ = Math.round(_loc4_.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha,-1),0.5)));
         _loc7_ = (_loc3_ - _loc4_.ts) / _loc6_;
         _loc8_ = Math.floor(_loc7_ * 4);
         _loc9_ = int(_loc7_ * 360 % 90) + 1;
         if(!_loc4_.actObj.lock)
         {
            if(_loc7_ < 0.99)
            {
               if(_loc4_.ref)
               {
                  rootClass.ui.mcInterface.actBar.getChildByName(_loc4_.ref).text = String(Number(Number(1 - _loc7_) * (_loc6_ / 1000)).toFixed(1));
               }
               _loc10_ = 0;
               while(_loc10_ < 4)
               {
                  if(_loc10_ < _loc8_)
                  {
                     _loc5_.mask["e" + _loc10_].y = -300;
                  }
                  else
                  {
                     _loc5_.mask["e" + _loc10_].y = _loc5_.mask["e" + _loc10_ + "oy"];
                     if(_loc10_ > _loc8_)
                     {
                        _loc5_.mask["e" + _loc10_].gotoAndStop(0);
                     }
                  }
                  _loc10_++;
               }
               MovieClip(_loc5_.mask["e" + _loc8_]).gotoAndStop(_loc9_);
            }
            else
            {
               if(_loc4_.ref)
               {
                  rootClass.ui.mcInterface.actBar.getChildByName(_loc4_.ref).visible = false;
               }
               _loc11_ = _loc5_.mask;
               _loc5_.mask = null;
               _loc5_.parent.removeChild(_loc11_);
               _loc4_.removeEventListener(Event.ENTER_FRAME,countDownAct);
               _loc5_.parent.removeChild(_loc5_);
               _loc5_.bitmapData.dispose();
               _loc4_.icon2 = null;
            }
         }
      }
      
      public function healByIcon(param1:Avatar) : void
      {
         var _loc2_:Object = null;
         _loc2_ = getFirstHeal();
         if(_loc2_ != null)
         {
            setTarget(param1);
            testAction(_loc2_);
         }
      }
      
      public function getFirstHeal() : Object
      {
         var _loc1_:* = undefined;
         try
         {
            _loc1_ = 0;
            while(_loc1_ < actions.active.length)
            {
               if(actions.active[_loc1_] != null && actions.active[_loc1_].damage != null && actions.active[_loc1_].damage < 0 && Boolean(actions.active[_loc1_].isOK))
               {
                  return actions.active[_loc1_];
               }
               _loc1_++;
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function AATest(param1:Event) : *
      {
      }
      
      public function connTest(param1:Event) : *
      {
      }
      
      internal function checkSP(param1:int, param2:Object) : Boolean
      {
         var _loc3_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < param2.auras.length)
         {
            if(param2.auras[_loc3_].nam == "Spirit Power")
            {
               if(param1 <= param2.auras[_loc3_].val)
               {
                  return true;
               }
               return false;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function acceptQuest(param1:int) : void
      {
         if(questTree[param1] == null)
         {
            getQuests([param1]);
         }
         if(questTree[param1].status == null)
         {
            questTree[param1].status = "p";
            rootClass.ui.mcQTracker.updateQuest();
         }
         if(!rootClass.ui.mcQTracker.visible)
         {
            rootClass.ui.mcQTracker.toggle();
         }
         rootClass.sfc.sendXtMessage("zm","acceptQuest",[param1],"str",curRoom);
      }
      
      public function tryQuestComplete(param1:int, param2:int = -1, param3:Boolean = false, param4:int = 1) : void
      {
         rootClass.sfc.sendXtMessage("zm","tryQuestComplete",[param1,param2,param3,param4,"wvz"],"str",curRoom);
      }
      
      public function getMapItem(param1:int) : void
      {
         if(coolDown("getMapItem"))
         {
            rootClass.sfc.sendXtMessage("zm","getMapItem",[param1],"str",curRoom);
         }
      }
      
      public function isQuestInProgress(param1:int) : Boolean
      {
         return questTree[param1] != null && questTree[param1].status != null;
      }
      
      public function getQuests(param1:Array) : void
      {
         rootClass.sfc.sendXtMessage("zm","getQuests",param1,"str",curRoom);
      }
      
      public function getQuest(param1:int) : void
      {
      }
      
      public function showQuestList(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         if(!rootClass.isGreedyModalInStack())
         {
            rootClass.clearPopupsQ();
            _loc4_ = rootClass.attachOnModalStack("QFrameMC");
            _loc5_ = param2.split(",");
            _loc6_ = param3.split(",");
            _loc4_.sIDs = _loc5_;
            _loc4_.tIDs = _loc6_;
            _loc4_.world = this;
            _loc4_.rootClass = rootClass;
            _loc4_.qMode = param1;
            _loc7_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               _loc9_ = _loc5_[_loc8_];
               if(questTree[_loc9_] == null)
               {
                  _loc7_.push(_loc9_);
               }
               else if(questTree[_loc9_].strDynamic != null)
               {
                  questTree[_loc9_] = null;
                  delete questTree[_loc9_];
                  _loc7_.push(_loc9_);
               }
               _loc8_++;
            }
            if(_loc7_.length > 0 && param2 != "")
            {
               getQuests(_loc7_);
            }
            else
            {
               _loc4_.open();
            }
         }
      }
      
      public function getApop(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         if(int(param1) < 1)
         {
            return;
         }
         if(rootClass.curID != param1)
         {
            rootClass.curID = param1;
            rootClass.sfc.sendXtMessage("zm","getApop",[param1],"str",curRoom);
            return;
         }
         _loc2_ = rootClass.apopTree[param1];
         _loc3_ = new Array();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.arrScenes.length)
         {
            _loc4_ = _loc2_.arrScenes[_loc5_];
            if(_loc4_.qID == null)
            {
               if(_loc4_.arrQuests != null)
               {
                  _loc6_ = String(_loc4_.arrQuests).split(",");
                  _loc7_ = 0;
                  while(_loc7_ < _loc6_.length)
                  {
                     if(questTree[_loc6_[_loc7_]] == null)
                     {
                        _loc3_.push(_loc6_[_loc7_]);
                        rootClass.quests = true;
                     }
                     else if(questTree[_loc6_[_loc7_]].strDynamic != null)
                     {
                        questTree[_loc6_[_loc7_]] = null;
                        delete questTree[_loc6_[_loc7_]];
                        _loc3_.push(_loc6_[_loc7_]);
                        rootClass.quests = true;
                     }
                     _loc7_++;
                  }
               }
            }
            else if(questTree[_loc4_.qID] == null)
            {
               _loc3_.push(_loc4_.qID);
               rootClass.quests = true;
            }
            else if(questTree[_loc4_.qID].strDynamic != null)
            {
               questTree[_loc4_.qID] = null;
               delete questTree[_loc4_.qID];
               _loc3_.push(_loc4_.qID);
               rootClass.quests = true;
            }
            _loc5_++;
         }
         if(_loc3_.length > 0)
         {
            rootClass.quests = true;
            rootClass.sfc.sendXtMessage("zm","getQuests2",_loc3_,"str",curRoom);
         }
         else
         {
            rootClass.quests = false;
            rootClass.createApop();
         }
      }
      
      public function showQuests(param1:String, param2:String) : void
      {
         showQuestList(param2,param1,param1);
      }
      
      public function showQuestLink(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc2_ = "$({";
         _loc3_ = "})$";
         _loc4_ = "";
         if(param1.unm.toLowerCase() != rootClass.sfc.myUserName)
         {
            _loc4_ += param1.unm + " issues a Call to Arms for " + _loc2_;
            _loc4_ = _loc4_ + ["quest",param1.quest.sName,param1.quest.QuestID,param1.quest.iLvl,param1.unm].toString();
            _loc4_ = _loc4_ + (_loc3_ + "!");
         }
         else
         {
            _loc4_ += "You issue a Call to Arms for " + param1.quest.sName + "!";
         }
         rootClass.chatF.pushMsg("event",_loc4_,"SERVER","",0);
      }
      
      public function getActiveQuests() : String
      {
         var _loc1_:String = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = "";
         for(_loc2_ in questTree)
         {
            _loc3_ = questTree[_loc2_];
            if(_loc3_.status != null)
            {
               if(_loc1_.length)
               {
                  _loc1_ += "," + _loc2_;
               }
               else
               {
                  _loc1_ += _loc2_;
               }
            }
         }
         return _loc1_;
      }
      
      public function checkAllQuestStatus(param1:* = null) : *
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         _loc2_ = [];
         if(param1 != null)
         {
            _loc2_ = [String(param1)];
         }
         else
         {
            for(_loc3_ in questTree)
            {
               _loc2_.push(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = questTree[_loc3_];
            _loc5_ = {};
            if(_loc4_.status != null)
            {
               if(_loc4_.turnin != null && _loc4_.turnin.length > 0)
               {
                  _loc5_.sItems = true;
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_.turnin.length)
                  {
                     _loc8_ = _loc4_.turnin[_loc7_].ItemID;
                     _loc9_ = _loc4_.turnin[_loc7_].iQty;
                     if(invTree[_loc8_] == null || invTree[_loc8_].iQty < _loc9_)
                     {
                        _loc5_.sItems = false;
                        break;
                     }
                     _loc7_++;
                  }
               }
               if(_loc4_.iTime != null)
               {
                  _loc5_.iTime = false;
                  if(_loc4_.ts != null)
                  {
                     _loc10_ = new Date();
                     if(_loc10_.getTime() - _loc4_.ts <= _loc4_.iTime)
                     {
                        _loc5_.iTime = true;
                     }
                  }
               }
               _loc4_.status = "c";
               for(_loc6_ in _loc5_)
               {
                  if(_loc5_[_loc6_] == false)
                  {
                     _loc4_.status = "p";
                  }
               }
            }
         }
         rootClass.ui.mcQTracker.updateQuest();
      }
      
      public function updateQuestProgress(param1:String, param2:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         for(_loc3_ in questTree)
         {
            _loc4_ = questTree[_loc3_];
            _loc5_ = {};
            if(_loc4_.status != null)
            {
               if(rootClass.litePreference.data.bQuestNotif)
               {
                  if(param1 == "item" && _loc4_.turnin != null && _loc4_.turnin.length > 0)
                  {
                     _loc5_.sItems = true;
                     _loc6_ = 0;
                     while(_loc6_ < _loc4_.turnin.length)
                     {
                        _loc7_ = _loc4_.turnin[_loc6_].ItemID;
                        _loc8_ = _loc4_.turnin[_loc6_].iQty;
                        if(param2.ItemID == _loc7_ && invTree[_loc7_] != null && invTree[_loc7_].iQty > _loc8_)
                        {
                           _loc9_ = invTree[_loc7_];
                           rootClass.ui.mcQTracker.updateQuest();
                           rootClass.addUpdate(_loc4_.sName + ": " + _loc9_.sName + " " + invTree[_loc7_].iQty + "/" + _loc8_);
                        }
                        _loc6_++;
                     }
                  }
               }
            }
            if(_loc4_.status != null && _loc4_.status == "p")
            {
               if(param1 == "item" && _loc4_.turnin != null && _loc4_.turnin.length > 0)
               {
                  _loc5_.sItems = true;
                  _loc6_ = 0;
                  while(_loc6_ < _loc4_.turnin.length)
                  {
                     _loc7_ = _loc4_.turnin[_loc6_].ItemID;
                     _loc8_ = _loc4_.turnin[_loc6_].iQty;
                     if(param2.ItemID == _loc7_ && invTree[_loc7_] != null && invTree[_loc7_].iQty <= _loc8_)
                     {
                        _loc9_ = invTree[_loc7_];
                        rootClass.addUpdate(_loc4_.sName + ": " + _loc9_.sName + " " + invTree[_loc7_].iQty + "/" + _loc8_);
                     }
                     _loc6_++;
                  }
               }
               checkAllQuestStatus(_loc3_);
               if(_loc4_.status == "c")
               {
                  rootClass.addUpdate(_loc4_.sName + " complete!");
                  rootClass.mixer.playSound("Good");
               }
            }
         }
      }
      
      public function canTurnInQuest(param1:int) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = questTree[param1];
         if(_loc2_.turnin != null && _loc2_.turnin.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.turnin.length)
            {
               _loc4_ = _loc2_.turnin[_loc3_].ItemID;
               _loc5_ = _loc2_.turnin[_loc3_].iQty;
               if(invTree[_loc4_] == null || invTree[_loc4_].iQty < _loc5_)
               {
                  return false;
               }
               if(myAvatar.isItemEquipped(_loc4_))
               {
                  rootClass.MsgBox.notify("Cannot turn in equipped item(s)!");
                  return false;
               }
               _loc3_++;
            }
         }
         return true;
      }
      
      public function maximumQuestTurnIns(param1:int) : int
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = -1;
         _loc3_ = questTree[param1];
         if(_loc3_.turnin != null && _loc3_.turnin.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.turnin.length)
            {
               _loc5_ = _loc3_.turnin[_loc4_].ItemID;
               _loc6_ = _loc3_.turnin[_loc4_].iQty;
               if(invTree[_loc5_] == null || invTree[_loc5_].iQty < _loc6_)
               {
                  return 0;
               }
               if(myAvatar.isItemEquipped(_loc5_))
               {
                  rootClass.MsgBox.notify("Cannot turn in equipped item(s)!");
                  return 0;
               }
               _loc7_ = Math.floor(invTree[_loc5_].iQty / _loc6_);
               if(_loc2_ == -1 || _loc2_ > _loc7_)
               {
                  _loc2_ = _loc7_;
               }
               _loc4_++;
            }
         }
         return Math.min(_loc2_,250);
      }
      
      public function abandonQuest(param1:int) : void
      {
         questTree[param1].status = null;
         rootClass.ui.mcQTracker.updateQuest();
      }
      
      public function completeQuest(param1:int) : void
      {
         if(questTree[param1] != null)
         {
            questTree[param1].status = null;
            rootClass.ui.mcQTracker.updateQuest();
         }
      }
      
      public function toggleQuestLog() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = rootClass.getInstanceFromModalStack("QFrameMC");
         if(_loc1_ == null)
         {
            if(rootClass.litePreference.data.bQuestLog)
            {
               showQuests(getActiveQuests(),"q");
            }
            else
            {
               showQuests("","l");
            }
         }
         else
         {
            _loc1_.open();
         }
      }
      
      public function isPartyMember(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         param1 = param1.toLowerCase();
         if(param1 != rootClass.sfc.myUserName)
         {
            _loc2_ = 0;
            while(_loc2_ < partyMembers.length)
            {
               if(partyMembers[_loc2_].toLowerCase() == param1)
               {
                  return true;
               }
               _loc2_++;
            }
         }
         return false;
      }
      
      public function doPartyAccept(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","gp",["pa",param1.pid],"str",1);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","gp",["pd",param1.pid],"str",1);
         }
      }
      
      public function doCTAAccept(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","gp",["ctaa",param1.unm],"str",1);
            showQuests(param1.QuestID,"q");
         }
      }
      
      public function doCTAClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:ModalMC = null;
         var _loc4_:Object = null;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = new ModalMC();
         _loc4_ = {};
         _loc4_.strBody = "Would you like to join the next avabilable party for " + _loc2_.sName + "?";
         _loc4_.callback = doCTAAccept;
         _loc4_.params = {
            "QuestID":_loc2_.QuestID,
            "unm":_loc2_.unm
         };
         _loc4_.btns = "dual";
         rootClass.ui.ModalStack.addChild(_loc3_);
         _loc3_.init(_loc4_);
      }
      
      public function addPartyMember(param1:String) : *
      {
         partyMembers.push(param1.toLowerCase());
         updatePartyFrame();
      }
      
      public function removePartyMember(param1:String) : *
      {
         var _loc2_:* = undefined;
         if(param1.toLowerCase() != rootClass.sfc.myUserName.toLowerCase())
         {
            _loc2_ = partyMembers.indexOf(param1.toLowerCase());
            if(_loc2_ > -1)
            {
               partyMembers.splice(_loc2_,1);
            }
         }
         else
         {
            partyID = -1;
            partyOwner = "";
            partyMembers = [];
         }
         updatePartyFrame();
      }
      
      public function updatePartyFrame(param1:Object = null) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         _loc2_ = null;
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = null;
         _loc6_ = 0;
         _loc7_ = null;
         _loc8_ = [];
         _loc9_ = true;
         _loc10_ = false;
         if(param1 != null && param1.range != null && param1.range == false)
         {
            _loc9_ = false;
         }
         if(param1 != null)
         {
            _loc8_ = [param1.unm.toLowerCase()];
         }
         else
         {
            _loc10_ = true;
            _loc8_ = partyMembers;
         }
         if(_loc8_.length > 0)
         {
            _loc11_ = "";
            if(param1 == null)
            {
               _loc12_ = [];
               _loc6_ = 0;
               _loc6_ = 0;
               while(_loc6_ < rootClass.ui.mcPartyFrame.numChildren)
               {
                  _loc12_.push(MovieClip(rootClass.ui.mcPartyFrame.getChildAt(_loc6_)));
                  _loc6_++;
               }
               _loc6_ = 0;
               _loc6_ = 0;
               while(_loc6_ < _loc12_.length)
               {
                  _loc2_ = _loc12_[_loc6_];
                  _loc13_ = _loc2_.strName.text;
                  if(partyMembers.indexOf(_loc13_) == -1)
                  {
                     _loc2_.removeEventListener(MouseEvent.CLICK,onPartyPanelClick);
                     rootClass.ui.mcPartyFrame.removeChild(_loc2_);
                  }
                  _loc6_++;
               }
            }
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc11_ = _loc8_[_loc6_];
               _loc2_ = getPartyPanelByName(_loc11_);
               _loc7_ = uoTree[_loc11_.toLowerCase()];
               if(_loc7_ == null)
               {
                  _loc2_.HP.visible = false;
                  _loc2_.MP.visible = false;
                  _loc2_.txtRange.visible = true;
               }
               else if(_loc9_)
               {
                  _loc3_ = int(_loc7_.intHP);
                  _loc4_ = int(_loc7_.intHPMax);
                  _loc5_ = _loc2_.HP;
                  if(_loc3_ >= 0)
                  {
                     _loc5_.strIntHP.text = String(_loc7_.intHP);
                  }
                  else
                  {
                     _loc5_.strIntHP.text = "X";
                  }
                  if(_loc3_ < 0)
                  {
                     _loc3_ = 0;
                  }
                  _loc5_.intHPbar.x = -(_loc5_.intHPbar.width * (1 - _loc3_ / _loc4_));
                  _loc3_ = int(_loc7_.intMP);
                  _loc4_ = int(_loc7_.intMPMax);
                  _loc5_ = _loc2_.MP;
                  if(_loc3_ >= 0)
                  {
                     _loc5_.strIntMP.text = String(_loc7_.intMP);
                  }
                  else
                  {
                     _loc5_.strIntMP.text = "X";
                  }
                  if(_loc3_ < 0)
                  {
                     _loc3_ = 0;
                  }
                  _loc5_.intMPbar.x = -(_loc5_.intMPbar.width * (1 - _loc3_ / _loc4_));
                  _loc2_.HP.visible = true;
                  _loc2_.MP.visible = true;
                  _loc2_.txtRange.visible = false;
               }
               else
               {
                  _loc2_.HP.visible = false;
                  _loc2_.MP.visible = false;
                  _loc2_.txtRange.visible = true;
               }
               if(_loc10_)
               {
                  _loc2_.y = int((_loc2_.height + 2) * _loc6_);
               }
               _loc2_.partyLead.visible = _loc11_.toLowerCase() == partyOwner.toLowerCase();
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(rootClass.ui.mcPartyFrame.numChildren > 0 && _loc6_ < 10)
            {
               _loc2_ = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(0));
               _loc2_.removeEventListener(MouseEvent.CLICK,onPartyPanelClick);
               rootClass.ui.mcPartyFrame.removeChildAt(0);
               _loc6_++;
            }
         }
         rootClass.ui.mcPortrait.partyLead.visible = partyOwner.toLowerCase() == rootClass.sfc.myUserName;
      }
      
      public function createPartyPanel(param1:Object) : MovieClip
      {
         var _loc3_:* = undefined;
         var _loc2_:* = rootClass.ui.mcPartyFrame.numChildren + 1;
         _loc3_ = MovieClip(rootClass.ui.mcPartyFrame.addChild(new PartyPanel()));
         _loc3_.strName.text = param1.unm;
         _loc3_.HP.visible = false;
         _loc3_.MP.visible = false;
         _loc3_.txtRange.visible = false;
         _loc3_.addEventListener(MouseEvent.CLICK,onPartyPanelClick,false,0,true);
         _loc3_.buttonMode = true;
         return _loc3_;
      }
      
      public function getPartyPanelByName(param1:String) : MovieClip
      {
         var _loc2_:* = undefined;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc2_ = rootClass.ui.mcPartyFrame.numChildren;
         _loc3_ = null;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(_loc4_));
            if(_loc3_.strName.text == param1.toLowerCase())
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return createPartyPanel({"unm":param1.toLowerCase()});
      }
      
      public function onPartyPanelClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Avatar = null;
         _loc2_ = MovieClip(param1.currentTarget);
         _loc3_ = {};
         _loc3_.strUsername = _loc2_.strName.text;
         if(param1.shiftKey)
         {
            _loc4_ = getAvatarByUserName(_loc3_.strUsername.toLowerCase());
            if(_loc4_ != null && _loc4_.pMC != null && _loc4_.dataLeaf != null && _loc4_.dataLeaf.strFrame == myAvatar.dataLeaf.strFrame)
            {
               setTarget(_loc4_);
            }
         }
         else
         {
            rootClass.ui.cMenu.fOpenWith("party",_loc3_);
         }
      }
      
      public function partyInvite(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","gp",["pi",param1],"str",1);
      }
      
      public function partyKick(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","gp",["pk",param1],"str",1);
      }
      
      public function partyLeave() : void
      {
         rootClass.sfc.sendXtMessage("zm","gp",["pl"],"str",1);
      }
      
      public function partySummon(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","gp",["ps",param1],"str",1);
      }
      
      public function acceptPartySummon(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","gp",["psa"],"str",1);
            if(param1.strF == null)
            {
               rootClass.sfc.sendXtMessage("zm","cmd",["goto",param1.unm],"str",1);
            }
            else
            {
               moveToCell(param1.strF,param1.strP);
            }
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","gp",["psd",param1.unm],"str",1);
         }
      }
      
      public function partyUpdate(param1:String, param2:String) : void
      {
      }
      
      public function partyPromote(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","gp",["pp",param1],"str",1);
      }
      
      public function goto(param1:*) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         param1 = param1.toLowerCase();
         _loc2_ = uoTree[rootClass.sfc.myUserName];
         _loc3_ = uoTree[String(param1).toLowerCase()];
         if(_loc2_.intState == 1 && (_loc2_.pvpTeam == null || _loc2_.pvpTeam == -1))
         {
            if(_loc3_ != null && _loc2_.uoName != _loc3_.uoName)
            {
               if("nogoto" in map && Boolean(map.nogoto))
               {
                  rootClass.chatF.pushMsg("warning","/goto can\'t target players within this map.","SERVER","",0);
                  return;
               }
               if(_loc2_.strFrame != _loc3_.strFrame)
               {
                  moveToCell(_loc3_.strFrame,_loc3_.strPad);
               }
            }
            else
            {
               rootClass.sfc.sendXtMessage("zm","cmd",["goto",param1],"str",1);
            }
         }
      }
      
      public function pull(param1:*) : *
      {
         param1 = param1.toLowerCase();
         rootClass.sfc.sendXtMessage("zm","cmd",["pull",param1],"str",1);
      }
      
      public function requestFriend(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","requestFriend",[param1],"str",1);
      }
      
      public function addFriend(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","addFriend",[param1.unm],"str",1);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","declineFriend",[param1.unm],"str",1);
         }
      }
      
      public function deleteFriend(param1:int, param2:*) : void
      {
         rootClass.sfc.sendXtMessage("zm","deleteFriend",[param1,param2],"str",1);
      }
      
      public function guildInvite(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","guild",["gi",param1],"str",1);
      }
      
      public function guildRemove(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","guild",["gr",param1.userName],"str",1);
         }
      }
      
      public function guildPromote(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","guild",["gp",param1],"str",1);
      }
      
      public function guildDemote(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","guild",["gd",param1],"str",1);
      }
      
      public function doGuildAccept(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","guild",["ga",param1.guildID,param1.owner],"str",1);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","guild",["gdi",param1.guildID,param1.owner],"str",1);
         }
      }
      
      public function setGuildMOTD(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","guild",["motd",param1],"str",1);
      }
      
      public function createGuild(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","guild",["gc",param1.guildName],"str",1);
         }
      }
      
      public function addMemSlots(param1:int) : void
      {
         rootClass.sfc.sendXtMessage("zm","guild",["slots",param1],"str",1);
      }
      
      public function renameGuild(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","guild",["rename",param1.guildName],"str",1);
         }
      }
      
      public function requestPVPQueue(param1:String, param2:int = -1) : void
      {
         rootClass.sfc.sendXtMessage("zm","PVPQr",[param1,param2],"str",rootClass.world.curRoom);
      }
      
      public function handlePVPQueue(param1:Object) : void
      {
         var _loc2_:MovieClip = null;
         if(param1.bitSuccess == 1)
         {
            PVPQueue.warzone = param1.warzone;
            PVPQueue.ts = new Date().getTime();
            PVPQueue.avgWait = param1.avgWait;
            rootClass.showMCPVPQueue();
         }
         else
         {
            PVPQueue.warzone = "";
            PVPQueue.ts = -1;
            PVPQueue.avgWait = -1;
            rootClass.hideMCPVPQueue();
         }
         _loc2_ = rootClass.ui.mcPopup;
         if(_loc2_.currentLabel == "PVPPanel" && _loc2_.mcPVPPanel != null)
         {
            _loc2_.mcPVPPanel.updateBody();
         }
         rootClass.closeModalByStrBody("A new Warzone battle has started!");
      }
      
      public function updatePVPAvgWait(param1:int) : void
      {
         PVPQueue.avgWait = param1;
      }
      
      public function duelExpire() : *
      {
         rootClass.closeModalByStrBody("has challenged you to a duel.");
      }
      
      public function receivePVPInvite(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = new ModalMC();
         _loc3_ = {};
         _loc4_ = getWarzoneByWarzoneName(param1.warzone);
         _loc3_.strBody = "A new Warzone battle has started!  Will you join " + _loc4_.nam + "?";
         _loc3_.greedy = true;
         _loc3_.params = {};
         _loc3_.callback = replyToPVPInvite;
         rootClass.ui.ModalStack.addChild(_loc2_);
         rootClass.ui.mcPopup.onClose();
         rootClass.hideMCPVPQueue();
         _loc2_.init(_loc3_);
      }
      
      public function replyToPVPInvite(param1:Object) : void
      {
         if(param1.accept)
         {
            sendPVPInviteAccept();
         }
         else
         {
            sendPVPInviteDecline();
         }
      }
      
      public function sendPVPInviteAccept() : void
      {
         rootClass.sfc.sendXtMessage("zm","PVPIr",["1"],"str",rootClass.world.curRoom);
      }
      
      public function sendPVPInviteDecline() : void
      {
         rootClass.sfc.sendXtMessage("zm","PVPIr",["0"],"str",rootClass.world.curRoom);
      }
      
      public function sendDuelInvite(param1:String) : void
      {
         rootClass.sfc.sendXtMessage("zm","duel",[param1],"str",1);
      }
      
      public function doDuelAccept(param1:Object) : void
      {
         if(param1.accept)
         {
            rootClass.sfc.sendXtMessage("zm","da",[param1.unm],"str",1);
         }
         else
         {
            rootClass.sfc.sendXtMessage("zm","dd",[param1.unm],"str",1);
         }
      }
      
      public function getWarzoneByName(param1:String) : *
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < PVPMaps.length)
         {
            if(PVPMaps[_loc2_].nam == param1)
            {
               return PVPMaps[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getWarzoneByWarzoneName(param1:String) : *
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < PVPMaps.length)
         {
            if(PVPMaps[_loc2_].warzone == param1)
            {
               return PVPMaps[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setPVPFactionData(param1:Array) : void
      {
         if(param1 != null)
         {
            PVPFactions = param1;
         }
         else
         {
            PVPFactions = [];
         }
      }
      
      public function attachMovieFront(param1:*) : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Class = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = ldr_map.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
         _loc4_ = true;
         if(FG.numChildren)
         {
            _loc2_ = MovieClip(FG.getChildAt(0));
            _loc5_ = _loc2_.constructor as Class;
            if(_loc5_ == _loc3_)
            {
               _loc4_ = false;
            }
         }
         if(_loc4_)
         {
            removeMovieFront();
            _loc2_ = MovieClip(FG.addChild(new _loc3_()));
            FG.mouseChildren = true;
         }
         return _loc2_;
      }
      
      public function attachMovieFrontMenu(param1:*) : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Class = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = getClass(param1) as Class;
         _loc4_ = true;
         if(FG.numChildren)
         {
            _loc2_ = MovieClip(FG.getChildAt(0));
            _loc5_ = _loc2_.constructor as Class;
            if(_loc5_ == _loc3_)
            {
               _loc4_ = false;
            }
         }
         if(_loc4_)
         {
            removeMovieFront();
            _loc2_ = MovieClip(FG.addChild(new _loc3_()));
            FG.mouseChildren = true;
         }
         return _loc2_;
      }
      
      public function removeMovieFront() : *
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(FG.numChildren > 0 && _loc1_ < 100)
         {
            _loc1_++;
            FG.removeChildAt(0);
         }
         rootClass.ldrMC.closeHistory();
         rootClass.stage.focus = null;
      }
      
      public function getMovieFront() : *
      {
         if(FG.numChildren > 0 && FG.getChildAt(0) != null)
         {
            return FG.getChildAt(0);
         }
         return null;
      }
      
      public function isMovieFront(param1:String) : Boolean
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Class = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = ldr_map.contentLoaderInfo.applicationDomain.getDefinition(param1) as Class;
         _loc4_ = false;
         if(FG.numChildren)
         {
            _loc2_ = MovieClip(FG.getChildAt(0));
            _loc5_ = _loc2_.constructor as Class;
            if(_loc5_ == _loc3_)
            {
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function loadMovieFront(param1:String, param2:String = "Game Files") : void
      {
         removeMovieFront();
         rootClass.ldrMC.loadFile(FG,param1,param2);
      }
      
      public function showPreL() : *
      {
         if(preLMC == null || !MovieClip(this).contains(preLMC))
         {
            preLMC = new PreL();
            addChild(preLMC);
            preLMC.x = 960 / 2 - preLMC.width / 2;
            preLMC.y = 550 / 2 - preLMC.height / 2;
         }
      }
      
      public function toggleFPS() : void
      {
         rootClass.ui.mcFPS.visible = !rootClass.ui.mcFPS.visible;
      }
      
      private function calculateFPS() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         try
         {
            if(fpsTS != 0)
            {
               _loc1_ = Number(new Date().getTime());
               _loc2_ = _loc1_ - fpsTS;
               _loc3_ = 0;
               if(ticklist.length == TICK_MAX)
               {
                  _loc3_ = int(ticklist.shift());
               }
               ticklist.push(_loc2_);
               ticksum = ticksum + _loc2_ - _loc3_;
               _loc4_ = 1000 / (ticksum / ticklist.length);
               if(rootClass.ui.mcFPS.visible)
               {
                  rootClass.ui.mcFPS.txtFPS.text = _loc4_.toPrecision(4);
               }
               if(rootClass.userPreference.data.quality == "AUTO" && ticklist.length == TICK_MAX && ++fpsQualityCounter % 24 == 0)
               {
                  fpsArrayQuality.push(_loc4_);
                  if(fpsArrayQuality.length == 5)
                  {
                     _loc5_ = 0;
                     _loc6_ = 0;
                     while(_loc6_ < fpsArrayQuality.length)
                     {
                        _loc5_ += fpsArrayQuality[_loc6_];
                        _loc6_++;
                     }
                     _loc7_ = _loc5_ / fpsArrayQuality.length;
                     _loc8_ = int(arrQuality.indexOf(rootClass.stage.quality));
                     if(_loc7_ < 12 && _loc8_ > 0)
                     {
                        rootClass.stage.quality = arrQuality[_loc8_ - 1];
                     }
                     if(_loc7_ >= 12 && _loc8_ < 2)
                     {
                        rootClass.stage.quality = arrQuality[_loc8_ + 1];
                     }
                     fpsArrayQuality = new Array();
                  }
               }
            }
            fpsTS = new Date().getTime();
         }
         catch(e:*)
         {
         }
      }
      
      public function onZmanagerEnterFrame(param1:Event) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:Number = NaN;
         calculateFPS();
         zSortArr = [];
         _loc3_ = 0;
         while(_loc3_ < CHARS.numChildren)
         {
            _loc2_ = MovieClip(CHARS.getChildAt(_loc3_));
            zSortArr.push({
               "mc":_loc2_,
               "oy":_loc2_.y
            });
            _loc3_++;
         }
         zSortArr.sortOn("oy",Array.NUMERIC);
         _loc4_ = 0;
         while(_loc4_ < zSortArr.length)
         {
            _loc2_ = zSortArr[_loc4_].mc;
            _loc7_ = CHARS.getChildIndex(_loc2_);
            if(_loc7_ != _loc4_)
            {
               CHARS.swapChildrenAt(_loc7_,_loc4_);
            }
            _loc4_++;
         }
         if(strMapName == "trickortreat" && strFrame == "Enter")
         {
            if(CHARS.getChildByName("mcPlayerNPCTrickOrTreat"))
            {
               CHARS.setChildIndex(CHARS.getChildByName("mcPlayerNPCTrickOrTreat"),CHARS.numChildren - 1);
            }
            else
            {
               try
               {
                  _loc8_ = getMonsters(1)[0].pMC;
                  if(_loc8_)
                  {
                     CHARS.setChildIndex(_loc8_,CHARS.numChildren - 1);
                  }
               }
               catch(e:*)
               {
               }
            }
         }
         else if(strMapName == "caroling" && strFrame == "Enter")
         {
            if(CHARS.getChildByName("mcPlayerNPCCaroling"))
            {
               CHARS.setChildIndex(CHARS.getChildByName("mcPlayerNPCCaroling"),CHARS.numChildren - 1);
            }
            else
            {
               try
               {
                  _loc9_ = getMonsters(1)[0].pMC;
                  if(_loc9_)
                  {
                     CHARS.setChildIndex(_loc9_,CHARS.numChildren - 1);
                  }
               }
               catch(e:*)
               {
               }
            }
         }
         if(EFAO.xpc++ > EFAO.xpn)
         {
            EFAO.xpc = 0;
            try
            {
               if(rootClass.stage == null)
               {
                  killTimers();
                  killListeners();
                  return;
               }
               _loc10_ = Number(new Date().getTime());
               if(rootClass.stage != null && myAvatar.objData.iBoostXP != null)
               {
                  if(rootClass.ui.mcPortrait.iconBoostXP.boostTS + rootClass.ui.mcPortrait.iconBoostXP.iBoostXP * 1000 < _loc10_ + 1000)
                  {
                     rootClass.sfc.sendXtMessage("zm","serverUseItem",["-","xpboost"],"str",-1);
                  }
               }
               if(rootClass.stage != null && myAvatar.objData.iBoostG != null)
               {
                  if(rootClass.ui.mcPortrait.iconBoostG.boostTS + rootClass.ui.mcPortrait.iconBoostG.iBoostG * 1000 < _loc10_ + 1000)
                  {
                     rootClass.sfc.sendXtMessage("zm","serverUseItem",["-","gboost"],"str",-1);
                  }
               }
               if(rootClass.stage != null && myAvatar.objData.iBoostRep != null)
               {
                  if(rootClass.ui.mcPortrait.iconBoostRep.boostTS + rootClass.ui.mcPortrait.iconBoostRep.iBoostRep * 1000 < _loc10_ + 1000)
                  {
                     rootClass.sfc.sendXtMessage("zm","serverUseItem",["-","repboost"],"str",-1);
                  }
               }
               if(rootClass.stage != null && myAvatar.objData.iBoostCP != null)
               {
                  if(rootClass.ui.mcPortrait.iconBoostCP.boostTS + rootClass.ui.mcPortrait.iconBoostCP.iBoostCP * 1000 < _loc10_ + 1000)
                  {
                     rootClass.sfc.sendXtMessage("zm","serverUseItem",["-","cpboost"],"str",-1);
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         if(!combatDisplayTime)
         {
            combatDisplayTime = new Date().time;
         }
         _loc5_ = new Date().time;
         _loc6_ = false;
         if(_loc5_ - combatDisplayTime >= 250)
         {
            if(actionResults.length > 0)
            {
               showActionImpact(actionResults.shift());
               _loc6_ = true;
            }
            if(actionResultsAura.length > 0)
            {
               showAuraImpact(actionResultsAura.shift());
               _loc6_ = true;
            }
            if(actionResultsMon.length > 0)
            {
               showActionImpact(actionResultsMon.shift());
               _loc6_ = true;
            }
            if(_loc6_)
            {
               combatDisplayTime = new Date().time;
            }
         }
      }
      
      public function iaTrigger(param1:MovieClip) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         if(coolDown("doIA"))
         {
            _loc2_ = [];
            _loc2_.push(param1.iaType);
            _loc2_.push(param1.name);
            if("iaPathMC" in param1)
            {
               _loc2_.push(myAvatar.dataLeaf.strFrame);
            }
            else
            {
               _loc2_.push(param1.iaFrame);
            }
            if("iaStr" in param1)
            {
               _loc2_.push(param1.iaStr);
            }
            if("iaPathMC" in param1)
            {
               _loc2_.push(param1.iaPathMC);
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc3_++;
            }
            rootClass.sfc.sendXtMessage("zm","ia",_loc2_,"str",1);
         }
      }
      
      public function actCastRequest(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         _loc2_ = ["castr"];
         _loc3_ = [];
         switch(param1.typ)
         {
            case "sia":
               if(coolDown("doIA"))
               {
                  _loc4_ = {};
                  _loc4_.typ = "sia";
                  _loc4_.callback = actCastTrigger;
                  _loc4_.args = param1;
                  _loc4_.dur = Number(param1.sAccessCD);
                  _loc4_.txt = param1.sMsg;
                  rootClass.ui.mcCastBar.fOpenWith(_loc4_);
                  _loc3_.push(1);
                  _loc3_.push(param1.ID);
               }
         }
         if(_loc3_.length > 0)
         {
            rootClass.sfc.sendXtMessage("zm",_loc2_,_loc3_,"str",1);
         }
      }
      
      public function actCastTrigger(param1:Object) : void
      {
         switch(param1.typ)
         {
            case "sia":
               siaTrigger(param1);
         }
      }
      
      public function siaTrigger(param1:Object) : void
      {
         rootClass.sfc.sendXtMessage("zm",["castt"],[],"str",1);
      }
      
      public function uoTreeLeaf(param1:*) : Object
      {
         if(uoTree[param1.toLowerCase()] == null)
         {
            uoTree[param1.toLowerCase()] = {};
         }
         return uoTree[param1.toLowerCase()];
      }
      
      public function myLeaf() : Object
      {
         return uoTreeLeaf(rootClass.sfc.myUserName);
      }
      
      public function uoTreeLeafSet(param1:*, param2:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(uoTree[param1.toLowerCase()] == null)
         {
            uoTree[param1.toLowerCase()] = {};
         }
         _loc3_ = uoTree[param1.toLowerCase()];
         var _loc4_:* = [];
         for(_loc5_ in param2)
         {
            _loc3_[_loc5_] = param2[_loc5_];
            _loc6_ = getAvatarByUserName(param1);
            if(_loc6_ != null && _loc6_.objData != null)
            {
               _loc6_.objData[_loc5_] = param2[_loc5_];
            }
         }
      }
      
      public function manageAreaUser(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         param1 = param1.toLowerCase();
         if(param2 == "+")
         {
            if(areaUsers.indexOf(param1) == -1)
            {
               areaUsers.push(param1);
            }
         }
         else
         {
            _loc3_ = int(areaUsers.indexOf(param1));
            if(_loc3_ > -1)
            {
               areaUsers.splice(_loc3_,1);
            }
         }
         rootClass.updateAreaName();
      }
      
      public function updateAreaUserCount() : void
      {
      }
      
      public function setAllCloakVisibility() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Avatar = null;
         _loc1_ = getUsersByCell(myAvatar.dataLeaf.strFrame);
         for each(_loc2_ in _loc1_)
         {
            _loc2_.pMC.setCloakVisibility(_loc2_.dataLeaf.showCloak);
         }
      }
      
      public function queueDungeon(param1:String) : void
      {
         if(coolDown("dungeonQueue"))
         {
            rootClass.sfc.sendXtMessage("zm","dungeonQueue",[param1],"str",curRoom);
         }
      }
      
      public function rejoinDungeon() : void
      {
         if(coolDown("dungeonRejoin"))
         {
            rootClass.sfc.sendXtMessage("zm","dungeonRejoin",[],"str",curRoom);
         }
      }
      
      public function coolDown(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = lock[param1];
         _loc3_ = new Date();
         _loc4_ = _loc3_.getTime();
         _loc5_ = _loc4_ - _loc2_.ts;
         if(_loc5_ < _loc2_.cd)
         {
            rootClass.chatF.pushMsg("warning","Action taken too quickly, try again in a moment.","SERVER","",0);
            return false;
         }
         _loc2_.ts = _loc4_;
         return true;
      }
      
      public function copyAvatarMC(param1:MovieClip) : void
      {
         var _loc2_:AvatarMCCopier = null;
         _loc2_ = new AvatarMCCopier(this);
         _loc2_.copyTo(param1);
      }
      
      public function doLoadPet(param1:Avatar) : Boolean
      {
         if(!rootClass.uoPref.bPet && param1 == myAvatar)
         {
            return false;
         }
         if(param1 != myAvatar && hideOtherPets)
         {
            return false;
         }
         return true;
      }
      
      public function get Scale() : Number
      {
         return SCALE;
      }
      
      public function get bankinfo() : BankController
      {
         return bankController;
      }
   }
}

