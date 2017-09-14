singer-heroku
=============

 A collection of utilities to facilitate running [singer.io](http://singer.io)
 taps and targets on Heroku

## Installation

    gem install singer-heroku


## Create this table in `DATABASE_URL` database

    CREATE TABLE singer_states
      (
        key text NOT NULL,
        data jsonb,
        CONSTRAINT singer_states_pkey PRIMARY KEY (key)
      )

## generate-config

  Reads from `#{KEY}_CONFIG_*` environment variables and generates json to
  stdout.

  Given the following ENV:

    TEST_CONFIG_first_name=joe
    TEST_CONFIG_last_name=lind

    generate-config -k TEST
    {"first_name":"joe","last_name":"lind"}

## read-state

  Reads JSON `data` from `singer_states` table in `DATABASE_URL` where key is
  `#{KEY}`, passed in args.

    > read-state -kTEST
    {"high_water_mark":4}


## write-state

  Reads jsonl from stdin and writes to database specified in DATABASE_URL

    > cat states.json
    { "high_water_mark": 1 }
    { "high_water_mark": 2 }
    { "high_water_mark": 3 }
    { "high_water_mark": 4 }

    > cat states.json | write-state -kTEST
    > read-state -kTEST
    {"high_water_mark":4}
