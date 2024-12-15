program lab7_2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  N = 255;
  wordsCount = 1532629;
  UpperLetters = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯ';
  approvedSymbols =
    ' ,-:;АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя.?!';

type
  TString = String[N];
  TMas = array [1 .. N] of TString;
  TDict = array [1 .. wordsCount] of TString;

procedure LoadDict(fname: TString; var isCorrect: boolean; var dict: TDict);
var
  f: textfile;
  s: string[200];
  i: integer;
begin
  i := 0;
  if FileExists(fname) then
  begin
    AssignFile(f, fname);
    Reset(f);
    while (not EOF(f)) do
    begin
      Inc(i);
      Readln(f, s);
      s := utf8ToAnsi(s);
      dict[i] := s;
    end;
    CloseFile(f);
  end
  else
    isCorrect := false;
end;

procedure getWords(const s, letters: TString; var words: TMas;
  var len: integer);
var
  i: integer;
  currentWord: TString;
begin
  len := 0;
  currentWord := '';
  for i := 1 to Length(s) do
  begin
    if Pos(s[i], letters) <> 0 then
      currentWord := currentWord + s[i]
    else if Length(currentWord) > 0 then
    begin
      Inc(len);
      words[len] := currentWord;
      currentWord := '';
    end;
  end;
  if Length(currentWord) > 0 then
  begin
    Inc(len);
    words[len] := currentWord;
  end;
end;

function CheckInDict(const dict: TDict; var words: TMas;
  const wordsLen: integer): boolean;
var
  low, high, index, i: integer;
  notFound, inSearch, extra: boolean;
begin
  i := 1;
  notFound := false;
  extra := false;
  while (i <= wordsLen) and (not notFound) do
  begin
    low := 1;
    high := wordsCount;
    inSearch := True;
    while inSearch do
    begin
      index := ((high + low) div 2);
      if (high = low) and (dict[high] <> words[i]) then
      begin
        if ('А' <= words[i][1]) and (words[i][1] <= 'Я') and (i = 1) then
        begin
          words[i] := ansilowercase(words[i]);
          extra := True;
          inSearch := false;
        end
        else
        begin
          notFound := True;
          inSearch := false;
        end;
      end
      else if dict[index] = words[i] then
        inSearch := false
      else if dict[index] < words[i] then
        low := index + 1
      else if dict[index] > words[i] then
        high := index;
    end;
    if extra then
      extra := false
    else
      Inc(i);
  end;
  CheckInDict := not notFound;
end;

function CheckString(const s, UpperLetters, approvedSymbols: TString;
  const dict: TDict): boolean;
var
  i, len, spaces, wordsLen: integer;
  spacesFlag: boolean;
  words: TMas;
begin
  CheckString := True;
  len := Length(s);
  if (len = 0) or (len = 1) then
    CheckString := false
  else if Pos(s[1], UpperLetters) = 0 then
    CheckString := false
  else if not((s[len] = '.') or (s[len] = '!') or (s[len] = '?')) then
    CheckString := false
  else if s[len - 1] = ' ' then
    CheckString := false;

  spaces := 0;
  spacesFlag := True;
  i := 2;
  while (i <= len - 1) and (spacesFlag) do
  begin
    if (s[i] = ' ') and (spaces = 1) then
    begin
      spacesFlag := false;
      CheckString := false;
    end
    else if s[i] = ' ' then
      Inc(spaces)
    else
      spaces := 0;
    if Pos(s[i], Copy(approvedSymbols, 1, 72)) = 0 then
      CheckString := false
    else if (s[i] = '.') and not((len - 2 <= i) and (i <= len)) then
      CheckString := false
    else if (s[i] = '.') and not((s[len] = '.') and (s[len - 1] = '.') and
      (s[len - 2] = '.')) then
      CheckString := false;
    Inc(i);
  end;

  getWords(s, Copy(approvedSymbols, 6, 66), words, wordsLen);
  if not CheckInDict(dict, words, wordsLen) then
    CheckString := false;

end;

function formatString(const s, approvedSymbols: TString): TString;
var
  i: integer;
  formatted: TString;
begin
  formatted := '';
  for i := 1 to Length(s) do
  begin
    if Pos(s[i], approvedSymbols) = 0 then
      formatted := formatted + '*'
    else
      formatted := formatted + s[i];
  end;

  formatString := formatted;
end;

procedure Justifyline(const words: TMas; const wordsLen, k: integer;
  var wordsCentered: TMas; var len: integer);
var
  i, voids, currentLen, currentWords: integer;
begin
  currentLen := 0;
  for I := 1 to wordsLen do
  begin
     if currentLen + Length() then

  end;

end;

var
  s, formattedStr: TString;
  dict: TDict;
  words: TMas;
  wordsLen, i: integer;
  isCorrect, isInDict: boolean;

begin
  isCorrect := True;
  LoadDict('../russian_sorted.txt', isCorrect, dict);
  if not isCorrect then
  begin
    writeln('Файл словаря недоступен или повреждён');
    Readln;
    exit;
  end;
  Write('Enter string: ');
  Readln(s);
  if CheckString(s, UpperLetters, approvedSymbols, dict) then
    writeln('Строка является предложением на русском языке')
  else
    writeln('Строка не является предложением на русском языке');

  formattedStr := formatString(s, approvedSymbols);
  writeln(formattedStr);
  Readln;

end.
