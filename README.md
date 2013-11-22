# REST friend

Writing REST clients in C is easier if you've got a friend

## Features

### Making API calls

This library provides functions for making calls to http and https endpoints, using libcurl.

GETting, POSTing, uploading files, adding authentication headers etc can be done easily.

A printf-like function helps dealing with parametric URLs.

Usage: take a look at `<rfhttp.h>`

### Parsing JSON responses

If you are using a REST API that speaks json, you can use `<rfjson.h>` to get lightweight object-tree
version of the response

### Misc utils

Some things that may come in handy. Look at `<rfutils.h>`

## Compiling

# Make sure you have all the required dependencies:
 * libapp  - https://github.com/drotiro/libapp
 * libjson - https://github.com/vincenthz/libjson/
 * libcurl
# Run `make` and optionally `sudo make install` to get the headers and the library
installed under `PREFIX`. The install target also installs the pkg-config file.

## Credits

REST friend is written by me (Domenico Rotiroti) and is based on
[https://github.com/drotiro/boxfs2 boxfs2] code.

The project is licensed under the GPLv3 (see gpl-3.0.txt).
