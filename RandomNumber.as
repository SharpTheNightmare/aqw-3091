package
{
   public class RandomNumber
   {
      
      internal const MAX_RATIO:Number = 4.656612875245797e-10;
      
      internal const NEGA_MAX_RATIO:Number = -MAX_RATIO;
      
      private var r:int = Math.random() * int.MAX_VALUE;
      
      private var randNum:Number;
      
      public function RandomNumber()
      {
         super();
      }
      
      public function rand(param1:Number = 0, param2:Number = 1) : Number
      {
         randNum = XORandom() * (param2 - param1) + param1;
         return randNum < param2 ? randNum : param2;
      }
      
      private function XORandom() : Number
      {
         r ^= r << 21;
         r ^= r >>> 35;
         r ^= r << 4;
         if(r > 0)
         {
            return r * MAX_RATIO;
         }
         return r * NEGA_MAX_RATIO;
      }
      
      public function newSeed() : void
      {
         r = Math.random() * int.MAX_VALUE;
      }
   }
}

