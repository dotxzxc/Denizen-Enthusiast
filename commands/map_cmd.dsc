
mapCmd:
  type: command
  debug: false
  name: map
  usage: /map
  description: import image to in-game
  script:
  - if <context.args.size> > 2 || <context.args.size> < 1:
      - narrate "Correct usage /map <&lt>image url<&gt>" format:error_format
      - stop

  - if <context.args.size> == 1:
    - define url <context.args.get[1]>

    - if <[url]||null> == null:
      - narrate "Correct usage /map <&lt>image url<&gt>" format:error_format
      - stop

    - if <[url]> == <element[delete]>:
      - execute as_player "image delete"
      - stop
    - else:
      - execute as_player "image create <[url]>"