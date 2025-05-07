"""
URL: https://leetcode.com/problems/majority-element/description/

Given an array nums of size n, return the majority element.

The majority element is the element that appears more than
⌊n / 2⌋ times. You may assume that the majority element
always exists in the array.

Input: nums = [3,2,3]
Output: 3
"""

from collections import Counter


def majority_element(nums):
    freq = Counter(nums)
    most_common_number = freq.most_common(1)[0][0]

    return most_common_number


nums = [3, 2, 3]
print("Solution: ", majority_element(nums))
