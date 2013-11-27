#ifndef RFUTILS_H
#define RFUTILS_H

#include <sys/stat.h>
#include <stdio.h>
#include <time.h>

typedef struct edata_t {
	char * data;
	size_t len;
	size_t capacity;
} edata;

void    edata_init(edata * e);
void    edata_cat(edata * e, char * txt, size_t size);

off_t   filesize(const char * localpath);
char *  pathappend(const char * one, const char * two);      

/*
 * Convert string dates (eg. "2013-10-28 07:20:31")
 * to unix timestamps.
 * The 2 args variant allows using a custom strptim format
 */
time_t  unix_time(const char * timestr);
time_t  unix_time_format(const char * timestr, const char * format);

#endif
//RFUTILS_H
