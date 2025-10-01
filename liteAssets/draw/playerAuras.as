package liteAssets.draw
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol146")]
   public class playerAuras extends MovieClip
   {
      
      internal var rootClass:MovieClip;
      
      internal var auraContainer:MovieClip;
      
      public var icons:Object;
      
      public var scalar:Number = 0.6;
      
      internal var iconPriority:Array;
      
      public var auras:Object;
      
      public function playerAuras(param1:MovieClip)
      {
         super();
         this.name = "playerAuras";
         this.x = 86;
         this.y = 86;
         this.visible = true;
         rootClass = param1;
         auras = new Object();
         auraContainer = new MovieClip();
         auraContainer.mouseEnabled = auraContainer.mouseChildren = false;
         param1.ui.addChild(auraContainer);
         param1.ui.setChildIndex(auraContainer,0);
         auraContainer.name = "auraContainer";
         auraContainer.x = this.x;
         auraContainer.y = this.y;
      }
      
      public function createIconMC(param1:String, param2:Number, param3:String = null) : void
      {
         var _loc4_:Class = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Class = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:* = undefined;
         var _loc10_:MovieClip = null;
         if(rootClass.litePreference.data.bHideUI)
         {
            return;
         }
         if(icons == null)
         {
            icons = new Object();
            iconPriority = new Array();
         }
         if(!icons.hasOwnProperty(param1))
         {
            if(Boolean(param3) && param3 != "undefined")
            {
               if(param3.indexOf(",") > -1)
               {
                  _loc4_ = rootClass.world.getClass(param3.split(",")[param3.split(",").length - 1]) as Class;
               }
               else
               {
                  _loc4_ = rootClass.world.getClass(param3) as Class;
               }
            }
            else
            {
               _loc4_ = rootClass.world.getClass("isp2") as Class;
            }
            _loc5_ = new _loc4_();
            _loc6_ = getDefinitionByName("ib3") as Class;
            _loc7_ = new _loc6_();
            icons[param1] = auraContainer.addChild(_loc7_);
            icons[param1].name = "aura@" + param1;
            icons[param1].auraName = param1;
            _loc8_ = new MovieClip();
            _loc9_ = new Shape();
            _loc9_.graphics.beginFill(16777215);
            _loc9_.graphics.drawRect(0,0,23,21);
            _loc9_.graphics.endFill();
            _loc8_.addChild(_loc9_);
            _loc8_.alpha = 0;
            addChild(_loc8_);
            icons[param1].hitbox = _loc8_;
            icons[param1].hitbox.auraName = param1;
            icons[param1].width = 42;
            icons[param1].height = 39;
            icons[param1].cnt.removeChildAt(0);
            icons[param1].scaleX = scalar;
            icons[param1].scaleY = scalar;
            icons[param1].tQty.visible = false;
            _loc10_ = icons[param1].cnt.addChild(_loc5_);
            if(_loc10_.width > _loc10_.height)
            {
               _loc10_.scaleX = _loc10_.scaleY = 34 / _loc10_.width;
            }
            else
            {
               _loc10_.scaleX = _loc10_.scaleY = 31 / _loc10_.height;
            }
            _loc10_.x = icons[param1].bg.width / 2 - _loc10_.width / 2;
            _loc10_.y = icons[param1].bg.height / 2 - _loc10_.height / 2;
            iconPriority.push(param1);
            if(!rootClass.litePreference.data.dOptions["disAuraTips"])
            {
               icons[param1].hitbox.addEventListener(MouseEvent.MOUSE_OVER,onOver,false,0,true);
               icons[param1].hitbox.addEventListener(MouseEvent.MOUSE_OUT,onExit,false,0,true);
            }
            else
            {
               this.mouseChildren = this.mouseEnabled = false;
            }
         }
         icons[param1].auraStacks = param2;
         icons[param1].hitbox.auraStacks = param2;
      }
      
      public function onOver(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.openWith({"str":param1.currentTarget.auraName + " (" + param1.currentTarget.auraStacks + ")"});
      }
      
      public function onExit(param1:MouseEvent) : void
      {
         rootClass.ui.ToolTip.close();
      }
      
      public function rearrangeIconMC() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < iconPriority.length)
         {
            if(_loc3_ != 0 && _loc3_ % 4 == 0)
            {
               _loc1_ += 28;
               _loc2_++;
            }
            icons[iconPriority[_loc3_]].x = 32 * (_loc3_ - 4 * _loc2_) + 3;
            icons[iconPriority[_loc3_]].y = _loc1_;
            icons[iconPriority[_loc3_]].hitbox.x = icons[iconPriority[_loc3_]].x + 2;
            icons[iconPriority[_loc3_]].hitbox.y = icons[iconPriority[_loc3_]].y + 1;
            _loc3_++;
         }
      }
      
      public function cleanup() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         rootClass.ui.removeChild(rootClass.ui.getChildByName("auraContainer"));
         parent.removeChild(this);
      }
      
      public function clearMCs() : void
      {
         if(!rootClass.ui)
         {
            return;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         while(auraContainer.numChildren > 0)
         {
            auraContainer.removeChildAt(0);
         }
         icons = new Object();
         iconPriority = new Array();
      }
      
      public function handleAura(param1:Object) : *
      {
         var _loc2_:Date = null;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(param1.a == null)
         {
            return;
         }
         for each(_loc4_ in param1.a)
         {
            if(_loc4_.tInf.indexOf("p") != -1)
            {
               if(_loc4_.tInf.substring(2) == rootClass.sfc.myUserId)
               {
                  if(_loc4_.auras)
                  {
                     for each(_loc5_ in _loc4_.auras)
                     {
                        if(_loc4_.cmd.indexOf("+") > -1)
                        {
                           if(!auras.hasOwnProperty(_loc5_.nam))
                           {
                              auras[_loc5_.nam] = 1;
                              createIconMC(_loc5_.nam,1,_loc5_.icon);
                              coolDownAct(icons[_loc5_.nam],_loc5_.dur * 1000,new Date().getTime());
                           }
                           else
                           {
                              auras[_loc5_.nam] += 1;
                              for each(_loc6_ in rootClass.world.myAvatar.dataLeaf.auras)
                              {
                                 if(_loc6_.nam == _loc5_.nam)
                                 {
                                    _loc6_.ts = _loc5_.ts;
                                    createIconMC(_loc5_.nam,auras[_loc5_.nam]);
                                    coolDownAct(icons[_loc5_.nam],_loc5_.dur * 1000,_loc6_.ts);
                                    break;
                                 }
                              }
                           }
                        }
                        else if(_loc4_.cmd.indexOf("-") > -1)
                        {
                           delete auras[_loc5_.nam];
                        }
                     }
                  }
                  else if(_loc4_.cmd.indexOf("+") > -1)
                  {
                     if(!auras.hasOwnProperty(_loc4_.aura.nam))
                     {
                        auras[_loc4_.aura.nam] = 1;
                        createIconMC(_loc4_.aura.nam,1,_loc4_.aura.icon);
                        coolDownAct(icons[_loc4_.aura.nam],_loc4_.aura.dur * 1000,new Date().getTime());
                     }
                     else
                     {
                        auras[_loc4_.aura.nam] += 1;
                        for each(_loc7_ in rootClass.world.myAvatar.dataLeaf.auras)
                        {
                           if(_loc7_.nam == _loc4_.aura.nam)
                           {
                              _loc7_.ts = _loc4_.aura.ts;
                              auras[_loc4_.aura.nam] = 1;
                              createIconMC(_loc4_.aura.nam,auras[_loc4_.aura.nam]);
                              coolDownAct(icons[_loc4_.aura.nam],_loc4_.aura.dur * 1000,_loc7_.ts);
                              break;
                           }
                        }
                     }
                  }
                  else if(_loc4_.cmd.indexOf("-") > -1)
                  {
                     delete auras[_loc4_.aura.nam];
                  }
               }
            }
         }
      }
      
      public function classChanged() : void
      {
         clearMCs();
      }
      
      public function coolDownAct(param1:*, param2:int = -1, param3:Number = 127) : *
      {
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:MovieClip = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:DisplayObject = null;
         var _loc13_:TextField = null;
         var _loc14_:TextFormat = null;
         var _loc4_:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,-50,-50,-50,0);
         _loc5_ = param1;
         _loc7_ = null;
         _loc8_ = null;
         if(_loc5_.icon2 == null)
         {
            _loc9_ = new BitmapData(50,50,true,0);
            _loc9_.draw(_loc5_,null,_loc4_);
            _loc10_ = new Bitmap(_loc9_);
            _loc7_ = _loc5_.addChild(_loc10_);
            _loc5_.icon2 = _loc7_;
            _loc7_.transform = _loc5_.transform;
            _loc7_.scaleX = 1;
            _loc7_.scaleY = 1;
            _loc5_.ts = param3;
            _loc5_.cd = param2;
            _loc5_.auraName = _loc5_.auraName;
            _loc8_ = _loc5_.addChild(new ActMaskReverse()) as MovieClip;
            _loc8_.scaleX = 1;
            _loc8_.scaleY = 1;
            _loc8_.x = int(_loc7_.x + _loc7_.width / 2 - 244 / 2);
            _loc8_.y = int(_loc7_.y + _loc7_.height / 2 - 244 / 2);
            _loc11_ = 0;
            while(_loc11_ < 4)
            {
               _loc8_["e" + _loc11_ + "oy"] = _loc8_["e" + _loc11_].y;
               _loc11_++;
            }
            _loc7_.mask = _loc8_;
            _loc13_ = new TextField();
            _loc14_ = new TextFormat();
            _loc14_.size = 12;
            _loc14_.bold = true;
            _loc14_.font = "Arial";
            _loc14_.color = 16777215;
            _loc14_.align = "right";
            _loc13_.defaultTextFormat = _loc14_;
            _loc5_.stacks = _loc5_.addChild(_loc13_);
            _loc5_.stacks.x = 3.25;
            _loc5_.stacks.y = 28.1;
            _loc5_.stacks.width = 42.7;
            _loc5_.stacks.height = 16.25;
            _loc5_.stacks.mouseEnabled = false;
            _loc5_.stacks.filters = [new GlowFilter(0,5,0,0,5,5)];
         }
         else
         {
            _loc7_ = _loc5_.icon2;
            _loc8_ = _loc7_.mask;
            _loc5_.ts = param3;
            _loc5_.cd = param2;
            _loc5_.auraName = _loc5_.auraName;
         }
         _loc5_.stacks.text = _loc5_.auraStacks;
         _loc8_.e0.stop();
         _loc8_.e1.stop();
         _loc8_.e2.stop();
         _loc8_.e3.stop();
         _loc5_.removeEventListener(Event.ENTER_FRAME,countDownAct);
         _loc5_.addEventListener(Event.ENTER_FRAME,countDownAct,false,0,true);
         rearrangeIconMC();
      }
      
      public function countDownAct(param1:Event) : void
      {
         var dat:* = undefined;
         var ti:* = undefined;
         var ct1:* = undefined;
         var ct2:* = undefined;
         var cd:* = undefined;
         var tp:* = undefined;
         var mc:* = undefined;
         var fr:* = undefined;
         var i:* = undefined;
         var iMask:* = undefined;
         var e:Event = param1;
         if(rootClass.litePreference.data.bHideUI)
         {
            auras = new Object();
            clearMCs();
            return;
         }
         dat = new Date();
         ti = dat.getTime();
         ct1 = MovieClip(e.target);
         ct2 = ct1.icon2;
         cd = ct1.cd + 350;
         tp = (ti - ct1.ts) / cd;
         mc = Math.floor(tp * 4);
         fr = int(tp * 360 % 90) + 1;
         if(auras[ct1.auraName] == null)
         {
            tp = 1;
         }
         if(tp < 0.99)
         {
            i = 0;
            while(i < 4)
            {
               if(i >= mc)
               {
                  ct2.mask["e" + i].y = ct2.mask["e" + i + "oy"];
                  if(i > mc)
                  {
                     ct2.mask["e" + i].gotoAndStop(0);
                  }
               }
               i++;
            }
            MovieClip(ct2.mask["e" + mc]).gotoAndStop(fr);
         }
         else
         {
            try
            {
               iMask = ct2.mask;
               ct2.mask = null;
               ct2.parent.removeChild(iMask);
               ct1.removeEventListener(Event.ENTER_FRAME,countDownAct);
               stopDrag();
               ct2.parent.removeChild(ct2);
               ct2.bitmapData.dispose();
               ct1.icon2 = null;
               removeChild(icons[ct1.auraName].hitbox);
               auraContainer.removeChild(icons[ct1.auraName]);
               iconPriority.splice(iconPriority.indexOf(ct1.auraName),1);
               delete icons[ct1.auraName];
               rearrangeIconMC();
            }
            catch(exception:*)
            {
            }
         }
      }
   }
}

