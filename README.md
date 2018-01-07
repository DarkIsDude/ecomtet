# ecomtet

This repository contains code for ecomtet.com website.

## Helpers Commands

* `docker build -t ecomtet .`
* `docker run --name ecomtet -it -p 4000:4000 -v /Users/doudou/Workspaces/ecomtet.git:/app/ ecomtet ping 8.8.8.8`
* `docker exec -it ecomtet bash`
* `jekyll serve --host 0.0.0.0 --watch --livereload`
