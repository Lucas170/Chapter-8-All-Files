//+------------------------------------------------------------------+
//|                                  MyPracticeScript_SizingAlgo.mq4 |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs // Include this to show Inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
  
extern bool isSizingOn = true;   
extern double Risk = 1;          
extern double StopLoss = 30;    

double Lots, P;
bool isYenPair;

void OnStart()
  {
//---
   if(Digits == 5 || Digits == 3 || Digits == 1)P = 10;else P = 1; // To account for 5 digit brokers
   if(Digits == 3 || Digits == 2) isYenPair = true; // Adjust for YenPair
   
   if (isSizingOn == true) {
      Lots = Risk * 0.01 * AccountBalance() / (MarketInfo(Symbol(),MODE_LOTSIZE) * StopLoss * P * Point); // Sizing Algo based on account size
      if(isYenPair == true) Lots = Lots * 100; // Adjust for Yen Pairs
      
      Lots = NormalizeDouble(Lots, 2); // Round to 2 decimal place
   }
   
  Comment("Lots: ", Lots, " | Account Balance: ", AccountBalance()); 
  }
//+------------------------------------------------------------------+
