# yaml id discord_verification_data
verification_load_data:
  type: world
  debug: false
  events:
    # loads/creates the yaml data file on server start
    after server start:
    - if <proc[verification_data_exists].not>:
      - announce to_console "[Discord verificatior] Discord verification data does not exist, making one..."
      - run verification_data_create
      - stop
    - announce to_console "[Discord verificatior] Discord verification data found, loading it..."
    - ~yaml load:data/discord_verification_data.yml id:discord_verification_data

    on delta time minutely:
    - if <yaml[discord_verification_data].has_changes>:
      - ~yaml savefile:data/discord_verification_data.yml id:discord_verification_data

# script for creating the yaml data file
verification_data_create:
  type: task
  debug: false
  script:
  - yaml create id:discord_verification_data
  - ~yaml savefile:data/discord_verification_data.yml id:discord_verification_data

# just checks if the file exists on storage
verification_data_exists:
  type: procedure
  debug: false
  script:
  - determine <server.has_file[data/discord_verification_data.yml]>
