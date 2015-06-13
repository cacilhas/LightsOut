love.conf = (t) ->
    with t
        .version = "0.9.1"
        .identity = "lightsout"

    with t.window
        .title = "LightsOut"
        .icon = "images/lightsout.png"
        .width = 160
        .height = 160
        .fullscreen = false
