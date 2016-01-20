Procedure Pen_Up;                 {  БезСледа:  Поднять перо  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then PenUp;
   ModePenTur := False
 end;

Procedure Pen_Down;               {  СоСледом:  Опустить перо  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then PenDown;
   ModePenTur := True
 end;

Procedure Hide_Turtle;            {  Спрячь: Сделать "черепашку" невидимой  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then
     begin
       HideTurtle; TurtleDelay ( 0 );
     end;
   ModeTurtle := False
 end;

Procedure Show_Turtle;            {  Покажи: Сделать "черепашку"   видимой  }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if Not ModeScr then ShowTurtle;
     begin
       ShowTurtle; TurtleDelay ( 1500 );
     end;
   ModeTurtle := True
 end;

Procedure Clear_Screen;           {  БезЧертежа: "Снять" рисунок не изм.пол.}
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

Procedure Home_Turtle;            {  Центр: Поставить "черепашку" в исх.пол. }
 begin
   if Teste_Argument ( 1,1 ) then
     Exit;
   if ModeScr then Set_GraphMode;
   if ModePenTur then Draw ( XCor+159, 99-YCor, 159, 99, ColorGraph );
   Home
 end;

Procedure Set_PenColor;           {  Карандаш: Выбрать цвет для вычерчивания }
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   ColorGraph := Trunc ( WorkNum [1] );
   if Not ModeScr then SetPenColor ( ColorGraph )
 end;

Procedure Forwd_Turtle;           {  Вперед: Движение "черепашки" вперед  }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   d := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   Forwd ( d )
 end;

Procedure Back_Turtle;            {  Назад : Движение "черепашки" назад   }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   d := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   Back ( d )
 end;

Procedure Right_Turtle;           {  Вправо: Поворот  "черепашки" вправо  }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   d    := Trunc ( WorkNum [1] );
   Ugol := Ugol + d;
   if Not ModeScr then TurnRight ( d )
 end;

Procedure Left_Turtle;            {  Влево : Поворот  "черепашки" влево   }
 var d : integer;
 begin
   if Teste_Argument ( 2,2 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   d    := Trunc ( WorkNum [1] );
   Ugol := Ugol - d;
   if Not ModeScr then TurnLeft ( d )
 end;

Procedure Set_Position;           {  До: Передвинуть "черепашку" до координ. }
 var x,y : integer;
 begin
   if Teste_Argument ( 3,3 ) then
     Exit;
   Command := Copy ( LineBuf,NumberT [1,2],NumberT [2,2] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   x := Trunc ( WorkNum [1] );
   Command := Copy ( LineBuf,NumberT [1,3],NumberT [2,3] );
   if Write_Number ( Command,1 ) then         {  ОШИБКА в преобразовании     }
     Exit;                                    {          переменной          }
   y := Trunc ( WorkNum [1] );
   if ModeScr then Set_GraphMode;
   if ModePenTur then Draw ( XCor+159, 99-YCor, x+159, 99-y, ColorGraph );
   SetPosition ( x, y )
 end;
