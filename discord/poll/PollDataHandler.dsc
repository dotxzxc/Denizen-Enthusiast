# yaml id discord_poll_data
poll_load_data:
  type: world
  debug: false
  events:
    # loads/creates the yaml data file on server start
    after server start:
    - if <proc[poll_data_exists].not>:
      - announce to_console "[Discord Poll] Discord poll data does not exist, making one..."
      - run poll_data_create
      - stop
    - announce to_console "[Discord Poll] Discord poll data found, loading it..."
    - ~yaml load:data/discord_poll_data.yml id:discord_poll_data

    on delta time minutely:
    - if <yaml[discord_poll_data].has_changes>:
      - ~yaml savefile:data/discord_poll_data.yml id:discord_poll_data

# script for creating the yaml data file
poll_data_create:
  type: task
  debug: false
  script:
  - yaml create id:discord_poll_data
  - ~yaml savefile:data/discord_poll_data.yml id:discord_poll_data

# just checks if the file exists on storage
poll_data_exists:
  type: procedure
  debug: false
  script:
  - determine <server.has_file[data/discord_poll_data.yml]>
