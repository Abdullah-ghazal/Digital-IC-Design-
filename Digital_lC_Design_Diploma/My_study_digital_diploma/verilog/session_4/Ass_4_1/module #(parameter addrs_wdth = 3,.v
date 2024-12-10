#include <iostream>
#include <algorithm>

using namespace std;

bool isUgly(const int a[], int n) {
    int prefixSum = 0;
    for (int i = 0; i < n; ++i) {
        if (prefixSum == a[i]) {
            return true;
        }
        prefixSum += a[i];
    }
    return false;
}

void makeBeautiful(int a[], int n) {
    int prefixSum = 0;

    // Handle already beautiful case efficiently
    if (!isUgly(a, n)) {
        return;
    }

    // Efficiently find the first ugly element with a matching prefix sum
    for (int i = 0; i < n; ++i) {
        if (prefixSum == a[i]) {
            // Swap the ugly element with the next non-matching element
            int j = i + 1;
            while (j < n && prefixSum == a[j]) {
                j++;
            }
            if (j < n) {
                swap(a[i], a[j]);
                return;
            }
            break; // No valid swap found, array cannot be made beautiful
        }
        prefixSum += a[i];
    }
}

int main() {
    int t;
    cin >> t;

    while (t--) {
        int n;
        cin >> n;

        int a[n];
        for (int i = 0; i < n; ++i) {
            cin >> a[i];
        }

        makeBeautiful(a, n);
        if (isUgly(a, n)) {
            cout << "NO\n";
        } else {
            cout << "YES\n";
            for (int i = 0; i < n; ++i) {
                cout << a[i] << " ";
            }
            cout << endl;
        }
    }

    return 0;
}
