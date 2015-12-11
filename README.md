# BestComitter [![Build Status](https://travis-ci.org/pine613/BestCommiter.svg)](https://travis-ci.org/pine613/BestCommiter)

The GitHub commits count tool for developer

## Installation
First, you should install [Crystal](http://crystal-lang.org/) compiler v0.9.1, using a tool such as [crenv](https://github.com/pine613/crenv).

```sh
$ crystal -v
Crystal 0.9.1 [b3b1223] (Fri Oct 30 03:26:53 UTC 2015)

$ shards --version
Shards 0.5.3 [10e3126] (2015-11-04)

$ make
```

## Usage

```sh
$ cp config.sample.yml config.yml
$ vim config.yml # edit your configuration
$ ./bin/best_comitter --help # show command help
$ ./bin/best_comitter public --days 7 --sort-by count # show public repository
$ ./bin/best_comitter private --days 7 # show private repository
```

## Contributing

1. Fork it ( https://github.com/pine613/BestComitter/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [BestComitter](https://github.com/BestComitter) Pine Mizune - creator, maintainer
