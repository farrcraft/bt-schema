#!/bin/bash -e
#
# Create a system package
#
# Author: Joshua Farr <j.wgasa@gmail.com>
#

# Prerequisites:
# sudo apt-get install ruby-dev gcc
# sudo gem install fpm

if [ "$#" != "1" ]; then
	echo "Usage: ./package.sh <VERSION>"
	exit 1
fi

VERSION=$1

TMP_WORK_DIR=`mktemp -d`
INSTALL_ROOT_DIR=/opt/brewtheory
CONFIG_ROOT_DIR=/etc/brewtheory
LOG_ROOT_DIR=/var/log/brewtheory
LIB_ROOT_DIR=/var/lib/brewtheory
ARCH=`uname -i`
MAINTAINER=j.wgasa@gmail.com
VENDOR=tQF
PACKAGE_NAME="brewtheory-schema"
DESCRIPTION="BrewTheory Schema Tool"
PACKAGE_FILE="brewtheory-schema_${VERSION}_amd64.deb"

PRE_INSTALL_PATH=`mktemp`
POST_INSTALL_PATH=`mktemp`
POST_UNINSTALL_PATH=`mktemp`

cat <<EOF >$PRE_INSTALL_PATH
#!/bin/sh
if ! id -u "brewtheory" >/dev/null 2>&1; then
	adduser --quiet --system --no-create-home --home /var/run/brewtheory --group --uid 3003 --shell /usr/sbin/nologin brewtheory
fi
EOF

cat <<EOF >$POST_INSTALL_PATH
#!/bin/sh
rm -f $INSTALL_ROOT_DIR/schema
ln -s $INSTALL_ROOT_DIR/versions/schema/$VERSION $INSTALL_ROOT_DIR/api
EOF

cat <<EOF >$POST_UNINSTALL_PATH
#!/bin/sh
EOF

rake build

cp src/src $TMP_WORK_DIR/$INSTALL_ROOT_DIR/versions/schema/$VERSION/brewtheory-schema

mkdir -p  $TMP_WORK_DIR/$CONFIG_ROOT_DIR/
cp conf/config.json $TMP_WORK_DIR/$CONFIG_ROOT_DIR/schema.json.example

mkdir -p $TMP_WORK_DIR/$LOG_ROOT_DIR/
mkdir -p $TMP_WORK_DIR/$LIB_ROOT_DIR/

if [ -f $PACKAGE_FILE ]; then
	rm $PACKAGE_FILE
fi

FPM_ARGS="\
--log error \
-C $TMP_WORK_DIR \
--vendor $VENDOR \
--maintainer $MAINTAINER \
--before-install $PRE_INSTALL_PATH \
--after-install $POST_INSTALL_PATH \
--after-remove $POST_UNINSTALL_PATH \
--name $PACKAGE_NAME \
--deb-user brewtheory \
--deb-group brewtheory \
--config-files $CONFIG_ROOT_DIR"

fpm -s dir -t deb --description "$DESCRIPTION" $FPM_ARGS --version $VERSION .

rm -r $TMP_WORK_DIR
rm $PRE_INSTALL_PATH
rm $POST_INSTALL_PATH
rm $POST_UNINSTALL_PATH

# Leave with a smile!
exit 0
