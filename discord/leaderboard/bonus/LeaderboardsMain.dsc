#
#   flag structure for players
#
#   leaderboards:
#       <category>: <count>
#
#
#   flag struct for server
#
#   leaderboards:
#       reset_date: <date>
#       enabled_categories:
#       - <category>
#       - <category>
#       - <category>
#       rankings:
#           <category>:
#           - <#1> <player>: <value>
#           - <#2> <player>: <value>
#           - <#3> <player>: <value>
#       rankings_all:
#           <category>:
#           - <#1> <player>: <value>
#           - <#2> <player>: <value>
#           - <#3> <player>: <value>
#           - <#4> <player>: <value>
#           - ....
#

#
#   store rewards queue in server flag
#   run queue whenever player logs in
#
#   leaderboard_rewards_queue:
#       <player>:
#       - <command 1>
#       - <command 2>
#       - <command 3>
#

#
#   Resets the leaderboard
#
leaderboards_reset:
    type: task
    debug: false
    script:
    #   reset flags
    - define leaderboard_players <server.players_flagged[leaderboards]>
    - flag <[leaderboard_players]> leaderboards:!
    - flag server leaderboards:!

    #
    #   initiate a new leaderboard
    #
    - define leaderboard_data <script[leaderboards_data]>
    - define reset_duration <[leaderboard_data].data_key[reset_duration]>
    - define categories <[leaderboard_data].data_key[categories].keys>
    - define categories_count <[leaderboard_data].data_key[categories_count]>

    #   set the date for the next reset
    - flag server leaderboards.reset_date:<util.time_now.to_zone[+8].add[<[reset_duration]>]>
    #   set the randomized enabled categories
    - define enabled_categories <[categories].random[<[categories_count]>]>
    - flag server leaderboards.enabled_categories:<[enabled_categories]>

    #   sets the TBD leaderboard state on discord
    - define positions <[leaderboard_data].data_key[rewards].keys.size>
    - foreach <server.flag[leaderboards].get[enabled_categories]>:
        - flag server leaderboards.rankings.<[value]>:<element[TBD].repeat_as_list[<[positions].add[1]>]>
    - run leaderboards_discord_update

#
#   timely updating leaderboard values
#
leaderboards_server_events:
    type: world
    debug: false
    events:
        after system time minutely every:5:
        #
        #   scan players for leaderboard
        #   and update server rankings flag
        #   plus discord leaderboard msg
        #
        - define leaderboard_data <script[leaderboards_data]>
        - define positions <[leaderboard_data].data_key[rewards].keys.size>
        - define leaderboard_players <server.players_flagged[leaderboards].if_null[null]>
        #   dont update if there are no players recorded yet
        - if <[leaderboard_players].is_empty> || <[leaderboard_players]> == null:
            - stop
        #   add players to leaderboards.rankings.<category> server flag
        - define enabled_categories <server.flag[leaderboards.enabled_categories]>
        - foreach <[enabled_categories]>:
            - define category <[value]>
            - define player_rankings <[leaderboard_players].filter[has_flag[leaderboards.<[category]>]]>
            - if <[player_rankings].is_empty>:
                - foreach next
            - define player_rankings <[player_rankings].sort_by_number[flag[leaderboards.<[category]>]].reverse>
            #   format rankings into: #<rank> <name> » <score>
            - define parsed_player_rankings "<[player_rankings].parse_tag[#<[player_rankings].find[<[parse_value]>]> <[parse_value].name> » <[parse_value].flag[leaderboards.<[category]>]>]>"

            - flag server leaderboards.rankings_all.<[category]>:<[parsed_player_rankings]>
            - flag server leaderboards.rankings.<[category]>:<[parsed_player_rankings].get[1].to[<[positions]>]>

            - run leaderboards_discord_update
        - announce to_console "[Leaderboard] Updated with values: <&nl><server.flag[leaderboards].get[rankings].to_yaml>"

#
#   leaderboard rewards handler
#
leaderboards_rewards_handler:
    type: world
    debug: false
    events:
        after system time minutely:
        - define reset <server.flag[leaderboards].get[reset_date]>
        - if <util.time_now.to_zone[UTC-7].is_after[<[reset]>]>:
            - announce to_console "[Leaderboard] Reset ongoing values are <&nl><server.flag[leaderboards].get[rankings].to_yaml>"
            - announce "Leaderboards have reset, congratulations to those who are at the top, and keep it up for the next one!" format:default
            - announce "Re-join to claim your rewards" format:default
            - define leaderboard_data <script[leaderboards_data]>
            - define rewards <[leaderboard_data].data_key[rewards]>
            - define rankings <server.flag[leaderboards].get[rankings]>
            - foreach <[rankings]>:
                - if <[value].get[1]> == TBD:
                    - foreach next
                - foreach <[value]>:
                    - define player_data <[value].split>
                    - define rank <[player_data].get[1].after[#]>
                    - define player <server.match_offline_player[<[player_data].get[2]>]>
                    - define player_name <[player_data].get[2]>
                    - define reward_commands <[rewards].get[<[rank]>].parse[replace[{player}].with[<[player_name]>]]>
                    - flag server leaderboard_rewards_queue.<[player]>:|:<[reward_commands]>
            - run leaderboards_reset
        #   execute rewards queue when player joins
        after player joins:
        - define leaderboard_rewardees <server.flag[leaderboard_rewards_queue].if_null[null]>
        - if <[leaderboard_rewardees]> == null:
            - stop
        - if <[leaderboard_rewardees].keys.contains[<player>]>:
            - announce to_console "[leaderboard] Rewards for <player.name> successfully given!"
            - define rewards <[leaderboard_rewardees].get[<player>]>
            - foreach <[rewards]>:
                - execute as_server <[value]>
            - wait 1t
            - flag server leaderboard_rewards_queue.<player>:!

#
#   update discord leaderboard message
#
leaderboards_discord_update:
    type: task
    debug: false
    script:
    - define leaderboard_data <script[leaderboards_data]>
    - define title <[leaderboard_data].data_key[title]>
    - define description <[leaderboard_data].data_key[description]>
    - define channel <[leaderboard_data].data_key[discord_channel_id]>
    - define message_id <[leaderboard_data].data_key[discord_message_id]>

    #   discord embed format for the leaderboard
    - define reset <server.flag[leaderboards].get[reset_date]>
    - definemap embedded_message:
        title: <[title]>
        description: <[description]>
        thumbnail: https://i.imgur.com/G69IfQe.png
        color: yellow
        timestamp: <[reset]>
        footer: Resets within <[reset].from_now.formatted>
        footer_icon: https://i.imgur.com/G69IfQe.png
    - define embed <discord_embed.with_map[<[embedded_message]>]>

    # Rewards
    - definemap rewards:
        rewards:
        -   🥇 **Top 1**
        - > 1x Boketto Key
        - 
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[Rewards].value[<[message]>]>

    - definemap rewards:
        rewards:
        -   🥈 **Top 2**
        - > 1x Serendipity Key
        - 
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[].value[<[message]>]>

    - definemap rewards:
        rewards:
        -   🥉 **Top 3**
        - > $150,000
        - 
    - define message <[rewards].get[rewards].separated_by[<&nl>]>
    - define embed <[embed].add_inline_field[].value[<[message]>]>

    #   adding the categories and its values as fields
    - define rankings <server.flag[leaderboards].get[rankings]>
    - foreach <[rankings]>:
        - define category_title <[leaderboard_data].data_key[categories].get[<[key]>]>
        - define embed <[embed].add_field[<[category_title]>].value[```<[value].separated_by[<&nl>]>```]>
    #- ~discord id:bot edit_message channel:<[channel]> message_id:<[message_id]> <[message]>
    - ~discordmessage id:bot edit:<[message_id]> channel:<[channel]> <[embed]>
    #- ~discordmessage id:bot channel:<[channel]> <[message]>