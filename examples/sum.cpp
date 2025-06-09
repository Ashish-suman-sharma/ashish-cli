#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter number of integers: ";
    cin >> n;
    
    int sum = 0;
    cout << "Enter " << n << " integers: ";
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        sum += x;
    }
    
    cout << "Sum is: " << sum << endl;
    return 0;
}
