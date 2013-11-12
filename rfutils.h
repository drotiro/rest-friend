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

time_t  unix_time(const char * timestr);

#endif
//RFUTILS_H
