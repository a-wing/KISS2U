#!/bin/bash
source ./config.sh

SYSTEMD=kiss2u.service

cp config/${SYSTEMD}.template ${SYSTEMD}
sed -i s#\<KEY\>#`echo $KISS2U_AUTH_KEY`#g ${SYSTEMD}
sed -i s#\<DIR\>#`pwd`#g ${SYSTEMD}
sed -i s#\<BUNDLE\>#`which bundle`#g ${SYSTEMD}


echo "Install ~/.config/systemd/user/${SYSTEMD}"
echo "Please Run: systemctl --user start ${SYSTEMD}"

install ${SYSTEMD} -D ~/.config/systemd/user/${SYSTEMD}
rm ${SYSTEMD}

###################################

SYSTEMD=lilackiss.service

cp config/${SYSTEMD}.template ${SYSTEMD}
sed -i s#\<DIR\>#`pwd`#g ${SYSTEMD}

echo "Install ~/.config/systemd/user/${SYSTEMD}"
echo "Please Run: systemctl --user start ${SYSTEMD}"

install ${SYSTEMD} -D ~/.config/systemd/user/${SYSTEMD}
rm ${SYSTEMD}
