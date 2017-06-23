#!/bin/bash
TAG=containerdays-hamburg_2017-06
CID=$1
LOCATION="Container Days  06/2017 Hamburg"
TITLE="Linuxkit Basics"
docker exec -ti ${CID} /bin/bash -c "cd print ; ./print.sh /build/linuxkit-bascis-${TAG}-PeterRossbach.pdf '${LOCATION}'"
docker exec -ti ${CID} /bin/bash -c "cd print ; ./exif.sh /build/linuxkit-basics-${TAG}-PeterRossbach.pdf '${TITLE}'"
