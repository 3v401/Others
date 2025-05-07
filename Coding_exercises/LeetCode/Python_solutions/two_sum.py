"""
URL: https://leetcode.com/problems/two-sum/description/

Given an array of integers nums and an integer target,
return indices of the two numbers such that they add up to target.
You may assume that each input would have exactly one solution,
and you may not use the same element twice.
You can return the answer in any order.

Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
"""

nums = [2, 7, 11, 15]
target = 9


def two_sum_optimized(nums, target):
    """
    Uses a dictionary (hash map) for constant-time lookups of complements
    O(n) -> Efficient for large arrays
    """
    my_dict = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in my_dict:
            return [my_dict[complement], i]
        my_dict[num] = i


def two_sum_not_optimized(nums, target):
    """
    Double loop checks every pair O(n^2) -> inefficient for large arrays
    """
    for i in range(len(nums)):
        for j in range(len(nums)):
            if nums[i] + nums[j] == target and i != j:
                index_one = i
                index_two = j
                return [index_one, index_two]


print("Two sum optimized: ", two_sum_optimized(nums, target))
print("Two sum not optimized: ", two_sum_not_optimized(nums, target))
