wild_command:
  type: command
  name: wild
  usage: /wild
  description: a command to tp to wild
  debug: false
  script:
    - if <player.has_flag[wild_teleport_portal].not>:
      - flag <player> wild_teleporting expire:4s
      - narrate "<&e>Teleporting in 3 seconds... don't move."
      - wait 3s
      - if <player.has_flag[<player.uuid>.teleporting]>:
        - narrate "<&c>Teleport cancelled, please do not move when teleporting."
        - stop

    #- if <player.has_flag[wild_teleport_command_cooldown]>:
    #  - narrate "Please wait <player.flag_expiration[wild_teleport_command].from_now.formatted> before using this command." format:error
    #  - stop

    #- if <player.has_flag[wild_teleport_command]>:
    - playeffect effect:end_rod at:<player.location> data:0.1 offset:1.5 quantity:30
    - playeffect effect:cloud at:<player.location> data:0.1 offset:1.5 quantity:30
    - playsound sound:ENTITY_ENDER_DRAGON_FLAP at:<player.location> volume:0.5
    - wait 5t

    #- flag player wild_teleport_command_cooldown duration:5s

    - define location <location[<util.random.int[-5000].to[5000]>,200,<util.random.int[-5000].to[5000]>,seasoni]>

    - adjust <player> location:<[location]>
    - inject wild_teleport
    - playeffect effect:end_rod at:<player.location> data:0.1 offset:1.5 quantity:30
    - playeffect effect:cloud at:<player.location> data:0.1 offset:1.5 quantity:30
    - wait 20t
    - title title:<&b>Teleporting "subtitle:<&7>Teleported you to <&6>X = <[location].x> Z = <[location].z>" stay:2s fade_out:2s targets:<player>
    - narrate "<&7>Teleported you to <&6>X = <[location].x> Z = <[location].z>"
    - announce to_console "[RTP] Teleported <player.name> to <[location].simple>"

    #- else:
    #  - narrate "Wild command can only be used 2 minutes after teleporting from spawn's portal." format:error

survival_wild_portal:
  type: world
  debug: false
  events:
    after player walks flagged:wild_teleporting:
    - flag <player> <player.uuid>.teleporting expire:3s

    after delta time secondly:
    - define locations <cuboid[wilderness_portal].blocks>
    - playeffect effect:DRAGON_BREATH at:<[locations]> data:0.1 offset:0.5 quantity:3
    - playeffect effect:SOUL_FIRE_FLAME at:<[locations]> data:0.1 offset:0.5 quantity:2

    after player enters wilderness_portal:
    - ratelimit <player> 1s
    - playeffect effect:end_rod at:<player.location> data:0.1 offset:1.5 quantity:30
    - playeffect effect:cloud at:<player.location> data:0.1 offset:1.5 quantity:30
    - playsound sound:ENTITY_ENDER_DRAGON_FLAP at:<player.location> volume:0.5
    - wait 5t

    - flag player wild_teleport_portal duration:2m
    #- flag player wild_teleport_command_cooldown duration:5s

    - define location <location[<util.random.int[-5000].to[5000]>,200,<util.random.int[-5000].to[5000]>,seasoni]>

    - adjust <player> location:<[location]>
    - inject wild_teleport
    - playeffect effect:end_rod at:<player.location> data:0.1 offset:1.5 quantity:30
    - playeffect effect:cloud at:<player.location> data:0.1 offset:1.5 quantity:30

    - wait 20t
    - title title:<&b>Teleporting "subtitle:<&7>Teleported you to <&6>X = <[location].x> Z = <[location].z>" stay:2s fade_out:2s targets:<player>
    - narrate "<&7>Teleported you to <&6>X = <[location].x> Z = <[location].z>"
    - announce to_console "[RTP] Teleported <player.name> to <[location].simple>"

wild_teleport:
  type: task
  debug: false
  script:
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:0.8 volume:0.3
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_HARP pitch:0.6 volume:0.3
  - wait 5t
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:0.5 volume:0.3
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_HARP pitch:0.7 volume:0.3
  - wait 5t
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:0.8 volume:0.3
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_HARP pitch:0.8 volume:0.3
  - wait 5t
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BELL pitch:1 volume:0.3
  - playsound <player.location> sound:BLOCK_NOTE_BLOCK_HARP pitch:1 volume:0.3
  - wait 5t
  - playsound <player.location> sound:ENTITY_ENDER_DRAGON_FLAP volume:0.5
  - playeffect effect:cloud at:<player.location> quantity:30 offset:0.8 data:0.1
  - playeffect effect:end_rod at:<player.location> quantity:20 offset:0.8 data:0.2
  - playeffect effect:cloud at:<player.location.points_between[<player.location.add[0,50,0]>]> quantity:5 data:0.1
  - playeffect effect:end_rod at:<player.location.points_between[<player.location.add[0,50,0]>]> quantity:1
  - playeffect effect:cloud at:<player.location> quantity:30 offset:0.8 data:0.13
  - cast invisibility duration:10s <player>
  - cast regeneration duration:40s <player> amplifier:2
  - playsound <player.location> sound:BLOCK_END_PORTAL_SPAWN pitch:3 volume:1
  - wait 10t
  - cast slow_falling duration:20s <player>
  - wait 40t
  - narrate "You don't like the location? Do /wild - to teleport again." format:error