Program RusLogo;
Uses Crt,
     Dos,
     Graph3,
     Printer;
Const
     ErrMsg0  = '�� ⠪�� ';
     ErrMsg1  = '��祬 ��譨� ����� ������� ';
     ErrMsg2  = '��祬� �� 墠⠥� ������ ������� ';
     ErrMsg3a = '��� �����稥 � ��砫� ����� ��६����� ';
     ErrMsg3b = '��祬 ��६����� ⠪�� ������� ��� ';
     ErrMsg4  = '��祬� �� ᮧ���� ��६����� ';
     ErrMsg5a = '� 祬� ����᪠�� �訡�� � ��ࠦ���� ?';
     ErrMsg5b = '� 祬� ����᪠�� �訡�� � ������� �᫨ ?';
     ErrMsg6  = '��祬 ��楤�� ⠪�� ������� ��� ';
     ErrMsg7  = '��祬 �� ���� ��楤�� ';
     ErrMsg8  = '��祬 �ணࠬ�� ��� ���⨭� ⠪�� ������� ��� ';
     ErrMsg9  = '��祬 �ணࠬ�� ��� ���⨭� ���宥 ��� ';
     ErrMsgAa = '��� 祣� ⠪ ����� �맮��� ��楤�� ?';
     ErrMsgAb = '��� 祣� ⠪ ����� �������� ������� ?';
     ErrMsgBa = '��祬 ��譨� ����� ��楤�� ';
     ErrMsgBb = '��祬� �� 墠⠥� ������ ��楤�� ';
     ErrMsgC  = '��祬 ������� ���宥 �᫮ ?';
     ErrMsgD  = '��� 祣� ������ �� 0 � ��ࠦ���� ?';
     ErrMsgE  = '� 祬� ���宩 ��㬥�� ��� �㭪樨 ';
     ErrMsgGa = '� 祬� ���娥 ����� ��� ������� ��ࠩ ?';
     Warning0 = '����⭮, �� ⠪�� ';
     Warning1 = '�� 墠⠥� ����� ��� �ணࠬ�� !';
     Warning2 = '�� 墠⠥� ����� ��� ���������� !';
     Warning3 = '�� 墠⠥� ����� ��� ��६����� !';
     Warning4 = '� ����᪮� ०��� ����� ����������� ';
     WarningA = '�� ������� �ணࠬ�� � ������ ';
     WarningB = '�� ������� ���⨭� � ������ ';
     WarningC = '��� �� ��⮢ � ࠡ�� !';
     WarningD = '�ਭ�� �� ��⮢ � ࠡ�� !';
     WarningZ = '�ਭ㤨⥫쭮 ��⠭������ !';
     MaxLine = 819;                     {  ���ᨬ.�᫮ ��ப ⥪��     }
     MaxName = 255;                     {  ���ᨬ.�᫮ ����������       }
     MaxVar  = 255;                     {  ���ᨬ���oe �᫮ ��६����  }
     LengNam = 20;                      {  ���ᨬ��쭠� ����� �����      }
     KeyCode  : array [-11..45] of char =
           ( #104,#105,#106,#107,#108,#109,#110,#111,#112,#113, #94, #95,
              #38, #45, #32, #25, #37, #04, #33, #48, #31, #02, #22, #12,
              #20, #50, #16, #60, #06, #24, #09, #19, #18, #21, #59, #34,
              #07, #65, #64, #63, #66, #46, #03, #67, #47, #35, #36, #61,
              #62, #44, #68, #14, #01, #30, #23, #17, #49 );
     KeyWord  : array [-11..45] of string [10] =
           ( '��᮫�⭮�','�઒������','�롮�'     ,'�஡�',
             '��७�2'   ,'��ᨭ��'   ,'�⋮����','���㣫���',
             '�����'     ,'�������'   ,'�����'     ,'��ᯮ����',
             '��������'  ,'������⥦�','�����'     ,'���������',
             '�����'     ,'���।'    ,'��ࠢ�'    ,'�᥅᫨',
             '�뢥��'    ,'�멤�'     ,'��䨪�'   ,'��',
             '�᫨'      ,'�����'    ,'������'   ,'���������',
             '��ࠩ'     ,'����'     ,'��࠭���'  ,'�����.',
             '����揮��' ,'�����'     ,'�⯥�⠩' ,'�����',
             '������'    ,'����������','����'    ,'��������',
             '����������','������'    ,'���砫�'   ,'������',
             '��������'  ,'����'     ,'���ਊ���','���࠭�',
             '��������'  ,'������'    ,'�����'    ,'��',
             '�����'     ,'���'       ,'����'     ,'�����',
             '��' );
Type
     Line79 = string [79];
     LineNm = string [LengNam];
     Arr1 = array [1..MaxLine]   of Line79;
     Arr2 = array [1..MaxVar]    of real;
     Arr3 = array [1..MaxVar]    of LineNm;
     Arr4 = array [1..MaxName]   of integer;
     Arr5 = array [1..MaxName]   of LineNm;
     Arr6 = array [1..MaxName]   of byte;
     Arr7 = array [1..2,1..40]   of byte;
     Arr8 = array [1..18]        of real;
     Arr9 = array [1..17]        of char;
     ArrA = array [1..MaxVar]    of boolean;
     ArrS = array [1..67,1..254] of char;
     MemoryProgram = ^Arr1;
Var
     FileName,
     Lst     : Text;
     ProgTxt : MemoryProgram;         {     ��ப� ⥪�� �ணࠬ��         }
     PrgNumb : integer;               {  �����⥫� ����� ⥪�� �ணࠬ��   }
     VarTabl : Arr2;                  {     ���ᨢ ���祭��      ��६����� }
     VarName : Arr3;                  {  ���ᨢ ����          ��६�����    }
     VarNumb : byte;                  {  �����⥫� ������⢠ ��६�����    }
     ZagTabl : Arr4;                  {     ���ᨢ ����஢ ��ப ���������� }
     ZagName : Arr5;                  {  ���ᨢ ����            ����������  }
     ZagArg  : Arr6;                  {  ���ᨢ ���. ��㬥�⮢ ����������  }
     ZagLeng : Arr6;                  {  ���ᨢ ���� ��楤��   ����������  }
     ZagNumb : byte;                  {  �����⥫� ������⢠   ����������  }
     Screen  : ArrS;
     LineBuf,                         {     ���� ����� ��ப�              }
     PredBuf,                         {  �।���� ��ப�                  }
     Command : Line79;                {  ������ ��६�����,⥪��� ��ப�  }
     LengBuf : byte absolute LineBuf; {  ����� ���� �室���  ��ப�       }
     LengCom : byte absolute Command; {  ����� ���� ������� ��ப�       }
     NumberT : Arr7;                  {     ���ᨢ ࠧ������� ���� ��ப� }
     CountNm : byte;                  {  ������⢮ ������⮢ ࠧ�������    }
     WorkNum : Arr8;                  {  ���ᨢ ࠧ������� ���.��ࠦ����  }
     ProcChr : Arr9;                  {  ���ᨢ ������ ����権 � ��ࠦ���� }
     CountWr : byte;                  {  ������⢮ ������⮢ ࠧ�������    }
     ColorText, GroundText,           {     ���� ᨬ����� � 䮭� � ⥪��   }
     ColorGraph,GroundGraph,          {     ���� ����� � 䮭�    � ��䨪�  }
     Oktava,Dliteln,                  {  ����� ⥪�饩 ��⠢� � ���⥫�.   }
     Dev,
     CountLevel   : byte;             {  ���稪 �������� ��楤��          }
     CountLine    : integer;          {     ���稪 ��ப                   }
     StackReturn  : Arr4;             {     �⥪ �����⮢ /����� ��ப/   }
     ProcNumber   : byte;             {  ����� ⥪�饩 ��楤���            }
     StackZickl   : Arr4;             {     �⥪ ���ᮢ ������ �� ����� }
     StackCount   : Arr4;             {  �⥪ ���稪�� ����७�� 横���   }
     CountZickl   : byte;             {  ���稪 �᫠ �������� 横��       }
     StackStrukt  : ArrA;             {     �⥪ �������� ������� �᫨-��  }
     CountStrukt  : byte;             {  ���稪 �������� ������� �᫨-��  }
     GraphX,GraphY,
     Ugol         : integer;
     y,m,d,d1     : byte;
     Ch           : char;
     ModeScr,                         { ��࠭       True:⥪�� False:���.  }
     ModePenTur,                      { ���        True:����. False:����.  }
     ModeTurtle,                      { ��९��    True:���.  False:�����. }
     FindCommd,                       { �ਧ�.���. True:����. False:������.}
     ErrorCode,                       { ��� �訡��  True:����  False:���    }
     flag1        : boolean;

Procedure Set_TextMode;               {  ��⠭���� ⥪�⮢���   ०���      }
 var i,j : byte;
 begin
   GraphX := XCor;
   GraphY := YCor;
   Ugol   := Heading;
   GetPic ( Screen,0,0,319,199 );
   TextMode ( C80 );
   Window ( 1,1,80,25 ); TextBackGround ( 0 ); TextColor ( 3 );
   for i := 1 to 3 do
     for j := 1 to 7 do
       begin
         GotoXY ( i*13 - 10, j ); write ( KeyWord [i*7-7+j] )
       end;
   for i := 4 to 6 do
     for j := 1 to 8 do
       begin
         GotoXY ( i*13 - 10, j ); write ( KeyWord [i*8-8+j-3] )
       end;
   GotoXY ( 1,8 ); for i := 1 to 40 do write ( '�' );
   TextBackGround ( 3 );
   TextColor ( 0 );
   GotoXY ( 2,25 ); write ( '�⯥�  ������  ���࠭  ������  ������  ',
                            '����  ������  C�����  ������  �����' );
   TextBackGround ( 0 );
   TextColor ( 14 );
   GotoXY ( 1,25 ); write ( '1' );
   for i := 1 to 9 do
     begin
       GotoXY ( i*8,25 );  write ( (i+1):2 )
     end;
   GotoXY ( 9,1 );  write ('�');  GotoXY ( 6,2 );  write ('�');
   GotoXY ( 3,3 );  write ('�');  GotoXY ( 8,4 );  write ('�');
   GotoXY ( 4,5 );  write ('�');  GotoXY ( 2,6 );  write ('^�');
   GotoXY ( 6,7 );  write ('�');  GotoXY ( 22,1 ); write ('�');
   GotoXY ( 17,2 ); write ('�');  GotoXY ( 15,3 ); write ('^');
   GotoXY ( 20,3 ); write ('�');  GotoXY ( 16,4 ); write ('�');
   GotoXY ( 15,5 ); write ('^�'); GotoXY ( 15,6 ); write ('^�');
   GotoXY ( 21,7 ); write ('�');  GotoXY ( 28,1 ); write ('^�');
   GotoXY ( 28,3 ); write ('^');  GotoXY ( 32,3 ); write ('�');
   GotoXY ( 28,4 ); write ('^');  GotoXY ( 32,4 ); write ('�');
   GotoXY ( 28,5 ); write ('^');  GotoXY ( 36,5 ); write ('�');
   GotoXY ( 29,6 ); write ('�');  GotoXY ( 28,7 ); write ('^�');
   GotoXY ( 42,1 ); write ('�');  GotoXY ( 42,3 ); write ('�');
   GotoXY ( 41,4 ); write ('^�'); GotoXY ( 55,1 ); write ('�');
   GotoXY ( 54,2 ); write ('^�'); GotoXY ( 62,4 ); write ('�');
   GotoXY ( 58,5 ); write ('�');  GotoXY ( 56,6 ); write ('�');
   GotoXY ( 71,1 ); write ('�');  GotoXY ( 67,3 ); write ('^�');
   GotoXY ( 67,4 ); write ('^�'); GotoXY ( 68,5 ); write ('�');
   GotoXY ( 67,6 ); write ('^�'); GotoXY ( 68,7 ); write ('�');
   GotoXY ( 69,8 ); write ('�');
   TextBackGround ( GroundText ); TextColor ( ColorText );
   Window ( 1,9,80,24 );
   ClrScr;
   ModeScr := True
 end;

Procedure Set_GraphMode;              {  ��⠭���� ����᪮�� ०���      }
 begin
   ModeScr := False;
   if Ugol > 359 then Ugol := Ugol - 359;
   if Ugol < 0   then Ugol := Ugol + 360;
   GraphColorMode;                           {  ��⠭�������� 梥⭮�       }
   Palette (3);                              {           ����᪨� ०��  }
   GraphBackGround ( GroundGraph  );         {  ������� 䮭                }
   SetPenColor     ( ColorGraph   );         {  ������� 梥� ���          }
   PutPic          ( Screen,0,199 );         {  ����⠭�������� ��࠭,      }
   SetPosition     ( GraphX,GraphY );        {  ������ �९��,           }
   SetHeading      ( Ugol );                 {  㣮� �� ������,           }
   if ModeTurtle then ShowTurtle             {  ��ࠬ���� �९�� �        }
                 else HideTurtle;
   if ModeTurtle then TurtleDelay ( 1500 )   {  ᪮p���� �p����, �        }
                 else Turtledelay ( 0 );
   if ModePenTur then PenDown                {  梥� ��� �९��          }
                 else PenUp;
   Wrap                                      {  ������ �� ��⨢.��஭� }
 end;

Function Teste_Mode ( ScrMode : byte ): Boolean;
 begin
   Teste_Mode := False;
   if (Not ModeScr) And (ScrMode = 1) then
     begin                                    {  �஢������ ��� ������� : }
       if Not ModeScr then Set_TextMode;      {    0 - ����᪠�         }
       write ( Warning4,Command,' !');        {    1 - ⥪�⮢��           }
       ErrorCode  := True;                    {    2 - ᬥ蠭���           }
       Teste_Mode := True
     end
 end;

Function Teste_Argument ( n1,n2 : byte ) : Boolean;
 begin
   Teste_Argument := False;
   if CountNm < n1 then                       {  ��㬥�⮢ �� ����� n1 - 1 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg2,Command,' ?' );        {  ������ : ���� ��㬥�⮢ �  }
       ErrorCode      := True;                {           � �������          }
       Teste_Argument := True;
       Exit
     end;
   if CountNm > n2 then                       {  ��㬥�⮢ �� ����� n2 - 1 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg1,Command,' ?' );        {  ������ : ��譨� ��㬥���   }
       ErrorCode      := True;                {           � �������          }
       Teste_Argument := True
     end
 end;

Function Teste_ArgProc  ( n1,n2 : byte ) : Boolean;
 begin
   Teste_ArgProc := False;
   if CountNm < n1 then                       {  ��㬥�⮢ �� ����� n1 - 2 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsgBb,Command,' ?' );       {  ������ : ���� ��㬥�⮢ �  }
       ErrorCode     := True;                 {           � ��楤���        }
       Teste_ArgProc := True;
       Exit
     end;
   if CountNm > n2 then                       {  ��㬥�⮢ �� ����� n2 - 2 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsgBa,Command,' ?' );       {  ������ : ��譨� ��㬥���   }
       ErrorCode     := True;                 {           � ��楤���        }
       Teste_ArgProc := True
     end
 end;

Function Teste_VarName ( NameVar : Line79 ) : boolean;
 var leng : byte absolute NameVar;
 begin
   Teste_VarName := False;
   if NameVar[1] <> ':' then
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg3a,NameVar,' ?');        {  ������ : ��� �������  �  }
       ErrorCode     := True;                 {           ����� ��६�����  }
       Teste_VarName := True
     end
                        else
   if leng > LengNam then
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg3b,NameVar,' ?');        {  ������ : ᫨誮�  �������  }
       ErrorCode     := True;                 {           ��� � ��६�����  }
       Teste_VarName := True
     end
 end;

Function Find_VarName  ( NameVar : Line79 ) : byte;
 var i : byte;
 begin
   Find_VarName := 0;                         {  �᫨ ��६����� ���,       }
   if VarNumb > 0 then                        {       �� ����� ࠢ�� 0      }
     for i := 1 to MaxVar do
        if NameVar = VarName [i] then  Find_VarName := i
 end;

Function NotFind_VarName  ( n1 : byte ) : boolean;
 begin
   NotFind_VarName := False;
   if n1 = 0 then                             {  �᫨ ����� ��६����� = 0   }
     begin                                    {            �� :              }
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg4,Command,' ?');         {  ������ : ��६����� �� ᮧ. }
       ErrorCode       := True;
       NotFind_VarName := True
     end
 end;

Function Write_Number  ( NameStr : Line79;
                               i : byte ) : boolean;
 var n : byte; k : integer; r : real;
 begin
   Write_Number := False;
   if NameStr = ':��'   then NameStr := '3.1415926536';
   if NameStr = ':�'    then NameStr := '2.718281828';
   if NameStr = ':����' then Str ( GraphX, NameStr );
   if NameStr = ':��'  then Str ( GraphY, NameStr );
   if NameStr = ':����' then Str ( Ugol,   NameStr );
   Val ( NameStr,r,k );
   if k > 0 then
     begin
       if Teste_VarName ( NameStr ) then
         begin
           Write_Number := True;
           Exit
         end;
       n := Find_VarName  ( NameStr );
       if NotFind_VarName ( n ) then
         Exit
                                else
         WorkNum [i] := VarTabl [n]
     end
            else WorkNum [i] := r
 end;

Function Teste_FileName ( FileName : Line79 ) : Boolean;
 var leng : byte absolute FileName;
        i : byte;
        c : char;
 begin
   Teste_FileName := False;
   if leng > 8 then
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg8,Filename,' ?' );
       Teste_FileName := True;
       ErrorCode      := True;
       Exit
     end;
   for i := 1 to leng do
      begin
        c := FileName [i];
        case c of
          '0'..'9','-','_' : ;
          'A'..'z'         : ;
             else  begin
                     if Not ModeScr then Set_TextMode;
                     write ( ErrMsg9,Filename,' ?' );
                     Teste_FileName := True;
                     ErrorCode      := True;
                     Exit
                   end
        end
      end
 end;

{$I Funckt.pas    ������祭�� 䠩�� � �㭪�ﬨ :
                       ��᮫�⭮�, �઒������, �롮�, �஡�,  ��७�2,
                       ��ᨭ��, �⋮����, ���㣫���, �����, �������,
                       �����,   ��ᯮ����            � �������� ��ࠩ  }

{$I Graphs.pas    ������祭�� 䠩�� � ���������
                  ��������, ��������, ������, ������, ������⥦�,
                  �����, ��࠭���, ���।, �����, ��ࠢ�, �����, ��  }

{$I Number.pas    ������祭�� 䠩�� � ���������
                  ������, �����, ���������, ������, �뢥��  }

{$I Screen.pas    ������祭�� 䠩�� � ���������  �����, ��䨪�, ����, ���  }

Procedure Get_LineBuf ( n1 : byte; flag : boolean );
 var j,k,uk : byte;
     i      : integer;
 begin
   if flag then
     write ( LineBuf )
           else
     begin
       LengBuf := n1;
       if LengBuf > 0 then
         begin
           for i := 1 to LengBuf do LineBuf [i] := ' ';
           write ( LineBuf )
         end
     end;
   uk := LengBuf;
   Ch := #0;
   while Ch <> #13 do
     begin
       Ch := ReadKey;
       case Ch of
         #8       : if (LengBuf > 0) And (uk = LengBuf) then
                      begin
                        LineBuf [uk] := ' ';
                        write (#8,' ',#8);
                        uk      := uk - 1;
                        LengBuf := uk
                      end;
         ' '..'�' : if uk < 79 then
                      begin
                        write (Ch);
                        uk := uk + 1;
                        if uk > LengBuf then LengBuf := uk;
                        LineBuf [uk] := Ch
                      end;
          #0..#31 : begin
                      if  Ch = #0 then Ch := ReadKey;
                      if (Ch = #72) Or (Ch = #80) Or (Ch = #83) Or
                         (Ch = #82) Or (Ch = #27)  then
                        Exit;
                      if  Ch = #71  then                     {  �����       }
                        begin                                {    � ��砫�   }
                          GotoXY ( 1, WhereY );              {       ��ப�  }
                          uk := 0
                        end;
                      if  Ch = #79  then                     {  �����       }
                        begin                                {    � �����    }
                          GotoXY ( LengBuf+1, WhereY );      {       ��ப�  }
                          uk := LengBuf
                        end;
                      if (Ch = #75) And (uk > 0)       then  {  �����       }
                        begin                                {        �����  }
                          write ( #8 ); uk := uk - 1
                        end;
                      if (Ch = #77) And (uk < LengBuf) then  {  �����       }
                        begin                                {        ��ࠢ� }
                          uk := uk + 1; write ( LineBuf[uk] )
                        end;
                      if LengBuf < 65 then
                        for i := -11 to 45 do
                          if Ch = KeyCode [i] then
                            begin
                              write ( KeyWord [i],' ' );
                              if i = 20 then
                                begin
                                  GotoXY ( 1,WhereY ); write ( KeyWord [i] );
                                  ClrEol;
                                  LineBuf := KeyWord [20];
                                  Ch      := #80;
                                  Exit
                                end;
                              k := Ord ( KeyWord [i][0] );
                              for j := 1 to k do
                                LineBuf [uk+j] := KeyWord [i][j];
                              LineBuf [uk+k+1] := ' ';
                              uk := uk + k + 1;
                              if uk > LengBuf then LengBuf := uk
                            end
                    end
       end
     end
end;

Procedure Process_LineBuf;
 var i  : byte;
     c1 : char;
 begin
   LineBuf := Linebuf + ' ';
   CountNm := 0;
   c1      := ' ';
   for i := 1 to LengBuf do
      begin
        Ch := LineBuf[i];
        if (c1 = ' ')  And (Ch <> ' ') then
          begin
            NumberT [1,CountNm+1] := i ;
            CountNm := CountNm + 1
          end;
        if (c1 <> ' ') And (Ch = ' ')  then
          NumberT [2,CountNm] := i - NumberT [1,CountNm];
        c1 := Ch
      end
 end;

{$I Memory.pas    ������祭�� 䠩�� � ��������� ��, ���������, �⯥�⠩
                                        ����������,�����,��������,���砫� }

{$I FileRW.pas    ������祭�� 䠩�� � ��������� ��⠩, ��⠩����,
                                        ����, ���ਊ���, ���࠭�, ��������  }

{$I WorkPr.pas    ������祭�� 䠩�� � ��������� �멤�, �����, �����, ������
                                    �����-����揮��, �᫨-��-����-�᥅᫨ }

Procedure Interpreter_Line;
 label      Error;
 var n    : byte;
     i,n1 : integer;
     c    : char;
 begin
  repeat
   if CountLevel > 0 then
     begin
       CountLine := CountLine + 1;
       LineBuf   := ProgTxt^[CountLine]
     end;
   Process_LineBuf;
   Command := Copy ( LineBuf,NumberT [1,1],NumberT [2,1] );
   if ((CountNm > 0) And            {  � ��ப� ��-� ���� � �������� ���  }
       (CountStrukt = 0)) Or        {                ���                    }
      ((CountNm > 0) And            {  �������� ����, �� �롮ઠ ࠧ�襭�  }
       (CountStrukt > 0) And StackStrukt [CountStrukt]) Or
      ((CountStrukt > 0) And
       (Command = KeyWord [08]) Or
       (Command = KeyWord [10]) Or
       (Command = KeyWord [18]) Or
       (Command = KeyWord [20]) Or
       (Command = KeyWord [41])) then
     begin
       FindCommd := True;
       ErrorCode := False;
       n1        := 46;
       {   ����  �������  �� �����   }
       for i := -11 to 45 do
         if Command = KeyWord[i] then n1 := i;  {   �������   �������       }
       if n1 < 1 then                           {  �᫨ �����㦥�� �㭪��  }
         begin                                  {            �� :           }
           Dev := n1 + 12;  Function_All        {  �������� �� ���.����� }
         end;
       case n1 of
           1 : Pen_Up;          23 : Write_All;
           2 : Clear_Screen;    24 : Repeat_Begin;
           3 : Input_Data;      25 : Show_Turtle;
           4 : Input_Char;      26 : Read_Image;
           5 : Left_Turtle;     27 : Read_File;
           6 : Forwd_Turtle;    28 : Edit_Procedure;
           7 : Right_Turtle;    29 : Free_Memory;
           8 : End_If;          30 : Process_Numb;
           9 : Output_Data;     31 : Clear_Memory;
          10 : Exit_Procedure;  32 : Create_Var;
          11 : Clear_Graph;     33 : Pen_Down;
          12 : Set_Position;    34 : Erase_File;
          13 : If_Begin;        35 : Erase_Image;
          14 : Erase_All;       36 : Write_File;
          15 : Exit_System;     37 : Write_Image;
          16 : Write_Zagol;     38 : Hide_Turtle;
          17 : Play_Music;      39 : Clear_Scr;
          18 : Else_Continue;   40 : FindCommd := False;
          19 : Set_PenColor;    41 : Finish_Procedure;
          20 : Exit_Procedure;  42 : Color_Ground;
          21 : End_Repeat;      43 : Color_Text;
          22 : Back_Turtle;     44 : Home_Turtle;
                                45 : Create_Procedure;
          { �᫨ ������� �� ��������, � �ந�室�� ���� ��楤��� �� ����� }
          46 : begin
                 FindCommd := False;
                 if ZagNumb > 0 then   {  �᫨ ���� �����-����� ��楤���,  }
                   for n1 := 1 to ZagNumb do
                     if Command = ZagName [n1] then
                       begin
                         FindCommd := True;
                         if CountLevel = MaxVar then    {  �ॢ�襭�         }
                           begin                        {      �����������   }
                             if Not ModeScr then Set_TextMode; {    ��楤�� }
                             write ( ErrMsgAa );
                             ErrorCode := True;
                             goto Error
                           end;
                         if Teste_ArgProc ( ZagArg [n1]+1,ZagArg [n1]+1 )
                           then goto Error;
                         if CountNm > 1 then
                           for i := 2 to CountNm do
                             begin
                               Command := Copy ( LineBuf,
                                                 NumberT [1,i],NumberT [2,i] );
                               if Write_Number ( Command,i-1 ) then
                               goto Error
                             end;
                         if (ProcNumber <> n1) Or (CountLevel = 0) then
                           CountLevel := CountLevel + 1;
                         StackReturn [CountLevel] := CountLine;
                         CountLine  := ZagTabl [n1];
                         ProcNumber := n1;
                         LineBuf    := ProgTxt^[CountLine];
                         Process_LineBuf;
                         Command := Copy ( LineBuf,
                                           NumberT [1,2],NumberT [2,2] );
                         if Teste_ArgProc ( ZagArg [n1]+2,ZagArg [n1]+2 )
                           then goto Error;
                         if CountNm > 2 then
                           for i := 3 to CountNm do
                             begin
                               Command := Copy ( LineBuf,
                                                 NumberT [1,i],NumberT [2,i] );
                               if Teste_VarName ( Command ) then
                                 goto Error;
                               n := Find_VarName ( Command );
                               if NotFind_VarName ( n ) then
                                 goto Error;
                               VarTabl [n] := WorkNum [i-2]
                             end
                       end
               end
       end;
       if Not FindCommd then
         begin
           if Not ModeScr then Set_TextMode;
           write ( ErrMsg0,Command,' ?' );  ErrorCode := True
         end;
       if KeyPressed then                   {  �᫨ ����� ������, �� :   }
         begin                              {  �஢���� �� ���.  �᫨ ��  }
           c := ReadKey;                    {  ࠢ�� #27 ( ������ Esc ),  }
           if c = #27 then                  {              �� :            }
             begin                          {     �ந����� ���뢠���    }
               if Not ModeScr then Set_TextMode;
               writeln;
               write ( WarningZ );  ErrorCode := True
             end
         end;
Error: if ErrorCode then
         begin
           if CountLevel = 0 then writeln
                             else
             begin
               writeln ( ' � ��ப� :' );
               writeln ( LineBuf );
               writeln ( '�� �஢�� ',CountLevel,':',CountZickl+CountStrukt,
                         ' � ��楤�� ',ZagName [ProcNumber],'.');
               CountLevel := 0
             end
         end
     end
  until CountLevel = 0;
 end;

Begin
  flag1 := False;
  GetDir ( 0, Command );
{$I- �몫�祭��  ��⥬����  ����஫�  ���  �����ﬨ  �����-�뢮��  }
  {if Command <> 'C:\WORK\MLOGO' then
    begin
      Assign ( FileName,'mlogo.exe' );
      Erase  ( FileName );
      if IOResult > 0 then Inline ( $9B )
    end;}
{$I+ ����祭��   ��⥬����  ����஫�  ���  �����ﬨ  �����-�뢮��  }
  ColorText  := 3; GroundText  := 0;
  Set_TextMode;
  PrgNumb    := 0; CountLevel  := 0;
  VarNumb    := 0; CountZickl  := 0;
  ZagNumb    := 0; CountStrukt := 0;
  Oktava     := 3; Dliteln     := 8;
  ModePenTur := True;
  ModeTurtle := True;
  ColorGraph := 3; GroundGraph := 0;
  GraphX     := 0; GraphY      := 0;
  Ugol       := 0;
  TextColor ( 14 );
  writeln ('�������� - �� ��砫쭮�� ���祭�� �ணࠬ��஢����.');
  writeln (
  '��p�� 1.0 p��ࠡ�⠫ Braun User ( ��ࣥ� �.��� ),䥢ࠫ� 1990 �,����.');
  TextColor ( 3 );
  CountNm := 1;
  Free_Memory;
  New ( ProgTxt );
  PredBuf := KeyWord [31];
  flag1   := False;
  {   � � � � � � �   � � � �   }
  repeat
    Get_LineBuf ( 0,flag1 );
    flag1 := False;
    case Ch of
      #27 : begin
              GotoXY ( 1, WhereY ); ClrEol
            end;
      #72 : begin
              GotoXY ( 1, WhereY );
              LineBuf := PredBuf;
              flag1   := True
            end;
      else  begin
              writeln;
              PredBuf := LineBuf;
              Interpreter_Line;
              if Not ModeScr then
                begin
                  while Not KeyPressed do
                    begin
                      ShowTurtle; Delay (200); HideTurtle; Delay (150)
                    end;
                  Set_TextMode
                end
            end
    end
  until False
End.
