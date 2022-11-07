create_link_cmd:
  type: task
  script:
    - definemap options:
        1:
          type: string
          name: username
          description: Enter your Minecraft Username
          required: true

        2:
          type: string
          name: referrer
          description: Referrer
          required: false

    - ~discordcommand id:bot create group:950815231075024898 name:link "description:Link your Minecraft to Noodle Realm Discord" options:<[options]>

# yaml data discord_verification_data
# on key "discord"
verification_discord_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:link:
    - ~discordinteraction defer interaction:<context.interaction>

    - define user <context.interaction.user>

    # check if referrer exist
    - define referrer <context.options.deep_get[referrer].if_null[<element[N/A]>]>

    - if <[referrer]> != <element[N/A]>:
      - define referrer <server.match_offline_player[<[referrer]>].if_null[null]>
      - if <[referrer]> == null:
        - definemap message_map:
            color: 201,79,79
            author_name: Entered referrer doesn't exist in the server.
            thumbnail: https://i.imgur.com/G69IfQe.png
        - define message <discord_embed.with_map[<[message_map]>]>
        - ~discordinteraction reply interaction:<context.interaction> <[message]>
        - stop

    # check if player exists
    - define username_arg <context.options.deep_get[username]>
    - define player <server.match_player[<[username_arg]>].if_null[null]>
    - if <[player]> == null:
      - definemap message_map:
          color: 201,79,79
          title: Can't find player named <[username_arg]>!
          description: You must be online in Noodle Realms to be able to link your account. Join now using the IP<&co> __**NOODLEREALMS.COM**__.
          thumbnail: https://i.imgur.com/G69IfQe.png
      - define message <discord_embed.with_map[<[message_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[message]>
      - stop

    # check if player == referrer
    - if <[referrer].name> == <[username_arg]>:
      - definemap message_map:
          color: 201,79,79
          author_name: You can't refer your own self.
          author_icon_url: https://i.imgur.com/G69IfQe.png
      - define message <discord_embed.with_map[<[message_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[message]>
      - stop

    # player found
    - definemap message_map:
        color: 201,79,79
        thumbnail: https://mc-heads.net/avatar/<[player].name>.png
        description: Copy and paste the command below and execute it in-game to complete the process ```/link <[user].id>```
        footer: Referrer: <[referrer].name.if_null[N/A]>
        footer_icon: https://mc-heads.net/avatar/<[referrer].name.if_null[N/A]>.png
    - define message <discord_embed.with_map[<[message_map]>]>
    - ~discordinteraction reply interaction:<context.interaction> <[message]>

    - flag server discord_verification.<[player].name>:<[user].id> duration:5m
    - flag server discord_referrer.<[player].name>:<[referrer]> duration:5m

# on the minecraft side of things
verification_minecraft_cmd:
  type: command
  debug: false
  name: link
  description: Links Minecraft account with Discord on SkyPinas
  usage: /link (Discord ID)
  script:
  - define args <context.args>
  - define accounts_to_link <server.flag[discord_verification]>
  - define accounts_to_refer <server.flag[discord_referrer]>

  - if <server.flag[discord_verified].contains_any[<player.name>]>:
    - narrate "It seems that you have already been verified. If you think this is an error, contact a staff on Discord." format:error
    - stop

  - if <[accounts_to_link].keys.contains[<player.name>].not>:
    - narrate "Join our Discord community and start the linking process. Read the topmost channel #readme." format:error
    - stop

  - if <[args].size> < 1:
    - narrate "You forgot to enter your Discord ID. Correct usage is /link (Discord ID)" format:error
    - stop

  - if <[accounts_to_link].get[<player.name>]> != <[args].get[1]>:
    - narrate "The command that you used does not match the one given by the bot!" format:error
    - stop

  - if <[accounts_to_refer].keys.contains[<player.name>].not>:
    - define referrer null
  - else:
    - define referrer <[accounts_to_refer].get[<player.name>]>

  - flag server discord_verified:->:<player.name>
  - flag server discord_referrer.<player.name>:!

  - define discord_id <[args].get[1]>
  - define discord_user <discord_user[bot,<[discord_id]>]>
  - define discord_role <discord_role[950815231075024898,952258524132560976]>
  - define discord_channel <discord_channel[bot,950815232119435327]>
  - define discord_group <discord_group[bot,950815231075024898]>

  - ~yaml id:discord_verification_data set discord.<[discord_id]>:<player.name>
  - ~yaml savefile:data/discord_verification_data.yml id:discord_verification_data

  - ~discord id:bot add_role user:<[discord_user]> role:<[discord_role]> group:<[discord_group]>
  - ~discord id:bot rename `<player.name> user:<[discord_user]> group:<[discord_group]>

  - definemap message_map:
      color: yellow
      title: Link Successful!
      description: Player **<player.name>** successfully linked with user <[discord_user].mention>!
      thumbnail: https://i.imgur.com/G69IfQe.png
  - define message <discord_embed.with_map[<[message_map]>]>
  - ~discordmessage id:bot channel:<[discord_channel]> <[message]>

  - narrate "Sucessfully linked your Discord Account!" format:noodle

  - flag server referral.<[referrer]>:->:<player.uuid>
  - define player <[referrer].name.if_null[null]>
  - if <[player]> == null:
    - stop

  - execute as_server "eco give <[player]> 150000"
  - execute as_server "crates give v Boketto 1 <[player]>"
  - execute as_server "crates give v Serendipity 1 <[player]>"
  - execute as_server "mr add <[player]> 100"

  - execute as_server "eco give <player.name> 150000"
  - execute as_server "crates give v Boketto 1 <player.name>"
  - execute as_server "crates give v Serendipity 1 <player.name>"
  - execute as_server "mr add <player.name> 100"



# Verification Send Message
verification_send_message:
  type: task
  debug: false
  script:
  - define channel 952235345825640498
  - define data <script[verification_message_data]>
  - define message <[data].data_key[message]>
  - definemap embed_map:
      title: Welcome to Noodle Realms! <&lt>a<&co>noodle<&co>1018046115767124018<&gt>
      color: yellow
      description: <[message].separated_by[<&nl>]>
      thumbnail: https://i.imgur.com/G69IfQe.png
  - define embed <discord_embed.with_map[<[embed_map]>]>
  - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> <[embed]>

verification_message_data:
  type: data
  message:
    - "Please link your Minecraft account with your Discord account so you can access other channels. This is to make sure that you are a player of our server to avoid spam and be able to match player data with Discord."
    - ""
    - "**Steps:**"
    - "**1.** Login to our Minecraft server at **NOODLEREALMS.COM**"
    - ""
    - "**2.** Type the command below in [*verification*](https://discord.com/channels/950815231075024898/950815232119435327) channel while logged into the server."
    - "```/link <minecraft username>```"
    - "If you were referred by an existing player, enter their username so both of you could receive referral reward."
    - "```/link <minecraft username> <referrer username>```"
    - "**3.** Wait to receive a code from the bot in Discord."
    - ""
    - "**4.** Copy and paste the full command from Discord into the Minecraft chat window on our server."
    - ""
    - "**5.** You should now be verified and have access to channels!"
    - ""
    - **Referral Rewards**
    - "Both referrer & referee will receive rewards!"
    - ```• $150,000
    - • 1x Boketto Key
    - • 1x Serendipity Key
    - • 100 mcMMO Credits```