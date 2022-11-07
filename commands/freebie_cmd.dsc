freebie_data:
  type: data
  hours:
    1:
      rewards:
      - $25,000
      - 25 credits
      command:
      - eco give PLAYER 25000
      - mr add PLAYER 25

    3:
      rewards:
      - $50,000
      - 1x Kalopsia Key
      command:
      - eco give PLAYER 50000
      - cc give v Kalopsia 1 PLAYER

    5:
      rewards:
      - $100,000
      - 2x Serendipity Key
      command:
      - eco give PLAYER 100000
      - crates give v Serendipity 2 PLAYER

    10:
      rewards:
      - $150,000
      - 1x Saudade Key
      - 1x Pygalgia Key
      command:
      - eco give PLAYER 150000
      - crates give v Saudade 1 PLAYER
      - crates give v Pygalgia 1 PLAYER

    25:
      rewards:
      - $300,000
      - 3x Boketto Key
      command:
      - eco give PLAYER 300000
      - crates give v Boketto 3 PLAYER

    50:
      rewards:
      - $500,000
      - Wanderer Rank
      command:
      - eco give PLAYER 500000
      - lp user PLAYER parent add wanderer

    100:
      rewards:
      - $1,000,000
      - Traveller Rank
      command:
      - eco give PLAYER 1000000
      - lp user PLAYER parent add Traveller

    200:
      rewards:
      - $3,000,000
      - 3x Boketto Key
      - 1x Spawner Key
      command:
      - eco give PLAYER 3000000
      - crates give v Boketto 3 PLAYER
      - crates give v Spawner 1 PLAYER

    300:
      rewards:
      - $5,000,000
      - 20,000 XP
      - 500 credits
      command:
      - eco give PLAYER 5000000
      - xp give PLAYER 20000
      - mr add PLAYER 500

    500:
      rewards:
      - $10,000,000
      - 5x Boketto Key
      - 1,500 credits
      command:
      - eco give PLAYER 10000000
      - mr add PLAYER 1500

freebie:
  type: command
  debug: false
  name: freebie
  usage: /freebie
  aliases:
  - freebies
  description: freebies!
  script:
  - define playtime <placeholder[statistic_hours_played].player[<player>].format_number>
  - narrate <empty>
  - narrate " <&gradient[from=#F74C06;to=#F9BC2C]><&l>Freebies"
  - narrate " <&a>Play & Get Rewards"
  - narrate <empty>
  - narrate " <&6>Your playtime: <&7><[playtime]> hours"
  - narrate <empty>

  - define data <script[freebie_data].data_key[hours]>
  - foreach <[data].keys>:
    - define reward <[data].deep_get[<[value]>].get[rewards]>
    - define command <[data].deep_get[<[value]>].get[command]>

    - narrate " <&e><[value]> hours<&8>:"

    - if <[playtime]> >= <[value]>:
      - foreach <[reward]>:
        - narrate "   <&8>• <&7><&m><[value]>"

      - if <player.has_flag[freebie.<[value]>].not>:
        - foreach <[command]>:
          - execute as_server <[value].replace_text[PLAYER].with[<player.name>]>
        - flag <player> freebie.<[value]>
        - narrate "<&a>You have successfully claimed your <[value]> hours freebie!" format:noodle

    - else:
      - foreach <[reward]>:
        - narrate "   <&8>• <&7><[value]>"
  - narrate <empty>