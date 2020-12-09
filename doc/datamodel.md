# Ordnung datamodel

It all revolves around files. On your hardisk, NAS, the cloud,
CDROMs/DVDs, whatever.

Files have a name and a path. The path should tell you a bit about the
files purpose or content.

(Pathes are stripped from their prefix, like `C:\` or `/home` which
reveal little compared to `Pictures\Family` or `Documents/bank`.)

Ordnung especially helps you to find duplicates. Duplicate detection
is done with checksum hashes, like md5.

A second attribute is the file size. If two files (identified by name
and path) share the same checksum and size, Ordnung treats them as
identical.

A file has some more attributes:

* name
  As explained above, minus the extension.
* extension foreign_key
  like .doc, .jpg, or .mp3; without the dot
* directory foreign_key
  list of path components, like: "Pictures","Family"
* md5
  checksum
* size
  file size in bytes
* ctime
  file creation time
* mimetype foreign_key
  on import, the file is checked by its extension
  and a detailed mimetype is stored
* tags
  tbd

----

File
- id: Int primary_key
- name: String
- md5: String
- size: Int
- ctime: Date
- has_one :extension
- has_one :mimetype
- has_one :directory

Directory - linked list of path elements
- id: Int primary_key
- parent: Int
- name: String

Mimetype
- id: Int primary_key
- name: String
- has_one: extension

Extension
- id: Int primary_key
- name: String
- has_many: mimetype
