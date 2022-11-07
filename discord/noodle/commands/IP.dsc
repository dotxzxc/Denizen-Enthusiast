create_ip_cmd:
  type: task
  script:
    - ~discordcommand id:noodle create group:950815231075024898 name:ip "description:Display ip address."

ip_command_handler:
  type: world
  debug: false
  events:
    on discord slash command name:ip:
    - ~discordinteraction defer interaction:<context.interaction>

    - definemap embed_map:
        color: yellow
        description: 🎮 **Noodle Realms IP**<&co> __**noodlerealms.com**__
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - ~discordinteraction reply interaction:<context.interaction> <[embed]>