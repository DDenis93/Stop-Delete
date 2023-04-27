//+------------------------------------------------------------------+
//|                                                  OrderDelete.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   OrdersModifyPerspective();
  }
//+------------------------------------------------------------------+
void OrdersModifyPerspective()
  {
   MqlTradeRequest request2 = {};
   MqlTradeResult result2 = {};
   int total2=OrdersTotal();
   for(int i=total2-1; i>=0; i--)
     {
      ulong  order_ticket=OrderGetTicket(i);
      ZeroMemory(request2);
      ZeroMemory(result2);
      request2.action=TRADE_ACTION_REMOVE;
      request2.order = order_ticket;
      if(!OrderSend(request2,result2))
         PrintFormat("OrderSend error %d",GetLastError());
     }
  };
//+------------------------------------------------------------------+
