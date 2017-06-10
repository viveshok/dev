
set -e

SYNOPSIS="Synopsis: $ bash keymgr.sh (get|set) KEYWORD"
VAULT=~/vault.gpg
AWS_URI="s3://filevault/vault.gpg"
ACTION=$1
KEYWORD=$2
RANDOM_WORD=`awk -v lineno="$RANDOM" 'lineno==NR{print;exit}' /usr/share/dict/words`
CACHE_FILE=".${RANDOM_WORD,,}.tmp"

if [ ! -e $VAULT ]; then
    echo "Cannot find vault file '$VAULT'!"
    echo $SYNOPSIS
    exit -1
fi

if [ -z $KEYWORD ]; then
    echo "Keyword required!"
    echo $SYNOPSIS
    exit -1
fi

read -sp "Enter vault's password: " PASSWORD; echo

if [ $ACTION == 'get' ]; then
    gpg --passphrase $PASSWORD --batch --yes --decrypt $VAULT | grep -i $KEYWORD
elif [ $ACTION == 'set' ]; then
    read -sp "Confirm vault's password: " PASSWORD2; echo
    if [ ! $PASSWORD == $PASSWORD2 ]; then
        echo "Passwords don't match!!!"
        exit -1
    fi
    read -p 'Enter key (or leave empty to generate one): ' KEY; echo
    if [ -z $KEY ]; then
        KEY=`< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c25`
    fi
    gpg --passphrase $PASSWORD --batch --yes --decrypt $VAULT > $CACHE_FILE
    MSG="Key for '$KEYWORD' is '$KEY'"
    echo $MSG | tee --append $CACHE_FILE
    gpg --passphrase $PASSWORD --batch --yes --symmetric --output $VAULT $CACHE_FILE
    rm --verbose $CACHE_FILE
    rm --verbose --force .*.tmp
    aws s3 cp $VAULT $AWS_URI
else
    echo $SYNOPSIS
fi

