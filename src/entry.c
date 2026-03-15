#include <vga.h>
#include <kb.h>
#include <stdint.h>

void josh(void) {
    kb_init();
    puts("josh\nKeyboard echo ready. Type to see characters on screen.\n");

    for (;;) {
        unsigned char c = loop_until_keypress_e(); /* blocking busy-wait */
        if (!c) continue;

        if (c == 0x1B) { /* ESC */
            puts("[ESC]");
            continue;
        }

        if (c == '\b') {
            extern void set_cursor_pos(int row, int col);
            extern int row, col;

            if (col > 0) {
                col--;
            } else if (row > 0) {
                row--;
                col = 79;
            }
            putc(' ');
            set_cursor_pos(row, col);
            continue;
        }

        /* newline handling */
        if (c == '\n') {
            putc('\n');
            continue;
        }

        /* printable */
        putc((char)c);
    }
}