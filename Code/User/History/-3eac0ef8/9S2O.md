# HSLU I2C Password Manager

Basic password manager, able to store simple key:value entries. Because of simplicity it isn't
implemented with a hash table but with the values chained one after another.

## Structure

The filestructure is as follows:

| Bytes in file     | Value                 |
| ----------------- | --------------------- |
| First 32 bytes    | SHA256 hash in binary |
| 8 bytes           | Salt                  |
| encrypted n-bytes | key1:val1\n           |
| encrypted n-bytes | key2:val2\n           |
| ...               | ...\0                 |

Whereas the hash is the master-password hash and the salt is used to encrypt/decrypt the entries with AES256.
The (plaintext) entries are newline-terminated strings chained one after another.

## Limitations

-   The application can only understand and process extended ASCII (8bit) characters.
-   Since the individual entries are arranged directly next to each other, a compromise
    must be made between write speed and file size when handling insertions.

## TODO

-   maybe hash table implementation

## External Dependencies

-   [Libsodium](https://libsodium.gitbook.io/doc/)
-   [OpenSSL](https://www.openssl.org/)

### Installation for development

#### Linux

Install libsodium with your package manager. 

Debian-systems:
```bash
sudo apt-get install libsodium-dev
```

Arch:
```bash
sudo pacman -S libsodium
```

And the src/CMakeLists.txt should look somewhat like this:

```cmake
cmake_minimum_required(VERSION 3.0.0)
project(pw_manager VERSION 0.1.0)

# libsodium
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBSODIUM REQUIRED libsodium)
include_directories(${LIBSODIUM_INCLUDE_DIRS})

set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
add_executable(pw_manager
  ${SOURCE_DIR}/main.c
  ${SOURCE_DIR}/crypto.c
  ${SOURCE_DIR}/files.c
  ${SOURCE_DIR}/password.c
)
target_include_directories(pw_manager PUBLIC include)

# Find OpenSSL
find_package(OpenSSL REQUIRED)
if(OPENSSL_FOUND)
    message("OpenSSL found")
    include_directories(${OPENSSL_INCLUDE_DIR})

    find_library(LIBSODIUM_LIBRARY NAMES sodium REQUIRED)
    if(NOT LIBSODIUM_LIBRARY)
        message(FATAL_ERROR "libsodium not found")
    endif()
    target_link_libraries(pw_manager
        ${OPENSSL_LIBRARIES}
        ${LIBSODIUM_LIBRARY}
        ${CMAKE_DL_LIBS}
    )

else()
  message(FATAL_ERROR "OpenSSL not found")
endif()

message(STATUS "OpenSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message(STATUS "OpenSSL found: ${OPENSSL_FOUND}")
message(STATUS "OpenSSL libraries: ${OPENSSL_LIBRARIES}")


```

#### Windows

1. Download the [libsodium-x.y.z-mingw.tar.gz](https://download.libsodium.org/libsodium/releases/) binaries and extract them to a folder of your choice.
2. Take the contents of either the x64 or x32 folder and copy them to a folder called libsodium in the root directory of the project.
3. Then change your src/CMakeLists.txt to the following:

```cmake
# Enforce the use of static libraries
set(BUILD_SHARED_LIBS OFF)

set(LIBSODIUM_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libsodium)
include_directories(${LIBSODIUM_DIR}/include)

add_executable(pw_manager main.c crypto.c files.c password.c)

target_include_directories(pw_manager PUBLIC include)
# target_link_libraries(pw_manager PRIVATE ${LIBSODIUM_DIR}/lib/libsodium.a)

# Link OpenSSL statically
set(OPENSSL_USE_STATIC_LIBS TRUE)
find_package(OpenSSL REQUIRED)
if(OPENSSL_FOUND)
message("OPENSSL FOUND!")
endif()
target_link_libraries(pw_manager OpenSSL::Crypto ${LIBSODIUM_DIR}/lib/libsodium.a ${CMAKE_DL_LIBS})

message(STATUS "OpenSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message(STATUS "OpenSSL found: ${OPENSSL_FOUND}")
message(STATUS "OpenSSL libraries: ${OPENSSL_LIBRARIES}")
```

Also add the libsodium folder to your .gitignore file.
