#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

/* #define WPM 400 */
/* should be 1/2 the size of the longest string don't want to read in the whole thing first. if the string is longer than 2x the offset, too bad. */
#define OFFSET 20
#define BUFSIZE 1024
#define COLOR "\x1b[0m"
/* "\x1b[37;1m" */
#define CENTERCOLOR "\x1b[31;1m"
#define RESETCOLOR "\x1b[0m"

/* number of spaces to prepend to string on output */
int spaces(int stringsize, int offset) {
/* offset marks where the middle character should go. so # of spaces is offset - stringsize/2 or 0 of negative */
    int result = offset - (stringsize/2); 
    return (result > 0) ? result : 0;
}

int buffer_spans(char *buffer, size_t size, char *delims) {
    int i = 0;
    int len_delims = strlen(delims);
    /* for each delimiter (marking separation character) check if the last character in the buffer matches. If it does, we don't need to save the last token */
    for (i = 0; i < len_delims; i++) {
        if (buffer[size-1] == delims[i]) {
            return 0;
        }
    }
    return 1; 
}

void printstring(char *string) {
    int n_spaces;
    int middle = (strlen(string)/2);

    n_spaces = spaces(strlen(string), OFFSET);
    printf("%*s", n_spaces,"");
    printf(COLOR "%.*s", middle, string);
    printf(CENTERCOLOR "%.*s", 1, string+middle);
    printf(COLOR "%s" RESETCOLOR, string+middle+1);
}
    

int main(int argc, char *argv[]) {
    struct stat st_buf;
    int WPM, status, save_last, has_punct;
    long conv;

    FILE *f;
    char *delims = ";\n \"";
    char buffer[BUFSIZE],*p;
    /* for strings that span the buffer boundary */
    char *savedstring = NULL;
    char *frankenstring = NULL;
    char *last;

    if (argc > 1) {
        conv = strtol(argv[1], NULL, 10);
        if ((conv > 2000) || (conv <= 0))
            WPM = 400;
        else
            WPM = conv;
    } else {
        WPM = 400;
        conv = 0;
    }

    if (argc == 3) {
        status = stat(argv[2], &st_buf);
        if (status != 0 || (!S_ISREG(st_buf.st_mode))) {
            fprintf(stderr, "Error or file not found: %s\n", argv[2]);
            return 1;
        }
        f = fopen(argv[2], "r");
    } else if (argc == 2) {
        if (conv == 0) {
            /* check file */
            status = stat(argv[1], &st_buf);
            if (status != 0 || (!S_ISREG(st_buf.st_mode))) {
                fprintf(stderr, "Error or file not found: %s\n", argv[1]);
                return 1;
            }
            f = fopen(argv[1], "r");
        } else
            f = stdin;
    } else
        f = stdin;

    /* open the file */
    if (f == NULL) {
        fprintf(stderr, "Error opening file: %s\n", argv[1]);
        return 1;
    }

    while(fgets(buffer, BUFSIZE, f) != NULL) {
        save_last = buffer_spans(buffer, BUFSIZE, delims);

        p=strtok(buffer, delims);
        /* fgets keeps newlines, but the tokenizer splits them so p can be NULL if fgets only has a newline. */
        if (p == NULL) {
            usleep(4*(60.0/WPM) * 1000 * 1000);
            continue;
        }
        if (savedstring && (savedstring != NULL)) { 
            if (frankenstring && (frankenstring != NULL)) {
                free(frankenstring);
                frankenstring = NULL;
            }

            frankenstring = malloc(sizeof(char) * (strlen(p)+strlen(savedstring)) + 1);
            strncat(frankenstring, savedstring, strlen(savedstring));
            strncat(frankenstring, p, strlen(p));
            p = frankenstring;
        }

        do {
            if (save_last == 1) {
                last = p;
            }
            printstring(p);

            /* I actually don't know why these don't work if both are puts or printf or they are swapped... shrug. */
            printf("\x1b[0K");
            puts("\x1b[1A");

            /* delay twice as long for punctuation */
            has_punct = (ispunct(p[strlen(p)-1]) == 0) ? 1 : 2;
            usleep(has_punct*(60.0/WPM) * 1000 * 1000);

        } while ((p = strtok(NULL, delims)));

        /* clean up */
        if (save_last == 1) {
            if (savedstring && (savedstring != NULL)) {
                free(savedstring);
                savedstring = NULL;
            } else {
                savedstring = strdup(last);
            }
        }
    
    }
    fclose(f);
    printf("\n");
}
