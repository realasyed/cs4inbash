#!/bin/bash

# In the original problem I had to make a function that checked to see if an
# array or list had identical first and last items. Afaik, Bash does not have
# a super clean way to check types, so I need a helper function. In Python,
# this is two lines of code.

# Helper function adapted from https://gist.github.com/CMCDragonkai/f1ed5e0676e53945429b
function _typecheck {
    local inputtype=$(declare -p ${1})
    if [[ "${inputtype}" =~ "declare --" ]]; then printf "string"
    elif [[ "${inputtype}" =~ "declare -a" ]]; then printf "array"
    elif [[ "${inputtype}" =~ "declare -A" ]]; then printf "dict"
    else printf "none"
    fi
}

function checkends {
    if [[ "$(_typecheck ${1})" == "array" || "$(_typecheck ${1})" == "dict" ]]; then
        # To-do: then check if the first and last items are identical.
