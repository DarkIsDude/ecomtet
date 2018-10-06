# ecomtet

This repository contains code for ecomtet.com website.

## Helpers Commands

* `docker build -t ecomtet .`
* `docker run --rm --name ecomtet -it -p 4000:4000 -v ${PWD}:/srv/jekyll --entrypoint=/bin/bash ecomtet`
* `docker exec -it ecomtet bash`
* `jekyll serve --host 0.0.0.0 --watch`
