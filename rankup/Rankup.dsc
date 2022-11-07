# REQUIREMENTS (all optional)
# money
# playtime
# votes
# items
# advancements
rankup_command:
  type: command
  debug: false
  name: rankup
  usage: /rankup
  description: Type /rankup to ascend into a higher rank
  tab complete:
  - determine details|benefits
  script:
  - define rank <luckperms.track[rankup].groups[<player>].get[1]>
  - define data <script[rankup_data]>
  - define rankData <[data].data_key[ranks.<[rank]>]>
  - if <context.args.get[1]||null> == detail || <context.args.get[1]||null> == details:
    - inject rankup_details
    - stop

  - if <context.args.get[1]||null> == benefit || <context.args.get[1]||null> == benefits:
    - execute as_player "dm open rank_benefits"
    - stop

  - if <[rank]> == noodlex:
    - narrate "You have reached the highest rank!" format:error
    - stop

  # error checking
  - if <[rank]> == "":
    - narrate "<&c>Rankup data error contact an admin on the Noodle Realms Discord ~1"
    - stop
  - if <[data].data_key[ranks].keys.contains[<[rank]>].not>:
    - narrate "<&c>Rankup data error contact an admin on the Noodle Realms Discord ~2"
    - stop
  - if <script[rankup_data]||null> == null:
    - narrate "<&c>Rankup data error contact an admin on the Noodle Realms Discord ~3"
    - stop


  # requirements
  # money check
  - if <[rankData].get[requirements].keys.contains[money]>:
    - if <player.money> < <[rankData].get[requirements].get[money]>:
      - narrate "<&c>You need <&a>$<[rankData].get[requirements].get[money].sub[<player.money>].round_to[1]> <&c>to rank-up, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
      - stop
  # playtime check
  - if <[rankData].get[requirements].keys.contains[playtime]>:
    - if <player.time_lived.in_hours> < <[rankData].get[requirements].get[playtime]>:
      - narrate "<&c>You need <&a><[rankData].get[requirements].get[playtime].sub[<player.time_lived.in_hours>].round_to[1]> more hours <&c>of play-time to rank-up, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
      - stop
  # votecount check
  - if <[rankData].get[requirements].keys.contains[votecount]>:
    - if <placeholder[superbvote_votes]> < <[rankData].get[requirements].get[votecount]>:
      - narrate "<&c>You need <&a><element[<placeholder[superbvote_votes]>]>/<element[<[rankData].get[requirements].get[votecount]>]> more votes <&c>to rank-up, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
      - stop

  # items check
  - if <[rankData].get[requirements].keys.contains[items]>:
    - foreach <[rankData].get[requirements].get[items]>:
      - if <player.inventory.contains_item[<[key]>].quantity[<[value]>].not>:
        - narrate "<&c>You don't have <&a><[value]> <material[<[key]>].name.replace_text[_].with[ ]> in your inventory<&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # advancements check
  - if <[rankData].get[requirements].keys.contains[advancements]>:
    - foreach <[rankData].get[requirements].get[advancements]>:
      - if <player.advancements.contains[minecraft:<[key]>].not||true>:
      #- if <player.has_advancement[<[key]>].not||true>:
        - narrate "<&c>You don't have the advancement <&a><[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # mob check
  - if <[rankData].get[requirements].keys.contains[mob_kill]>:
    - foreach <[rankData].get[requirements].get[mob_kill]>:
      - if <placeholder[statistic_kill_entity:<[key]>].player[<player>]> < <[value]>:
        - narrate "<&c>You need to kill <&a><[key].replace_text[_].with[ ]> <placeholder[statistic_kill_entity:<[key]>].player[<player>]>/<[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # animals breed
  - if <[rankData].get[requirements].keys.contains[breed]>:
    - foreach <[rankData].get[requirements].get[breed]>:
      - if <placeholder[statistic_animals_bred].player[<player>]> < <[value]>:
        - narrate "You need to breed animals <&a><placeholder[statistic_animals_bred].player[<player>]>/<[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # enchant
  - if <[rankData].get[requirements].keys.contains[enchant]>:
    - foreach <[rankData].get[requirements].get[enchant]>:
      - if <placeholder[statistic_item_enchanted].player[<player>]> < <[value]>:
        - narrate "<&c>You need to enchant an item <&a><placeholder[statistic_item_enchanted].player[<player>]>/<[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # mine_block
  - if <[rankData].get[requirements].keys.contains[mine_block]>:
    - foreach <[rankData].get[requirements].get[mine_block]>:
      - if <placeholder[statistic_mine_block:<[key]>].player[<player>]> < <[value]>:
        - narrate "<&c>You need to mine <&a><[key].replace_text[_].with[ ]> <placeholder[statistic_mine_block:<[key]>].player[<player>]>/<[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error
        - stop
  # distance walked
  - if <[rankData].get[requirements].keys.contains[walk]>:
    - foreach <[rankData].get[requirements].get[walk]>:
      - if <placeholder[statistic_walk_one_cm].player[<player>].replace_text[,].with[].div[100000].round_up> < <[value]>:
        - narrate "<&c>You need to walk <&a><placeholder[statistic_walk_one_cm].player[<player>].replace_text[,].with[].div[100000].round_up>/<[value]> km<&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error"
        - stop
  # craft item
  - if <[rankData].get[requirements].keys.contains[craft]>:
    - foreach <[rankData].get[requirements].get[craft]>:
      - if <placeholder[statistic_craft_item:<[key]>].player[<player>]> < <[value]>:
        - narrate "<&c>You need to craft <&a><[key].replace_text[_].with[ ]> <placeholder[statistic_craft_item:<[key]>].player[<player>]>/<[value]><&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error"
        - stop
  # catch fish
  - if <[rankData].get[requirements].keys.contains[catch_fish]>:
    - foreach <[rankData].get[requirements].get[catch_fish]>:
      - if <placeholder[statistic_fish_caught].player[<player>]> < <[value]>:
        - narrate "<&c>You need to catch <&a><placeholder[statistic_fish_caught].player[<player>]>/<[value]> fish<&c>, type <&e>/rankup details <&c>to view the requirements and type <&e>/rankupbenefits <&c>to view rank benefits." format:error"
        - stop

  # rankup verification
  - if <player.has_flag[confirmRankup]>:
    #- if <script[rank_health_data].list_keys[ranks].contains[<[rank]>]>:
    #  - define new_health <script[rank_health_data].data_key[ranks].get[<[rank]>]>
    #  - adjust <player> health_data:<[new_health]>/<[new_health]>
    - if <[rankData].get[requirements].keys.contains[money]>:
      - take money quantity:<[rankData].get[requirements].get[money]>
      - narrate "<&c>P<[rankData].get[requirements].get[money]> has been taken from your balance"
    - if <[rankData].get[requirements].keys.contains[items]>:
      - foreach <[rankData].get[requirements].get[items]>:
        - take material:<[key]> quantity:<[value]>
        - narrate "<&c><[value]> <material[<[key]>].name.replace_text[_].with[ ]> has been taken from your inventory"
    - playsound <player> volume:0.8 pitch:0.3 sound:UI_TOAST_CHALLENGE_COMPLETE
    - announce "<&8>[<&c>!<&8>] <&6><player.name> <&b>has ranked up!"

    - define config_data <script[game_chat_config].data_key[config]>
    - define channel <discord_channel[bot,<[config_data].get[channel-id]>]>
    - define name <player.name>
    - define rank <placeholder[luckperms_primary_group_name].player[<player>].to_uppercase>
    - if <[rank]> == <element[Default]>:
      - define rank Noodle
    - define message "<player.name> has ranked up!"
    - run webhook_send def.message:```<[config_data].get[minecraft].get[rankup-format].parsed>``` def.url:<[config_data].get[webhook-url].parsed> def.rank:<[rank]> def.avatar:https://mc-heads.net/avatar/<player.name>.png def.username:<[name]>

    - toast "<&e>You have ranked up!" icon:<[rankData].get[icon]||golden_helmet>
    - execute as_server "lp user <player.name> promote rankup"
    - adjust <player> max_health:<[rankData].get[heart]>
  - else:
    - flag player confirmRankup duration:30s
    - if <[rankData].get[requirements].keys.contains[money]> || <[rankData].get[requirements].keys.contains[items]>:
      - narrate <empty>
      - narrate "  <&e>Are you sure you want to rankup?"
      - narrate "  <&e>You will lose the following items:"
      - narrate <empty>
      - if <[rankData].get[requirements].keys.contains[money]>:
        - narrate "  <&c>• $<[rankData].get[requirements].get[money]>"
      - if <[rankData].get[requirements].keys.contains[items]>:
        - foreach <[rankData].get[requirements].get[items]>:
          - narrate "  <&c>• <[value]> <material[<[key]>].name.replace_text[_].with[ ]>"
      - narrate <empty>
    - else:
      - narrate <empty>
      - narrate "  <&e>Are you sure you want to rankup?"
      - narrate "  <&e>Type /rankup again to confirm"
      - narrate <empty>

# money
# playtime
# votes
# items
# advancements
rankup_details:
  type: task
  debug: false
  script:
  - narrate <empty>
  - narrate " <&b><[rankData].get[name]> ---<&gt>"
  #- narrate <empty>
  #- foreach <[rankData].get[description]>:
  #  - narrate " <&7><[value]>"
  - narrate <empty>
  - narrate "<&6>Requirements:"
  # money
  - if <[rankData].get[requirements].keys.contains[money]>:
    - narrate "  <&e>Money:"
    - if <player.money> < <[rankData].get[requirements].get[money]>:
      - narrate "   <&c>• $<[rankData].get[requirements].get[money]>"
    - else:
      - narrate "   <&8><&m>• $<[rankData].get[requirements].get[money]>"
  # playtime
  - if <[rankData].get[requirements].keys.contains[playtime]>:
    - narrate "  <&e>Play-time"
    - if <player.time_lived.in_hours> < <[rankData].get[requirements].get[playtime]>:
      - narrate "   <&c>• <[rankData].get[requirements].get[playtime]> hours"
    - else:
      - narrate "   <&8><&m>• <[rankData].get[requirements].get[playtime]> hours"
  # votecount
  - if <[rankData].get[requirements].keys.contains[votecount]>:
    - narrate "  <&e>Votes:"
    - if <placeholder[superbvote_votes]> < <[rankData].get[requirements].get[votecount]>:
      - narrate "  <&c>• <[rankData].get[requirements].get[votecount]>"
    - else:
      - narrate "  <&8><&m>• <[rankData].get[requirements].get[votecount]>"
  # items
  - if <[rankData].get[requirements].keys.contains[items]>:
    - narrate "  <&e>Items:"
    - foreach <[rankData].get[requirements].get[items]>:
      - if <player.inventory.contains_item[<[key]>].quantity[<[value]>].not>:
        - narrate "   <&c>• <[value]> <material[<[key]>].name.replace_text[_].with[ ]>"
      - else:
        - narrate "   <&8><&m>• <[value]> <material[<[key]>].name.replace_text[_].with[ ]>"
  # advancement
  - if <[rankData].get[requirements].keys.contains[advancements]>:
    - narrate "  <&e>Advancements:"
    - foreach <[rankData].get[requirements].get[advancements]>:
      - if <player.advancements.contains[minecraft:<[key]>].not||true>:
        - narrate "   <&c>• <[value]>"
      - else:
        - narrate "   <&8><&m>• <[value]>"
  # mob_kill
  - if <[rankData].get[requirements].keys.contains[mob_kill]>:
    - narrate "  <&e>Mob kill:"
    - foreach <[rankData].get[requirements].get[mob_kill]>:
      - if <placeholder[statistic_kill_entity:<[key]>].player[<player>]> < <[value]>:
        - narrate "   <&c>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_kill_entity:<[key]>].player[<player>]>/<[value]>"
      - else:
        - narrate "   <&8><&m>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_kill_entity:<[key]>].player[<player>]>/<[value]>"
  # animals breed
  - if <[rankData].get[requirements].keys.contains[breed]>:
    - narrate "  <&e>Animal breed:"
    - foreach <[rankData].get[requirements].get[breed]>:
      - if <placeholder[statistic_animals_bred].player[<player>]> < <[value]>:
        - narrate "   <&c>• <placeholder[statistic_animals_bred].player[<player>]>/<[value]>"
      - else:
        - narrate "   <&8><&m>• <placeholder[statistic_animals_bred].player[<player>]>/<[value]>"

  # enchant
  #- if <[rankData].get[requirements].keys.contains[enchant]>:
  #  - narrate "  <&e>Enchant item:"
  #  - foreach <[rankData].get[requirements].get[enchant]>:
  #    - if <placeholder[statistic_item_enchanted].player[<player>]> < <[value]>:
  #      - narrate "   <&c>• <placeholder[statistic_item_enchanted].player[<player>]>/<[value]>"
  #    - else:
  #      - narrate "   <&8><&m>• <placeholder[statistic_item_enchanted].player[<player>]>/<[value]>"

  # mine_block
  - if <[rankData].get[requirements].keys.contains[mine_block]>:
    - narrate "  <&e>Mine block:"
    - foreach <[rankData].get[requirements].get[mine_block]>:
      - if <placeholder[statistic_mine_block:<[key]>].player[<player>]> < <[value]>:
        - narrate "   <&c>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_mine_block:<[key]>].player[<player>]>/<[value]>"
      - else:
        - narrate "   <&8><&m>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_mine_block:<[key]>].player[<player>]>/<[value]>"
  # distance walked
  - if <[rankData].get[requirements].keys.contains[walk]>:
    - narrate "  <&e>Travel by walking:"
    - foreach <[rankData].get[requirements].get[walk]>:
      - if <placeholder[statistic_walk_one_cm].player[<player>].replace_text[,].with[].div[100000].round_up> < <[value]>:
        - narrate "   <&c>• walk <placeholder[statistic_walk_one_cm].player[<player>].replace_text[,].with[].div[100000].round_up>/<[value]> km"
      - else:
        - narrate "   <&8><&m>• walk <placeholder[statistic_walk_one_cm].player[<player>].replace_text[,].with[].div[100000].round_up>/<[value]> km"
  # craft item
  - if <[rankData].get[requirements].keys.contains[craft]>:
    - narrate "  <&e>Craft item:"
    - foreach <[rankData].get[requirements].get[craft]>:
      - if <placeholder[statistic_craft_item:<[key]>].player[<player>]> < <[value]>:
        - narrate "   <&c>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_craft_item:<[key]>].player[<player>]>/<[value]>"
      - else:
        - narrate "   <&8><&m>• <[key].replace_text[_].with[ ]>: <placeholder[statistic_craft_item:<[key]>].player[<player>]>/<[value]>"
  # catch fish
  - if <[rankData].get[requirements].keys.contains[catch_fish]>:
    - narrate "  <&e>Catch fish:"
    - foreach <[rankData].get[requirements].get[catch_fish]>:
      - if <placeholder[statistic_fish_caught].player[<player>]> < <[value]>:
        - narrate "   <&c>• <placeholder[statistic_fish_caught].player[<player>]>/<[value]>"
      - else:
        - narrate "   <&8><&m>• <placeholder[statistic_fish_caught].player[<player>]>/<[value]>"
  - narrate <empty>