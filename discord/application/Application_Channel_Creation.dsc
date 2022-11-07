##ignorewarning stray_space_eol
application_channel_create:
    type: task
    debug: false
    definitions: category|modal_inputs|interaction
    script:
    - define config_data <yaml[discord_applications_config].read[discord_applications_config]>
    - define category_assigned <[config_data].get[category-assignment].get[<[category]>]>

    - define application_creator <[interaction].user>
    - define application_channel_name application-<[application_creator].name>
    - define description "Applicated submitted by:<[application_creator].mention> on:<util.time_now.to_utc.format> UTC category:<[category]>"
    #- define assigned_roles <[config_data].get[roles-assignment]>
    #- define assigned_roles <[assigned_roles].get[<[category]>].if_null[<[assigned_roles].get[default]>]>
    - define group <[interaction].channel.group>

    - ~discordcreatechannel id:bot group:<[group]> name:<[application_channel_name]> category:<[category_assigned]> description:<[description]> users:<[application_creator].id> save:channel
    - flag <entry[channel].channel> is_application_channel:true
    - flag <entry[channel].channel> application_created:<util.time_now.to_utc.format[yyyy/MM/dd-HH:mm]>
    - flag <entry[channel].channel> application_category:<[category]>
    - flag <entry[channel].channel> application_creator:<[interaction].user.name> application_channel_log

    # first channel message
    - definemap initial_message_map:
        title: <[category].replace_text[-].with[<&co> ].to_titlecase>
        color: <[config_data].get[embedded-initial-message].get[color]>
        footer_icon: <[application_creator].avatar_url>
        footer: <[application_creator].name>
        timestamp: <util.time_now.to_utc>
    - define embedded_initial_message <discord_embed.with_map[<[initial_message_map]>]>
    - foreach <[modal_inputs]>:
        - define question <[config_data].get[input-forms].get[<[category]>].get[<[key]>]>
        - define answer <[value]>
        - define embedded_initial_message <[embedded_initial_message].add_field[<[question]>].value[```<[answer]>```]>
        - flag <entry[channel].channel> "application_channel_log:->:<[question]><&co> <[answer]>"
    # resolved button
    - define button_approve <discord_button.with_map[<[config_data].get[embedded-initial-message].get[button_approve]>]>
    - define button_deny <discord_button.with_map[<[config_data].get[embedded-initial-message].get[button_deny]>]>
    - define embedded_initial_message "<[embedded_initial_message].add_field[Submitted by].value[<[application_creator].mention>]>"
    #- define parsed_assigned_roles <[assigned_roles].parse_tag[<discord_role[<[group].id>,<[parse_value]>].mention>]>
    #- define parsed_assigned_roles <[assigned_roles].parse_tag[<&lt>@&<[parse_value]><&gt>].separated_by[<&sp>]>
    #- define embedded_initial_message "<[embedded_initial_message].add_field[Assigned to].value[<[parsed_assigned_roles]>]>"

    - ~discordmessage id:bot channel:<entry[channel].channel> <[embedded_initial_message]> rows:<list_single[<[button_approve]>|<[button_deny]>]>

    - define channel_creation_message "Your application has been submitted, wait for a few days to get a respond."
    - ~discordinteraction reply interaction:<[interaction]> <[channel_creation_message]> ephemeral:true


application_channel_resolved_button:
    type: world
    debug: false
    events:
        after discord button clicked for:bot:
        - define channel <context.channel>
        - if <[channel].has_flag[is_application_channel]> && <[channel].has_flag[application_channel_log]>:
            - define config_data <yaml[discord_applications_config].read[discord_applications_config]>

            - define application_channel_id <[channel].flag[application_created]>_<[channel].flag[application_category]>_<[channel].flag[application_creator]>
            - define application_creator <context.group.member[<[channel].flag[application_creator]>]>
            - define application_position <[channel].flag[application_category].after[Position-].to_sentence_case>

            - define user_roles <context.interaction.user.roles[<context.group>]>
            - define role <list[952258497360314418]>

            - if <[user_roles].contains_any_text[<[role]>]>:
                - define button_id <context.button.map.get[id]>
                - if <[button_id]> == close:
                    - definemap rejection_message:
                        format:
                        - Dear <[application_creator].name>,
                        - 
                        - Thank you for taking the time to apply for the <[application_position]> position at Noodle Realms. We appreciate your interest in joining the team. At this time, we will not be moving forward with your application.
                        - 
                        - We're encourage you to apply again in the future!
                        - 
                        - Sincerely,
                        - Dotxzxc
                        - Administrator
                        - Noodle Realms
                    - define message <[rejection_message].get[format].separated_by[<&nl>]>
                    - definemap rejection_message:
                        author_name: Application Rejected
                        author_icon_url: https://i.imgur.com/G69IfQe.png
                        color: yellow
                        description: <[message]>
                    - define rejection_message <discord_embed.with_map[<[rejection_message]>]>
                    - ~discordmessage id:bot user:<[application_creator]> <[rejection_message]>
                
                - if <[button_id]> == approve:
                    - definemap approved_message:
                        format:
                        - Dear <[application_creator].name>,
                        - 
                        - Congratulations, your <[application_position]> application has been approved!
                        - 
                        - Welcome to the Noodle Realms staff team!
                        - 
                        - Sincerely,
                        - Dotxzxc
                        - Administrator
                        - Noodle Realms
                    - define message <[approved_message].get[format].separated_by[<&nl>]>
                    - definemap approved_message:
                        author_name: Application Approved!
                        author_icon_url: https://i.imgur.com/G69IfQe.png
                        color: yellow
                        description: <[message]>
                    - define approved_message <discord_embed.with_map[<[approved_message]>]>
                    - ~discordmessage id:bot user:<[application_creator]> <[approved_message]>

                - define clicker <context.interaction.user>
                - define logging_channel <discord_channel[<[config_data].get[application-logging].get[log-channel]>]>
                - ~discordmessage id:bot channel:<[logging_channel]> "<[channel].flag[application_category]> application closed by <[clicker].mention>" attach_file_name:<[application_channel_id]>.txt attach_file_text:<[channel].flag[application_channel_log].separated_by[<&nl>]>
                - adjust <[channel]> delete

            - else:
                - ~discordinteraction reply interaction:<context.interaction> "You don't have the permission to deny or approve an application." ephemeral:true

application_channel_logger:
    type: world
    debug: false
    events:
        after discord message received for:bot:
        - if <context.channel.has_flag[is_application_channel]>:
            - define author_name <context.new_message.author.name>
            - define message_text <context.new_message.text>
            - define date <util.time_now.to_utc.format>
            - flag <context.channel> "application_channel_log:->:<[date]> <[author_name]><&co> <[message_text]>"