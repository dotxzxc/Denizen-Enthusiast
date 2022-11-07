discord_changelog:
    type: world
    debug: false
    events:
        after discord message received channel:1018063541556760587 for:noodle:
        - define description <context.new_message.text>
        - define author <context.new_message.author.name>
        - define footer_icon <context.new_message.author.avatar_url>
        - define version <server.flag[update_version]>
        - definemap embed_map:
            author_name: Noodle Realms v<[version]>
            author_icon_url: https://i.imgur.com/G69IfQe.png
            color: yellow
            description: "```<[description]>```"
            footer: Changes made by <[author]>
            footer_icon: <[footer_icon]>
        - define embed <discord_embed.with_map[<[embed_map]>]>
        - ~discordmessage id:noodle channel:1018063585332699136 <[embed]>
        - flag server update_version:++