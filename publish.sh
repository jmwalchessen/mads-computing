#!/bin/sh

UPLOAD_DIR=alex@pandora.xyloid.org:/www/refsmmat.com/html/courses/msp-computing

rsync -rvch --exclude '*.DS_Store' _book/ $UPLOAD_DIR
