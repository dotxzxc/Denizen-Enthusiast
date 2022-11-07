event_reminder:
  type: world
  debug: false
  events:
    after player joins:
    - stop
    - wait 5s
    - bossbar event_<player.uuid> players:<player> "title:<&gradient[from=#F74C06;to=#F9BC2C]><&l>Halloween Build Contest <&8>| <&f>For more info /event" color:blue
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.9
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.8
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.7
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.6
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.5
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.4
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.3
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.2
    - wait 20t
    - bossbar update event_<player.uuid> color:blue progress:0.1
    - wait 20t
    - bossbar remove event_<player.uuid>