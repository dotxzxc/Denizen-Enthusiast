buyClaimBlocks_command:
  type: command
  debug: false
  name: buyclaimblocks
  description: buy claim
  usage: /buyclaimblocks
  aliases:
  - buyclaim
  - buyblocks
  script:
  - inventory open d:claimBlockShop

claimBlockShopAssignment:
  type: assignment
  debug: false
  actions:
    on assignment:
    - trigger name:click state:true
    on click:
    - inventory open d:claimBlockShop

claimBlockShop:
  type: inventory
  inventory: chest
  debug: false
  title: Claim Blocks Shop
  gui: true
  size: 9
  definitions:
    filler: gray_stained_glass_pane
  slots:
  - "[filler] [filler] [dirt_path[display_name=<&a>100 Claim Blocks;lore=<&f>Price: <&e>$500,000]] [filler] [podzol[display_name=<&a>500 Claim Blocks;lore=<&f>Price: <&e>$2,500,000]] [filler] [mycelium[display_name=<&a>1000 Claim Blocks;lore=<&f>Price: <&e>$5,000,000]] [filler] [filler]"

claimBlockShopEvents:
  type: world
  debug: false
  events:
    on player opens claimBlockShop:
    - playsound <player> sound:BLOCK_CHEST_OPEN volume:0.5
    on player closes claimBlockShop:
    - playsound <player> sound:BLOCK_CHEST_OPEN volume:0.5 pitch:0.8
    on player drags in claimBlockShop:
    - determine cancelled
    on player clicks in claimBlockShop:
    - if <context.item> == gray_stained_glass_pane:
      - determine cancelled
    - determine cancelled passively
    - choose <context.slot>:
    # 100 Claim Block
      - case 3:
        - define price 500000
        - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - execute as_server "acb <player.name> 100"
            - narrate "<&f>You bought 100 Claim Blocks for $<[price].format_number>" format:shop
        - else:
            - narrate "You don't have enough money" format:shop
        - inventory close
    # 500 Claim Block
      - case 5:
        - define price 2500000
        - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - execute as_server "acb <player.name> 500"
            - narrate "<&f>You bought 500 Claim Blocks for $<[price].format_number>" format:shop
        - else:
            - narrate "You don't have enough money" format:shop
        - inventory close
    # 1000 Claim Block
      - case 7:
        - define price 5000000
        - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - execute as_server "acb <player.name> 1000"
            - narrate "<&f>You bought 1000 Claim Blocks for $<[price].format_number>" format:shop
        - else:
            - narrate "You don't have enough money" format:shop
        - inventory close