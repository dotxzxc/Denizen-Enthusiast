suggestion_message:
  type: task
  debug: false
  script:
    - define channel 1026687750948261929
    - define data <script[bot_suggestion_message_data]>
    - define message <[data].data_key[message]>
    - definemap embed_map:
        title: Click the button below to create a suggestion
        color: yellow
        description: <[message].separated_by[<&nl>]>
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - define button "<discord_button.with[style].as[primary].with[id].as[create_suggestion].with[label].as[📧 Create Suggestion]>"
    - ~discordmessage id:bot channel:<[channel]> rows:<[button]> <[embed]>

suggest_create_button_handler:
  type: world
  debug: false
  events:
    on discord button clicked for:bot channel:1026687750948261929 id:create_suggestion:
    - inject suggestion_create_modal

    on discord modal submitted name:create_suggestion for:bot:
    - ~discordinteraction defer interaction:<context.interaction> ephemeral:true

    - define channel 953388734206844968
    - define suggestion <context.values.get[suggestion]>
    - define author <context.interaction.user.nickname[<context.group>].substring[2]||<context.interaction.user.name>>
    - define author_url <context.interaction.user.avatar_url>
    - define author_id <context.interaction.user.id>

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

suggestion_create_modal:
  type: task
  debug: false
  script:
    - definemap modal:
        1:
          1: <discord_text_input.with[id].as[suggestion].with[label].as[What is your suggestion].with[style].as[paragraph].with[placeholder].as[Type your suggestion here]>
    - ~discordmodal interaction:<context.interaction> name:create_suggestion "title:Create Suggestion" rows:<[modal]>

bot_suggestion_message_data:
  type: data
  message:
    - **Rules:**
    -   • No troll or absurd suggestions.
    -   • No suggestions telling us to promote / demote someone.
    -   • Your suggestion may exist already, do a simple search.
    -   • Don't suggest saying to 'fix' something, [*bug*](https://discord.com/channels/950815231075024898/953600611390205972) channel exist for a reason.
    - 
    - **Rewards for approved suggestion:**
    -   • $100,000
    -   • 1x Boketto Key
    -   • 1x Serendipity Key