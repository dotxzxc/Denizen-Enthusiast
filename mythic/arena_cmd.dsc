arena_cmd:
  type: command
  debug: false
  name: arena
  usage: /arena
  description: randomly teleport to the arena
  script:
    - flag <player> wild_teleporting expire:4s
    - narrate "<&6>Teleporting in 3 seconds... don't move." format:default
    - wait 3s
    - if <player.has_flag[<player.uuid>.teleporting]>:
      - narrate "<&c>Teleport cancelled, please do not move when teleporting."
      - stop

    - random:
      - adjust <player> location:<location[arena1]>
      - adjust <player> location:<location[arena2]>
      - adjust <player> location:<location[arena3]>
      - adjust <player> location:<location[arena4]>

arena_command_event:
  type: world
  debug: false
  events:
    after player walks flagged:wild_teleporting:
    - flag <player> <player.uuid>.teleporting expire:3s