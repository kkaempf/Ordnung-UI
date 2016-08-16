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

GET /add - select directory
POST /add/path/to/dir - add directory
GET / - view dashboard
GET /tags/tag:no:1/tag:no:2 - filter by tags
POST /tags/tag:no:1/tag:no:2?item=<hash> - add tags to item