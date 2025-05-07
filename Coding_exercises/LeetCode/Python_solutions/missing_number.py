"""
URL: https://leetcode.com/problems/missing-number/description/

Given an array nums containing n distinct numbers in the range [0, n],
return the only number in the range that is missing from the array.

Input: nums = [3,0,1]
Output: 2
"""


def missing_number(nums):
    n = len(nums)
    expected_sum = n * (n + 1) // 2
    real_sum = sum(nums)
    return expected_sum - real_sum


nums = [3, 0, 1]
print("Solution: ", missing_number(nums))
