bot_connect:
  type: task
  debug: false
  script:
  - ~discordconnect id:bot tokenfile:data/bot_token.txt
  - run bot_status_set


sp_admin_disconnect:
  type: task
  debug: false
  script:
  - discord id:bot disconnect


bot_status_set:
  type: task
  debug: false
  script:
  - ~discord id:bot status "<server.online_players.size> online" status:ONLINE activity:WATCHING

bot_main_events:
  type: world
  debug: false
  events:
    after server start:
    - run bot_connect
    after delta time minutely:
    - run bot_status_set