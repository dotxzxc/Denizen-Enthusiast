shoprequest_cmd:
  type: command
  debug: false
  name: shoprequest
  usage: /shoprequest
  aliases:
  - rp
  description: command to request price
  script:
  - define by <player.name>
  - define item <context.args.get[1]>
  - define buy <context.args.get[2]>
  - define sell <context.args.get[3]>
  - define reason <context.raw_args.after[<context.args.get[3]>]>

  - if <context.args.size> <= 2:
    - narrate "Correct usage /shoprequest <&lt>item<&gt> <&lt>buy<&gt> <&lt>sell<&gt> <&lt>reason<&gt>" format:error
    - stop

  - definemap format:
      requestformat:
      - **Request by: <[by]>**
      - **Item:** <[item]>
      -   **Buy:** <[buy]>
      -   **Sell:** <[sell]>
      -   **Reason:** <[reason]>

  - define message <[format].get[requestformat].separated_by[<&nl>]>

  - ~discordmessage id:bot channel:<discord_channel[1026677115749404842]>  <[message]>
  - narrate "Your request has been successfully sent." format:success