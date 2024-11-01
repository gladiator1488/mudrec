#include <iostream>
#include <string>
#include <vector>
#include <random>
#include <chrono>


using namespace std;
using namespace std::chrono;

// �������� ������� ��������
string lcs_brute_force(const string& X, const string& Y) {
    int n = X.length();
    int m = Y.length();
    string max_lcs = "";

    // ������� ���� ���������������������� ������ ������
    for (int i = 0; i < (1 << n); ++i) {
        string subsequence = "";
        for (int j = 0; j < n; ++j) {
            if (i & (1 << j)) {
                subsequence += X[j];
            }
        }

        // ��������, �������� �� ��������������������� ���������������������� ������ ������
        int k = 0;
        bool is_subsequence = true;
        for (int j = 0; j < m; ++j) {
            if (k < subsequence.length() && subsequence[k] == Y[j]) {
                k++;
            }
        }
        if (k == subsequence.length() && subsequence.length() > max_lcs.length()) {
            max_lcs = subsequence;
        }
    }

    return max_lcs;
}

// �������� ������������� ����������������
string lcs_dynamic_programming(const string& X, const string& Y) {
    int n = X.length();
    int m = Y.length();

    // ������������� ������� LCS
    vector<vector<int>> LCS(n + 1, vector<int>(m + 1, 0));

    // ���������� ������� LCS
    for (int i = 1; i <= n; ++i) {
        for (int j = 1; j <= m; ++j) {
            if (X[i - 1] == Y[j - 1]) {
                LCS[i][j] = LCS[i - 1][j - 1] + 1;
            } else {
                LCS[i][j] = max(LCS[i - 1][j], LCS[i][j - 1]);
            }
        }
    }

    // �������������� ��� �� ������� LCS
    int i = n;
    int j = m;
    string lcs = "";
    while (i > 0 && j > 0) {
        if (X[i - 1] == Y[j - 1]) {
            lcs += X[i - 1];
            i--;
            j--;
        } else {
            if (LCS[i - 1][j] > LCS[i][j - 1]) {
                i--;
            } else {
                j--;
            }
        }
    }

    // �������� �������, ����� �������� ��� � ���������� �������
    //reverse(lcs.begin(), lcs.end());

    return lcs;
}

string generateRandomUpperCaseString(int length) {
  random_device rd;  // ���������� random_device ��� ����� ������������ �����������
  mt19937 generator(rd()); // Mersenne Twister 19937 - ������ ��������� ��������������� �����
  uniform_int_distribution<> distribution('A', 'Z'); // �������� �� 'A' �� 'Z'

  string randomString;
  for (int i = 0; i < length; ++i) {
    randomString += distribution(generator);
  }
  return randomString;
}


int main() {
    int desiredLength = 10000; // ������ �������� ����� ������
    string X = generateRandomUpperCaseString(desiredLength);
    string Y = generateRandomUpperCaseString(desiredLength);
    
    

    cout << "��� (" << "X" << ", " << "Y" << ") ������� ������� ��������: " << lcs_brute_force(X, Y) << endl;
    cout << "��� (" << "X" << ", " << "Y" << ") ������� ������������� ����������������: " << lcs_dynamic_programming(X, Y) << endl;

    return 0;
}
