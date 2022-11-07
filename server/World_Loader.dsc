World_Loader:
  type: world
  debug: false
  events:
    on server prestart:
    - createworld spawn
    - createworld arena generator:denizen:void