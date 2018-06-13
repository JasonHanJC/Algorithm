int start = 0, maxLen = 1;
void extendPalindrome(char* s, int low, int high, int len) {
    while (low >= 0 && high < len && s[low] == s[high]) {
        if (high - low + 1 > maxLen) {
            start = low;
            maxLen = high - low + 1;
        }
        --low;
        ++high;
    }
}

char* longestPalindrome(char* s) {
    int len = strlen(s);

    if (len == 0 ||  len == 1) {
        return s;
    }

    int i;
    for (i = 1; i < len; i++) {
        // check even length, start point i-1, i
        extendPalindrome(s, i - 1, i, len);
        // check even length, start point i
        extendPalindrome(s, i, i, len);
    }

    // make the string
    char *res = (char *)malloc(sizeof(char));
    char *temp = res;
    for (int i = start; i <= start + maxLen - 1; i++) {
        *temp = s[i];
        temp++;
    }
    *temp = '\0';

    return res;
}
