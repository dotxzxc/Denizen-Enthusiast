create_store_cmd:
  type: task
  script:
    - ~discordcommand id:noodle create group:950815231075024898 name:store "description:Store link"

store_command_handler:
  type: world
  debug: false
  events:
    on discord slash command name:store:
    - ~discordinteraction defer interaction:<context.interaction>

    - definemap embed_map:
        author_name: 🛒 https://store.noodlerealms.com
        author_url: http://store.noodlerealms.com
        color: yellow
        thumbnail: https://i.imgur.com/G69IfQe.png
        description: Support Noodle Realms by purchasing items from our store, funds will be used to develop new features for the server's upkeep and development.
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - ~discordinteraction reply interaction:<context.interaction> <[embed]>