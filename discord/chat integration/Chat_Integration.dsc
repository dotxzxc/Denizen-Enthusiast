game_chat_config:
  type: data
  config:
    channel-id: 952225935116103760
    webhook-url: https://discord.com/api/webhooks/952236626782859345/EEttu1eDAaYG8uaObKFde6cuEbqlmyx8e5l2U0-ASgiMOX6Eg0djE7hOUxCBCdaVuYGM
    minecraft:
      death-format: 💀 <[message]>
      join-format: ➕ <[name]> has joined
      leave-format: ➖ <[name]> has left
      #chat-format: 🗨️ ️[<[rank]>] <[name]><&co> <[message]>
      chat-format: 🗨️ » <[message]>
      transfer-format: <[name]> ➡️ <[server]>
      advancement-format: "🏆 <[message]>"
      die-format: "💀 <[message]>"
      rankup-format: "🔺 <[message]>"
    discord:
      message-limit: 300
      chat-format: <&8>[<&b>Discord<&8>] <&7><[name]> <&8>» <&f><[message]>

game_chat:
  type: world
  debug: false
  events:
    # chats from minecraft
    after player chats priority:10:
    - define config_data <script[game_chat_config].data_key[config]>
    - define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    - define name <player.name>
    - define rank <placeholder[luckperms_primary_group_name].player[<player>].to_uppercase>
    - if <[rank]> == <element[Default]>:
      - define rank Noodle
    - define message <context.message.replace_text[`]>
    - run webhook_send def.message:```<[config_data].get[minecraft].get[chat-format].parsed>``` def.url:<[config_data].get[webhook-url].parsed> def.rank:<[rank]> def.avatar:https://mc-heads.net/avatar/<player.name>.png def.username:<[name]>

    # chats from discord
    after discord message received channel:952225935116103760:
    - define config_data <script[game_chat_config].data_key[config]>
    - define channel_id <[config_data].get[channel-id]>
    - define message <context.new_message>
    - define author <[message].author>
    - if <[author].is_bot.not>:
      - define name <context.new_message.author.nickname[<discord_group[bot,950815231075024898]>].substring[2]||<context.new_message.author.name>>
      - define message <context.new_message.text>
      - define message_limit <[config_data].get[discord].get[message-limit]>
      - if <[message].length> > <[message_limit]>:
        - ~discordmessage id:bot reply:<context.new_message> "Your message was not sent because your message contains <[message_limit]>+ characters"
        - stop
      - announce <[config_data].get[discord].get[chat-format].parsed>
      - announce to_console <[config_data].get[discord].get[chat-format].parsed>

    # joins and leaves
    on player joins:
    - define config_data <script[game_chat_config].data_key[config]>
    - define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    - define name <player.name>
    - define rank <placeholder[luckperms_primary_group_name].player[<player>].to_uppercase>
    - if <[rank]> == <element[Default]>:
      - define rank Noodle
    - run webhook_send def.message:```<[config_data].get[minecraft].get[join-format].parsed>``` def.url:<[config_data].get[webhook-url].parsed> def.rank:<[rank]> def.avatar:https://mc-heads.net/avatar/<player.name>.png def.username:<player.name>

    on player quits:
    - define config_data <script[game_chat_config].data_key[config]>
    - define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    - define name <player.name>
    - define rank <placeholder[luckperms_primary_group_name].player[<player>].to_uppercase>
    - if <[rank]> == <element[Default]>:
      - define rank Noodle
    - run webhook_send def.message:```<[config_data].get[minecraft].get[leave-format].parsed>``` def.url:<[config_data].get[webhook-url].parsed> def.rank:<[rank]> def.avatar:https://mc-heads.net/avatar/<player.name>.png def.username:<player.name>

    after server start:
    - define config_data <script[game_chat_config].data_key[config]>
    - define url <[config_data].get[webhook-url].parsed>
    - define message "```Noodle Realms Survival has been started. 🙂```"
    - definemap data:
        username: "Noodle Realms Survival"
        avatar_url: https://i.imgur.com/G69IfQe.png
        content: <[message]>
    - ~webget <[url]> headers:<map.with[Content-Type].as[application/json]> data:<[data].to_json>

    on shutdown:
    - define config_data <script[game_chat_config].data_key[config]>
    - define url <[config_data].get[webhook-url].parsed>
    - define message "```Noodle Realms Survival has been shutdown. 🥺```"
    - definemap data:
        username: "Noodle Realms Survival"
        avatar_url: https://i.imgur.com/G69IfQe.png
        content: <[message]>
    - ~webget <[url]> headers:<map.with[Content-Type].as[application/json]> data:<[data].to_json>

    #after player completes advancement:
    #- define config_data <script[game_chat_config].data_key[config]>
    #- define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    #- define message "<player.name> has made the advancement <context.advancement.after_last[/].replace_text[_].with[ ].to_titlecase>!"
    #- ~discordmessage id:bot channel:952225935116103760 "```🏆 <[message]>```"

    on player dies:
    - define config_data <script[game_chat_config].data_key[config]>
    - define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    - define name <player.name>
    - define rank <placeholder[luckperms_primary_group_name].player[<player>].to_uppercase>
    - if <[rank]> == <element[Default]>:
      - define rank Noodle
    - define message "<context.message.strip_color>"
    - run webhook_send def.message:```<[config_data].get[minecraft].get[die-format].parsed>``` def.url:<[config_data].get[webhook-url].parsed> def.rank:<[rank]> def.avatar:https://mc-heads.net/avatar/<player.name>.png def.username:<[name]>
