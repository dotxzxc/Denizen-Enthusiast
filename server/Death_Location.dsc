send_death_location:
  type: world
  debug: false
  events:
    after player dies:
    - narrate "You died at <context.entity.location.simple.formatted>" format:default
    - announce to_console "<context.entity.name> died at <context.entity.location.simple.formatted>"