unit FullSum;

interface

uses SysUtils;

{
Функция перевода суммы, записанной цифрами в сумму прописью :
например, 23.12 -> двадцать три рубля 12 копеек.
переводит до 999999999 руб. 99 коп.
Функция не отслеживает, правильное ли значение получено в параметре Number
(т.е. положительное и округленное с точностью до сотых) - эту проверку
необходимо провести до вызова функции.
}

//----------------- Copyright (c) 1999 by Константин Егоров
//----------------- mailto: egor@vladi.elektra.ru

function SumNumToFull(Number: real): string;

implementation

function SumNumToFull(Number:real):string;
var
  PartNum, TruncNum, NumTMP, D: integer;
  NumStr : string;
  i, R : byte;
  Flag11 : boolean;
begin
  D:=1000000;
  R:=4;
  //выделяем рубли
  TruncNum:=Trunc(Number);
  if TruncNum<>0 then
    repeat
      PartNum:=TruncNum div D;
      Dec(R);
      D:=D div 1000;
    until
      PartNum<>0
  else
    R:=0;

  // перевод рублей
  for i:=R downto 1 do
  begin
    Flag11:=False;
    // выделение цифры сотен
    NumTMP:=PartNum div 100;
    case NumTMP of
      1: NumStr:=NumStr+'сто ';
      2: NumStr:=NumStr+'двести ';
      3: NumStr:=NumStr+'триста ';
      4: NumStr:=NumStr+'четыреста ';
      5: NumStr:=NumStr+'пятьсот ';
      6: NumStr:=NumStr+'шестьсот ';
      7: NumStr:=NumStr+'семьсот ';
      8: NumStr:=NumStr+'восемьсот ';
      9: NumStr:=NumStr+'девятьсот ';
    end;
    // выделение цифры десятков
    NumTMP:=(PartNum mod 100) div 10;
    case NumTMP of
      1:
      begin
        NumTMP:=PartNum mod 100;
        case NumTMP of
          10: NumStr:=NumStr+'десять ';
          11: NumStr:=NumStr+'одиннадцать ';
          12: NumStr:=NumStr+'двенадцать ';
          13: NumStr:=NumStr+'тринадцать ';
          14: NumStr:=NumStr+'четырнадцать ';
          15: NumStr:=NumStr+'пятнадцать ';
          16: NumStr:=NumStr+'шестнадцать ';
          17: NumStr:=NumStr+'семнадцать ';
          18: NumStr:=NumStr+'восемнадцать ';
          19: NumStr:=NumStr+'девятнадцать ';
        end;
        case i of
          3: NumStr:=NumStr+'миллионов ';
          2: NumStr:=NumStr+'тысяч ';
          1: NumStr:=NumStr+'рублей ';
        end;
        Flag11:=True;
      end;
      2: NumStr:=NumStr+'двадцать ';
      3: NumStr:=NumStr+'тридцать ';
      4: NumStr:=NumStr+'сорок ';
      5: NumStr:=NumStr+'пятьдесят ';
      6: NumStr:=NumStr+'шестьдесят ';
      7: NumStr:=NumStr+'семьдесят ';
      8: NumStr:=NumStr+'восемьдесят ';
      9: NumStr:=NumStr+'девяносто ';
    end;
    // выделение цифры единиц
    NumTMP:=PartNum mod 10;
    if not Flag11 then
    begin
      case NumTMP of
        1:
          if i=2 then
            NumStr:=NumStr+'одна '
          else
            NumStr:=NumStr+'один ';
        2:
          if i=2 then
            NumStr:=NumStr+'две '
          else
            NumStr:=NumStr+'два ';
        3: NumStr:=NumStr+'три ';
        4: NumStr:=NumStr+'четыре ';
        5: NumStr:=NumStr+'пять ';
        6: NumStr:=NumStr+'шесть ';
        7: NumStr:=NumStr+'семь ';
        8: NumStr:=NumStr+'восемь ';
        9: NumStr:=NumStr+'девять ';
      end;
      case i of
        3:
          case NumTMP of
            1: NumStr:=NumStr+'миллион ';
            2,3,4: NumStr:=NumStr+'миллиона ';
            else
              NumStr:=NumStr+'миллионов ';
          end;
        2:
          case NumTMP of
            1 : NumStr:=NumStr+'тысяча ';
            2,3,4: NumStr:=NumStr+'тысячи ';
            else
              if PartNum<>0 then
                NumStr:=NumStr+'тысяч ';
          end;
        1:
          case NumTMP of
            1 : NumStr:=NumStr+'рубль ';
            2,3,4: NumStr:=NumStr+'рубля ';
            else
              NumStr:=NumStr+'рублей ';
          end;
      end;
    end;
    if i>1 then
    begin
      PartNum:=(TruncNum mod (D*1000)) div D;
      D:=D div 1000;
    end;
  end;

  //перевод копеек
  PartNum:=Round(Frac(Number)*100);
  if PartNum=0 then
  begin
    SumNumToFull:=NumStr+'00 копеек';
    Exit;
  end;
  // выделение цифры десятков
  NumTMP:=PartNum div 10;
  if NumTMP=0 then
    NumStr:=NumStr+'0'+IntToStr(PartNum)+' '
  else
    NumStr:=NumStr+IntToStr(PartNum)+' ';
  // выделение цифры единиц
  NumTMP:=PartNum mod 10;
  case NumTMP of
    1:
      if PartNum<>11 then
        NumStr:=NumStr+'копейка'
      else
        NumStr:=NumStr+'копеек';
    2,3,4:
      if (PartNum<5) or (PartNum>14) then
        NumStr:=NumStr+'копейки'
      else
        NumStr:=NumStr+'копеек';
    else
      NumStr:=NumStr+'копеек';
  end;
  SumNumToFull:=NumStr;
end;

end.

