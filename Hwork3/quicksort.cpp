#include <iostream>
#include <vector>
#include <stack>
#include <utility>

int partition(std::vector<int>& arr, int low, int high) {
    int pivot = arr[high]; // Choose rightmost element as pivot
    int i = (low - 1); // index of 'high' element, the last element that is smaller than our pivot

    // Iterate over subarray to ensure elements are properly partitioned, swapping as needed
    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }

    std::swap(arr[i+1], arr[high]);
    return (i + 1);
}

std::vector<int> quicksort(std::vector<int>& nums) {
    if (nums.empty() || nums.size() <= 1) {
        return nums; // Already sorted or empty
    }

    std::stack<std::pair<int, int>> stack; // The pair will be the start and end indices of each range
    stack.push({0, static_cast<int>(nums.size() - 1)}); // Push initial range (start, end)

    while (!stack.empty()) {
        std::pair<int, int> range = stack.top();
        stack.pop();

        int low = range.first;
        int high = range.second;

        if (low < high) {
            int partitionIndex = partition(nums, low, high);

            // Push sub-array ranges onto the stack
            stack.push({partitionIndex + 1, high}); // right sub-array
            stack.push({low, partitionIndex-1});
        }
    }

    return nums;
}

int main() {
    std::vector<int> unsortedArray = {7, 2, 1, 6, 8, 5, 3, 4, 9}; // Define a test array

    std::cout << "Unsorted array: "; // Output label
    for (int val : unsortedArray) { // Loop through and print each value in unsortedArray
        std::cout << val << " ";
    }
    std::cout << std::endl; // Newline after printing array

    std::vector<int> sortedArray = quicksort(unsortedArray); // Call the quicksort function

    std::cout << "Sorted array: ";
    for (int val : sortedArray) { // Loop through and print each value in sortedArray
        std::cout << val << " ";
    }
    std::cout << std::endl; // Newline after printing array

    return 0; // Indicate successful program execution
}