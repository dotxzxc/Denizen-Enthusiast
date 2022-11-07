##ignoreWarning brace_syntax
##ignoreWarning bad_tag_base
##ignoreWarning tag_trace_failure

#
#   Records player statistics for leaderboard
#   and automatically gives rewards for top players
#

#
#   Leaderboards data config
#
leaderboards_data:
    type: data
    #   IDs for the leaderboard on Discord
    discord_channel_id: 954111491651547156
    discord_message_id: 1018057505479331841
    #   leaderboard title
    title:  🏆 Weekly Bonus
    description: Rewards will be given to the top players automatically every reset.
    # Use the `!leaderboards` command in <#991558342969405521>
    #
    #   duration for the leaderboard
    #   reset and the rewards
    #
    reset_duration: 7d
    #
    #   rewards/commands to run
    #   for players of each position
    #   placeholder: {player} = player name
    #
    rewards:
        1:
        - crates give v Boketto 1 {player}
        2:
        - crates give v Serendipity 1 {player}
        3:
        - eco give {player} 150000
        #4:
        #- say {player} is stoopid
        #5:
        #- say {player} is stoopid

    #   the number of categories to be enabled
    categories_count: 4
    #
    #   <category>: <title>
    #
    #   Leaderboard categories and their titles.
    #
    #   must add "category" here after making
    #   an event in order for it to be
    #   registered in the leaderboards
    #
    categories:
        monsters_killed: 👹Monsters Slained
        neutral_mob_kills: 🐔Neutrals Slained
        wither_kills: 💀Withers Slained
        ender_dragon_kills: 🐲Dragons Slained
        tnts_primed: 🧨TNTs Primed
        server_votes: 🗳️Votes
        spider_eye_consumed: 🕷️Spider Eye Enjoyer
        bread_consumed: 🥖French Stick Shill
        mined_blocks: 🧱Wreck-It Ralph
        arrows_hit: 🏹Hawkeye
        fishes_caught: 🎣Fishes Caught
        entities_punched: 🥊Manny Pacquiao
        animals_bred: 🐮Animals Bred
        items_enchanted: ✨Items Enchanter
        rotten_flesh_consumed: 🧟Reverse Zombie
        babies_punched: 👼Babies smacked


#
#   Events handler for the Leaderboard categories recorder
#
leaderboards_category_events:
    type: world
    debug: false
    events:
        #
        #   adding a category to the leaderboard
        #   requires adding it to the data script above
        #
        after player kills entity:
        - define player <context.damager>
        - define killed_entity <context.entity>

        #   player_kills
        - if <[killed_entity].is_player>:
            - flag <[player]> leaderboards.player_kills:++

        #   monster_kills
        - if <[killed_entity].is_monster>:
            - flag <[player]> leaderboards.monsters_killed:++

            #   wither_kills
            - if <[killed_entity].entity_type> == wither:
                - flag <[player]> leaderboards.wither_kills:++
        - else:
            #   neutral_mob_kills
            - flag <[player]> leaderboards.neutral_mob_kills:++

            #   ender_dragon_kills
            - if <[killed_entity].entity_type> == ender_dragon:
                - flag <[player]> leaderboards.ender_dragon_kills:++

        #   tnts_primed
        after tnt primes:
        - if <context.entity.if_null[null]> != null:
            - if <context.entity.is_player>:
                - flag <context.entity> leaderboards.tnts_primed:++

        #   server_votes
        after votifier vote:
        - define player <server.match_offline_player[<context.username>].if_null[null]>
        - if <[player]> != null:
            - flag <[player]> leaderboards.server_votes:++

        after player consumes item:
        - define item <context.item>
        - choose <[item].material.name>:
            #   spider_eye_consumed
            - case spider_eye:
                - flag player leaderboards.spider_eye_consumed:++
            #   bread_consumed
            - case bread:
                - flag player leaderboards.bread_consumed:++
            #   rotten_flesh_consumed
            - case rotten_flesh:
                - flag player leaderboards.rotten_flesh_consumed:++



        after player breaks block:
        #   mined_blocks
        - flag player leaderboards.mined_blocks:++

        #   arrows_hit
        after arrow hits entity:
        - define player <context.shooter.if_null[null]>
        - if <[player]> != null && <[player].is_player>:
            - flag <[player]> leaderboards.arrows_hit:++

        #   fishes_caught
        after player fishes entity:
        - flag player leaderboards.fishes_caught:++

        #   entities_punched
        after player damages entity with:air:
        - if <context.damager.flag[entities_punched].contains[<context.entity>].not.if_null[true]>:
            - flag <context.damager> leaderboards.entities_punched:++
        - flag <context.damager> entities_punched:|:<context.entity> duration:30s

        #   babies_punched
        - if <context.entity.is_baby.if_null[false]>:
            - flag player leaderboards.babies_punched:++

        #   animals_bred
        after entity breeds:
        - if <context.breeder.is_player.if_null[false]>:
            - flag <context.breeder> leaderboards.animals_bred:++

        #   items_enchanted
        after item enchanted:
        - if <context.entity.is_player.if_null[false]>:
            - flag <context.entity> leaderboards.items_enchanted:++