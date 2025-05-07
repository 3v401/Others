"""
URL: https://leetcode.com/problems/top-k-frequent-elements/description/

Given an integer array nums and an integer k,
return the k most frequent elements.
You may return the answer in any order.

Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
"""

from collections import Counter
import heapq


def top_k_frequent(nums, k):
    freq = Counter(nums)
    return heapq.nlargest(k, freq.keys(), key=freq.get)


# Counter gives the element and its frequence in a dictionary
# Heapq.nlargest looks for the k most frequent elements

nums = [1, 1, 1, 2, 2, 3]
k = 2

print("Solution: ", top_k_frequent(nums, k))
