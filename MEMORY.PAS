Procedure Create_Procedure;       {  Это: Создание процедуры              }
 var i,n1 : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,20 ) then
     Exit;
   Command := Copy ( LineBuf, NumberT [1,2], NumberT [2,2] );
   if Ord ( Command [0] ) > LengNam then
     begin
       write ( ErrMsg6,Command,' ?' );        {  ОШИБКА: длинное имя проц.   }
       ErrorCode := True;
       Exit
     end;
   if ZagNumb = MaxName then
     begin
       write ( Warning2 );                    {  Не хватает заголовков       }
       ErrorCode := True;
       Exit
     end;
   if PrgNumb = MaxLine - 1 then
     begin
       write ( Warning1 );                    {  Не хватает памяти проц.    }
       ErrorCode := True;
       Exit
     end;
   if ZagNumb > 0 then                        {  Если уже есть какие-то     }
     for i := 1 to ZagNumb do                 {  процедуры, то неплохо бы   }
        if Command = ZagName [i] then         {    проверить вот что :      }
          begin
            write ( ErrMsg7,Command,' ?');    {  ОШИБКА: повторное определ. }
            ErrorCode := True;
            Exit
          end;
   {  после  всех проверок начали ввод процедуры  }
   ZagNumb := ZagNumb + 1;
   PrgNumb := PrgNumb + 1;
   ProgTxt^[PrgNumb] := LineBuf;
   ZagName [ZagNumb] := Command;
   ZagTabl [ZagNumb] := PrgNumb;
   ZagArg  [ZagNumb] := CountNm - 2;
   CountLine         := 1;
   n1                := 2;
   repeat
     Get_LineBuf ( n1,False );
     if Ch = #27 then
       begin
         GotoXY ( 1, WhereY ); ClrEol
       end
                 else
       begin
         writeln;
         PrgNumb   := PrgNumb   + 1;
         CountLine := CountLine + 1;
         Process_LineBuf;
         Command := Copy ( LineBuf, NumberT [1,1], NumberT [2,1] );
         if (Command = KeyWord [13]) Or (Command = KeyWord [24]) then
           n1 := n1 + 2;
         if (Command = KeyWord [08]) Or (Command = KeyWord [21]) then
           if n1 > 3 then
             begin
               n1 := n1 - 2;
               Delete ( LineBuf,1,2 );
               GotoXY ( 1, WhereY-1 ); write ( LineBuf ); ClrEol;
               writeln
             end;
         if (Command = KeyWord [20]) Or ( CountLine = 255 ) then
           begin
             Linebuf := KeyWord [20] + ' ';
             GotoXY ( 1, WhereY-1 ); write ( KeyWord [20] ); ClrEol;
             writeln
           end;
         LengBuf           := LengBuf - 1;
         ProgTxt^[PrgNumb] := LineBuf
       end
   until LineBuf = KeyWord [20];
   ZagLeng [ZagNumb] := CountLine;
   writeln ( Warning0,ZagName [ZagNumb],'.' )
 end;

Procedure Write_Zagol;            {  Заголовки: Вывод заголовков на экр.  }
 var i,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   if ZagNumb > 0 then                        {  Если есть хотя бы  одна   }
     for i := 1 to ZagNumb do                 {           процедура        }
        begin
          n := LengNam + 1 - Ord (ZagName [i][0]);
          writeln ('Процедура: ', ZagName [i],',':n,
                   ' аргументов:',ZagArg  [i]:2,',',
                   ' строк:',     ZagLeng [i]:3,'.')
        end
 end;

Procedure Write_Procedure ( n : byte ); {  Вывод на экран или принтер текста }
 var i : byte;
 begin
   if Dev = 0 then
     begin
       Assign  ( Lst, 'Prn' );
       Rewrite ( Lst );
{$I-  отключение системного контроля за операциями ввода - вывода   }
       for i := 1 to ZagLeng [n] do
         begin
           writeln ( Lst, ProgTxt^[i + ZagTabl[n] - 1] );
           if IOResult > 0 then
             begin
               write ( WarningD ); ErrorCode := True;
               Close ( Lst );
               Exit
             end
         end;
{$I+   включение системного контроля за операциями ввода - вывода   }
       Close ( Lst )
     end
              else
     for i := 1 to ZagLeng [n] do
       begin
         writeln ( ProgTxt^[i + ZagTabl[n] - 1] );
         Delay ( 100 )
       end
 end;

Procedure Write_Variable ( n : byte );  {  Вывод на экран n-ой переменной    }
 var i : byte;
 begin
   if Dev = 0 then
     begin
       Assign  ( Lst, 'Prn' );
       Rewrite ( Lst );
{$I-  отключение системного контроля за операциями ввода - вывода   }
       writeln ( Lst, VarName [n],'= ':23-Ord ( VarName [n][0] ),
                      VarTabl [n]:7:6 );
       if IOResult > 0 then
         begin
           write ( WarningD ); ErrorCode := True;
           Close ( Lst );
           Exit
         end;
{$I+   включение системного контроля за операциями ввода - вывода   }
       Close ( Lst )
     end
              else
     begin
       writeln (      VarName [n],'= ':23-Ord ( VarName [n][0] ),
                      VarTabl [n]:7:6 );
       Delay ( 100 )
     end
 end;

Procedure Write_All;              {  Отпечатай: Вывод содержимого памяти  }
 var i,j,k,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   Dev := 1;
   for j := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,j],NumberT [2,j] );
       k       := 5;
       if Command = 'НаБумаге'   then k := 0;
       if Command = 'Все'        then k := 1;
       if Command = 'Процедуры'  then k := 2;
       if Command = 'Переменные' then k := 3;
       if Command[1] = ':'       then k := 4;
       case k of
         0 : Dev := 0;
         1 : begin
               if ZagNumb > 0 then           {  Если есть хотя бы  одна     }
                 for i := 1 to ZagNumb do    {          процедура           }
                   begin
                     Write_Procedure ( i );
                     if ErrorCode then  Exit
                   end;
               ErrorCode := False;
               if VarNumb > 0 then
                 for i := 1 to VarNumb do
                   begin
                     Write_Variable ( i );
                     if ErrorCode then  Exit
                   end
             end;
         2 : if ZagNumb > 0 then             {  Если есть хотя бы одна      }
               for i := 1 to ZagNumb do      {          процедура           }
                 begin
                   Write_Procedure ( i );
                   if ErrorCode then  Exit
                 end;
         3 : if VarNumb > 0 then
               for i := 1 to VarNumb do
                 begin
                   Write_Variable ( i );
                   if ErrorCode then  Exit
                 end;
         4 : begin
               if Teste_VarName ( Command ) then {  Если неправильное имя   }
                 Exit;                           {      переменной          }
               n := Find_VarName ( Command );
               if NotFind_VarName ( n ) then     {  Если переменной нет     }
                 Exit;
               Write_Variable ( n );
               if ErrorCode then  Exit
             end;
         5 : begin
               n := 0;
               for i := 1 to ZagNumb do
                 if ZagName [i] = Command then n := i;
               if n = 0 then                 {  Процедуры с таким именем    }
                 begin                       {             НЕТ              }
                   write ( ErrMsg0,Command,' ?' );
                   ErrorCode := True;
                   Exit
                 end;
               Write_Procedure ( n );
             end
       end
     end
 end;

Procedure Free_Memory;            {  СвобПамять:  Объем свободной памяти  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   writeln ( 'В Вашем распоряжении строк: ',MaxLine - PrgNumb,
                           ', заголовков: ',MaxName - ZagNumb,
                          ' и переменных: ',MaxVar  - VarNumb,'.')
 end;

Procedure Erase_All;              {  Забудь: Стирание рабочей памяти      }
 var i,j,len,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
      begin
        Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
        Dev := 5;
        if Command = 'Все'        then Dev := 1;
        if Command = 'Процедуры'  then Dev := 2;
        if Command = 'Переменные' then Dev := 3;
        if Command[1] = ':'       then Dev := 4;
        case Dev of
          1 : begin
                PrgNumb := 0;
                ZagNumb := 0;
                VarNumb := 0
              end;
          2 : begin
                PrgNumb := 0;
                ZagNumb := 0
              end;
          3 : VarNumb := 0;
          4 : begin
                if Teste_VarName ( Command ) then {  Если неправильное имя   }
                  Exit;                           {      переменной          }
                n := Find_VarName ( Command );
                if NotFind_VarName ( n ) then     {  Если переменной нет     }
                  Exit;
                if n < VarNumb then
                  for j := n to VarNumb-1 do           {  Удаление           }
                     begin                             {     переменной      }
                       VarTabl [j] := VarTabl [j+1];   {     путем сдвига    }
                       VarName [j] := VarName [j+1]    {     в VarTabl       }
                     end;
                VarNumb := VarNumb - 1
              end;
          5 : begin
                if ZagNumb = 0 then           {  Если не создано ни одной    }
                  begin                       {           процедуры          }
                    write ( ErrMsg0,Command,' ?' );  ErrorCode := True;
                    Exit
                  end;
                n := 0;
                for j := 1 to ZagNumb do
                  if ZagName [j] = Command then n := j;
                if n = 0 then                 {  Процедуры с таким именем    }
                  begin                       {             НЕТ              }
                    write ( ErrMsg0,Command,' ?' );  ErrorCode := True;
                    Exit
                  end;
                len := ZagLeng [n];
                if n < ZagNumb then
                  begin
                    for j := ZagTabl [n] to PrgNumb - len do
                       ProgTxt^[j] := ProgTxt^[j+len];
                    for j := n to ZagNumb-1 do
                       begin
                         ZagTabl [j] := ZagTabl [j+1];
                         ZagName [j] := ZagName [j+1];
                         ZagArg  [j] := ZagArg  [j+1];
                         ZagLeng [j] := ZagLeng [j+1];
                       end
                  end;
                PrgNumb := PrgNumb - len;
                ZagNumb := ZagNumb - 1
              end
        end
      end
 end;

Procedure Edit_Procedure;         {  Редактируй: редактирование процедуры }
 var i              : integer;
     k,num,n1,smh,y : byte;
     charter        : char;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   num     := 0;
   for i := 1 to ZagNumb do
      if ZagName [i] = Command then num := i;
   if num = 0 then                            {  Процедуры с таким именем    }
     begin                                    {             НЕТ              }
       write ( ErrMsg0,Command,' ?' );
       ErrorCode := True;
       Exit
     end;
   {   после  всех  проверок  начинаем  редактирование   }
   smh := ZagTabl [num];
   if ZagLeng [num] > 16 then k := 16
                         else k := ZagLeng [num];
   for i := 0 to k-2 do
     writeln ( ProgTxt^[smh + i] );
   write     ( ProgTxt^[smh + k - 1] );
   GotoXY ( 1, WhereY - k + 1 );
   n1 := 1;
   repeat
     LineBuf := ProgTxt^[smh + n1 - 1];
     if LineBuf = KeyWord [20] then             {  Если встретилась строка  }
       begin                                    {   со словом Конец., ТО:   }
         writeln ( KeyWord [20] ); Exit         {         ЗАВЕРШИТЬ         }
       end;                                     {       редактирование      }
     Get_LineBuf ( 0, True );
     charter := Ch;
     Process_LineBuf;
     LengBuf := LengBuf - 1;
     Command := Copy ( LineBuf,NumberT [1,1],NumberT [2,1] );
     case charter of
       #27 : if n1 = 1 then                     {  СТИРАНИЕ  текущей строки  }
               GotoXY ( 1, WhereY )             {  Первая строка  НЕ может   }
                        else                    {         быть стерта        }
               begin
                 ProgTxt^[smh + n1 - 1] := '  ';
                 GotoXY ( 1, WhereY );
                 ClrEol
               end;
       #72 : if n1 = 1 then                     {  Курсор  ВВЕРХ             }
               GotoXY ( 1, WhereY )             {  Выше 1-й строки подняться }
                       else                     {          Н Е Л Ь З Я       }
               begin
                 ProgTxt^[smh + n1 - 1] := LineBuf;
                 n1 := n1 - 1;
                 if WhereY > 1 then
                   GotoXY ( 1, WhereY-1 )
                               else
                   begin
                     GotoXY ( 1,WhereY ); InsLine
                   end;
               end;
   #13,#80 : begin                              {  Курсор ВНИЗ               }
               ProgTxt^[smh + n1 - 1] := LineBuf;
               n1 := n1 + 1;
               if WhereY = 16 then writeln
                              else GotoXY ( 1, WhereY + 1 )
             end;
       #82 : if (ZagLeng [num] < MaxVar) And (PrgNumb < MaxLine ) then
               begin                            {  ВСТАВКА новой строки      }
                 writeln;
                 InsLine;
                 PrgNumb       := PrgNumb + 1;
                 ZagLeng [num] := ZagLeng [num] + 1;
                 for i := PrgNumb downto ( smh + n1 ) do
                   ProgTxt^[i] := ProgTxt^[i - 1];
                 ProgTxt^[smh + n1] := '  ';
                 n1 := n1 + 1
               end;
       #83 : if n1 = 1 then                     {  УДАЛЕНИЕ текущей строки   }
               GotoXY ( 1, WhereY )             {  Первая строка  НЕ может   }
                        else                    {         быть удалена       }
               begin
                 DelLine;
                 y := WhereY;
                 PrgNumb       := PrgNumb - 1;
                 ZagLeng [num] := ZagLeng [num] - 1;
                 for i := ( smh + n1 - 1 ) to PrgNumb do
                   ProgTxt^[i] := ProgTxt^[i + 1];
                 if num < ZagNumb then
                   for i := num + 1 to ZagNumb do
                     ZagTabl [i] := ZagTabl [i] - 1;
                 if (ZagLeng [num] - n1) > (16 - y - 1) then
                   begin
                     GotoXY ( 1, 16 ); write ( ProgTxt^[n1 + 16 - y] )
                   end;
                 GotoXY ( 1, y );
               end
     end
   until False
 end;

Procedure Clear_Memory;           {  Сначала:  Очистить рабочую память  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   PrgNumb := 0; CountLevel := 0;
   VarNumb := 0;
   ZagNumb := 0
 end;
