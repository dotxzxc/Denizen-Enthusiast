donations_message:
    type: world
    debug: false
    events:
        after discord message received channel:1019921442994925628:
        - define player <context.new_message.text.split_args.get[1]>
        - define package <context.new_message.text.split_args.get[2]>
        - definemap embed_map:
            color: yellow
            author_name: Thank you <[player]> for supporting Noodle Realms! ❤️
            author_icon_url: https://mc-heads.net/avatar/<[player]>.png
        - define embed <discord_embed.with_map[<[embed_map]>]>
        - ~discordmessage id:noodle channel:952253343835750444 <[embed]>