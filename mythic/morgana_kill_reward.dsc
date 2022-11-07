morgana_kill_reward:
  type: world
  debug: false
  events:
    after mythicmob Morgana killed:
    - if <context.killer.is_player>:
        - define player <context.killer.name>
      # Rewards
        # Money
        - execute as_server "eco give <[player]> 250000"
        # XP
        - give xp quantity:5000 player:<[player]>
        # Keys
        - execute as_server "cc give v Boketto 1 <[player]>"
        - execute as_server "cc give v Serendipity 1 <[player]>"

        - announce <empty>
        - announce "  <&c>Morgana <&7>was killed by <&6><[player]>"
        - announce <empty>