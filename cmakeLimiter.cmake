#
# Include this file in your code before including any other project/subcmake
# 
#
# Available commands:
#
# - cmakelimiter_messages (1/0)
# - cmakelimiter_compile_executables (1/0)
# - cmakelimiter_custom_targets (1/0)
# - cmakelimiter_compile_libraries(1/0)

# limiter code

if (NOT CMAKE_LIMITER_NOREDIFINE)

    # Set to on, to do not redifine it again
    SET(CMAKE_LIMITER_NOREDIFINE "ON")
    cmake_minimum_required (VERSION 2.8.11)

    # Limiting functions
    function(cmakelimiter_messages onoff)
        if (NOT MESSAGE_QUIET)
            set(MESSAGE_QUIET "0" CACHE STRING "how many calls to cmakelimiter_messages have been done" FORCE)
        endif()
        
        if (onoff MATCHES "0")
            math(EXPR new_variable "${MESSAGE_QUIET}+1")
        else()
            math(EXPR new_variable "${MESSAGE_QUIET}-1")
        endif()

        if(new_variable LESS 1)
            unset(MESSAGE_QUIET CACHE)
        else()
            set(MESSAGE_QUIET ${new_variable} CACHE STRING "how many calls to cmakelimiter_messages have been done" FORCE)
        endif()
    endfunction(cmakelimiter_messages)

    function(cmakelimiter_compile_executables onoff)
        if (NOT NO_COMPILE_EXECUTABLES)
            set(NO_COMPILE_EXECUTABLES "0" CACHE STRING "how many calls to cmakelimiter_compile_executables have been done" FORCE)
        endif()
        
        if (onoff MATCHES "0")
            math(EXPR new_variable "${NO_COMPILE_EXECUTABLES}+1")
        else()
            math(EXPR new_variable "${NO_COMPILE_EXECUTABLES}-1")
        endif()

        if(new_variable LESS 1)
            unset(NO_COMPILE_EXECUTABLES CACHE)
        else()
            set(NO_COMPILE_EXECUTABLES ${new_variable} CACHE STRING "how many calls to cmakelimiter_compile_executables have been done" FORCE)
        endif()
    endfunction(cmakelimiter_compile_executables)

    function(cmakelimiter_custom_targets onoff)
        if (NOT NO_ADD_CUSTOM)
            set(NO_ADD_CUSTOM "0" CACHE STRING "how many calls to cmakelimiter_custom_targets have been done" FORCE)
        endif()
        
        if (onoff MATCHES "0")
            math(EXPR new_variable "${NO_ADD_CUSTOM}+1")
        else()
            math(EXPR new_variable "${NO_ADD_CUSTOM}-1")
        endif()

        if(new_variable LESS 1)
            unset(NO_ADD_CUSTOM CACHE)
        else()
            set(NO_ADD_CUSTOM ${new_variable} CACHE STRING "how many calls to cmakelimiter_custom_targets have been done" FORCE)
        endif()
    endfunction(cmakelimiter_custom_targets)

    function(cmakelimiter_compile_libraries onoff)
        if (NOT NO_COMPILE_LIBRARIES)
            set(NO_COMPILE_LIBRARIES "0" CACHE STRING "how many calls to cmakelimiter_compile_libraries have been done" FORCE)
        endif()
        
        if (onoff MATCHES "0")
            math(EXPR new_variable "${NO_COMPILE_LIBRARIES}+1")
        else()
            math(EXPR new_variable "${NO_COMPILE_LIBRARIES}-1")
        endif()

        if(new_variable LESS 1)
            unset(NO_COMPILE_LIBRARIES CACHE)
        else()
            set(NO_COMPILE_LIBRARIES ${new_variable} CACHE STRING "how many calls to cmakelimiter_compile_libraries have been done" FORCE)
        endif()
    endfunction(cmakelimiter_compile_libraries)

    # Get the cmakeLimiter version
    execute_process(
        COMMAND git describe --always --tags
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        OUTPUT_VARIABLE cmakelimit_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE)

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

    #function to remove unused libraries
    function(add_library)
        _add_library(${ARGN})
        if (NO_COMPILE_LIBRARIES)
            set_target_properties(${ARGV0} PROPERTIES EXCLUDE_FROM_ALL 1 EXCLUDE_FROM_DEFAULT_BUILD 1)
        endif()
    endfunction()
endif()