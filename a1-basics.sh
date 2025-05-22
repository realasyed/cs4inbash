#!/bin/bash

# Important: the formatting will be very inconsistent;
# I am trying to figure out how I like to format things.

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
    echo "Sees if two numbers differ by one."

    local result=$((${1}-${2}))

    if [[ "${result:0:1}" == "-" ]]; then # ${input:step:length}
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

    echo "An improved version of 'differ_by_one'."

    local difference=$((${1} - ${2}))

    if [[ ${difference} == "1" || ${difference} == "-1" ]]; then
        echo "true"; else
        echo "false"
    fi
} 

# Note on `function`: I prefer the `function` command over the `()` notation
# because the `()` does not actually take arguments (afaik). In my view,
# this makes `function` a more honest approach to defining functions in Bash.

# In this next problem, I had to take three inputs and return true if and only
# if the inputs were in ascending order. In Python this takes two lines of code:
# def Ascending(x, y, z):
#   return x<y<z

# From here on out I am going to add a --help option.
function ascending {
    
    if [[ ${1} == "--help" || ${1} == "-h" ]]; then 
        echo "Returns 'true' if provided positional arguments are in ascending order. Returns 'false' otherwise."
    else
        # To make things more similar to the Python program.
        local x=${1}
        local y=${2}
        local z=${3}
        # [[ $((x < y < z)) -eq 1 ]] does not work because Bash treats it like
        # ((x < y) < z). This is intended to mirror C or something.
        if (( x < y && y < z )); then
            echo "true"; else
            echo "false"
        fi
    fi 
}

function median {
    if [[ ${1} == "--help" || ${1} == "-h" ]]; then 
        echo "Returns the median of provided positional arguments."
    else
        local x=${1}
        local y=${2}
        local z=${3}
        local med=''

        # I will revisit this once I figure out a better way.
        # I think there is a case command or something?
        # Also, like Python, this works with letters.
        if (( x <= y && y <= z )); then echo ${y};
        elif (( y <= x && x <= x )); then echo ${x};
        else echo ${z}
        fi 
    fi
}

# Last one! In the original assignment, I had to take an input and then round
# it to the nearest integer. I don't think Bash can work with floats anyways?
# I might just make something that rounds to the nearest ten.

# Okay, there HAS to be a better way...

function round {
    input=${1}
    rounded=''

    if [[ ${1} == "--help" || ${1} == "-h" ]]; then 
        echo "Rounds the provided parameter to the nearest ten."
    else
        if [[ ${input} -ge 0 ]]; then
            if [[ ${input: -1} -ge 5 ]]; then
                rounded=$((${input} + (10 - ${input: -1})))
                echo ${rounded}
            else
                rounded=$((${input} - ${input: -1}))
                echo ${rounded}
            fi
        else
            if [[ ${input} -lt 0 ]]; then
                if [[ ${input: -1} -ge 5 ]]; then
                    rounded=$((${input} - (10 - ${input: -1})))
                    echo ${rounded}
                else
                    rounded=$((${input} + ${input: -1}))
                    echo ${rounded}
                fi
            fi
        fi
    fi
}
