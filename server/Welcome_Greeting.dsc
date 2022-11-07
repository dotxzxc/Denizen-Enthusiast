title_greeting:
    type: world
    debug: false
    events:
        after player joins bukkit_priority:lowest:
        - title "title:<&gradient[from=#F74C06;to=#F9BC2C]>Noodle Realms <&a>Season I" "subtitle:<&e>Welcome <player.name>!"
        - narrate "<&8><&m>+---------------------------+"
        - narrate "         "
        - narrate "               <&gradient[from=#F74C06;to=#F9BC2C]><&l>Noodle Realms"
        - narrate "                   <&a>Season I"
        - narrate "         "
        - narrate " <&7>Welcome, <&b><&n><player.name><&7>!"
        - narrate "         "
        - narrate " <&e>Website<&7>: <element[<&f>https://noodlerealms.com/].on_click[http://noodlerealms.com/].type[OPEN_URL]>"
        - narrate " <&d>Store<&7>: <element[<&f>https://store.noodlerealms.com/].on_click[http://store.noodlerealms.com/].type[OPEN_URL]>"
        - narrate " <&9>Discord<&7>: <element[<&f>https://discord.noodlerealms.com/].on_click[http://discord.noodlerealms.com/].type[OPEN_URL]>"
        - narrate " <&c>Wiki<&7>: <element[<&f>https://wiki.noodlerealms.com/].on_click[http://wiki.noodlerealms.com/].type[OPEN_URL]>"
        - narrate "         "
        - narrate "         <&8>» <&6>noodlerealms.com <&8>« "
        - narrate "<&8><&m>+---------------------------+"