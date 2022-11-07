spawner_limit:
  type: world
  debug: false
  events:
    on player places spawner:
    #- if <player.is_op.not>:
    #  - determine cancelled passively
    #  - narrate "<&c>Temporarily disabled placing spawner."
    - if <player.has_permission[mineablespawners.mine].not>:
      - determine cancelled passively
      - narrate "<&c>Only rank IV and above can mine & place spawner."
      - stop
    - define list <list>
    - foreach <player.location.chunk.tile_entities>:
        - if <[value].material.contains_all_text[spawner]>:
            - define list <[list].include[<[value]>]>
    - if <[list].size> > 3:
        - determine cancelled passively
        - narrate "<&c>You have reached the limit of spawner each chunk."