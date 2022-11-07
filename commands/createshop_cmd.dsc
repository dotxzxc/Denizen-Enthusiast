createshop:
  type: command
  debug: false
  name: createshop
  usage: /createshop
  description: creating shop through shopkeeper
  aliases:
  - cs
  script:
  - if <context.args.size> == 1:
    - define mob <context.args.get[1]>
    - execute as_player "shopkeeper trading-shop <[mob]>"
    - stop
  - else:
    - narrate "Correct usage /createshop <&lt>mob-type<&gt>" format:error