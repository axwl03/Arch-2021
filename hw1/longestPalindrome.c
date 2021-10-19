#include <stdio.h>

int longestPalindrome(char *s){
    int count['z' + 1] = {0}, ans = 0;

    // count the number of occurences of each letter
    char *ptr = s;
    for (; *ptr != '\0'; ++ptr)
        ++count[*ptr];
    int length = ptr - s;

    // count each pair
    for (int i = 'A'; i <= 'z'; ++i)
        ans += (count[i] & 0xfffffffe);
    return ans + ((ans < length) ? 1 : 0);
}

int main() {
    char *str = "abccccdd";
    printf("%d", longestPalindrome(str));
    return 0;
}
