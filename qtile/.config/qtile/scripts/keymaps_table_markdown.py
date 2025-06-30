import config

for key in config.keys:
    str = "| "
    for mod in key.modifiers:
        str += "<kbd>" + mod + "</kbd> + "

    str += "<kbd>" + key.key + "</kbd>" + " | " + key.desc + " |"

    print(str)
