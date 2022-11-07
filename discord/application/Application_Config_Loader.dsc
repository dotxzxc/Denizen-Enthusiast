application_config_loader:
    type: world
    events:
        after server start:
        - run application_config_load

application_config_load:
    type: task
    script:
    - define config_path /.config/Application_Config.yml
    - ~yaml load:<[config_path]> id:discord_applications_config

application_config_reload_command:
    type: command
    name: applicationconfigreload
    description: Reloads Discord Application config.yml file
    usage: /applicationconfigreload
    aliases:
    - tconfigreload
    - tconfreload
    permission: discord.application_config.reload
    script:
    - run application_config_load
    - narrate "Discord application config reloaded!"