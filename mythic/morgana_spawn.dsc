morgana_events:
  type: world
  debug: false
  events:
    after mythicmob Morgana spawns:
    - title "title:<&6>Morgana" "subtitle:<&7>has spawned in Arena" stay:3s fade_out:1s target:<server.online_players>

    after mythicmob Morgana killed:
    - title "title:<&6>Morgana" "subtitle:<&7>has turned into ashes" stay:3s fade_out:1s target:<server.online_players>

morgana_spawn_task:
    type: task
    debug: false
    script:
      - stop

      - chunkload <location[morgana_spawn].chunk>
      - wait 20t
      - mythicspawn Morgana <location[morgana_spawn]>

      - define channel 952253343835750444

      - definemap embed_map:
          author_name: Morgana has re-awakened in the Island of Delusion
          description: **Bounty<&co>**<&nl>• $250,000<&nl>• 5,000 XP<&nl>• 1x Boketto<&nl>• 1x Serendipity
          color: 201,79,79
          thumbnail: https://i.imgur.com/yv88F5m.png

      - define embed <discord_embed.with_map[<[embed_map]>]>
      - ~discordmessage id:bot channel:<[channel]> <[embed]>

morgana_spawn_reminder_1:
    type: task
    debug: false
    script:
      - stop

      - announce <empty>
      - announce "  <&c>Morgana <&7>will appear in the Boss Arena 30 minutes from now."
      - announce <empty>

morgana_spawn_reminder_2:
    type: task
    debug: false
    script:
      - stop

      - announce <empty>
      - announce "  <&c>Morgana <&7>will appear in the Boss Arena 15 minutes from now."
      - announce <empty>

morgana_spawn_reminder_3:
    type: task
    debug: false
    script:
      - stop

      - announce <empty>
      - announce "  <&c>Morgana <&7>will appear in the Boss Arena 3 minutes from now."
      - announce <empty>