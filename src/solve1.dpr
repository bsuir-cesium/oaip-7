program lab7_1;

const
  N = 255;

type
  TString = String[N];

const
  alphabet = 'abcdefghijklmnopqrstuvwxyz';
  vowelsLetters = 'AEIOUaeiou';

var
  s, s1, s2, lastWord: TString;

function GetLastWord(s: TString): TString;
var
  wordIsBegun, exitFlag: Boolean;
  i, lastIndex: Integer;
begin
  exitFlag := False;
  wordIsBegun := False;
  lastIndex := Length(s);
  i := Length(s);
  while (i >= 1) and not exitFlag do
  begin
    if (s[i] <> ' ') and (not wordIsBegun) then
    begin
      wordIsBegun := True;
      lastIndex := i;
    end
    else if (s[i] = ' ') and (wordIsBegun) then
    begin
      GetLastWord := Copy(s, i + 1, lastIndex - i);
      exitFlag := True;
    end
    else if (s[i] = ' ') then
    begin
      lastIndex := i;
    end;
    i := i - 1;
  end;
  if wordIsBegun and not exitFlag then
    GetLastWord := Copy(s, 1, lastIndex)
  else if not wordIsBegun then
    GetLastWord := '';
end;

function GetTask1(s: TString; lastWord: TString; alphabet: TString): TString;
var
  resultStr, tempStr: TString;
  i, index: Integer;
begin
  resultStr := '';
  tempStr := '';
  for i := 1 to Length(s) do
  begin
    if s[i] <> ' ' then
    begin
      tempStr := tempStr + s[i];
    end
    else
    begin
      if not(tempStr = lastWord) then
      begin
        index := Pos(tempStr, alphabet);
        if (index <> 0) and (Copy(alphabet, index, Length(alphabet) + 1 - index)
          = tempStr) then
        begin
          resultStr := resultStr + Copy(alphabet, index, Length(alphabet) + 1 -
            index) + ' ';
        end;
      end;
      tempStr := '';
    end;
  end;

  if Length(resultStr) > 0 then
    GetTask1 := resultStr
  else
    GetTask1 := 'Строка пустая';
end;

function GetTask2(s: TString; lastWord: TString;
  vowelsLetters: TString): TString;
var
  resultStr, tempStr: TString;
  i, j: Integer;
begin
  resultStr := '';
  tempStr := '';
  for i := 1 to Length(s) do
  begin
    if s[i] <> ' ' then
    begin
      tempStr := tempStr + s[i];
    end
    else
    begin
      if not(tempStr = lastWord) and (Length(tempStr) > 0) then
      begin
        for j := 1 to Length(tempStr) do
        begin
          if Pos(tempStr[j], vowelsLetters) = 0 then
          begin
            resultStr := resultStr + tempStr[j];
          end;
        end;
        resultStr := resultStr + ' ';
      end;
      tempStr := '';
    end;
  end;

  if Length(resultStr) > 0 then
    GetTask2 := resultStr
  else
    GetTask2 := 'Строка пустая';
end;

begin
  Write('Enter string: ');
  ReadLn(s);
  lastWord := GetLastWord(s);
  s1 := GetTask1(s, lastWord, alphabet);
  s2 := GetTask2(s, lastWord, vowelsLetters);
  writeln('п.1: ', s1);
  writeln('п.2: ', s2);
  ReadLn;

end.