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
  TString = String;
  TMas = array [1 .. N] of TString;
  TDict = array [1 .. wordsCount] of TString;

procedure LoadDict(fname: TString; var isCorrect: boolean; var dict: TDict);
var
  f: textfile;
  s: TString;
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
        if (i = 1) and not(extra) then
        begin
          words[i] := ansilowercase(words[i]);
          extra := True;
          inSearch := false;
        end
        else
        begin
          writeln('(debug) Not found: ', words[i]);
          extra := False;
          notFound := True;
          inSearch := false;
        end;
      end
      else if dict[index] = words[i] then
      begin
        inSearch := False;
        extra := False;
      end
      else if dict[index] < words[i] then
        low := index + 1
      else if dict[index] > words[i] then
        high := index;
    end;
    if not extra then
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
    else if (s[i] = ' ') and (Pos(s[i + 1], ',.:;') <> 0) then
      CheckString := false
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

function stretchline(line: TString; k: integer): string;
var
  words: array of TString;
  i, start, wordcount, totalspaces, spaceslots, extraspaces, spaceperslot: integer;
  newline: TString;
begin
  line := trim(line);
  wordcount := 0;
  i := 1;
  while i <= Length(line) do
  begin
    while (i <= Length(line)) and (line[i] = ' ') do
      Inc(i);
    if i <= Length(line) then
    begin
      start := i;
      while (i <= Length(line)) and (line[i] <> ' ') do
        Inc(i);
      Inc(wordcount);
      setlength(words, wordcount);
      words[wordcount - 1] := Copy(line, start, i - start);
    end;
  end;
  if wordcount > 1 then
  begin
    totalspaces := k - Length(line) + (wordcount - 1);
    spaceslots := wordcount - 1;
    spaceperslot := totalspaces div spaceslots;
    extraspaces := totalspaces mod spaceslots;
  end
  else
  begin
    spaceperslot := 0;
    extraspaces := 0;
  end;
  newline := '';
  for i := 0 to wordcount - 2 do
  begin
    newline := newline + words[i] + stringofchar(' ', spaceperslot);
    if extraspaces > 0 then
    begin
      newline := newline + ' ';
      dec(extraspaces);
    end;
  end;
  newline := newline + words[wordcount - 1];
  stretchline := newline;
end;

procedure stretchWords(const words: TMas; const len, k: integer;
  var lines: TMas; var count: integer; var available: boolean);
var
  i: integer;
  line, word: TString;
begin
  available := True;
  count := 1;
  line := '';
  word := '';
  for i := 1 to len do
  begin
    if Length(words[i]) > k then
      available := false;
    if Length(words[i]) = k then
    begin
      if Length(line) > 0 then
      begin
        lines[count] := stretchline(line, k);
        Inc(count);
        line := '';
      end;
      lines[count] := stretchline(words[i], k);
      Inc(count);
    end
    else if (Length(line) + Length(words[i]) + 1 > k) and available then
    begin
      lines[count] := stretchline(line, k);
      Inc(count);
      line := words[i] + ' ';
    end
    else
    begin
      line := line + words[i] + ' ';
    end;

    if (i = len) and (Length(line) > 0) and available then
      lines[count] := stretchline(line, k);
  end;
end;

var
  s, formattedStr: TString;
  dict: TDict;
  words, lines: TMas;
  k, wordsLen, linesCount, i: integer;
  isCorrect: boolean;

begin
  isCorrect := True;
  LoadDict('../russian_sorted.txt', isCorrect, dict);
  if not isCorrect then
  begin
    writeln('Файл словаря недоступен или повреждён');
    Readln;
    exit;
  end;
  Write('Введите строку: ');
  Readln(s);
  Write('Введите k: ');
  Readln(k);
  writeln;
  if CheckString(s, UpperLetters, approvedSymbols, dict) then
    writeln('Строка является предложением на русском языке')
  else
    writeln('Строка не является предложением на русском языке');
  formattedStr := formatString(s, approvedSymbols);
  writeln;
  writeln('Отформатированная строка: ', formattedStr);

  getWords(formattedStr, Copy(approvedSymbols, 2, 73), words, wordsLen);
  stretchWords(words, wordsLen, k, lines, linesCount, isCorrect);
  writeln;
  if isCorrect then
  begin
    writeln('Растянутая в ширину по k:');
    for i := 1 to linesCount do
      writeln(lines[i]);
  end
  else
    writeln('Невозможно растянуть строку');
  Readln;

end.
