#!/bin/bash

set -e

VAULT=~/vault.gpg
AWS_URI="s3://filevault/vault.gpg"
SYNOPSIS="Synopsis: $ bash keymgr.sh (get|set|edit) [KEYWORD]"
ACTION=$1
KEYWORD=$2

if [ ! -e $VAULT ]; then
    echo "Cannot find vault file '$VAULT'!"
    echo $SYNOPSIS
    exit -1
fi

function ensure_keyword {
    if [ -z $1 ]; then
        echo "Keyword required!"
        echo $SYNOPSIS
        exit -1
    fi
}

read -sp "Enter vault's password: " PASSWORD; echo

if [ $ACTION == 'get' ]; then
    ensure_keyword $KEYWORD
    gpg --passphrase $PASSWORD --batch --yes --decrypt $VAULT | grep -i $KEYWORD
elif [ $ACTION == 'set' ]; then
    ensure_keyword $KEYWORD
    read -p 'Enter key (or leave empty to generate one): ' KEY; echo
    if [ -z $KEY ]; then
        KEY=`< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c25`
    fi
    echo "Setting $KEYWORD secret to $KEY"
    echo "$(gpg --passphrase $PASSWORD --batch --yes --decrypt $VAULT)"$'\n'"$KEYWORD,$KEY" |
        gpg --passphrase $PASSWORD --batch --yes --symmetric --output $VAULT
    aws s3 cp $VAULT $AWS_URI
elif [ $ACTION == 'edit' ]; then
    gpg --passphrase $PASSWORD --batch --yes --decrypt $VAULT |
        vipe |
        gpg --passphrase $PASSWORD --batch --yes --symmetric --output $VAULT
    aws s3 cp $VAULT $AWS_URI
else
    echo $SYNOPSIS
fi

