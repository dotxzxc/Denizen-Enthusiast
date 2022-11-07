dBot_status_events:
  type: world
  debug: false
  events:
    after server start:
    - wait 3s
    - ~run bot_status_update
    after delta time minutely:
    - ~run bot_status_update

bot_status_update:
  type: task
  debug: false
  script:
  # Chart

  - define time <util.time_now.to_zone[UTC+8].hour>h<&co><util.time_now.to_zone[UTC+8].minute>m
  - define tps <server.recent_tps.first.round_to_precision[0.05]>
  - define player_count <server.online_players.size>

  - flag server statistics_chart.time:->:<[time]>
  - flag server statistics_chart.tps:->:<[tps]>
  - flag server statistics_chart.player_count:->:<[player_count]>
  # remove data if total exceeds 30
  - foreach <server.flag[statistics_chart]> key:label:
      - if <[value].size> > 30:
          - flag server statistics_chart.<[label]>:<-:<[value].first>

  # send chart to discord
  - if <server.flag[statistics_chart].get[time].first.if_null[null]> != null:
      - define labels <server.flag[statistics_chart].get[time].separated_by[,]>
      - define tps_data <server.flag[statistics_chart].get[tps].separated_by[,]>
      - define player_count_data <server.flag[statistics_chart].get[player_count].separated_by[,]>

      - define chart_url https://quickchart.io/chart/render/zm-5a750fd8-7201-4b60-974b-c8a8cb75c16c?
      - define chart_url <[chart_url]>title=Noodle%20Realms%20Survival&labels=<[labels]>&data1=<[player_count_data]>&data2=<[tps_data]>

      # ex ~discordmessage id:bot channel:<discord_channel[943259408337604639]> hi
      #- ~discordmessage id:bot edit:<[message_id]> channel:<[channel]> <[chart_url]>

  - define players <server.online_players>
  - define author_name Survival
  - define author_icon_url https://i.imgur.com/G69IfQe.png
  - define thumbnail https://i.imgur.com/G69IfQe.png
  - define status <discord_embed.with[author_name].as[<[author_name]>].with[author_icon_url].as[<[author_icon_url]>].with[thumbnail].as[<[thumbnail]>].with[image].as[<[chart_url]>]>
  - define performance "<&gt> <server.recent_tps.get[1].div[20].mul[100].round_to[1]><&pc>"
  - define uptime <server.current_tick.div[20].div[60].div[60].round>
  - define pCount <[players].size>
  - define status "<[status].add_inline_field[Player Count].value[<&gt> <[pCount]> players]>"
  - define status <[status].add_inline_field[Performance].value[<[performance]>]>
  - define status "<[status].add_inline_field[Uptime].value[<&gt> <[uptime]> hours]>"
  - define status <[status].add_field[Players:].value[```<[players].parse[name].comma_separated>```]>
  - ~discordmessage id:bot edit:1018054633228337153 channel:<discord_channel[952235387684794449]> <[status].with[color].as[yellow]>