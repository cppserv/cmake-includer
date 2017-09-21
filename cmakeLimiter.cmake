#
# Include this file in your code before including any other project/subcmake
# 
#
# Available commands:
#
# - cmakelimiter_custom_targets (1/0)
# - cmakelimiter_compile_executables (1/0)
# - cmakelimiter_messages (1/0)

# limiter code

if (NOT CMAKE_LIMITER_NOREDIFINE)

    # Set to on, to do not redifine it again
    SET(CMAKE_LIMITER_NOREDIFINE "ON")
    cmake_minimum_required (VERSION 2.8.11)

    # Limiting functions 
    function(cmakelimiter_custom_targets onoff)
        if (onoff MATCHES "0")
            if (NOT NO_ADD_CUSTOM)
                set(NO_ADD_CUSTOM 1)
            else()
                math(EXPR NO_ADD_CUSTOM "${NO_ADD_CUSTOM}+1")
            endif()
        else()
            if (NO_ADD_CUSTOM MATCHES "1")
                unset(NO_ADD_CUSTOM)
            else()
                math(EXPR NO_ADD_CUSTOM "${NO_ADD_CUSTOM}-1")
            endif()
        endif()
    endfunction(cmakelimiter_custom_targets)

    function(cmakelimiter_compile_executables onoff)
        if (onoff MATCHES "0")
            if (NOT NO_COMPILE_EXECUTABLES)
                set(NO_COMPILE_EXECUTABLES 1)
            else()
                math(EXPR NO_COMPILE_EXECUTABLES "${NO_COMPILE_EXECUTABLES}+1")
            endif()
        else()
            if (NO_COMPILE_EXECUTABLES MATCHES "1")
                unset(NO_COMPILE_EXECUTABLES)
            else()
                math(EXPR NO_COMPILE_EXECUTABLES "${NO_COMPILE_EXECUTABLES}-1")
            endif()
        endif()
    endfunction(cmakelimiter_compile_executables)

    function(cmakelimiter_messages onoff)
        if (onoff MATCHES "0")
            if (NOT MESSAGE_QUIET)
                set(MESSAGE_QUIET 1)
            else()
                math(EXPR MESSAGE_QUIET "${MESSAGE_QUIET}+1")
            endif()
        else()
            if (MESSAGE_QUIET MATCHES "1")
                unset(MESSAGE_QUIET)
            else()
                math(EXPR MESSAGE_QUIET "${MESSAGE_QUIET}-1")
            endif()
        endif()
    endfunction(cmakelimiter_messages)

    # Get the cmakeLimiter version
    execute_process(
        COMMAND git describe --always --tags
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        OUTPUT_VARIABLE cmakelimit_VERSION)

    MESSAGE(STATUS "Included CMake-Limiter " ${cmakelimit_VERSION})

    #Function to make output a bit more quiet
    function(message)
        if (NOT MESSAGE_QUIET)
            _message(${ARGN})
        endif()
    endfunction()

    #Function to remove imported executables
    function(add_executable)
        _add_executable(${ARGN})
        if (NO_COMPILE_EXECUTABLES)
            set_target_properties(${ARGV0} PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
        endif()
    endfunction()

    #Function to remove custom targets
    function(add_custom_target)
        if (NOT NO_ADD_CUSTOM)
            _add_custom_target(${ARGN})
        else()
        endif()
    endfunction()

    function(INSTALL)
        if (NOT NO_COMPILE_EXECUTABLES)
            _INSTALL(${ARGN})
        else()
        endif()
    endfunction()
endif()