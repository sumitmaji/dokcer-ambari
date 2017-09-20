#!/bin/bash

cd /usr/local/ambari && mvn versions:set -DnewVersion=2.5.2.0.0 && cd /usr/local/ambari/ambari-metrics; mvn -X version:set -DnewVersion=2.5.2.0.0 && cd /usr/local/ambari
