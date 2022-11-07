application_modal_create:
    type: task
    debug: false
    definitions: interaction
    script:
    - define application_category <[interaction].flag[application_category_id]>
    - define config_data <yaml[discord_applications_config].read[discord_applications_config]>
    - define category_input_forms <[config_data].get[input-forms].get[<[application_category]>]>
    - define input_forms <list>
    - foreach <[category_input_forms]>:
        - define form <discord_text_input.with[style].as[short]>
        - define label <[value].substring[1,45]>
        - define form <[form].with[id].as[<[key]>].with[label].as[<[label]>]>
        - define input_forms <[input_forms].include[<[form]>]>
    - ~discordmodal interaction:<[interaction]> name:<[application_category].to_titlecase> "title:<[application_category].to_titlecase> application!" rows:<[input_forms]>


application_modal_events_handler:
    type: world
    debug: false
    events:
        on discord modal submitted for:bot:
        - define category <context.name>
        - define config_data <yaml[discord_applications_config].read[discord_applications_config]>
        - if <[config_data].get[input-forms].contains[<[category]>]>:
            - define modal_inputs <context.values>
            - define interaction <context.interaction>
            - ~discordinteraction defer interaction:<[interaction]> ephemeral:true
            - run application_channel_create def:<[category]>|<[modal_inputs]>|<[interaction]>