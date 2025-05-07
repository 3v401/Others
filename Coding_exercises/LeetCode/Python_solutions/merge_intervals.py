"""
URL: https://leetcode.com/problems/merge-intervals/description/

Given an array of intervals where intervals[i] = [starti, endi],
merge all overlapping intervals, and return an array of
the non-overlapping intervals that cover all the intervals in the input.

Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
"""


def merge_intervals(intervals):
    # Sort each interval by first element in each interval
    intervals.sort(key=lambda x: x[0])

    merged = []

    for interval in intervals:
        # If merged is empty ro don't overlap, append this interval
        if not merged or merged[-1][1] < interval[0]:
            merged.append(interval)
        else:
            # They overlap -> combine updating the end
            merged[-1][1] = max(merged[-1][1], interval[1])

    return merged


intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
print("Solution: ", merge_intervals(intervals))