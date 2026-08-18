def parse_fg_list(value):
    if value is None or value == "":
        return None
    separator = ";" if ";" in value else ","
    return [int(x) for x in value.split(separator)]
