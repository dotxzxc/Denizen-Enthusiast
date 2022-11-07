kits_cmd:
    type: world
    debug: false
    events:
        on kits command:
        - determine fulfilled passively
        - execute as_player "dm open kit_main"