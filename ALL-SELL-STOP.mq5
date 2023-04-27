//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
input double OPEN_Symbols = 100;
input double STOP_Symbols = 95;
input double LOT          = 0.11;

ENUM_ORDER_TYPE type_Sell = ORDER_TYPE_SELL_STOP;

struct Prices
  {
   double            Symbols;
  };
Prices bid;
Prices ask;
//+------------------------------------------------------------------+
void OnStart()
  {
   MqlTick price;
   if(SymbolInfoTick(Symbol(),price)==true)
     {
      bid.Symbols = price.bid;
      ask.Symbols = price.ask;
      OpenOrder(type_Sell,ask.Symbols,bid.Symbols,OPEN_Symbols,STOP_Symbols,Symbol(),"_SELL_STOP",5);
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
   
   if(type1 == ORDER_TYPE_SELL_STOP)
     {
      request.type = type1;
      request.price = NormalizeDouble(PricesMIN-OP_Symbol*Point(),pips);
      request.sl = NormalizeDouble(PricesMAX+SL_Symbol*Point(),pips);
      request.comment = Comm + DopComm;
      if(!OrderSend(request,result))
        {PrintFormat(Comm+DopComm + " - Error open order - %d", GetLastError());}
     }
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+