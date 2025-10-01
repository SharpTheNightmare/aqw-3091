package
{
   import flash.display.MovieClip;
   
   public class BankController
   {
      
      private var bankModified:Boolean = true;
      
      private var rootClass:MovieClip;
      
      public var bankItems:Object;
      
      private var bankArr:Array = new Array();
      
      public var searchArr:Array = new Array();
      
      public var lastSearch:String = "";
      
      private var requestedTypes:Object = new Object();
      
      public var Count:int = 0;
      
      public function BankController()
      {
         super();
         rootClass = World.GameRoot;
         bankItems = new Object();
      }
      
      public function addItemsToBank(param1:Array) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1)
         {
            bankItems[int(_loc2_.ItemID)] = _loc2_;
         }
         bankModified = true;
      }
      
      public function addItem(param1:Object) : void
      {
         bankItems[param1.ItemID] = param1;
      }
      
      public function isItemInBank(param1:int) : Boolean
      {
         return bankItems[param1] != null;
      }
      
      public function get items() : Array
      {
         return searchArr.length == 0 ? BankArray : SearchArray;
      }
      
      public function get BankArray() : Array
      {
         var _loc1_:Object = null;
         if(bankModified)
         {
            bankArr = new Array();
            for each(_loc1_ in bankItems)
            {
               bankArr.push(_loc1_);
            }
            bankModified = false;
         }
         return bankArr;
      }
      
      public function addRequestedTypes(param1:Array) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            requestedTypes[String(param1[_loc2_])] = true;
            _loc2_++;
         }
      }
      
      public function hasRequested(param1:Array) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            if(requestedTypes[param1[_loc2_]] == null)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function bankToInv(param1:int) : Object
      {
         if(bankItems[param1] == null)
         {
            return null;
         }
         var _loc2_:Object = bankItems[param1];
         delete bankItems[param1];
         bankModified = true;
         if(_loc2_.bCoins == 0)
         {
            --Count;
         }
         var _loc3_:String = lastSearch;
         resetSearch();
         search(_loc3_);
         return _loc2_;
      }
      
      public function bankFromInv(param1:int = -1) : void
      {
         bankModified = true;
         var _loc2_:String = lastSearch;
         resetSearch();
         search(_loc2_);
      }
      
      public function getBankItem(param1:int) : Object
      {
         return bankItems[param1];
      }
      
      public function resetSearch() : void
      {
         lastSearch = "";
         searchArr = new Array();
      }
      
      public function get SearchArray() : Array
      {
         return searchArr;
      }
      
      public function search(param1:String) : void
      {
         var _loc2_:Object = null;
         if(rootClass.ui.mcPopup.currentLabel != "Bank" && rootClass.ui.mcPopup.currentLabel != "HouseBank")
         {
            return;
         }
         if(lastSearch != param1 && param1 != "")
         {
            searchArr = new Array();
            lastSearch = param1;
            for each(_loc2_ in bankItems)
            {
               if(_loc2_.sName.toLowerCase().indexOf(param1) > -1 && Boolean(rootClass.bankFiltersMC.onFilter(_loc2_)))
               {
                  searchArr.push(_loc2_);
               }
            }
         }
         if(param1 == "")
         {
            searchArr = new Array();
            lastSearch = "";
         }
         rootClass.bankFiltersMC.dispatch();
      }
   }
}

