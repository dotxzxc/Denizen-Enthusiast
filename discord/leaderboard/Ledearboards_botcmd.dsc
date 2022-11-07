create_leaderboard_cmd:
  type: task
  script:
    - definemap options:
        1:
          type: string
          name: player
          description: Who you want to check?
          required: true
        2:
          type: string
          name: type
          description: Time types: alltime|hourly|daily|weekly|monthly|yearly
          required: true

    - ~discordcommand id:bot create name:leaderboard "description:Show player's leaderboard." group:950815231075024898 options:<[options]>

leaderboard_cmd_handler:
  type: world
  debug: false
  events:
    on discord slash command name:leaderboard:
    - ~discordinteraction defer interaction:<context.interaction>
    - define player <server.match_offline_player[<context.options.deep_get[player]>].if_null[null]>
    - define type <context.options.deep_get[type]>

    - if <[type].contains_any_text[alltime|hourly|daily|weekly|monthly|yearly].not>:
        - ~discordinteraction reply interaction:<context.interaction> "Invalid time type. Options<&co> `alltime|hourly|daily|weekly|monthly|yearly`"
        - stop


    - if <[player]> == null:
      - definemap embed_map:
          description: I couldn't find that player in the server. :c
          color: 201,79,79
          footer: Noodle Realms Survival
          footer_icon: https://i.imgur.com/G69IfQe.png
      - define embed <discord_embed.with_map[<[embed_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[embed]>

    - define channel <context.channel>

    - definemap embed_map:
        title: 🏆 <[player].name>'s <[type].to_sentence_case> Record
        color: yellow
        thumbnail: https://mc-heads.net/avatar/<[player].name>.png
    - define embed <discord_embed.with_map[<[embed_map]>]>

    # Hours Played
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_hours_played_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_hours_played_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⌛ Hours Played].value[```<[message].replace_text[|].with[»]>```]>

    # Survivor
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_hours_since_death_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_hours_since_death_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🏕️ Survivor].value[```<[message].replace_text[|].with[»]>```]>

    # Jumper
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_jump_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_jump_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🤾🏼‍♂️ Jumper].value[```<[message].replace_text[|].with[»]>```]>

    # Mob Killers
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_mob_kills_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_mob_kills_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[👹 Mob Killers].value[```<[message].replace_text[|].with[»]>```]>

    # Block Miners
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_mine_block_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_mine_block_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🧱 Block Miners].value[```<[message].replace_text[|].with[»]>```]>

    # Deaths
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_deaths_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_deaths_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[💀 Deaths].value[```<[message].replace_text[|].with[»]>```]>

    # Crafters
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_craft_item_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_craft_item_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🖼️ Crafters].value[```<[message].replace_text[|].with[»]>```]>

    # Breeders
    - definemap format:
        format:
        - #<placeholder[ajlb_position_statistic_animals_bred_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_statistic_animals_bred_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🌾 Breeders].value[```<[message].replace_text[|].with[»]>```]>

    # Voters
    - definemap format:
        format:
        - #<placeholder[ajlb_position_superbvote_votes_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_superbvote_votes_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[📮 Voters].value[```<[message].replace_text[|].with[»]>```]>

    # mcMMO Power
    - definemap format:
        format:
        - #<placeholder[ajlb_position_mcmmo_power_level_<[type]>].player[<[player]>]> | <placeholder[ajlb_value_mcmmo_power_level_<[type]>].player[<[player]>]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⚔️ mcMMO Power].value[```<[message].replace_text[|].with[»]>```]>

    - ~discordinteraction reply interaction:<context.interaction> <[embed]>