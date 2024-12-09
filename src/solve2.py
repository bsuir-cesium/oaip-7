def checkString(sentence: str) -> bool:
    if len(sentence) == 0:
        return False
    if not ("А" <= sentence[0] <= "Я" or "Ё" == sentence[0]):
        return False
    if not (sentence[-1] in [".", "!", "?"]):
        return False

    # Проверка на недопустимые символы
    for ch in sentence:
        if not (("А" <= ch <= "Я") or ("а" <= ch <= "я") or ch in [" ", ".", "!", "?"]):
            return False

    return True


def getWords(sentence):
    """Извлекает слова из строки вручную, без использования .split()"""
    words = []
    current_word = ""

    for ch in sentence:
        if ch == " ":
            if current_word != "":
                words.append(current_word)
                current_word = ""
        else:
            current_word += ch
    if current_word != "":
        words.append(current_word)  # Добавляем последнее слово, если оно есть

    return words


def formatString(sentence: str) -> str:
    formatted = ""
    for ch in sentence:
        if not (("А" <= ch <= "Я") or ("а" <= ch <= "я") or ch in [" ", ".", "!", "?"]):
            formatted += "*"
        else:
            formatted += ch
    return formatted


def getArrayFromString(sentence, k):
    """Разбивает строку на части длиной k, не разрывая слова"""
    words = []

    words = getWords(sentence)

    # Проверка, чтобы ни одно слово не было длиннее k
    for word in words:
        if len(word) > k:
            return "Невозможно разбить строку"

    # Разбиение на строки длиной k
    result = []
    current_line = ""

    for word in words:
        if len(current_line) + len(word) + (1 if current_line else 0) > k:
            result.append(current_line)
            current_line = word
        else:
            if current_line:
                current_line += " " + word
            else:
                current_line = word

    if current_line:
        result.append(current_line)

    return result


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

    if checkString(s):
        print("Строка является предложением на русском языке")
    else:
        print("Строка не является предложением на русском языке")

    formattedStr: str = formatString(s)
    print("Отформатированная строка: ")
    print(formattedStr)

    print("Разбитая на слова строка: ")
    print(getArrayFromString(formattedStr, k))


if __name__ == "__main__":
    main()
