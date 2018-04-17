#!/bin/sh
# Usage:
#     ./bootstrap.sh  # use buildout.cfg
#     ./bootstrap.sh -c dev.cfg  # use dev.cfg
ln -s dev.cfg buildout.cfg
pip install --user -r https://raw.githubusercontent.com/plone/buildout.coredev/5.1/requirements.txt
buildout "$@"
