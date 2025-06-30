# import unicodedata
# def unicode_len(text: str):
#     modifier_categories = set(["Mc", "Mn"])
#
#     return sum(unicodedata.category(ch) not in modifier_categories for ch in text)


def adjust_str(text: str, max_len: int):
    ellipsis = "..."
    len_diff = len(text) - max_len

    if len_diff > 0:
        return text[: max_len - len(ellipsis)] + ellipsis
    else:
        return text + (" " * (-len_diff))
