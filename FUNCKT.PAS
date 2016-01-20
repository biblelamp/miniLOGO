Procedure Function_All;           {  * Обработка встроенных функций *   }
 var i,n : byte;
 begin
   Randomize;
   if Teste_Argument ( 3,3 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   Command := Copy ( LineBuf,NumberT [1,3],NumberT [2,3] );
   if Teste_VarName ( Command ) then          {  Если неправильное имя       }
     Exit;                                    {      переменной              }
   n := Find_VarName ( Command );
   if NotFind_VarName ( n ) then              {  Если такой переменной нет   }
     Exit;
   Command := Copy ( LineBuf,NumberT [1,1],NumberT [2,1] );
   case Dev of
      1 : VarTabl [n] := Abs    ( WorkNum [1] );
      2 : VarTabl [n] := ArcTan ( WorkNum [1] * 180 / Pi );
      3 : if WorkNum [1] = 0 then VarTabl [n] := Random
                             else
            VarTabl [n] := Random ( Trunc ( WorkNum [1] ) );
      4 : VarTabl [n] := Frac ( WorkNum [1] );
      5 : if WorkNum [1] > 0 then VarTabl [n] := Sqrt ( WorkNum [1] )
                             else
            begin
              write ( ErrMsgE, Command,' ?' );  ErrorCode := True
            end;
      6 : VarTabl [n] := Cos   ( WorkNum [1] * Pi / 180 );
      7 : VarTabl [n] := Ln    ( WorkNum [1] );
      8 : VarTabl [n] := Round ( WorkNum [1] );
      9 : VarTabl [n] := Sin   ( WorkNum [1] * Pi / 180 );
     10 : if (WorkNum [1] <> 90) And (WorkNum [1] <> 270) then
            VarTabl [n] := Sin ( WorkNum [1] * Pi / 180 ) /
                           Cos ( WorkNum [1] * Pi / 180 )
                                                          else
            begin
              write ( ErrMsgE, Command,' ?' );  ErrorCode := True
            end;
     11 : VarTabl [n] := Trunc ( WorkNum [1] );
     12 : VarTabl [n] := Exp   ( WorkNum [1] )
   end
 end;

Procedure Play_Music;             {  Играй: Исполнение заданной мелодии  }
 var i,n : byte;
     k,d : integer;
     r   : real;
     c   : char;
 const
      Tempo = 1500;
      Notes : array [1..12,0..6] of integer =
              ( (  66, 131, 262, 523, 1047, 2094, 4188 ),
                (  69, 139, 277, 554, 1109, 2218, 4436 ),
                (  73, 147, 294, 587, 1175, 2350, 4700 ),
                (  78, 156, 311, 622, 1247, 2490, 4980 ),
                (  83, 165, 330, 659, 1319, 2638, 5276 ),
                (  87, 175, 349, 699, 1397, 2794, 5588 ),
                (  93, 185, 370, 740, 1480, 2960, 5920 ),
                (  98, 196, 392, 784, 1568, 3136, 6272 ),
                ( 104, 208, 415, 831, 1661, 3322, 6644 ),
                ( 110, 220, 440, 880, 1760, 3520, 7040 ),
                ( 117, 233, 466, 932, 1865, 3730, 7460 ),
                ( 123, 247, 494, 988, 1975, 3950, 7900 ) );
 begin
   if Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       case Command [1] of
         '1'..'9' : begin
                      Val ( Command, r, k );
                      if k > 0 then
                        begin
                          write ( ErrMsgGa );  ErrorCode := True;
                          Exit
                        end
                               else
                        Dliteln := Trunc ( r )
                    end;
         'o','O'  : begin
                      n := Ord ( Command [2] ) - 48;
                      if (n >= 0) And (n <= 6) then Oktava := n
                                               else
                        begin
                          write ( ErrMsgGa );  ErrorCode := True;
                          Exit
                        end
                    end;
         'p','P'  : begin
                      d := Tempo Div Dliteln;
                      if Command [LengCom] = '.' then
                        d := d + ( d div 2 );
                    end;
         'c','d','e','f','g','a','h','C','D','E','F','G','A','H' :
                    begin
                      c := UpCase ( Command [1] );
                      d := Tempo Div Dliteln;
                      if Command [LengCom] = '.' then
                        d := d + ( d div 2 );
                      case c of
                        'C' : n := 1;
                        'D' : n := 3;
                        'E' : n := 5;
                        'F' : n := 6;
                        'G' : n := 8;
                        'A' : n := 10;
                        'H' : n := 12;
                      end;
                      if LengCom > 1  then
                        begin
                          if Command [2] = '#' then n := n + 1;
                          if Command [2] = '-' then n := n - 1
                        end;
                      Sound ( Notes [n,Oktava] );
                      Delay ( d );
                      NoSound;
                      Delay ( 10 )
                    end
             else   begin
                      write ( ErrMsgGa );  ErrorCode := True; Exit
                    end
       end
     end
 end;
