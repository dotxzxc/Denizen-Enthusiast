noodle:
  type: format
  debug: false
  format: <&8>[<&e>Noodle<&8>]<&7> <[text]>

error:
  type: format
  debug: false
  format: <&8>[<&c>!<&8>]<&c> <[text]>

default:
  type: format
  debug: false
  format: <&8>[<&e>!<&8>]<&7> <[text]>

success:
  type: format
  debug: false
  format: <&8>[<&a>!<&8>]<&7> <[text]>

broadcast:
  type: format
  debug: false
  format: <&8>[<&c>Brodcast<&8>]<&e> <[text]>

shop:
  type: format
  debug: false
  format: <&8>[<&a>Shop<&8>]<&f> <[text]>

no_perm:
  type: procedure
  definitions: case
  script:
  - if <[case]||null> == null:
    - define case feature
  - define msg "<&8>[<&c>!<&8>]<&c> Sorry, you don't have any permission to use this <[case]>"
  - determine <[msg]>

premium_only:
  type: procedure
  script:
  - define msg "<&8>[<&c>!<&8>]<&c> Sorry, this feature is only accessible to those who bought premium ranks at store.skypinas.net"
  - determine <[msg]>

discord:
  type: format
  debug: false
  format: <&lb>Discord Bot<&rb> <[text]>

npc:
  type: format
  debug: false
  format: <&7><npc.name> <&8>» <&f><[text]>
