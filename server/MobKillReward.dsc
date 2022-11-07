mob_kill_event:
  type: world
  debug: false
  events:
    after player kills entity:
    - ratelimit <player> 5t
    - if <context.entity.entity_type> == player || <context.entity.is_npc||false>:
      - stop
    - define data <script[mob_rewards_list]>
    - define mob <context.entity>
    - if <[data].data_key[excluded].contains[<[mob].entity_type>]>:
      - stop
    # check if entity is a custom entity and if it has a custom prize
    # custom entities must have the flag "custom_entity" and a custom_name
    - if <[mob].has_flag[custom_entity]||false> && <[data].data_key[custom].keys.contains[<[mob].flag[custom_entity]>]>:
      - define money <[data].data_key[custom].get[<[mob].flag[custom_entity]>]>
      - if <player.has_flag[killmsgnot].not>:
        - actionbar "<&7>You earned <&a>$<[money]> <&7>for slaying a <&6><[<[mob].custom_name||<[mob].translated_name>>]>"
      - give money quantity:<[money]>
      - stop
    - if <[data].data_key[mobs].keys.contains[<[mob].entity_type>]>:
      - define from <[data].data_key[mobs].get[<[mob].entity_type>].get[from]>
      - define to <[data].data_key[mobs].get[<[mob].entity_type>].get[to]>
      - define money <util.random.int[<[from]>].to[<[to]>]>
    - else:
      - define money <util.random.int[<[data].data_key[default].get[from]>].to[<[data].data_key[default].get[to]>]>

    - if <server.has_flag[bonus_drop]> && <[mob].is_monster>:
      - define money <[money].mul[<util.random.int[3].to[5]>]>
    - if <player.has_flag[killmsgnot].not>:
      - actionbar "<&7>You earned <&a>$<[money]> <&7>for slaying a <&6><[mob].custom_name||<[mob].translated_name>>"
    - give money quantity:<[money]>

KillMsgToggle:
  type: command
  debug: false
  name: mobkillmessage
  description: message toggle
  usage: /mobkillmessage on|off
  script:
  - choose <context.args.get[1]>:
    - case on:
      - if <player.has_flag[killmsgnot]>:
        - flag <player> killmsgnot:!
      - narrate "<&7>Toggled <&a>On <&7>Kill Reward Message"
    - case off:
      - flag <player> mobkillmsgnot
      - narrate "<&7>Toggled <&c>Off <&7>Kill Reward Message"

# pag wala sa list ang default mahatag nila nga kwarta
# random ang mahatag from-to na values
mob_rewards_list:
  type: data
  default:
    from: 3
    to: 15
  custom:
    custom_flag: 300
  excluded:
  - armor_stand
  - boat
  mobs:
    # monsters
    zombie:
      from: 3
      to: 25
    skeleton:
      from: 3
      to: 25
    spider:
      from: 3
      to: 15
    creeper:
      from: 7
      to: 35
    enderman:
      from: 7
      to: 25
    phantom:
      from: 5
      to: 25
    piglin:
      from: 5
      to: 25
    drowned:
      from: 5
      to: 25
    stray:
      from: 5
      to: 25
    wither_skeleton:
      from: 15
      to: 45
    zombie_villager:
      from: 5
      to: 25
    ravager:
      from: 15
      to: 100
    husk:
      from: 7
      to: 35
    ghast:
      from: 35
      to: 150
    pillager:
      from: 7
      to: 35
    ender_dragon:
      from: 10000
      to: 100000
    wither:
      from: 10000
      to: 75000
    guardian:
      from: 7
      to: 50
    elder_guardian:
      from: 7
      to: 50
    witch:
      from: 7
      to: 50
    iron_golem:
      from: 15
      to: 50