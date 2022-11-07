noodle_bot_connect:
  type: task
  debug: false
  script:
  - ~discordconnect id:noodle tokenfile:data/noodle_bot_token.txt
  - run noodle_bot_status_set


noodle_bot_status_set:
  type: task
  debug: false
  script:
  - ~discord id:noodle status "noodlerealms.com" status:ONLINE activity:PLAYING

noodle_bot_main_events:
  type: world
  debug: false
  events:
    after server start:
    - run noodle_bot_connect

noodle_bot_welcome_message:
  type: world
  debug: false
  events:
    on discord user joins group:950815231075024898:
    - define channel <discord_channel[noodle,950815232119435327]>
    - definemap message_map:
        color: yellow
        title: Welcome <context.user.name>!
        description: <context.user.mention> verify your account to access other channels, instructions at <&lt>#952235345825640498<&gt>
        thumbnail: https://i.imgur.com/G69IfQe.png
    - define message <discord_embed.with_map[<[message_map]>]>
    - ~discordmessage id:noodle channel:<[channel]> <[message]>