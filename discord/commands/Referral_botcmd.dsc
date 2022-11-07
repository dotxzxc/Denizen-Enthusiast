create_referral_cmd:
  type: task
  script:
    - define group 950815231075024898
    - definemap options:
        1:
          type: string
          name: username
          description: Enter Minecraft Username to check referral score
          required: true

    - ~discordcommand id:bot create group:<[group]> name:referral "description:Check referral score" options:<[options]>

# yaml data discord_verification_data
# on key "discord"
referral_discord_cmd:
  type: world
  debug: false
  events:
    on discord slash command name:referral:
    - ~discordinteraction defer interaction:<context.interaction>

    - define username <context.options.deep_get[username]>
    - define player <server.match_offline_player[<[username]>].if_null[null]>
    - if <[player]> == null:
      - definemap message_map:
          color: 201,79,79
          author_name: Can't find player named <[username]>!
      - define message <discord_embed.with_map[<[message_map]>]>
      - ~discordinteraction reply interaction:<context.interaction> <[message]>
      - stop

    # player found
    - definemap message_map:
        color: yellow
        author_name: <[player].name>'s referral score is <server.flag[referral.<[player]>].size.if_null[0]>
        author_icon_url: https://mc-heads.net/avatar/<[player].name>.png
    - define message <discord_embed.with_map[<[message_map]>]>
    - ~discordinteraction reply interaction:<context.interaction> <[message]>

    on discord slash command name:referraltop:
    - ~discordinteraction defer interaction:<context.interaction>

    - define top_players <server.flag[referral].sort_by_value[size].reverse>
    - define top_5 <list>
    - foreach <[top_players]>:
      - if <[loop_index]> >= 5:
        - foreach stop
      - define top_5 "<[top_5].include[#<[loop_index]> <[key].name> » <[value].size>]>"

    - definemap message_map:
        color: yellow
        title: Referrer Leaderboard 🏆
        description: "```<[top_5].separated_by[<&nl>]>```"
    - define message <discord_embed.with_map[<[message_map]>]>
    - ~discordinteraction reply interaction:<context.interaction> <[message]>

create_referraltop_cmd:
  type: task
  debug: false
  script:
    - define group 950815231075024898

    - ~discordcommand id:bot create group:<[group]> name:referraltop "description:Check referral top score"