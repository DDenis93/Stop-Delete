//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
input double OPEN_USDJPY = 110;
input double STOP_USDJPY = 95;
input double LOT        = 0.11;

ENUM_ORDER_TYPE type_Buy  = ORDER_TYPE_BUY_STOP;

struct Prices
  {
   double            USDJPY;
  };
Prices bid;
Prices ask;
//+------------------------------------------------------------------+
void OnStart()
  {
   MqlTick price;
   if(SymbolInfoTick("USDJPY",price)==true)
     {
      bid.USDJPY = price.bid;
      ask.USDJPY = price.ask;
      OpenOrder(type_Buy,ask.USDJPY,bid.USDJPY,OPEN_USDJPY,STOP_USDJPY,"USDJPY","_BUY_STOP",3);
     }
   Sleep(3000);
  }
//+------------------------------------------------------------------+
bool OpenOrder(ENUM_ORDER_TYPE type1, double PricesMAX,double PricesMIN, double OP_Symbol, double SL_Symbol, string Comm, string DopComm, int pips)
  {
   MqlTradeRequest request = {};
   MqlTradeResult result = {};
   request.action = TRADE_ACTION_PENDING;
   request.symbol = Comm;
   request.volume = LOT;

   if(type1 == ORDER_TYPE_BUY_STOP)
     {
      request.type = type1;
      request.price = NormalizeDouble(PricesMAX+OP_Symbol*Point(),pips);
      request.sl = NormalizeDouble(PricesMIN-SL_Symbol*Point(),pips);
      request.comment = Comm + DopComm;
      if(!OrderSend(request,result))
        {PrintFormat(Comm+DopComm + " - Error open order - %d", GetLastError());}
     }
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
