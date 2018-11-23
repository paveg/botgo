BotGo
===

A slack bot with golang.

## Installation

```bash
$ git clone https://github.com/paveg/botgo
$ cd botgo
```

## Run

### without Container

```bash
$ make build
$ make run
```

### with Container

```bash
# Please set env as a reference; .envrc-example .
$ make dkr.build # app root
$ make dkr.run
```
