![Flarum](http://flarum.org/img/logo.png)

Flarum skeleton
===

[![Build Status](https://travis-ci.org/flarum3xt/skeleton.svg?branch=master)](https://travis-ci.org/flarum3xt/skeleton)
[![Coverage Status](https://coveralls.io/repos/github/flarum3xt/skeleton/badge.svg?branch=master)](https://coveralls.io/github/flarum3xt/skeleton?branch=master)


Directories structure
---
```
path/to/project
├── CHANGELOG.md
├── composer.json
├── composer.lock
├── config
│   ├── app.php
│   └── app.php.dist
├── CONTRIBUTING.md
├── LICENSE
├── phpcs.xml.dist
├── phpunit.xml.dist
├── public
├── README.md
├── src
├── storage
├── tests
├── Vagrantfile
└── vendor
```
Requirements
---

* PHP 5.5+
* [Composer][composer]
* NodeJS and [npm][npm] 

TODO
---
- [ ] Write [README](README.md) document
- [x] Integrate [Composer][composer] and publish to https://packagist.org
- [ ] Refactor project constructor
- [ ] Integrate [PHPCS][phpcs] to check coding style
- [ ] Integrate [PHPUnit][phpunit] and write some unit test scripts
- [ ] Integrate some CI, eg: [TravisCI][travis], [Coveralls][coveralls], ...
- [ ] Write [Vagrant][vagrant] script to set up development environment
- [ ] Write [Docker][docker] script to set up development environment
- [ ] Write [CONTRIBUTE](CONTRIBUTING.md) rule document
- [ ] Write document and publish on [Github page][githubpage]



[psr2]:      https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md
[psr3]:      https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-3-logger-interface.md
[composer]:  https://getcomposer.org
[npm]:       https://docs.npmjs.com/getting-started/installing-node
[phpunit]:   https://phpunit.de
[phpcs]:     https://github.com/squizlabs/PHP_CodeSniffer
[vagrant]:   https://www.vagrantup.com
[docker]:    https://www.docker.com
[travis]:    https://travis-ci.org
[coveralls]: https://coveralls.io
[githubpage]: https://pages.github.com