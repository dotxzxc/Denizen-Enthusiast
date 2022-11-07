discord_console:
    type: world
    debug: false
    events:
        after discord message received channel:990786676253138984:
        - define group <discord_group[bot,950815231075024898]>
        - define gamemode <context.new_message.mentioned_users.get[1].id>
        - define command <context.new_message.text.substring[23]>
        - define bot 1018030328440426537

        - if <[gamemode]> == <[bot]>:
            - execute as_server "<[command]>"
            - definemap message_map:
                color: red
                description: Executing `/<[command]>`
            - define message <discord_embed.with_map[<[message_map]>]>
            - ~discordmessage id:bot channel:<context.channel> <[message]>