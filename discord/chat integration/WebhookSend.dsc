webhook_send:
    type: task
    debug: false
    definitions: message|url|rank|username|avatar
    script:
    - definemap data:
        username: "[<[rank]>] <[username]>"
        avatar_url: <[avatar]>
        content: <[message]>
    - ~webget <[url]> headers:<map.with[Content-Type].as[application/json]> data:<[data].to_json>