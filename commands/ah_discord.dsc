ah_cmd:
    type: world
    debug: true
    events:
        on ah command:
        - if <context.args.size> >= 2:
            - if <player.item_in_hand.material.name> == air:
                - stop

            #- define item <player.item_in_hand.material.item.formatted.to_titlecase>
            - define item <player.item_in_hand>

            - define option <context.args.get[1]>
            - define price <context.args.get[2]>
            - define channel 1029259994312482876

            - if <[price]> >= 5000 && <[price]> <= 100000000:
                - if <[option]> == sell || <[option]> == list:

                    - if <context.args.size> == 2:
                        - define quantity <player.item_in_hand.quantity>
                    # sell or bid
                        # Dotxzxc listed 1x <item> for <[price]>

                    - if <context.args.size> == 3:
                    # sell or bid
                        - define quantity <context.args.get[3]>
                        - if <[quantity].is_integer.not> || <[quantity]> > <player.item_in_hand.quantity>:
                            - stop

                    - definemap embed:
                        author_name: <player.name> listed <[quantity]>x <[item].material.name.replace_text[_].with[ ].to_titlecase> for $<[price].format_number>!
                        author_icon_url: https://mc-heads.net/avatar/<player.name>.png
                        color: yellow
                    - define message <discord_embed.with_map[<[embed]>]>

                    - if <[item].has_display>:
                        - define message <[message].add_field[Display].value[<&gt> <[item].display.strip_color>]>

                    - if <[item].is_enchanted>:
                        - define enchantments <list>
                        - foreach <[item].enchantments>:
                            - define enchantments <[enchantments].include[<&gt> <[value].replace_text[_].with[<empty>].to_titlecase>]>
                        - define message <[message].add_field[Enchantments].value[<[enchantments].separated_by[<&nl>]>]>

                    - if <[item].has_lore>:
                        - define lore <list>
                        - foreach <[item].lore>:
                            - define lore <[lore].include[<&gt> <[value].strip_color>]>
                        - define message <[message].add_field[Lore].value[<[lore].separated_by[<&nl>]>]>

                    - ~discordmessage id:bot channel:<[channel]> <[message]>
                    #- ~discordmessage id:bot channel:953802447715966986 <[message]>