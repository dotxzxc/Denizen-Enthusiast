join_leave_message:
  type: world
  debug: false
  events:
    on player joins:
    - determine none passively
    - define rank <placeholder[luckperms_primary_group_name].to_uppercase>
    - if <[rank]> == DEFAULT:
        - define rank Noodle
    - if <[rank]> == DEV:
        - define rank Dev
    #- announce "<&8>[<&7><[rank]><&8>] <&7><player.name> joined"
    - announce "<&a>+ <&7><player.name>"

    on player quits:
    - determine none passively
    - define rank <placeholder[luckperms_primary_group_name].to_uppercase>
    - if <[rank]> == DEFAULT:
        - define rank Noodle
    - if <[rank]> == DEV:
        - define rank Dev
    #- announce "<&8>[<&7><[rank]><&8>] <&7><player.name> left"
    - announce "<&c>- <&7><player.name>"