reset_reminder:
  type: world
  debug: false
  events:
    after player joins:
    - wait 10s
    - actionbar "<&gradient[from=#F74C06;to=#F9BC2C]>Season Started: October 1 | Next Season: January 1 | Total Players: <server.players.size>" targets:<player>