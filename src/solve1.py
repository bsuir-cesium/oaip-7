def getLastWord(s: str) -> str:
    wordIsBegun: bool = False
    lastIndex: int = len(s) - 1

    for i in range(len(s) - 1, 0, -1):
        if s[i] != " " and not wordIsBegun:
            wordIsBegun = True
            lastIndex = i
        elif s[i] == " " and wordIsBegun:
            return s[i + 1 : lastIndex + 1]
        elif s[i] == " ":
            lastIndex = i

    return s[0 : lastIndex + 1]


def getTask1(s: str, lastWord: str, alphabet: str, delimiter: str = " ") -> str:
    """Напечатать слова, отличные от последнего слова, если они
    удовлетворяют следующему условию: слово совпадает
    с конечным отрезком латинского алфавита (z, yz, xyz и т.д.).
    """

    resultStr: str = ""
    tempStr: str = ""
    for i in range(len(s)):
        if s[i] != " ":
            tempStr += s[i]
        else:
            if not (tempStr == lastWord):
                index = alphabet.find(tempStr)
                if (index != -1) and (alphabet[index:] == tempStr):
                    resultStr += alphabet[index:]
            resultStr += delimiter
            tempStr = ""

    return resultStr


def getTask2(s: str, lastWord: str, vowelsLetters: str, delimiter: str = " ") -> str:
    """Напечатать все слова, отличные от последнего слова,
    удаляя все гласные буквы.
    """

    resultStr: str = ""
    tempStr: str = ""
    for i in range(len(s)):
        if s[i] != " ":
            tempStr += s[i]
        else:
            if not (tempStr == lastWord):
                for j in range(len(tempStr)):
                    if tempStr[j] not in vowelsLetters:
                        resultStr += tempStr[j]
            resultStr += delimiter
            tempStr = ""

    return resultStr


def main():
    alphabet: str = "abcdefghijklmnopqrstuvwxyz"
    vowelsLetters: str = "AEIOUaeiou"
    s: str
    s1: str = ""
    s2: str = ""
    lastWord: str

    print("Введите строку: ")
    s = input()

    lastWord = getLastWord(s)

    s1 = getTask1(s, lastWord, alphabet)
    s2 = getTask2(s, lastWord, vowelsLetters)

    print(s1, len(s1))
    print(s2, len(s2))


if __name__ == "__main__":
    main()
