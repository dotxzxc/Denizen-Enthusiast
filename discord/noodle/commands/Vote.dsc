create_vote_cmd:
  type: task
  script:
    - ~discordcommand id:noodle create group:950815231075024898 name:vote "description:Display voting links."

vote_cmd_handler:
  type: world
  debug: false
  events:
    on discord slash command name:vote:
    - ~discordinteraction defer interaction:<context.interaction>

    - definemap format:
        voteformat:
        - > **1.** http://vote1.noodlerealms.com
        - > **2.** http://vote2.noodlerealms.com
        - > **3.** http://vote3.noodlerealms.com
        - > **4.** http://vote4.noodlerealms.com
        - > **5.** http://vote5.noodlerealms.com
        - > **6.** http://vote6.noodlerealms.com
        - > **7.** http://vote7.noodlerealms.com
        - > **8.** http://vote8.noodlerealms.com
        - > **9.** http://vote9.noodlerealms.com
        - > **10.** http://vote10.noodlerealms.com
        - 
        - *Quite a lot of links, just only vote what you need. :>*

    - define description <[format].get[voteformat].separated_by[<&nl>]>

    - definemap embed_map:
        author_name: 🗳️ Noodle Realms Vote Links
        color: yellow
        thumbnail: https://i.imgur.com/G69IfQe.png
        description: <[description]>
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - ~discordinteraction reply interaction:<context.interaction> <[embed]>