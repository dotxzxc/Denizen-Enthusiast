world_of_creation:
  type: world
  debug: false
  events:
    on player opens inventory in:RealmOfCreation:
    - narrate "You're not allowed to open any inventory in the world of Creation." format:error
    - inventory clear d:<player.inventory>
    - announce to_console <player.inventory.map_slots>
    - adjust <player> location:<location[spawn]>

    on backpack command in:RealmOfCreation:
    - determine cancelled passively
    - narrate "You can't open backpack in this world." format:error

    on bp command in:RealmOfCreation:
    - determine cancelled passively
    - narrate "You can't open backpack in this world." format:error

    on ec command in:RealmOfCreation:
    - determine cancelled passively
    - narrate "You can't open ender chest in this world." format:error

    on enderchest command in:RealmOfCreation:
    - determine cancelled passively
    - narrate "You can't open ender chest in this world." format:error

    on player changes world to RealmOfCreation:
    - if <player.inventory.map_slots.size> != 0:
      - narrate "You must empty your inventory before you can teleport to the world of Creation." format:error
      - flag <player> creation_teleporting expire:10t
      - adjust <player> location:<location[spawn]>
    - else:
      - if <player.gamemode> == SURVIVAL:
        - adjust <player> gamemode:creative

    on player changes world from RealmOfCreation:
    - if <player.gamemode> == CREATIVE && <player.is_op.not>:
      - adjust <player> gamemode:survival

    - if <player.inventory.map_slots.size> != 0:
      - if <player.has_flag[creation_teleporting].not>:
        - narrate "Your inventory has been emptied." format:error
        - announce to_console <player.inventory.map_slots>
        - inventory clear d:<player.inventory>

    on player quits:
    - if <player.gamemode> == CREATIVE && <player.is_op.not>:
      - adjust <player> gamemode:survival

    - if <player.world> == <world[RealmOfCreation]>:
      - announce to_console <player.inventory.map_slots>
      - inventory clear d:<player.inventory>
      - adjust <player> location:<location[spawn]>

    # Disable Wither
    on player places wither_skeleton_skull in:RealmOfCreation:
    - determine cancelled passively
    - narrate "You're not allowed to place a WITHER SKELETON SKULL in this world.'" format:error