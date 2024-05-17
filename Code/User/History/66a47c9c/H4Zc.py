hashes = [
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


def hash(s: str):
    num1 = 14695981039346656037
    try:
        for num2 in s.encode("utf-8"):
            num1 ^= num2
            num1 *= 1099511628211
    except:
        pass

    return num1 ^ 6605813339339102567


# def reverse_hash(hash_value) -> str:
#     initial_hash = 14695981039346656037
#     prime_number = 1099511628211
#     xor_value = 6605813339339102567
#
#     # Undo the final XOR operation
#     intermediate_hash = hash_value ^ xor_value
#
#     # Divide the hash value by the prime number repeatedly until the result is less than the prime number
#     bytes_list = []
#     while intermediate_hash >= prime_number:
#         remainder = intermediate_hash % prime_number
#         bytes_list.append(remainder)
#         intermediate_hash //= prime_number
#
#     # Undo the XOR operation for the last byte
#     bytes_list.append(intermediate_hash)
#
#     # Reconstruct the original string
#     original_string = b"".join(bytes(reversed(bytes_list))).decode("utf-8")
#     return original_string


# def reverse_hash(hash_value):
#     initial_hash = 14695981039346656037
#     prime_number = 1099511628211
#     xor_value = 6605813339339102567
#
#     # Undo the final XOR operation
#     intermediate_hash = hash_value ^ xor_value
#
#     # Divide the hash value by the prime number repeatedly until the result is less than the prime number
#     bytes_list = []
#     while intermediate_hash >= prime_number:
#         remainder = int(intermediate_hash % prime_number)
#         bytes_list.append(remainder)
#         intermediate_hash //= prime_number
#
#     # Undo the XOR operation for the last byte
#     bytes_list.append(int(intermediate_hash))
#
#     # Reconstruct the original string
#     original_string = b"".join(bytes_list[0].to_bytes(2, "big")).decode("utf-8")
#     return original_string


def reverse_hash(hash_value):
    CTXT_START_OFFSET = 0x30
    KEY_LENGTH = 0x96
    PREV_CTXT_BYTE_INITIAL_DEFAULT = 0xCC

    ciphertext = hash_value.to_bytes(0x20, "big")
    plaintext = bytearray(len(ciphertext))
    key = bytearray(KEY_LENGTH)

    prev_ctxt_byte = PREV_CTXT_BYTE_INITIAL_DEFAULT
    for i, ctxt_byte in enumerate(ciphertext[CTXT_START_OFFSET:]):
        ptxt_byte = ctxt_byte ^ (prev_ctxt_byte ^ key[i % KEY_LENGTH])
        plaintext[i] = ptxt_byte
        prev_ctxt_byte = ctxt_byte

    return plaintext.decode("utf-8")


# print(reverse_hash(hashes[0]))

# print(hash("apimonitor-x64").encode("utf-8"))
# print(f"yup: {'apimonitor-x64'.encode('utf-8')}")

print(get_hash("apimonitor-x64"))
