// shift an array of chars by m step
// ex:
// shift abcdef by 3 to defabc

// brute force way: shift one by one
// since we need to replace each chars m times, then the time complexity is O(mn)

// smarter way: reverse chars at 0 ~ m-1, then reverse chars at m ~ n-1, then reverse 0 ~ n-1
// time complexity is O(n)

!function(chars, n) {

    // array if object in javascript,
    // and javascript always pass a copy of object reference to another function
    console.log(typeof(chars));
    // get minimun steps
    var len = chars.length;
    var n = n % len;

    reverse(chars, 0, n - 1);
    reverse(chars, n, len - 1);
    reverse(chars, 0, len - 1);

    console.log(chars);

}(['a', 'b', 'c', 'd', 'e', 'f'], 3);

function reverse(a, s, e) {
    while(s < e) {
        var temp = a[s];
        a[s] = a[e];
        a[e] = temp;
        s++;
        e--;
    }
}



// 举一反三

