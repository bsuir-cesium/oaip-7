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
  wordIsBegun: Boolean;
  i, lastIndex: Integer;
begin
  wordIsBegun := False;
  lastIndex := Length(s);
  for i := Length(s) downto 1 do
  begin
    if (s[i] <> ' ') and (not wordIsBegun) then
    begin
      wordIsBegun := True;
      lastIndex := i;
    end      
    else if (s[i] = ' ') and (wordIsBegun) then
    begin
      Exit(Copy(s, i + 1, lastIndex - i));
    end
    else if (s[i] = ' ') then
    begin
      lastIndex := i;
    end;
  end;
  if wordIsBegun then
    GetLastWord := Copy(s, 1, lastIndex)
  else
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
      if not (tempStr = lastWord) then
      begin
        index := Pos(tempStr, alphabet);
        if (index <> 0) and (Copy(alphabet, index, Length(alphabet) + 1 - index) = tempStr) then
        begin
          resultStr := resultStr + Copy(alphabet, index, Length(alphabet) + 1 - index) + ' ';
        end;
      end;
      tempStr := '';
    end;
  end;

  GetTask1 := resultStr;
end;

function GetTask2(s: TString; lastWord: TString; vowelsLetters: TString): TString;
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
      if not (tempStr = lastWord) and (Length(tempStr) > 0) then
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

  GetTask2 := resultStr;
end;

begin
  Write('Enter string: ');
  ReadLn(s);
  lastWord := GetLastWord(s);
  s1 := GetTask1(s, lastWord, alphabet);
  s2 := GetTask2(s, lastWord, vowelsLetters);
  if length(s1) > 0 then
    writeln('п.1: ', s1)
  else
    writeln('Строка пустая');
  
  if length(s2) > 0 then
    writeln('п.2: ', s2)
  else
    writeln('Строка пустая');
end.