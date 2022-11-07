shop_cmd:
    type: world
    debug: false
    events:
        on shop command:
        - if <context.args.size> == 0:
            - determine cancelled passively
            - execute as_player "dm open shop"