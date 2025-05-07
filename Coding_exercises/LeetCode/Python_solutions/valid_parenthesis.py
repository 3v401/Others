"""
URL: https://leetcode.com/problems/valid-parentheses/description/

Given a string s containing just the characters
'(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Every close bracket has a corresponding open bracket of the same type.

Input: s = "()"
Output: true
"""


def valid_parenthesis(s):

    outcome = True
    stack = []
    mapping = {"(": ")", "{": "}", "[": "]"}

    for char in s:
        if char in mapping:
            stack.append(char)
            # Save the keys (beginnings)
        else:
            # We finish finding the keys (stacking the pile)
            if not stack:
                # If the stack is empty -> Error
                outcome = False
                break
            top = stack.pop()
            # Save the top of the stack
            if char != mapping[top]:
                # If the next character (after stacking) is not the
                # mapped equivalent of top -> The string is not correctly
                # ordered
                outcome = False
                break
    if stack:
        # If any symbol remains, it is not closed
        outcome = False

    return outcome


print("Solution: ", valid_parenthesis("{[()]}"))  # True
print("Solution: ", valid_parenthesis("([)]"))  # False
print("Solution: ", valid_parenthesis("((()))"))  # True
print("Solution: ", valid_parenthesis("{[}"))  # False
