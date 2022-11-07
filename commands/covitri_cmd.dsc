covitriShopCommand:
  type: command
  debug: false
  name: covitri
  usage: /covitri
  script:
    - inventory open d:covitriShop

covitriShopAssignment:
  type: assignment
  debug: false
  actions:
    on assignment:
    - trigger name:click state:true
    on click:
    - inventory open d:covitriShop

covitriShop:
  type: inventory
  inventory: chest
  debug: false
  title: Covitri Shop
  gui: true
  size: 9
  definitions:
    filler: gray_stained_glass_pane
  slots:
  - "[filler] [filler] [covit[lore=<&a>Buy: <&e>$10,000<&nl><&a>Sell: <&e>$9,700]] [filler] [covitri[lore=<&a>Buy: <&e>$100,000<&nl><&a>Sell: <&e>$97,000]] [filler] [magicCovitri[lore=<&a>Buy: <&e>$1,000,000<&nl><&a>Sell: <&e>$970,000]] [filler] [filler]"

covitriShopEvents:
  type: world
  debug: false
  events:
    on player drags in covitriShop:
    - determine cancelled
    on player opens covitriShop:
    - playsound <player> sound:BLOCK_CHEST_OPEN volume:0.5
    on player closes covitriShop:
    - playsound <player> sound:BLOCK_CHEST_OPEN volume:0.5 pitch:0.8
    on player clicks in covitriShop:
    - if <context.clicked_inventory> != <context.inventory>:
      - determine cancelled
    - if <context.item> == gray_stained_glass_pane:
      - determine cancelled
    - determine cancelled passively
    - choose <context.click>:
      - case "LEFT":
        # Covit
        - if <context.item.script> == <script[covit]>:
          - define price 10000
          - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - give covit quantity:1
            - narrate "<&f>You bought Covit for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have enough money" format:shop_format
        # Covitri
        - if <context.item.script> == <script[covitri]>:
          - define price 100000
          - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - give covitri quantity:1
            - narrate "<&f>You bought Covitri for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have enough money" format:shop_format
        # Magic Covitri
        - if <context.item.script> == <script[magicCovitri]>:
          - define price 1000000
          - if <player.money> >= <[price]>:
            - take money quantity:<[price]>
            - give magiccovitri quantity:1
            - narrate "<&f>You bought Magic Covitri for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have enough money" format:shop_format

      - case "RIGHT":
        # Covit
        - if <context.item.script> == <script[covit]>:
          - define price 9700
          - define item covit
          - if <player.inventory.contains_item[<[item]>]>:
            - give money quantity:<[price]>
            - take item:<[item]> quantity:1
            - narrate "<&f>You sold Covit for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have Covit in your inventory" format:shop_format
        # Covitri
        - if <context.item.script> == <script[covitri]>:
          - define price 97000
          - define item covitri
          - if <player.inventory.contains_item[<[item]>]>:
            - give money quantity:<[price]>
            - take item:<[item]> quantity:1
            - narrate "<&f>You sold Covitri for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have Covitri in your inventory" format:shop_format
        # Magic Covitri
        - if <context.item.script> == <script[magicCovitri]>:
          - define price 970000
          - define item magiccovitri
          - if <player.inventory.contains_item[<[item]>]>:
            - give money quantity:<[price]>
            - take item:<[item]> quantity:1
            - narrate "<&f>You sold Magic Covitri for $<[price].format_number>" format:shop_format
          - else:
            - narrate "You don't have Magic Covitri in your inventory" format:shop_format

covit:
  display name: <&8>[<&b><&k>!<&8>] <&b><&n>Covit<&r> <&8>[<&b><&k>!<&8>]
  type: item
  debug: false
  material: iron_nugget

covitri:
  display name: <&8>[<&b><&k>!<&8>] <&d><&n>Covitri<&r> <&8>[<&b><&k>!<&8>]
  type: item
  debug: false
  material: gold_nugget

magicCovitri:
  display name: <&8>[<&b><&k>!<&8>] <&6><&n>Magic Covitri<&r> <&8>[<&b><&k>!<&8>]
  type: item
  debug: false
  material: nether_star