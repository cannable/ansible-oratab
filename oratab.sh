#!/usr/bin/bash

# ------------------------------------------------------------------------------
# Super Primitive oratab facts.d Ansible Implementation
# ------------------------------------------------------------------------------
# C. Annable, 2022
#
# Installation:
#   Pop this into /etc/ansible/facts.d/oratab.fact and make it executable.
# Invocation:
# ./oratab.sh
# (defaults to /etc/oratab)
# ./oratab.sh /path/to/oratab
#
# License:
#
# Copyright 2022 C. Annable
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

# Script (finally):

oratab=$1

if [[ $# -ne 1 ]]; then
    oratab=/etc/oratab
fi

awkward=$(cat  <<- "GTFO"

BEGIN	{
    FS=":"
    printf "["
}
# Match any line with three sections, sans comments
/^[^:#][^:]*:[^:]+:[^:]+$/	{
    printf "%s{\"sid\":\"%s\",\"dbhome\":\"%s\",\"dbstart\":\"%s\"}", comma, $1, $2, $3

    comma = ","
}

END {
    printf "]"
}

GTFO
)

awk -e "${awkward}" "${oratab}"

