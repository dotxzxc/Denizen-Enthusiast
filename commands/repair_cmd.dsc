# flag repair_cmd.repair_count
# permission: denizen.repair
repair_cmd:
    type: command
    debug: false
    name: repair
    description: Repair broken items up to 3 times
    usage: /repair
    permission: denizen.repair
    permission message: <proc[premium_only]>
    script:
    - define item <player.item_in_hand>
    - define slot <player.held_item_slot>
    - if <[item].material.name> == air:
        - narrate "<&c>Please hold an item that you wish to repair" format:error_format
    - else:
        - if <[item].flag[repair_cmd.repair_count].if_null[0]> > 2:
            - narrate "<&c>This item has been repaired more than 3 times already" format:error_format
        - else:
            - if <[item].durability> == 0:
                - narrate "<&c>This item is already at max durability" format:error_format
                - stop
            - narrate "You've successfully repaired your <[item].display.if_null[<[item].material.translated_name>]>" format:default_format
            - inventory flag slot:<[slot]> repair_cmd.repair_count:++
            - inventory adjust slot:<[slot]> durability:0