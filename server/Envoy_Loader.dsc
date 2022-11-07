Envoy_Loader:
  type: world
  debug: false
  events:
    after delta time hourly every:1:
    - execute as_server "envoys reload"