arenaexitCommand:
  type: command
  debug: false
  name: arenaexit
  usage: /arenaexit
  description: exit arena
  script:
    - if <player.world> == arena:
        - adjust <player> location:<location[spawn]>