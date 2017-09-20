#!/bin/bash

tar -xzvf /usr/local/apache-ambari-2.5.2-src.tar.gz -C /usr/local/
mv /usr/local/apache-ambari-2.5.2-src /usr/local/ambari
rm -rf /usr/local/apache-ambari-2.5.2-src.tar.gz

tar -xzvf /usr/lib/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz -C /usr/lib/
rm -rf /usr/lib/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz

mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/target/grafana
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/target/embedded
mkdir -p /usr/local/apache-ambari-2.5.2/ambari-metrics/ambari-metrics-assembly/target/embedded

cp /usr/lib/repository/myjars/hbase.tar.gz /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded/hbase.tar.gz
cp /usr/lib/repository/myjars/phoenix.tar.gz /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded/phoenix.tar.gz
cp /usr/lib/repository/myjars/grafana.tgz /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/target/grafana/grafana.tgz
cp /usr/lib/repository/myjars/hadoop.tar.gz /usr/local/apache-ambari-2.5.2/ambari-metrics/ambari-metrics-assembly/target/embedded/hadoop.tar.gz


mv /usr/local/ambari/ambari-funtest/pom.xml /usr/local/ambari/ambari-funtest/pom.xml_bk
cp /container/funtest_pom.xml /usr/local/ambari/ambari-funtest/pom.xml

mv /usr/local/ambari/ambari-logsearch/pom.xml /usr/local/ambari/ambari-logsearch/pom.xml_bk
cp /container/logsearch_pom.xml /usr/local/ambari/ambari-logsearch/pom.xml

mv /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml_bk
cp /container/metric_assembly_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml

mv /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml_bk
cp /container/metric_grafana_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml

mv /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml_bk
cp /container/metric_storm_sink_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml

mv /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml_bk
cp /container/metric_timeline_services_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml

mv /usr/local/ambari/utility/pom.xml /usr/local/ambari/utility/pom.xml_bk
cp /container/utility_pom.xml /usr/local/ambari/utility/pom.xml

export JAVA_HOME="/usr/local/jdk"
export PATH="$PATH:$JAVA_HOME/bin"
export MVN_HOME="/usr/local/maven"
export PATH="$PATH:$MVN_HOME/bin"
export MAVEN_OPTS="-Xms256m -Xmx512m"
export _JAVA_OPTIONS="-Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true"


java -version
mvn -version

