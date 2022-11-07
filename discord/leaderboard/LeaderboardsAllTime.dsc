leaderboards_alltime_rewards_handler:
    type: world
    debug: false
    events:
        after system time minutely every:10:
        - inject leaderboard_alltime_task

leaderboard_alltime_task:
  type: task
  debug: false
  script:
    - define channel 1038681039280803871

    - definemap embed_map:
        title: Season I All Time Legends <&lt>a<&co>noodle<&co>1018046115767124018<&gt>
        color: yellow
    - define embed <discord_embed.with_map[<[embed_map]>]>

    # Top Hours Played
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_hours_played_1_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_played_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_hours_played_2_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_played_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_hours_played_3_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_played_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⌛ Top Hours Played].value[```<[message].replace_text[|].with[»]>```]>

    # Top Survivor
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_hours_since_death_1_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_hours_since_death_2_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_hours_since_death_3_alltime_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🏕️ Top Survivor].value[```<[message].replace_text[|].with[»]>```]>

    # Top Jumper
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_jump_1_alltime_name]> | <placeholder[ajlb_lb_statistic_jump_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_jump_2_alltime_name]> | <placeholder[ajlb_lb_statistic_jump_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_jump_3_alltime_name]> | <placeholder[ajlb_lb_statistic_jump_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🤾🏼‍♂️ Top Jumper].value[```<[message].replace_text[|].with[»]>```]>

    # Top Mob Killers
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_mob_kills_1_alltime_name]> | <placeholder[ajlb_lb_statistic_mob_kills_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_mob_kills_2_alltime_name]> | <placeholder[ajlb_lb_statistic_mob_kills_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_mob_kills_3_alltime_name]> | <placeholder[ajlb_lb_statistic_mob_kills_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[👹 Top Mob Killers].value[```<[message].replace_text[|].with[»]>```]>

    # Top Block Miners
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_mine_block_1_alltime_name]> | <placeholder[ajlb_lb_statistic_mine_block_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_mine_block_2_alltime_name]> | <placeholder[ajlb_lb_statistic_mine_block_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_mine_block_3_alltime_name]> | <placeholder[ajlb_lb_statistic_mine_block_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🧱 Top Block Miners].value[```<[message].replace_text[|].with[»]>```]>

    # Top Deaths
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_deaths_1_alltime_name]> | <placeholder[ajlb_lb_statistic_deaths_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_deaths_2_alltime_name]> | <placeholder[ajlb_lb_statistic_deaths_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_deaths_3_alltime_name]> | <placeholder[ajlb_lb_statistic_deaths_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[💀 Top Deaths].value[```<[message].replace_text[|].with[»]>```]>

    # Top Crafters
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_craft_item_1_alltime_name]> | <placeholder[ajlb_lb_statistic_craft_item_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_craft_item_2_alltime_name]> | <placeholder[ajlb_lb_statistic_craft_item_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_craft_item_3_alltime_name]> | <placeholder[ajlb_lb_statistic_craft_item_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🖼️ Top Crafters].value[```<[message].replace_text[|].with[»]>```]>

    # Top Breeders
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_animals_bred_1_alltime_name]> | <placeholder[ajlb_lb_statistic_animals_bred_1_alltime_value]>
        - <placeholder[ajlb_lb_statistic_animals_bred_2_alltime_name]> | <placeholder[ajlb_lb_statistic_animals_bred_2_alltime_value]>
        - <placeholder[ajlb_lb_statistic_animals_bred_3_alltime_name]> | <placeholder[ajlb_lb_statistic_animals_bred_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🌾 Top Breeders].value[```<[message].replace_text[|].with[»]>```]>

    # Top Voters
    - definemap format:
        format:
        - <placeholder[ajlb_lb_superbvote_votes_1_alltime_name]> | <placeholder[ajlb_lb_superbvote_votes_1_alltime_value]>
        - <placeholder[ajlb_lb_superbvote_votes_2_alltime_name]> | <placeholder[ajlb_lb_superbvote_votes_2_alltime_value]>
        - <placeholder[ajlb_lb_superbvote_votes_3_alltime_name]> | <placeholder[ajlb_lb_superbvote_votes_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[📮 Top Voters].value[```<[message].replace_text[|].with[»]>```]>

    # Top mcMMO Power
    - definemap format:
        format:
        - <placeholder[ajlb_lb_mcmmo_power_level_1_alltime_name]> | <placeholder[ajlb_lb_mcmmo_power_level_1_alltime_value]>
        - <placeholder[ajlb_lb_mcmmo_power_level_2_alltime_name]> | <placeholder[ajlb_lb_mcmmo_power_level_2_alltime_value]>
        - <placeholder[ajlb_lb_mcmmo_power_level_3_alltime_name]> | <placeholder[ajlb_lb_mcmmo_power_level_3_alltime_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⚔️ Top mcMMO Power].value[```<[message].replace_text[|].with[»]>```]>

    - define message_id 1038699448324337664
    #- ~discordmessage id:bot channel:<discord_channel[<[channel]>]> <[embed]>
    - ~discordmessage id:bot edit:<[message_id]> channel:<discord_channel[<[channel]>]> <[embed]>