#!/bin/bash -x

wget https://github.com/cpputest/cpputest/releases/download/v3.8/cpputest-3.8.tar.gz -O /tmp/cpputest.tar.gz
tar -xzvf /tmp/cpputest.tar.gz
cd cpputest-3.8/scripts && sudo ./InstallScripts.sh
