Procedure Read_File;              {  ����: �⥭�� �ணࠬ�� � ��᪠     }
 var i,count : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   Assign  ( FileName,Command+'.log' );
   Reset   ( FileName );
   if IOResult > 0 then
     begin
       write ( WarningA,Command,' !' );  ErrorCode := True;
       Exit
     end;
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   PrgNumb := 0;
   while Not Eof ( FileName ) do
     begin
       PrgNumb := PrgNumb + 1;
       readln  ( FileName, ProgTxt^[PrgNumb] )
     end;
   Close   ( FileName );
   ZagNumb := 0; CountLevel := 0;
   count   := 0;
   for i := 1 to PrgNumb do
     begin
       count   := count + 1;
       LineBuf := ProgTxt^[i];
       Process_Linebuf;
       Command := Copy ( LineBuf,NumberT [1,1],NumberT [2,1] );
       if Command = KeyWord [45] then
         begin
           count   := 1;
           ZagNumb := ZagNumb + 1;
           ZagTabl [ZagNumb] := i;
           ZagName [ZagNumb] := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
           ZagArg  [ZagNumb] := CountNm - 2
         end;
       if Command = KeyWord [20] then
         begin
           ZagLeng [ZagNumb] := count;
           writeln ( Warning0, ZagName [ZagNumb],'.' )
         end
     end
 end;

Procedure Write_File;             {  ���࠭�: ������ �ணࠬ�� �� ���    }
 var i : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
   Assign  ( FileName,Command+'.log' );
   Rewrite ( FileName );
   for i := 1 to PrgNumb do
      writeln ( FileName, ProgTxt^[i] );
   Close   ( FileName )
 end;

Procedure Read_Image;             {  ����������: �⥭�� ��䨪� � ��᪠   }
 var i,j : byte;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   Assign  ( FileName,Command+'.pic' );
   Reset   ( FileName );
   if IOResult > 0 then
     begin
       write ( WarningB,Command,' !' );  ErrorCode := True;
       Exit
     end;
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   for i := 1 to 67 do
     for j := 1 to 254 do
       read ( FileName, Screen [i,j] );
   Close   ( FileName );
   if ModeScr then Set_GraphMode
              else PutPic ( Screen,0,199 )
 end;

Procedure Write_Image;            {  ��������:  ������ ��䨪� �� ���    }
 var i,j : byte;
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
   Assign  ( FileName,Command+'.pic' );
   Rewrite ( FileName );
   for i := 1 to 67 do
     for j := 1 to 254 do
       write ( FileName, Screen [i,j] );
   Close   ( FileName )
 end;

Procedure Erase_File;             {  ����:  �������� �ணࠬ�� � ��᪠   }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   Assign  ( FileName,Command+'.log' );
   Erase   ( FileName );
   if IOResult > 0 then
     begin
       write ( WarningA,Command,' !' );  ErrorCode := True;
       Exit
     end
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
 end;

Procedure Erase_Image;            {  ���ਊ���: �������� ��䨪� � ��᪠  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Teste_FileName ( Command ) then
     Exit;
{$I-  �⪫�祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
   Assign  ( FileName,Command+'.pic' );
   Erase   ( FileName );
   if IOResult > 0 then
     begin
       write ( WarningB,Command,' !' );  ErrorCode := True;
       Exit
     end
{$I+   ����祭�� ��⥬���� ����஫� �� �����ﬨ ����� - �뢮��   }
 end;
