create_help_cmd:
  type: task
  script:
    - ~discordcommand id:noodle create group:950815231075024898 name:help "description:Display bot commands."

discord_bot_commands_data:
    type: data
    prefix: !
    help:
        categories:
            commands:
                title: 🤖 Commands
                commands:
                - `/suggest <suggestion>` - make a suggestion
                - `/profile <player>` - show a player's information and stats
                - `/check <player>` - show last player's online activity
                - `/vote` - display vote links
                - `/store` - display store link
                - `/ip` - server's ip address
                - `/leaderboard` - check a player's leaderboard information
                - `/creator` - information how to join creator program

discord_bot_commands_event_handler:
    type: world
    debug: false
    events:
        on discord slash command name:help:
        - ~discordinteraction defer interaction:<context.interaction>
        - define commands_data <script[discord_bot_commands_data]>

        - definemap help_map:
            title: Noodle Commands
            thumbnail: https://i.imgur.com/G69IfQe.png
            color: yellow
        - define help_embed <discord_embed.with_map[<[help_map]>]>
        - define help_data <[commands_data].data_key[help]>
        - foreach <[help_data].get[categories]>:
            - define category_title <[value].get[title]>
            - define commands "<&gt> <[value].get[commands].separated_by[<&nl><&gt><&sp>]>"
            - define help_embed <[help_embed].add_field[<[category_title]>].value[<[commands]>]>
        - ~discordinteraction reply interaction:<context.interaction> <[help_embed]>