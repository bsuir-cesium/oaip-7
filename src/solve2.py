def formatString(s: str, approvedSymbols: str) -> str:
    resultStr: str = ""
    for i in range(len(s)):
        if approvedSymbols.find(s[i]) != -1:
            resultStr += s[i]
        else:
            resultStr += "*"

    return resultStr


def getArrayFromString(s: str, k: int) -> list[str]: ...


def main():
    s: str
    k: int
    approvedSymbols: str = (
        " ,.?!-АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    )

    print("Введите строку: ")
    s = input()
    print("Введите k: ")
    k = int(input())

    formattedStr: str = formatString(s, approvedSymbols)

    print(formattedStr)


if __name__ == "__main__":
    main()
