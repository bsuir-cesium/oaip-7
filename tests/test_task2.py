from src.solve1 import getTask2


def test_task2():
    vowelsLetters: str = "AEIOUaeiou"

    assert getTask2(" abc  yuiokl  ", "yuiokl", vowelsLetters) == " bc    "
    assert (
        getTask2(
            "  fiol  kio abc ciao    abc  ",
            "abc",
            vowelsLetters,
        )
        == "  fl  k  c      "
    )
