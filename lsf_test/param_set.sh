#!/bin/bash
COUNTER=0

mkdir lsf_batch
cd lsf_batch

# '/eos/totem/data/cmstotem/2018/90m/data_copy/Run319256'
# '/eos/user/n/nminafra/Sampic/319176/'
ROOT_FILES_DIR='/eos/user/n/nminafra/Sampic/319176/'

ROOT_DIR=`pwd`

EVENTS_NUMBER=1000

# PLANE_ACTIVITY in 2 3 4
# TOLERANCE in 0. 0.1 0.5 1.
# THRESHOLD in 1.1 1.5 2.1 2.5
# SIGMA in 0. 0.1 0.5 1.

PIXEL_EFFICIENCY_FUNCTION='"(x>[0]-0.5*[1]-0.05)*(x<[0]+0.5*[1]-0.05)+0*[2]"'

for PLANE_ACTIVITY in 2 3; do
  for TOLERANCE in 0.; do
    for THRESHOLD in 1.1 1.5; do
      for SIGMA in 0.; do

        if [[ $THRESHOLD = '1.1' || $THRESHOLD = '2.1' ]] && [ $SIGMA = 0 ]; then
          continue
        fi

        cd $ROOT_DIR
        NEW_DIR="out${COUNTER}_plactiv${PLANE_ACTIVITY}_tol${TOLERANCE}_thres${THRESHOLD}_sig${SIGMA}_"
	mkdir $NEW_DIR
        cd $NEW_DIR

        sed -e "s|MAX_PLANE_ACTIVITY_CHANNELS|${PLANE_ACTIVITY}|g" \
        -e "s|TOLERANCE|${TOLERANCE}|g" \
        -e "s|THRESHOLD|${THRESHOLD}|g" \
        -e "s|SIGMA|${SIGMA}|g" \
        -e "s|PIXEL_EFFICIENCY_FUNCTION|${PIXEL_EFFICIENCY_FUNCTION}|g" \
	-e "s|ROOT_SOURCE_DIR|'${ROOT_FILES_DIR}'|g" \
	-e "s|EVENTS_NUMBER|${EVENTS_NUMBER}|g" < ${ROOT_DIR}/../test.py > ./test.py


        echo "$COUNTER: plane_activity=$PLANE_ACTIVITY, tolerance=$TOLERANCE, threshold=$THRESHOLD, sigma=$SIGMA" > setup

        COUNTER=$(($COUNTER + 1))

      done
    done
  done
done
