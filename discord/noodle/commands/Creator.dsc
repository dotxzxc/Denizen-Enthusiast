create_creator_cmd:
  type: task
  script:
    - ~discordcommand id:noodle create group:950815231075024898 name:creator "description:Information on how to join Creator Program."

creator_command_handler:
  type: world
  debug: false
  events:
    on discord slash command name:creator:
    - ~discordinteraction defer interaction:<context.interaction>

    - definemap embed_map:
        title: Noodle Realms Creator Program <&lt>a<&co>noodle<&co>1018046115767124018<&gt>
        color: yellow
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - definemap format:
        format:
        - Earn money with referrals using our Noodle Realms Creators program, you will earn 15% from purchases using your creator code.
        - 
        - **Application Requirements:**
        - 1. Posted 3 videos advertising Noodle Realms on any content sharing platform e.g., TikTok, YouTube, Facebook (must include the IP of our server noodlerealms.com)
        - 2. Create a Tebex account and set up your wallet (this is where you will be claiming your earnings) to register go to http://accounts.tebex.io/
        - 
        - **Long-Term Requirement:**
        - 1. Must post at least 3 videos a month.
        - 
        - **Getting your Creator Code:**
        - Once you have completed the application requirements above, inform an admin that you want to claim a creator code. 15% of the purchases using the referral tag will automatically go to your Tebex wallet.
    - define message <[format].get[format].separated_by[<&nl>]>
    - define embed <[embed].with[description].as[<[message]>]>

    - ~discordinteraction reply interaction:<context.interaction> <[embed]>
