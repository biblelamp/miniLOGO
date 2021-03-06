Procedure Clear_Scr;              {  �����:  ��३� � ⥪�⮢� ०��  }
 var i,j : byte;                  {          ��� ������ ��࠭         }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if ModeScr then ClrScr
              else Set_TextMode
 end;

Procedure Clear_Graph;            {  ��䨪�:  ��३� � ����᪨� ०��  }
 begin                            {            ��� ������ ��࠭           }
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then ClearScreen
                  else Set_GraphMode
 end;

Procedure Color_Text;             {  ����:  ��⠭����� 梥� ᨬ����� ⥪��  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   ColorText := Trunc ( WorkNum [1] );
   TextColor ( ColorText )
 end;

Procedure Color_Ground;           {  ��� :  ��⠭����� 䮭 ⥪�� ��� ���.  }
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ������ � �८�ࠧ������     }
     Exit;                                    {          ��६�����          }
   if ModeScr then
     begin
       GroundText  := Trunc ( WorkNum [1] ); TextBackGround ( GroundText )
     end
              else
     begin
       GroundGraph := Trunc ( WorkNum [1] ); GraphBackGround ( GroundGraph )
     end
 end;
