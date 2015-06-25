#!/bin/bash

function usage(){
    
    cat <<EOF
Usage: make-config.sh [DOMAIN NAME]
EOF
    exit 1
}

test -z $1 && usage

cd $(dirname $0)

./_make-config.sh $1 domain.sh targets.sh problem-plan.sh tests.sh
