credits_command:
  type: command
  debug: false
  name: credits
  usage: /credits
  description: morphredeem credits
  aliases:
  - credit
  script:
  - if <context.args.size> == 0:
    - execute as_player "morphredeem"
    - stop
  - if <context.args.get[1]> == send:
    - if <context.args.size> >= 3:
        - define player <server.match_offline_player[<context.args.get[2]>].if_null[null]>
        - define amount <context.args.get[3]>

        - if <[player]> == null:
            - narrate "I couldn't find the player." format:error
            - stop

        - if <[amount].is_integer.not>:
            - narrate "Amount must be numerical" format:error
            - stop

        - execute as_player "mr send <[player].name> <[amount]>"

    - else:
        - narrate "Correct usage /credits send <&lt>player<&gt> <&lt>amount<&gt>" format:error

  - else:
    - narrate "Correct usage /credits send <&lt>player<&gt> <&lt>amount<&gt>" format:error