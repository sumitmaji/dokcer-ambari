#!/bin/bash

: ${DERBY_INSTALL:=/usr/local/derby}


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi


