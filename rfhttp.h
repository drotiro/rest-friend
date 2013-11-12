#ifndef RFHTTP_H
#define RFHTTP_H

#include <stdio.h>
#include <stdarg.h>

/* 2010-02-03 Domenico Rotiroti
   Licensed under the GPLv3

   HTTP(S) transfer functions and related utilities
*/

/* A type for data to be posted */
struct postdata {
	struct curl_httppost * post;
	struct curl_httppost * last;
};
typedef struct postdata * postdata_t;

/* Fetching (GET) of pages and files */
char *	http_fetch(const char * url);
char *	http_fetchf(const char * fmt, ...);
int	http_fetch_file(const char * url, const char * dest, int append);

/* Data POSTing and other http requests */
postdata_t post_init();
void       post_free(postdata_t postdata);
void       post_add(postdata_t buf, const char * name, const char * val);
long       post_addfile(postdata_t rbuf, const char * name, const char * tmpfile);
char *     post_addfile_part(postdata_t rbuf, const char * name,
        		const char * tmpfile, size_t offset, size_t len);

char * http_post(const char * url, postdata_t data);
char * http_postfile(const char * url, postdata_t data);
char * http_post_fields(const char * url, const char * fields);
char * http_put_fields(const char * url, const char * fields);
long   http_delete(const char * url);

/* Authentication */
void set_auth_header(const char * auth_header);

/* Misc */
void set_conn_reuse(int reuse);

#endif
//BOXHTTP_H
