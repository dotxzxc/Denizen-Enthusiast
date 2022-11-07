lore_cmd:
  type: command
  debug: false
  name: rename
  usage: /rename
  description: shortcut for /itemrename
  script:
  - execute as_player "itemlore <context.raw_args>"