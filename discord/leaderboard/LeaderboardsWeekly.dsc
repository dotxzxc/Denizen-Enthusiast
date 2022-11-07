leaderboards_weekly_data:
    type: data
    rewards:
        1:
        #- eco give PLAYER 1
        - eco give PLAYER 150000
        - mr add PLAYER 50
        2:
        #- eco give PLAYER 2
        - eco give PLAYER 100000
        - mr add PLAYER 30
        3:
        #- eco give PLAYER 3
        - eco give PLAYER 50000
        - mr add PLAYER 20
    board:
    - statistic_hours_played
    - statistic_hours_since_death
    - statistic_jump
    - statistic_mob_kills
    - statistic_mine_block
    - statistic_deaths
    - statistic_craft_item
    - statistic_animals_bred
    - superbvote_votes
    - mcmmo_power_level

leaderboards_weekly_rewards_handler:
    type: world
    debug: false
    events:
        after system time minutely:
        - define day <util.time_now.day_of_week_name>
        - define hour <util.time_now.hour>
        - define minute <util.time_now.minute>
        - if <[day]> == SATURDAY && <[hour]> == 23 && <[minute]> == 55:
            - define data <script[leaderboards_weekly_data]>
            - define rewardstop1 <[data].data_key[rewards].get[1]>
            - define rewardstop2 <[data].data_key[rewards].get[2]>
            - define rewardstop3 <[data].data_key[rewards].get[3]>

            - foreach <[data].data_key[board]>:
                - define top1 <placeholder[ajlb_lb_<[value]>_1_weekly_name]>
                - foreach <[rewardstop1]> as:reward:
                    - wait 1t
                    - define command <[reward].replace_text[PLAYER].with[<[top1]>]>
                    - execute as_server <[command]>
                    - announce to_console "[Weekly Leaderboard] <[top1]> <&co> <[command]>"

                - define top2 <placeholder[ajlb_lb_<[value]>_2_weekly_name]>
                - foreach <[rewardstop2]> as:reward:
                    - wait 1t
                    - define command <[reward].replace_text[PLAYER].with[<[top2]>]>
                    - execute as_server <[command]>
                    - announce to_console "[Weekly Leaderboard] <[top2]> <&co> <[command]>"

                - define top3 <placeholder[ajlb_lb_<[value]>_3_weekly_name]>
                - foreach <[rewardstop3]> as:reward:
                    - wait 1t
                    - define command <[reward].replace_text[PLAYER].with[<[top3]>]>
                    - execute as_server <[command]>
                    - announce to_console "[Weekly Leaderboard] <[top3]> <&co> <[command]>"

            - flag server leaderboard_weekly:!
            - wait 10m system
            - inject leaderboard_weekly_task

        after system time minutely every:3:
        - inject leaderboard_weekly_task

leaderboard_weekly_task:
  type: task
  debug: false
  script:
    - define channel 1038181374236033084

    - definemap embed_map:
        title: 🏆 Weekly Legends
        color: yellow
        description: Rewards will be given to the top players automatically every week.
    - define embed <discord_embed.with_map[<[embed_map]>]>

    # Rewards
    - definemap rewards:
        rewards:
        -   🥇 **Top 1**
        - > $150,000
        - > 50 Credits
        - 
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[Rewards].value[<[message]>]>

    - definemap rewards:
        rewards:
        -   🥈 **Top 2**
        - > $100,000
        - > 30 Credits
        - 
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[].value[<[message]>]>

    - definemap rewards:
        rewards:
        -   🥉 **Top 3**
        - > $50,000
        - > 20 Credits
        - <&nl>
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[].value[<[message]>]>

    # Top Hours Played
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_hours_played_1_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_played_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_hours_played_2_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_played_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_hours_played_3_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_played_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⌛ Top Hours Played].value[```<[message].replace_text[|].with[»]>```]>

    # Top Survivor
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_hours_since_death_1_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_hours_since_death_2_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_hours_since_death_3_weekly_name]> | <placeholder[ajlb_lb_statistic_hours_since_death_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🏕️ Top Survivor].value[```<[message].replace_text[|].with[»]>```]>

    # Top Jumper
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_jump_1_weekly_name]> | <placeholder[ajlb_lb_statistic_jump_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_jump_2_weekly_name]> | <placeholder[ajlb_lb_statistic_jump_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_jump_3_weekly_name]> | <placeholder[ajlb_lb_statistic_jump_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🤾🏼‍♂️ Top Jumper].value[```<[message].replace_text[|].with[»]>```]>

    # Top Mob Killers
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_mob_kills_1_weekly_name]> | <placeholder[ajlb_lb_statistic_mob_kills_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_mob_kills_2_weekly_name]> | <placeholder[ajlb_lb_statistic_mob_kills_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_mob_kills_3_weekly_name]> | <placeholder[ajlb_lb_statistic_mob_kills_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[👹 Top Mob Killers].value[```<[message].replace_text[|].with[»]>```]>

    # Top Block Miners
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_mine_block_1_weekly_name]> | <placeholder[ajlb_lb_statistic_mine_block_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_mine_block_2_weekly_name]> | <placeholder[ajlb_lb_statistic_mine_block_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_mine_block_3_weekly_name]> | <placeholder[ajlb_lb_statistic_mine_block_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🧱 Top Block Miners].value[```<[message].replace_text[|].with[»]>```]>

    # Top Deaths
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_deaths_1_weekly_name]> | <placeholder[ajlb_lb_statistic_deaths_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_deaths_2_weekly_name]> | <placeholder[ajlb_lb_statistic_deaths_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_deaths_3_weekly_name]> | <placeholder[ajlb_lb_statistic_deaths_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[💀 Top Deaths].value[```<[message].replace_text[|].with[»]>```]>

    # Top Crafters
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_craft_item_1_weekly_name]> | <placeholder[ajlb_lb_statistic_craft_item_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_craft_item_2_weekly_name]> | <placeholder[ajlb_lb_statistic_craft_item_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_craft_item_3_weekly_name]> | <placeholder[ajlb_lb_statistic_craft_item_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🖼️ Top Crafters].value[```<[message].replace_text[|].with[»]>```]>

    # Top Breeders
    - definemap format:
        format:
        - <placeholder[ajlb_lb_statistic_animals_bred_1_weekly_name]> | <placeholder[ajlb_lb_statistic_animals_bred_1_weekly_value]>
        - <placeholder[ajlb_lb_statistic_animals_bred_2_weekly_name]> | <placeholder[ajlb_lb_statistic_animals_bred_2_weekly_value]>
        - <placeholder[ajlb_lb_statistic_animals_bred_3_weekly_name]> | <placeholder[ajlb_lb_statistic_animals_bred_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[🌾 Top Breeders].value[```<[message].replace_text[|].with[»]>```]>

    # Top Voters
    - definemap format:
        format:
        - <placeholder[ajlb_lb_superbvote_votes_1_weekly_name]> | <placeholder[ajlb_lb_superbvote_votes_1_weekly_value]>
        - <placeholder[ajlb_lb_superbvote_votes_2_weekly_name]> | <placeholder[ajlb_lb_superbvote_votes_2_weekly_value]>
        - <placeholder[ajlb_lb_superbvote_votes_3_weekly_name]> | <placeholder[ajlb_lb_superbvote_votes_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[📮 Top Voters].value[```<[message].replace_text[|].with[»]>```]>

    # Top mcMMO Power
    - definemap format:
        format:
        - <placeholder[ajlb_lb_mcmmo_power_level_1_weekly_name]> | <placeholder[ajlb_lb_mcmmo_power_level_1_weekly_value]>
        - <placeholder[ajlb_lb_mcmmo_power_level_2_weekly_name]> | <placeholder[ajlb_lb_mcmmo_power_level_2_weekly_value]>
        - <placeholder[ajlb_lb_mcmmo_power_level_3_weekly_name]> | <placeholder[ajlb_lb_mcmmo_power_level_3_weekly_value]>
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[⚔️ Top mcMMO Power].value[```<[message].replace_text[|].with[»]>```]>

    - define day <util.time_now.day_of_week_name>
    - if <[day]> == SUNDAY:
        - if <server.has_flag[leaderboard_weekly].not>:
            - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> <[embed]> save:sent
            - flag server leaderboard_weekly.message_id:<entry[sent].message.id>
            - stop

    - if <server.has_flag[leaderboard_weekly.message_id]>:
        - define message_id <server.flag[leaderboard_weekly.message_id]>
        - ~discordmessage id:bot edit:<[message_id]> channel:<discord_channel[<[channel]>]> <[embed]>