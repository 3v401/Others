"""
URL: https://leetcode.com/problems/subarray-sum-equals-k/description/

Given an array of integers nums and an integer k,
return the total number of subarrays whose sum equals to k.

A subarray is a contiguous non-empty sequence of elements within an array.

Input: nums = [1,1,1], k = 2
Output: 2
"""

# Mathematical property:
# If current sum -k = one previous seen sum -> There is a subarray

nums = [1, 1, 1, 1, 1, 1]
k = 2

def subarray_sum_equals_k(nums, k):
    count = 0
    current_sum = 0
    previous_sum = {0: 1}
    # Dictionary that stores how many times a previous sum was seen
    for num in nums:
        current_sum += num
        if current_sum - k in previous_sum:
            count += previous_sum[current_sum - k]
        previous_sum[current_sum] = previous_sum.get(current_sum, 0) + 1
        # Either positive or not, update the dictionary with the current sum
    return count

print(subarray_sum_equals_k(nums, k))