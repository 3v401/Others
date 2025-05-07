"""
URL: https://leetcode.com/problems/number-of-islands/description/

Given an m x n 2D binary grid grid which represents a map
of '1's (land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting
adjacent lands horizontally or vertically. You may assume
all four edges of the grid are all surrounded by water.
"""


def num_islands(grid):
    if not grid:
        return 0

    # Define DFS algorithm
    def dfs(r, c):
        # If we exit the matrix or are in water, we exit
        if r < 0 or c < 0 or r >= len(grid) or c >= len(grid[0]) or grid[r][c] == "0":
            return
        # Mark as visited:
        grid[r][c] = "0"
        # Move in 4 directions
        dfs(r + 1, c)
        dfs(r - 1, c)
        dfs(r, c + 1)
        dfs(r, c - 1)

    count = 0
    for r in range(len(grid)):
        for c in range(len(grid[0])):
            if grid[r][c] == "1":
                dfs(r, c)
                count += 1

    return count


grid = [
    ["1", "1", "0", "0", "0"],
    ["1", "1", "0", "0", "0"],
    ["0", "0", "1", "0", "0"],
    ["0", "0", "0", "1", "1"],
]
print("Solution: ", num_islands(grid))
