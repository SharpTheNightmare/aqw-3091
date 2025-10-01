package liteAssets.draw
{
   import com.adobe.serialization.json.JSON;
   import fl.controls.TextArea;
   import fl.controls.TextInput;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol155")]
   public class packetlogger extends MovieClip
   {
      
      public var btnClose:MovieClip;
      
      public var output:TextArea;
      
      public var input:TextInput;
      
      private var tf:TextFormat = new TextFormat();
      
      public var r:MovieClip;
      
      private var alwaysOn:Boolean = false;
      
      private var scrToBottom:Boolean = false;
      
      private var jsonLimit:int = 0;
      
      private var whiteSpace:RegExp = /\s{2,}/gim;
      
      private var tabPos:int = 0;
      
      private var separator:RegExp = /[%]+/gim;
      
      private var gdq:RegExp = /[&quot;]+/gim;
      
      private var gtrue:RegExp = /[true]+/gim;
      
      private var gfalse:RegExp = /[false]+/gim;
      
      public function packetlogger(param1:MovieClip)
      {
         super();
         this.visible = false;
         r = param1;
         r.stage.addChild(this);
         this.name = "packetlogger";
         tf.font = "Arial";
         tf.size = 18;
         output.setStyle("textFormat",tf);
         tf.size = 25;
         input.setStyle("textFormat",tf);
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16777215,0.9);
         _loc2_.graphics.drawRect(0,0,960,500);
         _loc2_.graphics.endFill();
         var _loc3_:* = new MovieClip();
         _loc3_.addChild(_loc2_);
         output.setStyle("upSkin",_loc3_);
         _loc2_ = new Shape();
         _loc2_.graphics.beginFill(16777215,0.9);
         _loc2_.graphics.drawRect(0,0,960,40);
         _loc2_.graphics.endFill();
         _loc3_ = new MovieClip();
         _loc3_.addChild(_loc2_);
         input.setStyle("upSkin",_loc3_);
         input.addEventListener(KeyboardEvent.KEY_DOWN,onInput,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onHide,false,0,true);
      }
      
      public function onHide(param1:MouseEvent) : void
      {
         this.visible = false;
         toggle();
      }
      
      public function onInput(param1:KeyboardEvent) : void
      {
         var _loc2_:String = null;
         if(param1.keyCode == 13)
         {
            _loc2_ = input.text.replace(whiteSpace,"");
            if(_loc2_.indexOf("/setlimit") == 0)
            {
               regular("This command is currently disabled");
            }
            else
            {
               switch(_loc2_)
               {
                  case "/help":
                     regular("\tCOMMANDS ---");
                     regular("\t/help - COMMANDS");
                     regular("\t/autoscr - AUTO SCROLL TO BOTTOM (DEFAULT: OFF)");
                     regular("\t/clear - CLEARS SCREEN");
                     regular("\t/hide - HIDES SCREEN");
                     regular("\t/alwayson - ALWAYS LOG EVEN IF HIDDEN");
                     regular("\tENTERING ANYTHING WILL SEND TO THE SERVER");
                     break;
                  case "/alwayson":
                     alwaysOn = !alwaysOn;
                     regular("\tALWAYS ON SET TO: " + alwaysOn);
                     break;
                  case "/autoscr":
                     scrToBottom = !scrToBottom;
                     regular("\tAUTO SCROLL TO BOTTOM SET TO: " + scrToBottom);
                     break;
                  case "/getlimit":
                     regular("\tJSON PRETTY PRINT STRING LIMIT -- " + jsonLimit + " CHARACTERS");
                     break;
                  case "/clear":
                     output.text = "";
                     break;
                  case "/hide":
                     this.visible = false;
                     toggle();
                     break;
                  default:
                     if(r.world.myAvatar.isStaff())
                     {
                        r.sfc.sendString(input.text);
                        regular("\tSENT TO SERVER: " + input.text);
                     }
               }
            }
            input.text = "";
            if(scrToBottom)
            {
               output.verticalScrollPosition = output.maxVerticalScrollPosition;
            }
         }
      }
      
      public function cleanup() : void
      {
         if(this.parent as MovieClip != null)
         {
            (this.parent as MovieClip).removeChild(this);
         }
         input.removeEventListener(KeyboardEvent.KEY_DOWN,onInput);
         r.sfc.removeEventListener("onDebugMessage",onLogger);
         r.pLoggerUI = null;
      }
      
      public function getTabs() : String
      {
         var _loc1_:* = "";
         var _loc2_:int = 0;
         while(_loc2_ < tabPos)
         {
            _loc1_ += "    ";
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function color(param1:String, param2:String) : String
      {
         return "<font face=\"Arial\" size=\"20\" color=\"" + param2 + "\">" + param1 + "</font>";
      }
      
      public function tab(param1:String) : void
      {
         output.htmlText += "<font face=\"Arial\" size=\"20\">" + getTabs() + param1 + "</font>";
         if(scrToBottom)
         {
            output.verticalScrollPosition = output.textField.maxScrollV;
         }
      }
      
      public function noTab(param1:String) : void
      {
         output.htmlText += "<font face=\"Arial\" size=\"20\">" + param1 + "</font>";
         if(scrToBottom)
         {
            output.verticalScrollPosition = output.textField.maxScrollV;
         }
      }
      
      public function regular(param1:String) : void
      {
         output.appendText(param1 + "\n");
      }
      
      public function parse(param1:*) : String
      {
         var _loc3_:* = undefined;
         var _loc6_:* = undefined;
         ++tabPos;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         if(_loc2_ == 0)
         {
            --tabPos;
            return " {}";
         }
         var _loc4_:int = 0;
         var _loc5_:* = " {\n";
         for(_loc6_ in param1)
         {
            _loc5_ += getTabs() + ("\"" + color(_loc6_,"#BF40BF") + "\":");
            if(param1[_loc6_] is String)
            {
               _loc5_ += " \"" + color(param1[_loc6_],"#FF0000") + "\"";
            }
            else if(param1[_loc6_] is Number || param1[_loc6_] is Boolean)
            {
               _loc5_ += " " + color(param1[_loc6_],"#FF0000");
            }
            else if(param1[_loc6_] is Object || param1[_loc6_] is Array)
            {
               _loc5_ += parse(param1[_loc6_]);
            }
            else
            {
               _loc5_ += " " + color(param1[_loc6_],"#FF0000");
            }
            if(_loc4_ + 1 != _loc2_)
            {
               _loc5_ += ",";
            }
            _loc5_ += "\n";
            _loc4_++;
         }
         --tabPos;
         return _loc5_ + (getTabs() + "}");
      }
      
      internal function raw_parse(param1:*) : String
      {
         var _loc3_:* = undefined;
         var _loc6_:* = undefined;
         ++tabPos;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         if(_loc2_ == 0)
         {
            --tabPos;
            return " {}";
         }
         var _loc4_:int = 0;
         var _loc5_:* = " {\n";
         for(_loc6_ in param1)
         {
            _loc5_ += getTabs() + ("\"" + _loc6_ + "\":");
            if(param1[_loc6_] is String)
            {
               _loc5_ += " \"" + param1[_loc6_] + "\"";
            }
            else if(param1[_loc6_] is Number || param1[_loc6_] is Boolean)
            {
               _loc5_ += " " + param1[_loc6_];
            }
            else if(param1[_loc6_] is Object || param1[_loc6_] is Array)
            {
               _loc5_ += raw_parse(param1[_loc6_]);
            }
            else
            {
               _loc5_ += " " + param1[_loc6_];
            }
            if(_loc4_ + 1 != _loc2_)
            {
               _loc5_ += ",";
            }
            _loc5_ += "\n";
            _loc4_++;
         }
         --tabPos;
         return _loc5_ + (getTabs() + "}");
      }
      
      private function fixHTML(param1:String) : String
      {
         var _loc2_:RegExp = /[<]+/gim;
         var _loc3_:RegExp = /[>]+/gim;
         var _loc4_:RegExp = /[&]+/gim;
         var _loc5_:RegExp = /["]+/gim;
         var _loc6_:RegExp = /[']+/gim;
         param1 = param1.replace(_loc2_,"&lt;");
         param1 = param1.replace(_loc3_,"&gt;");
         param1 = param1.replace(_loc4_,"&amp;");
         param1 = param1.replace(_loc5_,"&quot;");
         return param1.replace(_loc6_,"&apos;");
      }
      
      public function onLogger(param1:*) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:* = param1.params.message;
         if(_loc2_.indexOf("[ RECEIVED ]:") == 0)
         {
            _loc3_ = _loc2_.substr(_loc2_.indexOf("]: ") + 3,_loc2_.lastIndexOf(", (len:") - 14) + "\n";
            if(_loc3_.length > jsonLimit)
            {
               if(_loc3_.indexOf("%") != -1)
               {
                  regular("\t" + _loc3_);
               }
               else
               {
                  regular(raw_parse(com.adobe.serialization.json.JSON.decode(_loc3_)));
               }
            }
            else
            {
               noTab(parse(com.adobe.serialization.json.JSON.decode(_loc3_)));
            }
            tabPos = 0;
         }
         else
         {
            _loc3_ = _loc2_.substr(_loc2_.indexOf("]: ") + 3,_loc2_.length);
            if(_loc3_.length > jsonLimit)
            {
               regular("\t" + _loc3_);
            }
            else
            {
               if(_loc3_.indexOf("%") != -1 && _loc3_.length <= jsonLimit)
               {
                  _loc3_ = fixHTML(_loc3_);
                  _loc3_ = color(_loc3_,"#BF40BF");
                  _loc3_ = _loc3_.replace(separator,color("%","#FF0000"));
               }
               noTab("<br>" + _loc3_);
            }
         }
         if(scrToBottom)
         {
            output.verticalScrollPosition = output.maxVerticalScrollPosition;
         }
      }
      
      public function toggle() : void
      {
         r.stage.focus = null;
         if(!alwaysOn)
         {
            if(this.visible)
            {
               r.sfc.addEventListener("onDebugMessage",onLogger,false,0,true);
            }
            else
            {
               r.sfc.removeEventListener("onDebugMessage",onLogger);
            }
         }
      }
   }
}

