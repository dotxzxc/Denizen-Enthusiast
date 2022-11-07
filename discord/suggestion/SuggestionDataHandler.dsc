# yaml id discord_suggestion_data
suggestion_load_data:
  type: world
  debug: false
  events:
    # loads/creates the yaml data file on server start
    after server start:
    - if <proc[suggestion_data_exists].not>:
      - announce to_console "[Discord suggestor] Discord suggestion data does not exist, making one..."
      - run suggestion_data_create
      - stop
    - announce to_console "[Discord suggestor] Discord suggestion data found, loading it..."
    - ~yaml load:data/discord_suggestion_data.yml id:discord_suggestion_data

    on delta time minutely:
    - if <yaml[discord_suggestion_data].has_changes>:
      - ~yaml savefile:data/discord_suggestion_data.yml id:discord_suggestion_data

# script for creating the yaml data file
suggestion_data_create:
  type: task
  debug: false
  script:
  - yaml create id:discord_suggestion_data
  - ~yaml savefile:data/discord_suggestion_data.yml id:discord_suggestion_data

# just checks if the file exists on storage
suggestion_data_exists:
  type: procedure
  debug: false
  script:
  - determine <server.has_file[data/discord_suggestion_data.yml]>
