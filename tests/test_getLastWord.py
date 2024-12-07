from src.solve1 import getLastWord


def test_getLastWord():
    assert getLastWord("abc") == "abc"
    assert getLastWord("abc def") == "def"
    assert getLastWord("abc def  ") == "def"
    assert getLastWord("   abc ") == "abc"
    assert getLastWord("  abc") == "abc"
