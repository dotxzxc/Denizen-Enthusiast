create_profile_cmd:
  type: task
  script:
    - definemap options:
        1:
          type: string
          name: player
          description: Who you want to check?
          required: true

    - ~discordcommand id:bot create name:profile "description:Show player's profile." group:950815231075024898 options:<[options]>

profile_cmd_handler:
  type: world
  debug: false
  events:
    on discord slash command name:profile:
    - define player <server.match_player[<context.options.deep_get[player]>].if_null[null]>

    - ~discordinteraction defer interaction:<context.interaction>

    # check if player is online
    - if <[player].is_online>:
      # send player profile
      - definemap profile_embed:
          color: yellow
          thumbnail: https://mc-heads.net/avatar/<[player].name>.png
          title: <[player].name>'s Profile
          footer: Noodle Realms Survival
          footer_icon: https://i.imgur.com/G69IfQe.png
      - define profile_embed_message <discord_embed.with_map[<[profile_embed]>]>
      - define profile_embed_message "<[profile_embed_message].add_inline_field[].value[⚔️ Rank<&co> `<placeholder[luckperms_primary_group_name].player[<[player]>].to_uppercase>`  <&nl>💰 Money<&co> `$<[player].money.round_to[4].format_number>` <&nl>☠️Deaths<&co> `<placeholder[statistic_deaths].player[<[player]>]>` <&nl>⏲ Playtime<&co> `<placeholder[statistic_hours_played].player[<[player]>].format_number> hours`]>"
      # <&nl>☠️Deaths<&co> `<placeholder[statistic_deaths].player[<[player]>]>`
      - define profile_embed_message "<[profile_embed_message].add_inline_field[].value[✨ XP Level<&co> `<[player].xp_level.format_number>` <&nl>💤 Afk<&co> `<[player].is_afk.to_sentence_case>` <&nl>📅 Date joined<&co> `<[player].first_played_time.format[MMM dd, yyyy]>` <&nl>📅 Last played<&co> `<[player].last_played_time.format[MMM dd, yyyy]>`]>"
      #- define profile_embed_message <[profile_embed_message].add_field[].value[]>
      #- define profile_embed_message "<[profile_embed_message].add_field[<&nl>🏝️ Island Information].value[<&nl>🏆 Rank<&co> `<placeholder[Level_bskyblock_rank_value].player[<[player]>]>` <&nl> 📛 Name<&co> `<placeholder[bskyblock_island_name].player[<[player]>]>` <&nl>🆙 Level<&co> `<placeholder[Level_bskyblock_island_level].player[<[player]>]>` <&nl>💸 Bank<&co> `<placeholder[Bank_bskyblock_island_balance].player[<[player]>]>`]>"
      - ~discordinteraction reply interaction:<context.interaction> <[profile_embed_message]>
      - wait 1t
      # send player basic stats
      - definemap basic_stats:
          color: yellow
          title: <[player].name>'s Basic stats
          thumbnail: https://mc-heads.net/avatar/<[player].name>.png
          footer: Noodle Realms Survival
          footer_icon: https://i.imgur.com/G69IfQe.png
      - define basic_stats_message <discord_embed.with_map[<[basic_stats]>]>
      - define basic_stats_message "<[basic_stats_message].add_inline_field[].value[🐮 Animals Bred<&co> `<placeholder[statistic_animals_bred].player[<[player]>].format_number>` <&nl>🐟 Fish Caught<&co> `<placeholder[statistic_fish_caught].player[<[player]>].format_number>` <&nl>🏹 Item Enchanted<&co> `<placeholder[statistic_item_enchanted].player[<[player]>].format_number>` <&nl>🐲 Ender Dragon Kills<&co> `<placeholder[statistic_kill_entity:ender_dragon].player[<[player]>].format_number>` <&nl>👹 Wither Kills<&co> `<placeholder[statistic_kill_entity:wither].player[<[player]>].format_number>`]>"
      - define basic_stats_message "<[basic_stats_message].add_inline_field[].value[🧱 Blocks Mined<&co> `<placeholder[statistic_mine_block].player[<[player]>].format_number>` <&nl>⚔️ Mob Kills<&co> `<placeholder[statistic_mob_kills].player[<[player]>].format_number>` <&nl>🐾 Distance Walked<&co> `<placeholder[statistic_walk_one_cm].player[<[player]>].replace_text[,].with[].div[100000].round_up.format_number.if_null[N/A]> km`<&nl>📮 Votes<&co>  `<placeholder[superbvote_votes].player[<[player]>].format_number.if_null[0]>` <&nl>👑 Titles<&co>  `<placeholder[deluxetags_amount].player[<[player]>]>`]>"
      #`<placeholder[superbvote_votes].player[<[player]>].format_number>`]>"
      - ~discordinteraction reply interaction:<context.interaction> <[basic_stats_message]>
      - wait 1t
      # send player mcmmo stats
      - definemap mcmmo_embed:
          color: yellow
          title: <[player].name>'s mcMMO stats
          thumbnail: https://mc-heads.net/avatar/<[player].name>.png
          footer: Noodle Realms Survival
          footer_icon: https://i.imgur.com/G69IfQe.png
      - define mcmmo_embed_message <discord_embed.with_map[<[mcmmo_embed]>]>
      - define mcmmo_embed_message "<[mcmmo_embed_message].add_inline_field[🌾 Gathering Skills].value[<&gt> Excavation<&co> `<[player].mcmmo.level[excavation].format_number>`<&nl><&gt> Fishing<&co> `<[player].mcmmo.level[fishing].format_number>`<&nl><&gt> Herbalism<&co> `<[player].mcmmo.level[herbalism].format_number>`<&nl><&gt> Mining<&co> `<[player].mcmmo.level[mining].format_number>`<&nl><&gt> Woodcutting<&co> `<[player].mcmmo.level[woodcutting].format_number>`]>"
      - define mcmmo_embed_message "<[mcmmo_embed_message].add_inline_field[⚔️ Combat Skills].value[<&gt> Axes<&co> `<[player].mcmmo.level[axes].format_number>`<&nl><&gt> Swords<&co> `<[player].mcmmo.level[swords].format_number>`<&nl><&gt> Taming<&co> `<[player].mcmmo.level[taming].format_number>`<&nl><&gt> Unarmed<&co> `<[player].mcmmo.level[unarmed].format_number>`<&nl>]>"
      - define mcmmo_embed_message "<[mcmmo_embed_message].add_inline_field[💎 Misc Skills].value[<&gt> Acrobatics<&co> `<[player].mcmmo.level[acrobatics].format_number>`<&nl><&gt> Alchemy<&co> `<[player].mcmmo.level[alchemy].format_number>`<&nl><&gt> Repair<&co> `<[player].mcmmo.level[repair].format_number>`<&nl><&gt> Salvage<&co> `<[player].mcmmo.level[salvage].format_number>`<&nl><&gt> Smelting<&co> `<[player].mcmmo.level[smelting].format_number>`]>"
      - ~discordinteraction reply interaction:<context.interaction> <[mcmmo_embed_message]>
    - else:
      - definemap embed_map:
          description: That player is offline. :<
          color: 201,79,79
          footer: Noodle Realms Survival
          footer_icon: https://i.imgur.com/G69IfQe.png
      - define embed <discord_embed.with_map[<[embed_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[embed]>