# About Ordnung

A web application to index and tag all your data

## Functions

* select dir or file to add
* view dashboard
* tag item(s)

## Tag format

multi:component:tags

### Examples

nr:9, family:brother, family:sister:sue, 

## REST pathes

GET /directory - select directory
POST /directory body: /path/to/dir - add directory
GET /file/<hash>

GET / - view dashboard
GET /tag?tag:no:1&tag:no:2 - filter by tags
POST /tag/<hash> body: tag:no:1, tag:no:2?item= - add tags to item