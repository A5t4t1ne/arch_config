assemblyTimeStamps = [
    17097380490166623672,
    15194901817027173566,
    12718416789200275332,
    18392881921099771407,
    3626142665768487764,
    12343334044036541897,
    397780960855462669,
    6943102301517884811,
    13544031715334011032,
    11801746708619571308,
    18159703063075866524,
    835151375515278827,
    16570804352575357627,
    1614465773938842903,
    12679195163651834776,
    2717025511528702475,
    17984632978012874803,
]

known_debug_tool_names = [
    "binaryninja",
    "cutter",
    "ida",
    "ghidra",
    "wireshark",
    "radare2",
]

import ctypes


def get_hash(s):
    num1 = ctypes.c_ulonglong(14695981039346656037)
    try:
        for num2 in s.encode("utf-8"):
            num1.value ^= num2
            num1.value *= 1099511628211
    except:
        pass
    return ctypes.c_ulonglong(num1.value ^ 6605813339339102567).value
