#include <iostream>
#include <vector>
#include <unordered_map>

// To use standard c++ names without std:: every time
using namespace std;

int majorityElement(const vector<int>& nums) {
    unordered_map<int, int> countMap;
    int majorityCount = nums.size() / 2;
    for (int num: nums){
        countMap[num]++;

        if (countMap[num] > majorityCount) {
            return num;
        }
    }
    return -1;
}

int main() {
    vector<int> nums = {3,2,3};

    cout << " Majority Element: " << majorityElement(nums) << endl;
    return 0;
}