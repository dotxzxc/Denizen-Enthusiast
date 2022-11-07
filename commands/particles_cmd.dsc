particlesCmd:
  type: command
  debug: false
  name: particles
  usage: /particles
  aliases:
  - particle
  description: shortcut for playerparticle command
  script:
  - execute as_player "pp gui"