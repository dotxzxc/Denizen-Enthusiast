leaderboards_checker:
    type: world
    debug: false
    events:
        after discord message received channel:991558342969405521:
        - define category_contents <context.new_message>
        - define message_text <[category_contents].text>
        - define leaderboards_cmd "!leaderboards"
        - if <[message_text].starts_with[<[leaderboards_cmd]>]>:
            - define player <[message_text].replace[<[leaderboards_cmd]>].trim>
            - define player <server.match_offline_player[<[player]>].if_null[null]>
            - if <[player]> != null:
                - define enabled_categories <server.flag[leaderboards].get[enabled_categories]>
                - define player_rankings <server.flag[leaderboards].get[rankings_all]>

                - define player_name <[player].name>
                - define reset <server.flag[leaderboards].get[reset_date]>
                - definemap leaderboards_map:
                    color: red
                    thumbnail: https://mc-heads.net/avatar/<[player_name]>.png
                    title: <[player_name]>
                    description: Leaderboards Ranking for player named **<[player_name]>**
                    footer: Resets within <[reset].from_now.formatted>
                    timestamp: <[reset]>
                    footer_icon: https://i.imgur.com/wlLH9B0.png
                - define leaderboards_embed <discord_embed.with_map[<[leaderboards_map]>]>

                - define categories_data <script[leaderboards_data].data_key[categories]>
                - foreach <[enabled_categories]> as:category:
                    - define category_title <[categories_data].get[<[category]>]>
                    - define player_rankings <server.flag[leaderboards].get[rankings_all].get[<[category]>].if_null[null]>
                    - define category_contents "TBD"
                    - if <[player_rankings]> != null:
                        - define player_position <[player_rankings].parse[split.get[2]].find[<[player_name]>]>
                        #   checks if player has an entry in the leaderboard category
                        - if <[player_position]> != -1:
                            - define category_contents <empty>
                            - define category_title "<[category_title]> - #<[player_position]>"

                            #   adds player above
                            - if <[player_position]> > 1:
                                - define previous_player <[player_rankings].get[<[player_position].sub[1]>]>
                                - define category_contents <[previous_player]><&nl>▼<&nl>

                            - define player_data <[player_rankings].get[<[player_position]>]>
                            - define category_contents <[category_contents]><[player_data]>

                            #   adds player below
                            - define next_player <[player_rankings].get[<[player_position].add[1]>].if_null[null]>
                            - if <[next_player]> != null:
                                - define category_contents <[category_contents]><&nl>▲<&nl><[next_player]>

                    - define leaderboards_embed <[leaderboards_embed].add_field[<[category_title]>].value[```<[category_contents]>```]>

                - ~discordmessage id:bot channel:<context.channel> <[leaderboards_embed]>