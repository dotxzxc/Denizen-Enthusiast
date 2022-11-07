chat_mention_world:
    type: world
    debug: false
    events:
        after player chats:
        - if <context.message.contains_any[<server.online_players.parse[name]>]>:
            - wait 1t
            - foreach <server.online_players> as:player:
                - if <context.message.contains[<[player].name>]>:
                    - narrate targets:<[player]> "<&e><player.name> <&7>mentioned you!" format:default
                    - playsound <[player]> sound:block_note_block_bell
                    - toast icon:nether_star targets:<[player]> "<&e><player.name> <&7>mentioned you!" frame:goal