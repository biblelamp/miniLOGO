Procedure Pen_Up;                 {  ��������:  ������� ���  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then PenUp;
   ModePenTur := False
 end;

Procedure Pen_Down;               {  ��������:  ������� ���  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then PenDown;
   ModePenTur := True
 end;

Procedure Hide_Turtle;            {  ������: ������� "�९���" ���������  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then
     begin
       HideTurtle; TurtleDelay ( 0 );
     end;
   ModeTurtle := False
 end;

Procedure Show_Turtle;            {  ������: ������� "�९���"   �������  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then ShowTurtle;
     begin
       ShowTurtle; TurtleDelay ( 1500 );
     end;
   ModeTurtle := True
 end;

Procedure Clear_Screen;           {  ������⥦�: "�����" ��㭮� �� ���.���.}
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if ModeScr then Set_GraphMode;
   GraphX := XCor;
   GraphY := YCor;
   Ugol   := Heading;
   ClearScreen;
   SetPosition ( GraphX,GraphY );
   SetHeading  ( Ugol )
 end;

Procedure Home_Turtle;            {  �����: ���⠢��� "�९���" � ���.���. }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if ModeScr then Set_GraphMode;
   if ModePenTur then Draw ( XCor+159, 99-YCor, 159, 99, ColorGraph );
   Home
 end;

Procedure Set_PenColor;           {  ��࠭���: ����� 梥� ��� ����稢���� }
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   ColorGraph := Trunc ( WorkNum [1] );
   if Not ModeScr then SetPenColor ( ColorGraph )
 end;

Procedure Forwd_Turtle;           {  ���।: �������� "�९�誨" ���।  }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   d := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   Forwd ( d )
 end;

Procedure Back_Turtle;            {  ����� : �������� "�९�誨" �����   }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   d := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   Back ( d )
 end;

Procedure Right_Turtle;           {  ��ࠢ�: ������  "�९�誨" ��ࠢ�  }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   d    := Trunc ( WorkNum [1] );
   Ugol := Ugol + d;
   if Not ModeScr then TurnRight ( d )
 end;

Procedure Left_Turtle;            {  ����� : ������  "�९�誨" �����   }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   d    := Trunc ( WorkNum [1] );
   Ugol := Ugol - d;
   if Not ModeScr then TurnLeft ( d )
 end;

Procedure Set_Position;           {  ��: ��।������ "�९���" �� ���न�. }
 var x,y : integer;
 begin
   if Teste_Argument ( 3,3 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   x := Trunc ( WorkNum [1] );
   Command := Copy ( LineBuf,NumberT [1,3],NumberT [2,3] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   y := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   if ModePenTur then Draw ( XCor+159, 99-YCor, x+159, 99-y, ColorGraph );
   SetPosition ( x, y )
 end;
