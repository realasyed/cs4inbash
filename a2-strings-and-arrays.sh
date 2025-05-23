#!/bin/bash

# $ [[ "${SHELL}" > "${YOUR_LANG}" ]] && echo "true" || echo "false"
# true

# In the original problem I had to make a function that checked to see if an
# array or list had identical first and last items. Afaik, Bash does not have
# a super clean way to check types, so I need a helper function. In Python,
# this is two lines of code.

# Helper function adapted from https://gist.github.com/CMCDragonkai/f1ed5e0676e53945429b

function _type_check {
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
# Now, when I operate on the nameref, I access the contents of `${1}`.
# I still need to look into this though. Anyways, `&&` is weird because it runs
# the bit on the right of it iff the bit on the left runs successfully. I think
# `||` runs the right bit iff the left bit fails? Doesn't seem very inclusive.
# Regardless, `||` is the inclusive OR.

function check_ends {
    local input_name=${1}
    local var_type="$(_type_check "${input_name}")"
    declare -n input_content=${input_name}
    if [[ "${var_type}" == "array" ]]; then
        [[ "${input_content[0]}" == "${input_content[-1]}" ]] && echo "true" || echo "false"
        return 0
    elif [[ "${var_type}" == "string" ]]; then
        [[ "${input_content:0:1}" == "${input_content: -1}" ]] && echo "true" || echo "false"
        return 0
    else
        echo "Error: parameter must be string or array. I mean it doesn't have to be I guess... :c"
        return 1
    fi
}

# Next function! In the og assignment, I had to make a function `WordScramble(S)`
# that takes a word `S` and returns a string where the first half comprised every
# other letter starting from the first one and the second half comprised every
# other letter starting from the second one. This took me five lines of code in
# Python. It feels like Bash should have tools for this.

# Okay, I did some reasearch and nope, Python is still more concise. I love Bash,
# but wow, it can be a little tedious at times. From what I can tell, I have to
# use a "C-style for loop" for this task. I am somewhat familiar with these, so
# this should not be too hard.

# I am going to use two helper functions here. The main reason is that I can get
# a cleaner main function this way. Also, I think I like Bash because it is
# stupid like me. If I were a programming language I would be Bash.

function _every_other_letter {
    local input=${1}
    local result=""
    for (( l = 0 ; l < ${#input} ; l += 2 )); do
        result+=${input:${l}:1}
    done
    printf "${result}"
}

function _every_other_other_letter {
    local input=${1}
    local result=""
    for (( l = 1 ; l < ${#input} ; l += 2 )); do
        result+=${input:${l}:1}
    done
    printf "${result}"
}

function word_scramble {
    echo "$(_every_other_letter ${1} && _every_other_other_letter ${1})"
    return 0
} 

# For this next problem, I had to make a function `FlipSide(W)` that took a
# string `W` and swapped the first and last side of that string. So, for
# instance, 'Word' would become 'rdWo'. If `len(W)` was odd, I had to round down
# to the nearest `int`. Thankfully, this is the default behavior in Bash. This
# might be the first Bash function I make that is as concise as a Python
# function! In Python, this took me 6 lines of code, but likely could have been
# done in 2 with less intermediary variables.

# Reminder: `${INPUT:OFFSET:LENGTH}`. Set `LENGTH` to ` -N` for negative
# indexing.

function flip_side {
    echo "${1:$(( (${#1} / 2 ))):$(( (${#1} / 2) + 1 ))}${1:0:$(( ${#1} / 2 ))}"
}
