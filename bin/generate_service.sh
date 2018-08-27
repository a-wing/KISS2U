#!/bin/bash
source ./config.sh

cp config/kiss2u.service.template kiss2u.service
sed -i s#\<KEY\>#`echo $KISS2U_AUTH_KEY`#g kiss2u.service
sed -i s#\<DIR\>#`pwd`#g kiss2u.service
sed -i s#\<BUNDLE\>#`which bundle`#g kiss2u.service


echo "Install ~/.config/systemd/user/kiss2u.service"
echo "Please Run: systemctl --user start kiss2u"

install kiss2u.service -t ~/.config/systemd/user/
rm kiss2u.service
