Program RusLogo;
Uses Crt,
     Dos,
     Graph3,
     Printer;
Const
     ErrMsg0  = 'Что такое ';
     ErrMsg1  = 'Зачем лишние данные команде ';
     ErrMsg2  = 'Почему не хватает данных команде ';
     ErrMsg3a = 'Где двоеточие в начале имени переменной ';
     ErrMsg3b = 'Зачем переменной такое длинное имя ';
     ErrMsg4  = 'Почему не создана переменная ';
     ErrMsg5a = 'К чему допускать ошибки в выражении ?';
     ErrMsg5b = 'К чему допускать ошибки в команде Если ?';
     ErrMsg6  = 'Зачем процедуре такое длинное имя ';
     ErrMsg7  = 'Зачем еще одна процедура ';
     ErrMsg8  = 'Зачем программе или картине такое длинное имя ';
     ErrMsg9  = 'Зачем программе или картине плохое имя ';
     ErrMsgAa = 'Для чего так много вызовов процедур ?';
     ErrMsgAb = 'Для чего так много вложений структур ?';
     ErrMsgBa = 'Зачем лишние данные процедуре ';
     ErrMsgBb = 'Почему не хватает данных процедуре ';
     ErrMsgC  = 'Зачем вводить плохое число ?';
     ErrMsgD  = 'Для чего делить на 0 в выражении ?';
     ErrMsgE  = 'К чему плохой аргумент для функции ';
     ErrMsgGa = 'К чему плохие данные для команды Играй ?';
     Warning0 = 'Понятно, что такое ';
     Warning1 = 'Не хватает памяти для программы !';
     Warning2 = 'Не хватает памяти для заголовков !';
     Warning3 = 'Не хватает памяти для переменных !';
     Warning4 = 'В графическом режиме нельзя командовать ';
     WarningA = 'Не найдена программа с именем ';
     WarningB = 'Не найдена картина с именем ';
     WarningC = 'Диск не готов к работе !';
     WarningD = 'Принтер не готов к работе !';
     WarningZ = 'Принудительно остановлена !';
     MaxLine = 819;                     {  Максим.число строк текста     }
     MaxName = 255;                     {  Максим.число заголовков       }
     MaxVar  = 255;                     {  Максимальнoe число переменых  }
     LengNam = 20;                      {  Максимальная длина имени      }
     KeyCode  : array [-11..45] of char =
           ( #104,#105,#106,#107,#108,#109,#110,#111,#112,#113, #94, #95,
              #38, #45, #32, #25, #37, #04, #33, #48, #31, #02, #22, #12,
              #20, #50, #16, #60, #06, #24, #09, #19, #18, #21, #59, #34,
              #07, #65, #64, #63, #66, #46, #03, #67, #47, #35, #36, #61,
              #62, #44, #68, #14, #01, #30, #23, #17, #49 );
     KeyWord  : array [-11..45] of string [10] =
           ( 'Абсолютное','АркТангенс','Выбор'     ,'Дробь',
             'Корень2'   ,'Косинус'   ,'НтЛогарифм','Округлено',
             'Синус'     ,'Тангенс'   ,'Целое'     ,'Экспонента',
             'БезСледа'  ,'БезЧертежа','Введи'     ,'ВведиЗнак',
             'Влево'     ,'Вперед'    ,'Вправо'    ,'ВсеЕсли',
             'Выведи'    ,'Выйди'     ,'Графика'   ,'До',
             'Если'      ,'Забудь'    ,'Заверши'   ,'Заголовки',
             'Играй'     ,'Иначе'     ,'Карандаш'  ,'Конец.',
             'КонецПовт' ,'Назад'     ,'Отпечатай' ,'Повтори',
             'Покажи'    ,'ПокажиКарт','Прочти'    ,'Редактируй',
             'СвобПамять','Сделай'    ,'Сначала'   ,'Создай',
             'СоСледом'  ,'Сотри'     ,'СотриКарт','Сохрани',
             'СохрКарт'  ,'Спрячь'    ,'Текст'    ,'То',
             'Финиш'     ,'Фон'       ,'Цвет'     ,'Центр',
             'Это' );
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
     ProgTxt : MemoryProgram;         {     Строки текста программы         }
     PrgNumb : integer;               {  Указатель длины текста программы   }
     VarTabl : Arr2;                  {     Массив значений      переменных }
     VarName : Arr3;                  {  Массив имен          переменных    }
     VarNumb : byte;                  {  Указатель количества переменных    }
     ZagTabl : Arr4;                  {     Массив номеров строк заголовков }
     ZagName : Arr5;                  {  Массив имен            заголовков  }
     ZagArg  : Arr6;                  {  Массив кол. аргументов заголовков  }
     ZagLeng : Arr6;                  {  Массив длин процедур   заголовков  }
     ZagNumb : byte;                  {  Указатель количества   заголовков  }
     Screen  : ArrS;
     LineBuf,                         {     Буфер ввода строки              }
     PredBuf,                         {  Предыдущая строка                  }
     Command : Line79;                {  Рабочая переменная,текущая строка  }
     LengBuf : byte absolute LineBuf; {  Длина буфера входной  строки       }
     LengCom : byte absolute Command; {  Длина буфера элемента строки       }
     NumberT : Arr7;                  {     Массив разложения буфера строки }
     CountNm : byte;                  {  Количество элементов разложения    }
     WorkNum : Arr8;                  {  Массив разложения арифм.выражения  }
     ProcChr : Arr9;                  {  Массив знаков операций в выражении }
     CountWr : byte;                  {  Количество элементов разложения    }
     ColorText, GroundText,           {     Цвет символов и фона в тексте   }
     ColorGraph,GroundGraph,          {     Цвет линий и фона    в графике  }
     Oktava,Dliteln,                  {  Номер текущей октавы и длительн.   }
     Dev,
     CountLevel   : byte;             {  Счетчик вложений процедур          }
     CountLine    : integer;          {     счетчик строк                   }
     StackReturn  : Arr4;             {     стек возвратов /номера строк/   }
     ProcNumber   : byte;             {  Номер текущей процедуры            }
     StackZickl   : Arr4;             {     Стек адресов возврата на повтор }
     StackCount   : Arr4;             {  Стек счетчиков повторений циклов   }
     CountZickl   : byte;             {  Счетчик числа вложений цикла       }
     StackStrukt  : ArrA;             {     Стек вложений структур Если-То  }
     CountStrukt  : byte;             {  Счетчик вложений структур Если-То  }
     GraphX,GraphY,
     Ugol         : integer;
     y,m,d,d1     : byte;
     Ch           : char;
     ModeScr,                         { Экран       True:текст False:граф.  }
     ModePenTur,                      { Перо        True:опущ. False:подн.  }
     ModeTurtle,                      { Черепаха    True:вид.  False:невид. }
     FindCommd,                       { Призн.проц. True:найд. False:ненайд.}
     ErrorCode,                       { Код ошибки  True:есть  False:нет    }
     flag1        : boolean;

Procedure Set_TextMode;               {  Установка текстового   режима      }
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
   GotoXY ( 1,8 ); for i := 1 to 40 do write ( '─' );
   TextBackGround ( 3 );
   TextColor ( 0 );
   GotoXY ( 2,25 ); write ( 'Отпеча  Заголо  Сохран  СохрКа  Редакт  ',
                            'Прочти  Покажи  CвобПа  Создай  Текст' );
   TextBackGround ( 0 );
   TextColor ( 14 );
   GotoXY ( 1,25 ); write ( '1' );
   for i := 1 to 9 do
     begin
       GotoXY ( i*8,25 );  write ( (i+1):2 )
     end;
   GotoXY ( 9,1 );  write ('д');  GotoXY ( 6,2 );  write ('Ч');
   GotoXY ( 3,3 );  write ('В');  GotoXY ( 8,4 );  write ('З');
   GotoXY ( 4,5 );  write ('л');  GotoXY ( 2,6 );  write ('^В');
   GotoXY ( 6,7 );  write ('а');  GotoXY ( 22,1 ); write ('и');
   GotoXY ( 17,2 ); write ('ы');  GotoXY ( 15,3 ); write ('^');
   GotoXY ( 20,3 ); write ('и');  GotoXY ( 16,4 ); write ('Г');
   GotoXY ( 15,5 ); write ('^Д'); GotoXY ( 15,6 ); write ('^Е');
   GotoXY ( 21,7 ); write ('ь');  GotoXY ( 28,1 ); write ('^З');
   GotoXY ( 28,3 ); write ('^');  GotoXY ( 32,3 ); write ('а');
   GotoXY ( 28,4 ); write ('^');  GotoXY ( 32,4 ); write ('ч');
   GotoXY ( 28,5 ); write ('^');  GotoXY ( 36,5 ); write ('ш');
   GotoXY ( 29,6 ); write ('К');  GotoXY ( 28,7 ); write ('^К');
   GotoXY ( 42,1 ); write ('Н');  GotoXY ( 42,3 ); write ('П');
   GotoXY ( 41,4 ); write ('^П'); GotoXY ( 55,1 ); write ('С');
   GotoXY ( 54,2 ); write ('^С'); GotoXY ( 62,4 ); write ('м');
   GotoXY ( 58,5 ); write ('р');  GotoXY ( 56,6 ); write ('о');
   GotoXY ( 71,1 ); write ('я');  GotoXY ( 67,3 ); write ('^Т');
   GotoXY ( 67,4 ); write ('^Ф'); GotoXY ( 68,5 ); write ('Ф');
   GotoXY ( 67,6 ); write ('^Ц'); GotoXY ( 68,7 ); write ('Ц');
   GotoXY ( 69,8 ); write ('т');
   TextBackGround ( GroundText ); TextColor ( ColorText );
   Window ( 1,9,80,24 );
   ClrScr;
   ModeScr := True
 end;

Procedure Set_GraphMode;              {  Установка графического режима      }
 begin
   ModeScr := False;
   if Ugol > 359 then Ugol := Ugol - 359;
   if Ugol < 0   then Ugol := Ugol + 360;
   GraphColorMode;                           {  Устанавливаем цветной       }
   Palette (3);                              {           графический режим  }
   GraphBackGround ( GroundGraph  );         {  Заданный фон                }
   SetPenColor     ( ColorGraph   );         {  Заданный цвет пера          }
   PutPic          ( Screen,0,199 );         {  Восстанавливаем экран,      }
   SetPosition     ( GraphX,GraphY );        {  позицию черепахи,           }
   SetHeading      ( Ugol );                 {  угол ее поворота,           }
   if ModeTurtle then ShowTurtle             {  параметры черепахи и        }
                 else HideTurtle;
   if ModeTurtle then TurtleDelay ( 1500 )   {  скоpость чеpепахи, и        }
                 else Turtledelay ( 0 );
   if ModePenTur then PenDown                {  цвет пера черепахи          }
                 else PenUp;
   Wrap                                      {  появление на против.стороне }
 end;

Function Teste_Mode ( ScrMode : byte ): Boolean;
 begin
   Teste_Mode := False;
   if (Not ModeScr) And (ScrMode = 1) then
     begin                                    {  Проверяется ТИП команды : }
       if Not ModeScr then Set_TextMode;      {    0 - графическая         }
       write ( Warning4,Command,' !');        {    1 - текстовая           }
       ErrorCode  := True;                    {    2 - смешанная           }
       Teste_Mode := True
     end
 end;

Function Teste_Argument ( n1,n2 : byte ) : Boolean;
 begin
   Teste_Argument := False;
   if CountNm < n1 then                       {  аргументов не меньше n1 - 1 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg2,Command,' ?' );        {  ОШИБКА : мало аргументов у  }
       ErrorCode      := True;                {           у команды          }
       Teste_Argument := True;
       Exit
     end;
   if CountNm > n2 then                       {  аргументов не больше n2 - 1 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg1,Command,' ?' );        {  ОШИБКА : лишние аргументы   }
       ErrorCode      := True;                {           у команды          }
       Teste_Argument := True
     end
 end;

Function Teste_ArgProc  ( n1,n2 : byte ) : Boolean;
 begin
   Teste_ArgProc := False;
   if CountNm < n1 then                       {  аргументов не меньше n1 - 2 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsgBb,Command,' ?' );       {  ОШИБКА : мало аргументов у  }
       ErrorCode     := True;                 {           у процедуры        }
       Teste_ArgProc := True;
       Exit
     end;
   if CountNm > n2 then                       {  аргументов не больше n2 - 2 }
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsgBa,Command,' ?' );       {  ОШИБКА : лишние аргументы   }
       ErrorCode     := True;                 {           у процедуры        }
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
       write ( ErrMsg3a,NameVar,' ?');        {  ОШИБКА : нет двоеточия  в  }
       ErrorCode     := True;                 {           имени переменной  }
       Teste_VarName := True
     end
                        else
   if leng > LengNam then
     begin
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg3b,NameVar,' ?');        {  ОШИБКА : слишком  длинное  }
       ErrorCode     := True;                 {           имя у переменной  }
       Teste_VarName := True
     end
 end;

Function Find_VarName  ( NameVar : Line79 ) : byte;
 var i : byte;
 begin
   Find_VarName := 0;                         {  Если переменной нет,       }
   if VarNumb > 0 then                        {       ее номер равен 0      }
     for i := 1 to MaxVar do
        if NameVar = VarName [i] then  Find_VarName := i
 end;

Function NotFind_VarName  ( n1 : byte ) : boolean;
 begin
   NotFind_VarName := False;
   if n1 = 0 then                             {  Если номер переменной = 0   }
     begin                                    {            ТО :              }
       if Not ModeScr then Set_TextMode;
       write ( ErrMsg4,Command,' ?');         {  ОШИБКА : переменная не соз. }
       ErrorCode       := True;
       NotFind_VarName := True
     end
 end;

Function Write_Number  ( NameStr : Line79;
                               i : byte ) : boolean;
 var n : byte; k : integer; r : real;
 begin
   Write_Number := False;
   if NameStr = ':Пи'   then NameStr := '3.1415926536';
   if NameStr = ':Е'    then NameStr := '2.718281828';
   if NameStr = ':Абсц' then Str ( GraphX, NameStr );
   if NameStr = ':Орд'  then Str ( GraphY, NameStr );
   if NameStr = ':Курс' then Str ( Ugol,   NameStr );
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

{$I Funckt.pas    Подключение файла с функциями :
                       Абсолютное, АркТангенс, Выбор, Дробь,  Корень2,
                       Косинус, НтЛогарифм, Округлено, Синус, Тангенс,
                       Целое,   Экспонента            и командой Играй  }

{$I Graphs.pas    Подключение файла с командами
                  БезСледа, СоСледом, Спрячь, Покажи, БезЧертежа,
                  Центр, Карандаш, Вперед, Назад, Вправо, Влево, До  }

{$I Number.pas    Подключение файла с командами
                  Создай, Введи, ВведиЗнак, Сделай, Выведи  }

{$I Screen.pas    Подключение файла с командами  Текст, Графика, Цвет, Фон  }

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
         ' '..'я' : if uk < 79 then
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
                      if  Ch = #71  then                     {  Курсор       }
                        begin                                {    в начало   }
                          GotoXY ( 1, WhereY );              {       строки  }
                          uk := 0
                        end;
                      if  Ch = #79  then                     {  Курсор       }
                        begin                                {    в конец    }
                          GotoXY ( LengBuf+1, WhereY );      {       строки  }
                          uk := LengBuf
                        end;
                      if (Ch = #75) And (uk > 0)       then  {  Курсор       }
                        begin                                {        влево  }
                          write ( #8 ); uk := uk - 1
                        end;
                      if (Ch = #77) And (uk < LengBuf) then  {  Курсор       }
                        begin                                {        вправо }
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

{$I Memory.pas    Подключение файла с командами Это, Заголовки, Отпечатай
                                        СвобПамять,Забудь,Редактируй,Сначала }

{$I FileRW.pas    Подключение файла с командами Читай, ЧитайКарт,
                                        Сотри, СотриКарт, Сохрани, СохрКарт  }

{$I WorkPr.pas    Подключение файла с командами Выйди, Конец, Финиш, Заверши
                                    Повтори-КонецПовт, Если-То-Иначе-ВсеЕсли }

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
   if ((CountNm > 0) And            {  В строке что-то есть и вложений нет  }
       (CountStrukt = 0)) Or        {                ИЛИ                    }
      ((CountNm > 0) And            {  вложения есть, но выборка разрешена  }
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
       {   поиск  команды  по имени   }
       for i := -11 to 45 do
         if Command = KeyWord[i] then n1 := i;  {   Команда   найдена       }
       if n1 < 1 then                           {  Если обнаружена функция  }
         begin                                  {            ТО :           }
           Dev := n1 + 12;  Function_All        {  вычисляется ее ист.номер }
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
          { если команда не опознана, то происходит поиск процедуры по имени }
          46 : begin
                 FindCommd := False;
                 if ZagNumb > 0 then   {  Если есть какие-нибудь процедуры,  }
                   for n1 := 1 to ZagNumb do
                     if Command = ZagName [n1] then
                       begin
                         FindCommd := True;
                         if CountLevel = MaxVar then    {  Превышена         }
                           begin                        {      вложенность   }
                             if Not ModeScr then Set_TextMode; {    процедур }
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
       if KeyPressed then                   {  Если нажата клавиша, ТО :   }
         begin                              {  проверить ее код.  Если он  }
           c := ReadKey;                    {  равен #27 ( клавиша Esc ),  }
           if c = #27 then                  {              ТО :            }
             begin                          {     произвести прерывание    }
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
               writeln ( ' В строке :' );
               writeln ( LineBuf );
               writeln ( 'На уровне ',CountLevel,':',CountZickl+CountStrukt,
                         ' в процедуре ',ZagName [ProcNumber],'.');
               CountLevel := 0
             end
         end
     end
  until CountLevel = 0;
 end;

Begin
  flag1 := False;
  GetDir ( 0, Command );
{$I- выключение  системного  контроля  над  операциями  ввода-вывода  }
  {if Command <> 'C:\WORK\MLOGO' then
    begin
      Assign ( FileName,'mlogo.exe' );
      Erase  ( FileName );
      if IOResult > 0 then Inline ( $9B )
    end;}
{$I+ включение   системного  контроля  над  операциями  ввода-вывода  }
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
  writeln ('МиниЛОГО - язык начального обучения программированию.');
  writeln (
  'Веpсию 1.0 pазработал Braun User ( Сергей В.Ирюпин ),февраль 1990 г,Рига.');
  TextColor ( 3 );
  CountNm := 1;
  Free_Memory;
  New ( ProgTxt );
  PredBuf := KeyWord [31];
  flag1   := False;
  {   Р а б о ч и й   ц и к л   }
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