create_check_cmd:
  type: task
  script:
    - definemap options:
        1:
          type: string
          name: player
          description: Player
          required: true

    - ~discordcommand id:bot create name:check "description:Check last player online activity." group:950815231075024898 options:<[options]>

check_cmd_events:
  type: world
  debug: false
  events:
  # Handler for /ban command
    on discord slash command name:check:
    - define player <server.match_offline_player[<context.options.deep_get[player]>].if_null[null]>
    - define by <context.interaction.user.name>

    - ~discordinteraction defer interaction:<context.interaction>

    - if <[player]> == null:
      - definemap embed_map:
          color: <color[201,79,79]>
          description: I couldn't find the player you're looking for in our database.

      - define embed <discord_embed.with_map[<[embed_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[embed]>
      - stop

    - if <[player].is_online>:
      - definemap embed_map:
          footer_icon: https://mc-heads.net/avatar/<[player].name>.png
          footer: Noodle Realms Survival
          color: <color[201,79,79]>
          description: Player `<[player].name>` is online!
    - else:
      - definemap embed_map:
          footer_icon: https://mc-heads.net/avatar/<[player].name>.png
          footer: Noodle Realms Survival
          color: <color[201,79,79]>
          description: Player `<[player].name>` has been offline for `<util.time_now.duration_since[<[player].last_played_time>].formatted>`

    - define embed <discord_embed.with_map[<[embed_map]>]>
    - ~discordinteraction reply interaction:<context.interaction> <[embed]>