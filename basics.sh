#!/bin/bash

# In the original assignment, I had to make a function
# that returned `True` if x and y differed by one.
# First, though, it is worth noting how you use
# arguments in BASH. Rather than defining them in the
# function like you would in Python, you refer to
# the positions of arguments passed to your function
# without defining them before hand. For example,
# I might run `somefunc "string" 4`. To use `string`
# in my script, I would have to refer to `$1` within
# the function, as that is the first argument.
# This makes more sense when you consider that functions
# are often used on the command line. Often, you will
# hear Bash arguments referred to as "parameters."
# In general, it helps to keep in mind that BASH focuses
# on string manipulation.

# I know this is inefficient but I wanted to use several Bash features.
function differ_by_one {

    local result=$((${1}-${2}))

    if [[ "${result:0:1}" == "-" ]]; then
        local abs_result=${result#"-"}
        if [[ ${abs_result} == "1" ]]; then
            echo "true"; else
            echo "false"
        fi
    else
        if [[ ${result} == "1" ]]; then
            echo "true"; else
            echo "false"
        fi
    fi
}

function better_differ_by_one {

    local difference=$((${1} - ${2}))

    if [[ ${difference} == "1" || ${difference} == "-1" ]]; then
        echo "true"; else
        echo "false"
    fi
} 
