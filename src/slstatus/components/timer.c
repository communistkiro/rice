#include <stdio.h>
#include "../util.h"

const char *
timer(void)
{
    char *time_left [9];
    if (pscanf("/tmp/tmr.tmr.tmr", "%s", &time_left) != 1) {         
        return NULL;
    }
    return bprintf("[%s]", time_left);
}
