#include <vga.h>
#include <kb.h>

void josh() {
    puts("josh\n");
    kb_init();
    puts("keyboard initialized\n");
    for (;;) {
        char c = loop_until_keypress();
        putc(c);
    }
}
