Procedure Exit_Procedure;         {  Выйди, Конец.: Завершение работы проц.  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if CountLevel > 0 then
     begin
       if (CountStrukt > 0) then  CountStrukt := CountStrukt - 1;
       CountLine  := StackReturn [CountLevel];
       CountLevel := CountLevel - 1
     end
 end;

Procedure Finish_Procedure;       {  Финиш: Завершение работы с любого уров. }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   CountStrukt := 0;
   CountLevel  := 0
 end;

Procedure Exit_System;            {  Заверши:  Выход в операционную систему  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   Window (1,1,80,25); TextBackGround (0);
   GotoXY (1,25); ClrEol;
   GotoXY (1,24); ClrEol;
   Halt
 end;

Procedure Repeat_Begin;           {  Повтори:  Начало повторения команд(ы)   }
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   if CountLevel > 0 then
     begin
       if CountZickl = MaxVar then            {  Превышена                  }
         begin                                {      вложенность структур   }
         if Not ModeScr then Set_TextMode;
         write ( ErrMsgAb );  ErrorCode := True;
         Exit
       end;
       CountZickl := CountZickl + 1;
       StackCount [CountZickl] := Trunc ( WorkNum [1] );
       StackZickl [CountZickl] := CountLine
     end
 end;

Procedure End_Repeat;             {  КонецПовт:  Конец повторения команд(ы)  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if (CountLevel > 0) And (CountZickl > 0) then
     begin
       StackCount [CountZickl] := StackCount [CountZickl] - 1;
       if StackCount [CountZickl] = 0 then
         CountZickl := CountZickl - 1
                                      else
         CountLine  := StackZickl [CountZickl]
     end
 end;

Procedure If_Begin;               {  Если: Начало выбора одной из ветвей     }
 var zn : byte;
 begin
   if Teste_Argument ( 5,5 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,3],NumberT [2,3] );
   zn      := 0;
   if  Command = '='                       then zn := 1;
   if (Command = '<>') Or (Command = '><') then zn := 2;
   if  Command = '<'                       then zn := 3;
   if  Command = '<='                      then zn := 4;
   if  Command = '>'                       then zn := 5;
   if  Command = '>='                      then zn := 6;
   Command := Copy ( LineBuf,NumberT [1,5],NumberT [2,5] );
   if (zn = 0) Or (Command <> 'То') then
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg5b );  ErrorCode := True;
       Exit
     end;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   Command := Copy ( LineBuf,NumberT [1,4],NumberT [2,4] );
   if Write_Number ( Command,2 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   if CountLevel > 0 then
     begin
       if CountStrukt = MaxVar then           {  Превышена                  }
         begin                                {      вложенность структур   }
         if Not ModeScr then Set_TextMode;
         write ( ErrMsgAb );  ErrorCode := True;
         Exit
       end;
       CountStrukt               := CountStrukt + 1;
       StackStrukt [CountStrukt] := False;
       case zn of
         1 : if WorkNum [1] =  WorkNum [2] then
               StackStrukt [CountStrukt] := True;
         2 : if WorkNum [1] <> WorkNum [2] then
               StackStrukt [CountStrukt] := True;
         3 : if WorkNum [1] <  WorkNum [2] then
               StackStrukt [CountStrukt] := True;
         4 : if WorkNum [1] <= WorkNum [2] then
               StackStrukt [CountStrukt] := True;
         5 : if WorkNum [1] >  WorkNum [2] then
               StackStrukt [CountStrukt] := True;
         6 : if WorkNum [1] >= WorkNum [2] then
               StackStrukt [CountStrukt] := True
       end
     end
 end;

Procedure Else_Continue;          {  Иначе: Переключение индикатора выбора   }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if (CountLevel > 0) And (CountStrukt > 0) then
     StackStrukt [CountStrukt] := Not StackStrukt [CountStrukt]
 end;

Procedure End_If;                 {  ВсеЕсли: Выключение индикатора выбора   }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if (CountLevel > 0) And (CountStrukt > 0) then
     CountStrukt := CountStrukt - 1
 end;
