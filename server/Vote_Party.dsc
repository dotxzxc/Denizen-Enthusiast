voteparty_handler:
  type: world
  debug: false
  events:
    after system time 04:00:
    - flag server voteparty_count:0
    - announce "Vote party count has reset to 0." format:broadcast

    after votifier vote:
    - flag server voteparty_count:++

    - choose <server.flag[voteparty_count]>:
        - case 50:
            - execute as_server "eco give * 100000"
            - announce "Everyone has been awarded $100,000 for accumulating a total of 50 votes today!" format:broadcast

        - case 100:
            - foreach <server.online_players>:
                - execute as_server "mr add <[value].name> 50"
            - announce "Everyone has been awarded 50 credits for accumulating a total of 100 votes today!" format:broadcast

        - case 150:
            - execute as_server "cc giveall v Serendipity 2"
            - announce "Everyone has been awarded 1x Serendipity Key for accumulating a total of 150 votes today!" format:broadcast

        - case 200:
            - execute as_server "eco give * 150000"
            - announce "Everyone has been awarded $150,000 for accumulating a total of 200 votes today!" format:broadcast

        - case 250:
            - foreach <server.online_players>:
                - execute as_server "mr add <[value].name> 100"
            - announce "Everyone has been awarded 100 credits for accumulating a total of 250 votes today!" format:broadcast

voteparty_command:
  type: command
  debug: false
  name: voteparty
  usage: /voteparty
  description: show vote party count and rewards
  script:
    - narrate ""
    - narrate " <&gradient[from=#F74C06;to=#F9BC2C]><&l>Vote Party Rewards"
    - narrate ""

    # 50 votes
    - if <server.flag[voteparty_count]> < 50:
        - narrate " <&6>$100,000 <&8>(<server.flag[voteparty_count]>/50)"
    - else:
        - narrate " <&6><&m>$100,000 <&8><&m>(<server.flag[voteparty_count]>/50)"

    # 100 votes
    - if <server.flag[voteparty_count]> < 100:
        - narrate " <&6>50 credits <&8>(<server.flag[voteparty_count]>/100)"
    - else:
        - narrate " <&6><&m>50 credits <&8><&m>(<server.flag[voteparty_count]>/100)"

    # 150 votes
    - if <server.flag[voteparty_count]> < 150:
        - narrate " <&6>1x Serendipity Key <&8>(<server.flag[voteparty_count]>/150)"
    - else:
        - narrate " <&6><&m>1x Serendipity Key <&8><&m>(<server.flag[voteparty_count]>/150)"

    # 200 votes
    - if <server.flag[voteparty_count]> < 200:
        - narrate " <&6>$150,000 <&8>(<server.flag[voteparty_count]>/200)"
    - else:
        - narrate " <&6><&m>$150,000 <&8><&m>(<server.flag[voteparty_count]>/200)"

    # 250 votes
    - if <server.flag[voteparty_count]> < 250:
        - narrate " <&6>100 credits <&8>(<server.flag[voteparty_count]>/250)"
    - else:
        - narrate " <&6><&m>100 credits <&8><&m>(<server.flag[voteparty_count]>/250)"
    - narrate ""