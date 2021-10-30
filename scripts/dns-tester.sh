#!/usr/bin/bash

ARRAY=()

HOST1=www.web-service.org,107.2.148.169
HOST2=pihole.web-service.org,10.0.0.2
HOST3=tweepy.web-service.org,107.2.148.169
HOST4=vyperapi.web-service.org,107.2.148.169
HOST5=auth.web-service.org,107.2.148.169
HOST6=controller.web-service.org,10.0.0.196
HOST7=docker1.web-service.org,10.0.0.233
HOST8=docker2.web-service.org,10.0.0.240
HOST9=tower.web-service.org,10.0.0.164
HOST10=tp01-2066.web-service.org,10.0.0.239
HOST11=ubuntu-desktop-vm.web-service.org,10.0.0.46
HOST12=windows-vm1.web-service.org,10.0.0.44
HOST13=windows-vm2.web-service.org,10.0.0.45
HOST14=z820.web-service.org,10.0.0.177
HOST15=securex1.web-service.org,10.0.0.250
HOST16=pve.web-service.org,10.0.0.186
HOST17=ionos1.web-service.org,74.208.181.146
HOST18=aws1.web-service.org,3.132.14.147
HOST19=truenas1.web-service.org,10.0.0.191
HOST20=securex2.web-service.org,10.0.0.254
HOST21=docker3.web-service.org,10.0.0.198
HOST22=securex3.web-service.org,10.0.0.179
HOST23=securex-jump-server.web-service.org,107.2.148.169

ARRAY+=($HOST1)
ARRAY+=($HOST2)
ARRAY+=($HOST3)
ARRAY+=($HOST4)
ARRAY+=($HOST5)
ARRAY+=($HOST6)
ARRAY+=($HOST7)
ARRAY+=($HOST8)
ARRAY+=($HOST9)
ARRAY+=($HOST10)
ARRAY+=($HOST11)
ARRAY+=($HOST12)
ARRAY+=($HOST13)
ARRAY+=($HOST14)
ARRAY+=($HOST15)
ARRAY+=($HOST16)
ARRAY+=($HOST17)
ARRAY+=($HOST18)
ARRAY+=($HOST19)
ARRAY+=($HOST20)
ARRAY+=($HOST21)
ARRAY+=($HOST22)
ARRAY+=($HOST23)

#######################################
#######################################

echo ${ARRAY[@]}

FAILS=0
CHECKS=0
PASS=0
for var in "${ARRAY[@]}"
do
    TOKS=(${var//,/ })
    if [[ -z ${TOKS[0]} ]]; then
        echo "(1) DNS test for ${TOKS[0]} - ${TOKS[1]} - FAIL"
        exit 1
    fi
    if [[ -z ${TOKS[1]} ]]; then
        echo "(2) DNS test for ${TOKS[0]} - ${TOKS[1]} - FAIL"
        exit 1
    fi
    if [[ "${TOKS[1]}" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
        echo ""
    else
        echo "fail - ${TOKS[1]} is not an ip address."
        exit 1
    fi
    CNT=0
    if ping -c1 -w3 ${TOKS[1]} >/dev/null 2>&1
    then
        echo "Ping responded; IP address allocated"
        CNT=$((CNT+1))
    else
        echo "Ping did not respond; IP address (${TOKS[1]}) either free or firewalled"
    fi
    if [[ ${CNT} -eq 1 ]]; then
        TEST=$(getent hosts ${TOKS[0]} | awk '{ print $1 }')
        echo "DNS test for ${TOKS[0]} --> ${TOKS[1]} --> ${TEST}"
        if [[ "${TEST}" = "${TOKS[1]}" ]]; then
            echo "DNS test for ${TOKS[0]} --> ${TOKS[1]} --> ${TEST} - PASS"
            PASS=$((PASS+1))
        else
            echo "DNS test for ${TOKS[0]} --> ${TOKS[1]} --> ${TEST} - FAIL"
            FAILS=$((FAILS+1))
        fi
    fi
    CHECKS=$((CHECKS+1))
    #echo "${var} --> $TEST --> ${TOKS[0]} --> ${TOKS[1]}"
done

THRESHOLD=$((CHECKS / 2))
THRESHOLD=$((THRESHOLD + 1))

echo "PASS: $PASS"
echo "FAILS: $FAILS"
echo "CHECKS: $CHECKS"
echo "THRESHOLD: $THRESHOLD"

if [[ ${FAILS} -lt $THRESHOLD ]]; then
    echo "More than $THRESHOLD FAILS:$FAILS"
    exit 1
fi
echo "DONE."