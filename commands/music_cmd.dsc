nbs_player_cmd:
  type: command
  debug: false
  name: music
  description: Plays an nbs file located at /Denizen/nbs
  usage: /music
  script:
  - narrate <empty>
  - narrate " <&gradient[from=#F74C06;to=#F9BC2C]>List of Available Songs"
  - narrate "   <&a>Hover and click a song to play"
  - narrate <empty>
  - foreach <server.list_files[nbs]>:
    - define song <[value].before[.nbs]>
    - narrate " <&6><[loop_index]>: <&f><[song].replace_text[_].with[ ].to_titlecase.on_click[/noodle_music_play <[song]>].on_hover[<&e>click to play <[song]>]>"
  - narrate <empty>

nbs_play:
  type: command
  debug: false
  name: noodle_music_play
  description: subcommand for nbs command
  permission: skypinas.admin
  usage: /noodle_music_play
  script:
  - nbs stop targets:<player>
  - define song <context.raw_args>
  - nbs play file:/nbs/<[song]> targets:<player>
  - narrate "<&6>Now playing <&a><[song].replace_text[_].with[ ].to_titlecase>" format:default

server_music_cmd:
  type: command
  debug: false
  name: musicstop
  description: music player
  usage: /musicstop
  script:
  - if <player.nbs_is_playing>:
    - nbs stop
    - narrate "<&c>Music disabled!" format:default
  - else:
    - narrate "No song playing. Do <&c>/music <&7>to play a song." format:default