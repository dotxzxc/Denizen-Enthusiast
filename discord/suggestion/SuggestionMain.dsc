# Create /suggest command
create_suggest_cmd:
  type: task
  script:
    - definemap options:
        1:
          type: string
          name: suggestion
          description: What is your suggestion?
          required: true

    - ~discordcommand id:bot create name:suggest "description:Make a suggestion." group:950815231075024898 options:<[options]>

suggest_cmd:
    type: command
    usage: /suggest
    name: suggest
    debug: false
    description: Send a suggestion
    script:
    - define channel 953388734206844968
    - define suggestion <context.raw_args>

    - if <context.args.size> == 0:
      - narrate "Correct usage: /suggest <&lt>suggestion<&gt>" format:error
      - stop

    - if <[suggestion].length> < 5:
      - narrate "Suggestion must be greater than 5 characters." format:error
      - stop

    - define author <player.name>
    - define author_url https://mc-heads.net/avatar/<player.name>.png

    - narrate "Your suggestion has sent to #suggestions channel on Minecast Discord!" format:success

    - definemap embed_map:
        author_name: <[author]>'s Suggestion
        author_icon_url: <[author_url]>
        color: yellow
        description: <[suggestion]>
        footer: Status: Pending
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - definemap button_map:
        1:
          style: success
          id: Accepted
          label: Accept
          emoji: 👍
        2:
          style: danger
          id: Denied
          label: Deny
          emoji: 👎

    - define button_list <list>
    - foreach <[button_map]>:
      - define my_button <discord_button.with_map[<[value]>]>
      - define button_list <[button_list].include[<[my_button]>]>

    - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> rows:<list_single[<[button_list]>]> <[embed]> save:sent
    - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:✅
    - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:❌
    - define url <entry[sent].message.url.after[https://discord.com/channels/]>

    - ~yaml id:discord_suggestion_data set <[url]>.author:<[author]>
    - ~yaml id:discord_suggestion_data set <[url]>.author_url:<[author_url]>
    - ~yaml id:discord_suggestion_data set <[url]>.description:<[suggestion]>
    - ~yaml savefile:data/discord_suggestion_data.yml id:discord_suggestion_data

suggestion_cmd_handler:
  type: world
  debug: false
  events:
    on discord slash command name:suggest:
    - define channel 953388734206844968
    - define suggestion <context.options.deep_get[suggestion]>
    - define author <context.interaction.user.nickname[<context.group>].substring[2]||<context.interaction.user.name>>
    - define author_url <context.interaction.user.avatar_url>
    - define author_id <context.interaction.user.id>

    - ~discordinteraction defer interaction:<context.interaction>

    - definemap replyembed_map:
        color: yellow
        description: "Your suggestion has sent to <&lt>#953388734206844968<&gt>!"
    - define reply_embed <discord_embed.with_map[<[replyembed_map]>]>

    - ~discordinteraction reply interaction:<context.interaction> <[reply_embed]> ephemeral:true

    - definemap embed_map:
        author_name: <[author]>'s Suggestion
        author_icon_url: <context.interaction.user.avatar_url>
        color: yellow
        description: <[suggestion]>
        footer: Status: Pending
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - definemap button_map:
        1:
          style: success
          id: Accepted
          label: Accept
          emoji: 👍
        2:
          style: danger
          id: Denied
          label: Deny
          emoji: 👎

    - define button_list <list>
    - foreach <[button_map]>:
      - define my_button <discord_button.with_map[<[value]>]>
      - define button_list <[button_list].include[<[my_button]>]>

    - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> rows:<list_single[<[button_list]>]> <[embed]> save:sent
    - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:✅
    - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:❌
    - define url <entry[sent].message.url.after[https://discord.com/channels/]>

    - ~yaml id:discord_suggestion_data set <[url]>.author:<[author]>
    - ~yaml id:discord_suggestion_data set <[url]>.author_url:<[author_url]>
    - ~yaml id:discord_suggestion_data set <[url]>.author_id:<[author_id]>
    - ~yaml id:discord_suggestion_data set <[url]>.description:<[suggestion]>
    - ~yaml savefile:data/discord_suggestion_data.yml id:discord_suggestion_data

suggestion_button_handler:
  type: world
  debug: false
  events:
    on discord button clicked for:bot channel:953388734206844968:
    - define decision <context.button.map.deep_get[id]>
    - define by <context.interaction.user.nickname[<context.group>].substring[2]||<context.interaction.user.name>>
    - define user_roles <context.interaction.user.roles[<context.group>]>

    - define staff <list[952258497360314418]>

    - if <[user_roles].contains_any_text[<[staff]>]>:
      - define url <context.message.url.after[https://discord.com/channels/]>
      - define message_id <context.message.id>
      - define data <yaml[discord_suggestion_data].read[<[url]>]>
      - define description <[data].get[description]>
      - define author <[data].get[author]>
      - define author_url <[data].get[author_url]>

      - if <[decision]> == Accepted:
        - define channel 953388759104233532
        # Rewards
        - execute as_server "eco give <[author]> 100000"
        - execute as_server "crates give v Boketto 1 <[author]>"
        - execute as_server "crates give v Serendipity 1 <[author]>"

      - if <[decision]> == Denied:
        - define channel 953388824606679054

      - define embed <context.message.embed.get[1]>
      - define embed "<[embed].with[author_name].as[<[decision]> <[author]>'s suggestion]>"
      - define embed "<[embed].with[footer].as[Status: <[decision]> by <[by]>]>"

      - ~discordinteraction reply interaction:<context.interaction> "Suggestion has been <[decision].to_lowercase>." ephemeral:true
      - ~discordmessage id:bot edit:<[message_id]> channel:<context.channel> <[embed]>
      - ~discordmessage id:bot channel:<[channel]> <[embed]>
      - adjust <discord_message[<context.message>]> delete

    - else:

      - ~discordinteraction reply interaction:<context.interaction> "You're not allowed to accept or deny a suggestion." ephemeral:true