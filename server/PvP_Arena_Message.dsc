pvp_arena_join_message:
  type: world
  debug: false
  events:
    after player enters pvparena:
    - title "title:<&gradient[from=#F74C06;to=#F9BC2C]><&l>PvP Arena" "subtitle:<&c>Jump down to enter warzone!" stay:3s targets:<player>