Procedure Clear_Scr;              {  Текст:  Перейти в текстовый режим  }
 var i,j : byte;                  {          или очистить экран         }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if ModeScr then ClrScr
              else Set_TextMode
 end;

Procedure Clear_Graph;            {  Графика:  Перейти в графический режим  }
 begin                            {            или очистить экран           }
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then ClearScreen
                  else Set_GraphMode
 end;

Procedure Color_Text;             {  Цвет:  Установить цвет символов текста  }
 begin
   if Teste_Mode ( 1 ) Or Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   ColorText := Trunc ( WorkNum [1] );
   TextColor ( ColorText )
 end;

Procedure Color_Ground;           {  Фон :  Установить фон текста или граф.  }
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
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