#include <stdio.h>

#include "test.h"
#include "../../include/mylib.h"

int testLibrary() {
    printf("===TEST START===\n");
    int actual = adder(1, 2);
    int expected = 3;

    if (actual == expected) {
        printf("===PASS===\n");
        printf("===TEST END===\n");
        return 0;
    }
    printf("===FAIL MSG===\n");
    printf("Expected %d\n", expected);
    printf("Actual %d\n", actual);
    printf("===FAIL END===\n");
    return 1;
}
