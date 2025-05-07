"""
URL: https://leetcode.com/problems/minimum-window-substring/description/

Given two strings s and t of lengths m and n respectively,
return the minimum window substring of s such that every character
in t (including duplicates) is included in the window.
If there is no such substring, return the empty string "".

Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
"""

from collections import Counter

def min_window(s, t):
    if not t or not s:
        # If any of the strings is empty, no solution
        return ""

    t_count = Counter(t)
    # How many times appears each letter in t

    window_count = {}
    # Characters and frequency that appear in the current window

    have, need = 0, len(t_count)
    # 'have': How many required characters we already have
    # 'need': Total of characters required to find a window

    solution = [0, float("inf")]
    # In the worst case scenario, best solution is [0, infinity]
    left_pointer = 0

    for right_pointer in range(len(s)):

        char = s[right_pointer]
        # Character we are seeing
        window_count[char] = window_count.get(char, 0) + 1

        if char in t_count and window_count[char] == t_count[char]:
            # If we have the quantity required for that character
            have += 1

        while have == need:
            # If all required characters are found
            if (right_pointer - left_pointer) < (solution[1] - solution[0]):
                solution = [left_pointer, right_pointer]
                # If the length of the current pointers is shorter than the previous one
                # Update the solution

            window_count[s[left_pointer]] -= 1

            if (
                s[left_pointer] in t_count
                and window_count[s[left_pointer]] < t_count[s[left_pointer]]
            ):
                have -= 1
                # We don't have that character -> incomplete

            left_pointer += 1
            # Move left pointer to the right

    left, right = solution
    return s[left : right + 1] if solution[1] != float("inf") else ""


s = "ADOBECODEBANC"
t = "ABC"
print("Solution: ", min_window(s, t))
