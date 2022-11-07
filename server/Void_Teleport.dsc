void_teleport:
    type: world
    debug: false
    events:
        after delta time secondly:
        - foreach <world[spawn].players> as:player:
            - if <[player].location.y.round_up> <= 30:
                - adjust <[player]> location:<location[spawn]>