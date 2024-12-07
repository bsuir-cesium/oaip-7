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
  GetLastWord := Copy(s, 1, lastIndex);
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
        writeln(index);
        if (index <> 0) and (Copy(alphabet, index, Length(alphabet) + 1 - index) = tempStr) then
        begin
          resultStr := resultStr + Copy(alphabet, index, Length(alphabet) + 1 - index);
        end;
      end;
      resultStr := resultStr + ' ';
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
      if not (tempStr = lastWord) then
      begin
        for j := 1 to Length(tempStr) do
        begin
          if Pos(tempStr[j], vowelsLetters) = 0 then
          begin
            resultStr := resultStr + tempStr[j];
          end;
        end;
      end;
      resultStr := resultStr + ' ';
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
  writeln(s1, ' ', Length(s1));
  writeln(s2, ' ', Length(s2));
end.