the problem of collecting a sitemap and cycles appears to be a take on a depth
first search question.

things we should probably consider:
* following links in HTML probably likely requires an HTML parser
* there can be a lot of links on a page, recursive approach to DFS likely isn't a great solution

open questions:
* is a cycle an error? I'd say no
