Procedure Create_Procedure;       {  ��: �������� ��楤���              }
 var i,n1 : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,20 ) then
     Exit;
   Command := Copy ( LineBuf, NumberT [1,2], NumberT [2,2] );
   if Ord ( Command [0] ) > LengNam then
     begin
       write ( ErrMsg6,Command,' ?' );        {  ������: ������� ��� ���.   }
       ErrorCode := True;
       Exit
     end;
   if ZagNumb = MaxName then
     begin
       write ( Warning2 );                    {  �� 墠⠥� ����������       }
       ErrorCode := True;
       Exit
     end;
   if PrgNumb = MaxLine - 1 then
     begin
       write ( Warning1 );                    {  �� 墠⠥� ����� ���.    }
       ErrorCode := True;
       Exit
     end;
   if ZagNumb > 0 then                        {  �᫨ 㦥 ���� �����-�     }
     for i := 1 to ZagNumb do                 {  ��楤���, � ������ ��   }
        if Command = ZagName [i] then         {    �஢���� ��� �� :      }
          begin
            write ( ErrMsg7,Command,' ?');    {  ������: ����୮� ��।��. }
            ErrorCode := True;
            Exit
          end;
   {  ��᫥  ��� �஢�ப ��砫� ���� ��楤���  }
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

Procedure Write_Zagol;            {  ���������: �뢮� ���������� �� ���.  }
 var i,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   if ZagNumb > 0 then                        {  �᫨ ���� ��� ��  ����   }
     for i := 1 to ZagNumb do                 {           ��楤��        }
        begin
          n := LengNam + 1 - Ord (ZagName [i][0]);
          writeln ('��楤��: ', ZagName [i],',':n,
                   ' ��㬥�⮢:',ZagArg  [i]:2,',',
                   ' ��ப:',     ZagLeng [i]:3,'.')
        end
 end;

Procedure Write_Procedure ( n : byte ); {  �뢮� �� ��࠭ ��� �ਭ�� ⥪�� }
 var i : byte;
 begin
   if Dev = 0 then
     begin
       Assign  ( Lst, 'Prn' );
       Rewrite ( Lst );
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
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
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
       Close ( Lst )
     end
              else
     for i := 1 to ZagLeng [n] do
       begin
         writeln ( ProgTxt^[i + ZagTabl[n] - 1] );
         Delay ( 100 )
       end
 end;

Procedure Write_Variable ( n : byte );  {  �뢮� �� ��࠭ n-�� ��६�����    }
 var i : byte;
 begin
   if Dev = 0 then
     begin
       Assign  ( Lst, 'Prn' );
       Rewrite ( Lst );
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
       writeln ( Lst, VarName [n],'= ':23-Ord ( VarName [n][0] ),
                      VarTabl [n]:7:6 );
       if IOResult > 0 then
         begin
           write ( WarningD ); ErrorCode := True;
           Close ( Lst );
           Exit
         end;
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
       Close ( Lst )
     end
              else
     begin
       writeln (      VarName [n],'= ':23-Ord ( VarName [n][0] ),
                      VarTabl [n]:7:6 );
       Delay ( 100 )
     end
 end;

Procedure Write_All;              {  �⯥�⠩: �뢮� ᮤ�ন���� �����  }
 var i,j,k,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   Dev := 1;
   for j := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,j],NumberT [2,j] );
       k       := 5;
       if Command = '���㬠��'   then k := 0;
       if Command = '��'        then k := 1;
       if Command = '��楤���'  then k := 2;
       if Command = '��६����' then k := 3;
       if Command[1] = ':'       then k := 4;
       case k of
         0 : Dev := 0;
         1 : begin
               if ZagNumb > 0 then           {  �᫨ ���� ��� ��  ����     }
                 for i := 1 to ZagNumb do    {          ��楤��           }
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
         2 : if ZagNumb > 0 then             {  �᫨ ���� ��� �� ����      }
               for i := 1 to ZagNumb do      {          ��楤��           }
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
               if Teste_VarName ( Command ) then {  �᫨ ���ࠢ��쭮� ���   }
                 Exit;                           {      ��६�����          }
               n := Find_VarName ( Command );
               if NotFind_VarName ( n ) then     {  �᫨ ��६����� ���     }
                 Exit;
               Write_Variable ( n );
               if ErrorCode then  Exit
             end;
         5 : begin
               n := 0;
               for i := 1 to ZagNumb do
                 if ZagName [i] = Command then n := i;
               if n = 0 then                 {  ��楤��� � ⠪�� ������    }
                 begin                       {             ���              }
                   write ( ErrMsg0,Command,' ?' );
                   ErrorCode := True;
                   Exit
                 end;
               Write_Procedure ( n );
             end
       end
     end
 end;

Procedure Free_Memory;            {  ����������:  ��ꥬ ᢮������ �����  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   writeln ( '� ��襬 �ᯮ�殮��� ��ப: ',MaxLine - PrgNumb,
                           ', ����������: ',MaxName - ZagNumb,
                          ' � ��६�����: ',MaxVar  - VarNumb,'.')
 end;

Procedure Erase_All;              {  �����: ��࠭�� ࠡ�祩 �����      }
 var i,j,len,n : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
      begin
        Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
        Dev := 5;
        if Command = '��'        then Dev := 1;
        if Command = '��楤���'  then Dev := 2;
        if Command = '��६����' then Dev := 3;
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
                if Teste_VarName ( Command ) then {  �᫨ ���ࠢ��쭮� ���   }
                  Exit;                           {      ��६�����          }
                n := Find_VarName ( Command );
                if NotFind_VarName ( n ) then     {  �᫨ ��६����� ���     }
                  Exit;
                if n < VarNumb then
                  for j := n to VarNumb-1 do           {  ��������           }
                     begin                             {     ��६�����      }
                       VarTabl [j] := VarTabl [j+1];   {     ��⥬ ᤢ���    }
                       VarName [j] := VarName [j+1]    {     � VarTabl       }
                     end;
                VarNumb := VarNumb - 1
              end;
          5 : begin
                if ZagNumb = 0 then           {  �᫨ �� ᮧ���� �� �����    }
                  begin                       {           ��楤���          }
                    write ( ErrMsg0,Command,' ?' );  ErrorCode := True;
                    Exit
                  end;
                n := 0;
                for j := 1 to ZagNumb do
                  if ZagName [j] = Command then n := j;
                if n = 0 then                 {  ��楤��� � ⠪�� ������    }
                  begin                       {             ���              }
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

Procedure Edit_Procedure;         {  ��������: ।���஢���� ��楤��� }
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
   if num = 0 then                            {  ��楤��� � ⠪�� ������    }
     begin                                    {             ���              }
       write ( ErrMsg0,Command,' ?' );
       ErrorCode := True;
       Exit
     end;
   {   ��᫥  ���  �஢�ப  ��稭���  ।���஢����   }
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
     if LineBuf = KeyWord [20] then             {  �᫨ ����⨫��� ��ப�  }
       begin                                    {   � ᫮��� �����., ��:   }
         writeln ( KeyWord [20] ); Exit         {         ���������         }
       end;                                     {       ।���஢����      }
     Get_LineBuf ( 0, True );
     charter := Ch;
     Process_LineBuf;
     LengBuf := LengBuf - 1;
     Command := Copy ( LineBuf,NumberT [1,1],NumberT [2,1] );
     case charter of
       #27 : if n1 = 1 then                     {  ��������  ⥪�饩 ��ப�  }
               GotoXY ( 1, WhereY )             {  ��ࢠ� ��ப�  �� �����   }
                        else                    {         ���� ����        }
               begin
                 ProgTxt^[smh + n1 - 1] := '  ';
                 GotoXY ( 1, WhereY );
                 ClrEol
               end;
       #72 : if n1 = 1 then                     {  �����  �����             }
               GotoXY ( 1, WhereY )             {  ��� 1-� ��ப� ��������� }
                       else                     {          � � � � � �       }
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
   #13,#80 : begin                              {  ����� ����               }
               ProgTxt^[smh + n1 - 1] := LineBuf;
               n1 := n1 + 1;
               if WhereY = 16 then writeln
                              else GotoXY ( 1, WhereY + 1 )
             end;
       #82 : if (ZagLeng [num] < MaxVar) And (PrgNumb < MaxLine ) then
               begin                            {  ������� ����� ��ப�      }
                 writeln;
                 InsLine;
                 PrgNumb       := PrgNumb + 1;
                 ZagLeng [num] := ZagLeng [num] + 1;
                 for i := PrgNumb downto ( smh + n1 ) do
                   ProgTxt^[i] := ProgTxt^[i - 1];
                 ProgTxt^[smh + n1] := '  ';
                 n1 := n1 + 1
               end;
       #83 : if n1 = 1 then                     {  �������� ⥪�饩 ��ப�   }
               GotoXY ( 1, WhereY )             {  ��ࢠ� ��ப�  �� �����   }
                        else                    {         ���� 㤠����       }
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

Procedure Clear_Memory;           {  ���砫�:  ������ ࠡ���� ������  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 1,1 ) then
     Exit;
   PrgNumb := 0; CountLevel := 0;
   VarNumb := 0;
   ZagNumb := 0
 end;
