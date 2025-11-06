#include <stdarg.h>
#include <stdio.h>
#include <ctype.h>

int match_space(FILE *f) {
    int c;
    while ((c = fgetc(f)) != EOF && isspace(c));
    if (c != EOF) ungetc(c, f);
    return 0;
}

int match_char(FILE *f, char c) {
    int cc = fgetc(f);
    if (cc == c) return 1;
    if (cc != EOF) ungetc(cc, f);
    return 0;
}

int scan_char(FILE *f, va_list ap) {
    char *p = va_arg(ap, char*);
    int c = fgetc(f);
    if (c == EOF) return 0;
    *p = c;
    return 1;
}

int scan_int(FILE *f, va_list ap) {
    int *p = va_arg(ap, int*);
    int c = fgetc(f);
    if (!isdigit(c)) {
        if(c != EOF) ungetc(c, f);
        return 0;
    }
    int res = 0;
    while (isdigit(c)) {
        res = res * 10 + (c - '0');
        c = fgetc(f);
    }
    if(c != EOF) ungetc(c, f);
    *p = res;
    return 1;
}

int scan_string(FILE *f, va_list ap) {
    char *p = va_arg(ap, char*);
    int c = fgetc(f);
    if (c == EOF || isspace(c)) {
        if(c != EOF) ungetc(c, f);
        return 0;
    }
    int i = 0;
    while (c != EOF && !isspace(c)) {
        p[i++] = c;
        c = fgetc(f);
    }
    if(c != EOF) ungetc(c, f);
    p[i] = '\0';
    return 1;
}

int match_conv(FILE *f, const char **format, va_list ap) {
    switch(**format) {
        case 'c': return scan_char(f, ap);
        case 'd': match_space(f); return scan_int(f, ap);
        case 's': match_space(f); return scan_string(f, ap);
        default: return 0;
    }
}

int ft_vfscanf(FILE *f, const char *format, va_list ap) {
    int count = 0;
    while(*format) {
        if (*format == '%') {
            format++;
            if (!match_conv(f, &format, ap)) break;
            count++;
        } else if (isspace(*format)) {
            match_space(f);
        } else {
            if (!match_char(f, *format)) break;
        }
        format++;
    }
    if (ferror(f)) return EOF;
    return count;
}

int ft_scanf(const char *format, ...) {
    va_list ap;
    va_start(ap, format);
    int ret = ft_vfscanf(stdin, format, ap);
    va_end(ap);
    return ret;
}
