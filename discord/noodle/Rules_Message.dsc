##ignorewarning stray_space_eol
##ignorewarning identifier_missing_line
##ignorewarning weird_line_growth
bot_rules_message_send:
  type: task
  debug: false
  script:
  - define channel 1024511419598782495
  - define data <script[bot_rules_message_data]>
  - define message <[data].data_key[message]>
  - definemap embed_map:
      title: Noodle Realms Rules 📜
      color: yellow
      description: <[message].separated_by[<&nl>].replace_text[|].with[<&co>]>
      thumbnail: https://i.imgur.com/G69IfQe.png
  - define embed <discord_embed.with_map[<[embed_map]>]>
  - ~discordmessage id:noodle channel:<discord_channel[<[channel]>]> <[embed]>

bot_rules_message_data:
  type: data
  message:
    - **Glitches, Exploits and Unbalanced Features**
    - Use the channel [*bug*](https://discord.com/channels/950815231075024898/953600611390205972) to report glitches, exploits and unbalanced features. Abusing them will get you banned, but reporting them might get you rewarded!
    - 
    - **Reporting Players**
    - Use the channel [*player*](https://discord.com/channels/950815231075024898/1023797914063097916) to report players that are breaking the rules. This helps us keep the server fun for everyone.
    - 
    - >  • Staff reserves the right to punish users, even if the issue resides outside of these rules.
    - >  • Posting pornographic, distasteful, or excessively violent content is not allowed.
    - >  • Spamming or excessively sending messages, including repeating questions is not tolerated.
    - >  • Do not impersonate. Pretending to be a staff member is especially prohibited.
    - >  • Do not build any “Phallic”, “Sexual” or “Inappropriate” builds.
    - >  • Do not use language which can be reasonably considered discriminatory.
    - >  • Do not advertise other Discord or Minecraft servers.
    - >  • Do not ping staff without a valid reason.
    - >  • The use of alternate accounts is not allowed.
    - >  • Any form of cheating is not allowed.
    - >  • Avoid discussions and disclosure of private information.
    - >  • Avoid having inappropriate usernames/nicknames/profile pictures and using inappropriate reactions.
    - 
    - Moderators have leeway to interpret these rules and act in the best interests of the guild as a whole. 
    - 
    - Violating any of those rules can result in a warning, a kick, and/or a ban at the moderation's discretion. Ignorance of these rules is not a defense.
    -
    - **Server IP**| __noodlerealms.com__
    - **Website**| [https://noodlerealms.com](http://noodlerealms.com)
    - **Discord**| [https://discord.noodlerealms.com](http://discord.noodlerealms.com)
    - **Store**| [https://store.noodlerealms.com](http://store.noodlerealms.com)
    - **Wiki**| [https://wiki.noodlerealms.com](http://wiki.noodlerealms.com)