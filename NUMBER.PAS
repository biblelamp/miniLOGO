Procedure Create_Var;             {  ������:  ������� ��६�����  }
 var i : byte;
 begin
   if Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Teste_VarName ( Command ) then      {  �᫨ ���ࠢ��쭮� ���       }
         Exit;                                {      ��६�����              }
       if Find_VarName ( Command ) = 0 then   {  �᫨ ⠪�� ��६����� ���   }
         if VarNumb = MaxVar then             {  �᫨ ������ ��६�����      }
           begin                              {      ���������, ��           }
             ErrorCode := True;
             write ( Warning3 );              {  ��������������: ��� �����  }
             Exit                             {    ��६����� �� ᮧ������   }
           end
                             else
           begin
             VarNumb := VarNumb + 1;          {  ��������                    }
             VarName [VarNumb] := Command;    {           ����� ��६�����   }
             VarTabl [VarNumb] := 0
           end
      end
 end;

Procedure Input_Data;             {  �����:  ���� ��६�����    }
 var i,n,result : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,40 ) then
     Exit;
   for i := 2 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Teste_VarName ( Command ) then      {  �᫨ ���ࠢ��쭮� ���       }
         Exit;                                {      ��६�����              }
       n := Find_VarName ( Command );
       if NotFind_VarName ( n ) then          {  �᫨ ⠪�� ��६����� ���   }
         Exit;
{$I-  �⪫�砥� ��⥬�� ����஫� �� �����ﬨ �����-�뢮��  }
       repeat
         write  ( Command,' ? ' );            {  ���� ����� � ���������      }
         readln ( VarTabl [n] );              {               ��६�����     }
         result := IOResult;
         if result > 0 then writeln ( ErrMsgC )
       until result = 0
{$I+  ����砥�  ��⥬�� ����஫� �� �����ﬨ �����-�뢮��  }
     end
 end;

Procedure Input_Char;             {  ���������:  �������� ������ �� ��.  }
 var i,n1 : byte;
 begin
   if CountNm = 1 then
     Ch := ReadKey
                  else
     for i := 2 to CountNm do
       begin
         Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
         if Teste_VarName ( Command ) then    {  �᫨ ���ࠢ��쭮� ���       }
           Exit;                              {      ��६�����              }
         n1 := Find_VarName ( Command );
         if NotFind_VarName ( n1 ) then       {  �᫨ ⠪�� ��६����� ���   }
           Exit;
         Ch           := ReadKey;             {  ���� ���� ����⮩ ������   }
         VarTabl [n1] := Ord ( Ch )           {    � ��������� ��६�����    }
       end
 end;


Procedure Process_Numb;           {  ������:  ����� ��䬥��.��ࠦ���� �   }
 var n,i : byte;                  {           ��᢮���� ��� ����.��६����� }
 begin
   if Teste_Argument ( 4,40 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_VarName ( Command ) then          {  �᫨ ���ࠢ��쭮� ���       }
     Exit;                                    {      ��६�����              }
   n := Find_VarName ( Command );
   if NotFind_VarName ( n ) then              {  �᫨ ⠪�� ��६����� ���  }
     Exit;
   if Odd ( CountNm ) Or ( LineBuf [NumberT [1,3]] <> '=' ) then
     begin                                    {   �᫨ �᫮ ���. �⭮    }
       write ( ErrMsg5a ); ErrorCode := True; {   ��� ��� ����� "=", �� :    }
       Exit                                   {  ������ : ���ࠢ��쭮� ���.  }
     end;
   CountWr := 0;
   for i := 4 to CountNm do
     begin
       Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
       if Not Odd (i) then
         begin
           CountWr := CountWr + 1;
           if Write_Number ( Command,CountWr ) then
             Exit;                            {  ������ � �८�ࠧ������     }
         end                                  {   CountWr - � ��६�����     }
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

Procedure Output_Data;            {  �뢥��:  �뢮� ��६����� �  }
 var i : byte;                    {                ����⠭�       }
     n : integer;
 begin
   if Teste_Mode ( 1 ) then
     Exit;
   if CountNm > 1 then
     for i := 2 to CountNm do
       begin
         Command := Copy ( LineBuf,NumberT [1,i],NumberT [2,i] );
         if  Command = '!' then writeln        {  �᫨ ������ ���� '!', �   }
                           else                {  �ந�室�� ��ॢ�� ��ப�  }
           begin
             if (Command[1] = ':') then        {  �᫨ ������� ᯨ᪠        }
               begin                           {  ��稭����� � ":", � ��    }
                 n := Find_VarName ( Command );{  ��⠥��� ������ ��६��.  }
                 if Command = ':��'   then n := -1;
                 if Command = ':�'    then n := -2;
                 if Command = ':����' then n := -3;
                 if Command = ':��'  then n := -4;
                 if Command = ':����' then n := -5;
                 if n       = 0  then writeln;
                 if NotFind_VarName ( n ) then
                   Exit                        {  �᫨ ⠪�� ��६����� ���  }
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
           write ( ' ',Command )               {  �᫨ ������� ᯨ᪠ �� ��� }
         end                                   {  ��६�����,� �� ��⠥��� }
       end                                     {  ����⠭⮩ � �뢮�����     }
 end;
