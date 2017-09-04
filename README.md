singer-heroku
=============

 A collection of utilities to facilitate running [singer.io](http://singer.io)
 taps and targets on Heroku

## Installation

    gem install singer-heroku


## generate-config

  Reads from `#{KEY}_CONFIG_*` environment variables and generates json to
  stdout.

  Given the following ENV:

    VEND_CONFIG_first_name=joe
    VEND_CONFIG_last_name=lind

    generate-config -k VEND
    {"first_name":"joe","last_name":"lind"}
