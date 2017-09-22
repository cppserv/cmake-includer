# cmakeLimiter
Include cmake subprojects disabling some functionalities like libraries or applications

# Usage
Include the file `cmakeLimiter.cmake` in your cmake code by `include("PATH_TO_GIT_REPO/cmakeLimiter.cmake")` and you can start using it

# Available functions
There are the following available functions:
- `cmakelimiter_messages (onoff)`: 
    - onoff (boolean variable):
        - 0:            disable messages
        - 1 (default):  enable  messages
- `cmakelimiter_compile_executables (onoff)`: 
    - onoff (boolean variable):
        - 0:            disable the executable compilation
        - 1 (default):  enable  the executable compilation
- `cmakelimiter_custom_targets (onoff)`: 
    - onoff (boolean variable):
        - 0:            disable the custom targets
        - 1 (default):  enable  the custom targets
- `cmakelimiter_compile_libraries (onoff)`: 
    - onoff (boolean variable):
        - 0:            disable the libraries compilation
        - 1 (default):  enable  the libraries compilation