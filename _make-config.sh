#!/bin/bash

function usage(){
    
    cat <<EOF
Usage: make-config.sh domain script1.sh script2.sh script3.sh script4.sh

Signatures:

script1.sh : < domain name       -> domain.pddl>
script2.sh : < domain name       -> target PDDLs...>
script3.sh : < problem PDDL path -> plan path >
script4.sh : < domain name       -> tests PDDLs...>

EOF
    exit 1
}

test -z $5 && usage


cat <<EOF
;domain file
domain=$(bash $2 $1)

; MUM settings (as used in the ICAPS paper)
flawratio=0.1
entanglements=init goal
macroentanglements=both

;training problem files with corresponding plans
$(for problem in $(bash $3 $1)
 do
   plan=$(bash $4 $problem)
   [ -e $plan ] && echo "training=$problem $plan"
 done)
; maybe no files when no plans found

;testing problem files
$(for problem in $(bash $5 $1) ; do echo "problem=$problem" ; done)
EOF
