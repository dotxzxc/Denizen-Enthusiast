# Create /poll command
create_poll_cmd:
  type: task
  debug: false
  script:
    - define group <script[bot_data_config].data_key[config].get[group-id]>
    - definemap options:
        1:
          type: string
          name: poll
          description: Create a poll
          required: true

    - ~discordcommand id:bot create name:poll "description:Make a poll." group:<[group]> options:<[options]>

poll_cmd_handler:
  type: world
  debug: false
  events:
    on discord slash command name:poll:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true

    - define channel <script[bot_data_config].data_key[config].get[poll-channel-id]>
    - define role_permitted <script[bot_data_config].data_key[config].get[role-permitted-id]>
    - define user_roles <context.interaction.user.roles[<context.group>]>

    - define poll <context.options.deep_get[poll]>
    - define author <context.interaction.user.nickname[<context.group>].substring[2]||<context.interaction.user.name>>
    - define author_url <context.interaction.user.avatar_url>
    - define author_id <context.interaction.user.id>

    - if <[user_roles].contains_any_text[<[role_permitted]>]>:

      - definemap replyembed_map:
          color: yellow
          description: "Your poll has sent to <&lt>#<[channel]><&gt>!"
      - define reply_embed <discord_embed.with_map[<[replyembed_map]>]>

      - ~discordinteraction reply interaction:<context.interaction> <[reply_embed]>

      - define message <[poll]>

      - definemap button_map:
          1:
            style: success
            id: Approved
            label: Approve
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

      - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> rows:<list_single[<[button_list]>]> <[message]> save:sent
      - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:✅
      - ~discordreact id:bot message:<entry[sent].message.id> channel:<entry[sent].message.channel> add reaction:❌
      - define url <entry[sent].message.url.after[https://discord.com/channels/]>

      - ~yaml id:discord_poll_data set <[url]>.author:<[author]>
      - ~yaml id:discord_poll_data set <[url]>.author_url:<[author_url]>
      - ~yaml id:discord_poll_data set <[url]>.author_id:<[author_id]>
      - ~yaml id:discord_poll_data set <[url]>.description:<[poll]>
    - ~yaml savefile:data/discord_poll_data.yml id:discord_poll_data

    - else:
      - ~discordinteraction reply interaction:<context.interaction> "You're not allowed to use this command." ephemeral:true

poll_button_handler:
  type: world
  debug: false
  events:
    on discord button clicked for:bot channel:1025206759792578581:
    - define channel <script[bot_data_config].data_key[config].get[poll-channel-admin-id]>
    - define role_permitted <script[bot_data_config].data_key[config].get[role-permitted-id]>
    - define user_roles <context.interaction.user.roles[<context.group>]>

    - define decision <context.button.map.deep_get[id]>
    - define by <context.interaction.user.nickname[<context.group>].substring[2]||<context.interaction.user.name>>

    - if <[user_roles].contains_any_text[<[role_permitted]>]>:
      - define url <context.message.url.after[https://discord.com/channels/]>
      - define message_id <context.message.id>
      - define data <yaml[discord_poll_data].read[<[url]>]>
      - define description <[data].get[description]>
      - define author <[data].get[author]>
      - define author_url <[data].get[author_url]>

      - inject polls_format
      - ~discordmessage id:bot channel:<[channel]> <[message]>

      - ~discordinteraction reply interaction:<context.interaction> "Poll has been <[decision].to_lowercase>." ephemeral:true
      - adjust <discord_message[<context.message>]> delete

    - else:
      - ~discordinteraction reply interaction:<context.interaction> "You're not allowed to use this button." ephemeral:true