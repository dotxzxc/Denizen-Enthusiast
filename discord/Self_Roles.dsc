self_role_button_handler:
  type: world
  debug: false
  events:
    on discord button clicked for:bot channel:1019595120649195540:
    - define by <context.interaction.user.nickname[<context.group>].substring[2]>
    - define player <server.match_player[<[by]>].if_null[null]>
    - define rank <context.button.map.deep_get[id]>
    - define normal_roles <script[normal_roles_data].data_key[list]>
    - define premium_roles <script[premium_roles_data].data_key[list]>

    - if <[player]> == null:
      - define message "You must be online to claim a role."

    - if <player[<[player]>].has_permission[noodlerealms.rank.<[rank]>]>:
      - foreach <context.interaction.user.roles[<context.group>].filter[contains_any_text[<[normal_roles]>]]>:
        - ~discord id:bot remove_role user:<context.interaction.user> role:<[value]> group:<context.group>

      - foreach <context.interaction.user.roles[<context.group>].filter[contains_any_text[<[premium_roles]>]]>:
        - ~discord id:bot remove_role user:<context.interaction.user> role:<[value]> group:<context.group>

      - define role <context.group.role[<[rank]>]>
      - ~discord id:bot add_role user:<context.interaction.user> role:<[role]> group:<context.group>
      - define message "Role <&lt><&at>&<[role].after[950815231075024898,]><&gt> has been added to you."
    - else:
      - define message "You don't have the permission to claim this role."

    - definemap embed_map:
        color: yellow
        description: <[message]>
    - define embed <discord_embed.with_map[<[embed_map]>]>
    - ~discordinteraction reply interaction:<context.interaction> <[embed]> ephemeral:true

normal_roles_data:
    type: data
    list:
    - 1019606192684814346
    - 1019606243100344370
    - 1019606262222176377
    - 1019606298993643581
    - 1019606315942826014
    - 1019606337652543620
    - 1019606356262649946
    - 1019606374281400431
    - 1019606392862167071
    - 1019567986216022056

premium_roles_data:
    type: data
    list:
    - 1019840426301198438
    - 1019840640776937482
    - 1019840500167082044
    - 1019840549534048266
    - 1019840581465288785

# Send button message
self_role_task:
    type: task
    debug: false
    script:
    - define channel 1019595120649195540

    - definemap embed_map:
        color: yellow
        title: Click the button below to claim role.
    - define embed <discord_embed.with_map[<[embed_map]>]>

    - definemap button_map:
        1:
          style: secondary
          id: VI
          label: VI
        2:
          style: secondary
          id: VII
          label: VII
        3:
          style: secondary
          id: VIII
          label: VIII
        4:
          style: secondary
          id: IX
          label: IX
        5:
          style: secondary
          id: X
          label: X

    - define button_list <list>
    - foreach <[button_map]>:
      - define my_button <discord_button.with_map[<[value]>]>
      - define button_list <[button_list].include[<[my_button]>]>

    - ~discordmessage id:bot channel:<discord_channel[<[channel]>]> rows:<list_single[<[button_list]>]> <[embed]>