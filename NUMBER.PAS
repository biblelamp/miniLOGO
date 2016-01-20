Procedure Create_Var;             {  Создай:  Создать переменную  }
 var i : byte;
 begin
   if Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Teste_VarName ( Command ) then      {  Если неправильное имя       }
         Exit;                                {      переменной              }
       if Find_VarName ( Command ) = 0 then   {  Если такой переменной нет   }
         if VarNumb = MaxVar then             {  Если память переменных      }
           begin                              {      заполнена, ТО           }
             ErrorCode := True;
             write ( Warning3 );              {  ПРЕДУПРЕЖДЕНИЕ: нет памяти  }
             Exit                             {    переменная не создается   }
           end
                             else
           begin
             VarNumb := VarNumb + 1;          {  СОЗДАНИЕ                    }
             VarName [VarNumb] := Command;    {           новой переменной   }
             VarTabl [VarNumb] := 0
           end
      end
 end;

Procedure Input_Data;             {  Введи:  Ввод переменных    }
 var i,n,result : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Teste_VarName ( Command ) then      {  Если неправильное имя       }
         Exit;                                {      переменной              }
       n := Find_VarName ( Command );
       if NotFind_VarName ( n ) then          {  Если такой переменной нет   }
         Exit;
{$I-  отключаем системный контроль за операциями ввода-вывода  }
       repeat
         write  ( Command,' ? ' );            {  ВВОД ЧИСЛА в найденную      }
         readln ( VarTabl [n] );              {               переменную     }
         result := IOResult;
         if result > 0 then writeln ( ErrMsgC )
       until result = 0
{$I+  включаем  системный контроль за операциями ввода-вывода  }
     end
 end;

Procedure Input_Char;             {  ВведиЗнак:  Ожидание нажатия любой кл.  }
 var i,n1 : byte;
 begin
   if CountNm = 1 then
     Ch := ReadKey
                  else
     for i := 2 to CountNm do
       begin
         Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
         if Teste_VarName ( Command ) then    {  Если неправильное имя       }
           Exit;                              {      переменной              }
         n1 := Find_VarName ( Command );
         if NotFind_VarName ( n1 ) then       {  Если такой переменной нет   }
           Exit;
         Ch           := ReadKey;             {  ВВОД КОДА нажатой клавиши   }
         VarTabl [n1] := Ord ( Ch )           {    в найденную переменную    }
       end
 end;


Procedure Process_Numb;           {  Сделай:  Расчет арифметич.выражения и   }
 var n,i : byte;                  {           присвоение его знач.переменной }
 begin
   if Teste_Argument ( 4,40 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_VarName ( Command ) then          {  Если неправильное имя       }
     Exit;                                    {      переменной              }
   n := Find_VarName ( Command );
   if NotFind_VarName ( n ) then              {  Если такой переменной нет  }
     Exit;
   if Odd ( CountNm ) Or ( LineBuf [NumberT [1,3]] <> '=' ) then
     begin                                    {   Если число аргум. четно    }
       write ( ErrMsg5a ); ErrorCode := True; {   или нет знака "=", ТО :    }
       Exit                                   {  ОШИБКА : неправильное выр.  }
     end;
   CountWr := 0;
   for i := 4 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Not Odd (i) then
         begin
           CountWr := CountWr + 1;
           if Write_Number ( Command,CountWr ) then
             Exit;                            {  ОШИБКА в преобразовании     }
         end                                  {   CountWr - й переменной     }
                  else
         begin
           if (Command <> '*') And (Command <> '/') And (Command <> '\') And
              (Command <> '+') And (Command <> '-') then
             begin
               write ( ErrMsg5a ); ErrorCode := True;
               Exit;
             end;
           ProcChr [ CountWr ] := Command [1]
         end
     end;
   if CountNm > 3 then
     begin
       for i := 1 to CountWr-1 do
          case ProcChr [i] of
            '*'     : WorkNum [i+1] := WorkNum [i] * WorkNum [i+1];
            '/','\' : if WorkNum [i+1] <> 0 then
                        begin
                          WorkNum [i+1] := WorkNum [i] / WorkNum [i+1];
                          if ProcChr [i] = '\' then
                            WorkNum [i+1] := Trunc ( WorkNum [i+1] )
                        end
                                            else
                        begin
                          if Not ModeScr then Set_TextMode;
                          write ( ErrMsgD );  ErrorCode := True;
                          Exit
                        end
          end;
       for i := CountWr-1 downto 1 do
          case ProcChr [i] of
            '*' : WorkNum [i] := WorkNum [i+1];
            '/' : WorkNum [i] := WorkNum [i+1];
            '\' : WorkNum [i] := WorkNum [i+1]
          end;
       for i := 1 to CountWr-1 do
          case ProcChr [i] of
            '+' : WorkNum [i+1] := WorkNum [i] + WorkNum [i+1];
            '-' : WorkNum [i+1] := WorkNum [i] - WorkNum [i+1];
            '*' : WorkNum [i+1] := WorkNum [i];
            '/' : WorkNum [i+1] := WorkNum [i];
            '\' : WorkNum [i+1] := WorkNum [i]
          end
     end;
   VarTabl [n] := WorkNum [CountWr]
 end;

Procedure Output_Data;            {  Выведи:  Вывод переменных и  }
 var i : byte;                    {                констант       }
     n : integer;
 begin
   if Teste_Mode ( 1 ) then
     Exit;
   if CountNm > 1 then
     for i := 2 to CountNm do
       begin
         Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
         if  Command = '!' then writeln        {  Если найден знак '!', то   }
                           else                {  происходит перевод строки  }
           begin
             if (Command[1] = ':') then        {  Если элемент списка        }
               begin                           {  начинается с ":", то он    }
                 n := Find_VarName ( Command );{  считается именем перемен.  }
                 if Command = ':Пи'   then n := -1;
                 if Command = ':Е'    then n := -2;
                 if Command = ':Абсц' then n := -3;
                 if Command = ':Орд'  then n := -4;
                 if Command = ':Курс' then n := -5;
                 if n       = 0  then writeln;
                 if NotFind_VarName ( n ) then
                   Exit                        {  Если такой переменной нет  }
                                          else
                   case n of
                     -1 : write ( ' 3.141593' );
                     -2 : write ( ' 2.718282' );
                     -3 : write ( ' ', GraphX );
                     -4 : write ( ' ', GraphY );
                     -5 : write ( ' ', Ugol   );
                    else  if VarTabl [n] = Trunc ( VarTabl [n] ) then
                            write ( ' ',Trunc ( VarTabl [n] ) )
                                                                 else
                            write ( ' ',VarTabl [n]:7:6 )
                   end
               end
                                 else
           write ( ' ',Command )               {  Если элемент списка не имя }
         end                                   {  переменной,то он считается }
       end                                     {  константой и выводится     }
 end;
