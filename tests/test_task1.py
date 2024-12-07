from src.solve1 import getTask1


def test_task1():
    alphabet: str = "abcdefghijklmnopqrstuvwxyz"
    assert getTask1("z yz xyz", "xyz", alphabet) == "z yz "
    assert getTask1("z yz xyz  abc", "abc", alphabet) == "z yz xyz  "
    assert getTask1("   ", "", alphabet) == "   "
    assert getTask1("   xyz", "xyz", alphabet) == "   "
