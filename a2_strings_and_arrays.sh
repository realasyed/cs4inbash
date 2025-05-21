#!/bin/bash

# In the original problem I had to make a function that checked to see if an
# array or list had identical first and last items. Afaik, Bash does not have
# a super clean way to check types, so I need a helper function. In Python,
# this is two lines of code.

# Helper function adapted from https://gist.github.com/CMCDragonkai/f1ed5e0676e53945429b
function _typecheck {
    if [[ "$(declare -p ${1})" =~ "declare --" ]]; then echo "string"
    elif [[ "$(declare -p ${1})" =~ "declare -a" ]]; then echo "array"
    else echo "Error: function only takes strings or arrays."; return 1
    fi
}

# Okay, so this function uses many weird tricks. The `&&` and `||` operators are 
# strange and do not work like normal logical ANDs and ORs. This function also 
# makes use of namerefs to access the content of a variable rather than the
# variable itself. In essence, when I operate on `input_name` directly, I
# operate on the string that represents the content of `input_name`, which is
# the name of the content's variable. This means that `${input_name:0:1}` 
# would actually return the first letter of the variable passed to the function.
# To get the actual content of `input_name` (which is the content of `${1}`) I
# need to use a nameref. Apparently, there are two ways to do this: `eval` and
# `declare -n`. The latter is safer for some reason. It also looks better. 
function checkends {
    local input_name=${1}
    local var_type="$(_typecheck "${input_name}")"
    declare -n input_content=${input_name}
    if [[ "${var_type}" == "array" ]]; then
        [[ "${input_content[0]}" == "${input_content[-1]}" ]] && echo "true" || echo "false"
        return 0
    elif [[ "${var_type}" == "string" ]]; then
        [[ "${input_content:0:1}" == "${input_content: -1}" ]] && echo "true" || echo "false"
        return 0
    else
        echo "Error: parameter must be string or array. I mean it doesn't have to be but come on bro."
        return 1
    fi
}
