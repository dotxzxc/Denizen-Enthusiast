application_panel_create:
    type: task
    debug: false
    definition: channel
    script:
    - define config_data <yaml[discord_applications_config].read[discord_applications_config]>
    - define application_panel_config <[config_data].get[application-panel]>
    - define application_embed_message <discord_embed.with_map[<[application_panel_config]>]>

    # generate fields for categories, buttons, and dropdown menus
    - define application_categories <[config_data].get[categories]>
    - define application_buttons <list>
    - define application_dropdown_menus <list>
    - foreach <[application_categories]>:
        - define category <[key]>
        - define title <[value].get[title]>
        - define description <[value].get[description]>
        - define emoji <[value].get[emoji]>

        # dropdown menu
        #- if <[value].keys.contains[options]>:
        - define selection_options <map>
        - foreach <[value].get[options]>:
            - define selection_options <[selection_options].with[<[value]>].as[<map[value=<[value]>;label=<[value]>;description=<[value]>;emoji=<[emoji]>]>]>
        - define menu "<discord_selection.with[id].as[<[category]>].with[options].as[<[selection_options]>].with[placeholder].as[<[emoji]> <[category]>]>"
        - define application_dropdown_menus <[application_dropdown_menus].include[<[menu]>]>
        # buttons
        #- else:
        #    - definemap button_map:
        #        style: <[config_data].get[categories-button-style]>
        #        id: <[category]>
        #        label: <[title]>
        #        emoji: <[emoji]>
        #    - define button <discord_button.with_map[<[button_map]>]>
        #    - define application_buttons <[application_buttons].include[<[button]>]>

        - define application_embed_message <[application_embed_message].add_field[<[title]>].value[<[description].separated_by[<&nl>]>]>

    #- ~discordmessage id:bot channel:<[channel]> <[application_embed_message]> rows:<[application_dropdown_menus]>
    - define panel_interactables <list_single[<[application_dropdown_menus]>]>
    - ~discordmessage id:bot channel:<[channel]> <[application_embed_message]> rows:<[panel_interactables]> save:message
    - flag <entry[message].message> is_application_panel:true


application_panel_handler:
    type: world
    debug: false
    events:
        on discord selection used for:bot:
        - if <context.message.has_flag[is_application_panel]>:
            - define category <context.menu.map.get[id]>
            - define option <context.option.get[value]>
            - define interaction <context.interaction>
            - flag <[interaction]> application_category:<[category]>
            - flag <[interaction]> application_category_id:<[category]>-<[option]>
            - run application_modal_create def.interaction:<[interaction]>