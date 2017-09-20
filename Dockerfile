FROM sumit/maven:latest
MAINTAINER Sumit Kumar Maji

RUN apt-get update && apt-get install -yq ant
RUN apt-get install -yq gcc g++
RUN apt-get install -y git vim python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
RUN pip install --upgrade pip
RUN pip install --upgrade pwntools
RUN apt-get install -yq wget
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get install -yq postgresql-8.4 

ARG REPOSITORY_HOST
RUN wget -O /usr/local/apache-ambari-2.5.2-src.tar.gz "$REPOSITORY_HOST"/repository/files/apache-ambari-2.5.2-src.tar.gz &&\
wget -O /usr/lib/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz "$REPOSITORY_HOST"/repository/files/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz &&\
tar -xzvf /usr/local/apache-ambari-2.5.2-src.tar.gz -C /usr/local/ &&\
mv /usr/local/apache-ambari-2.5.2-src /usr/local/ambari &&\
rm -rf /usr/local/apache-ambari-2.5.2-src.tar.gz &&\
tar -xzvf /usr/lib/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz -C /usr/lib/ &&\
rm -rf /usr/lib/repository-hue-oozie-4.3-ambari-2.5.2.0.tar.gz &&\
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded &&\
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/target/grafana &&\
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/target/embedded &&\
mkdir -p /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/target/embedded &&\
mv /usr/lib/repository/myjars/hbase.tar.gz /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded/hbase.tar.gz &&\
mv /usr/lib/repository/myjars/phoenix.tar.gz /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/target/embedded/phoenix.tar.gz &&\
mv /usr/lib/repository/myjars/grafana.tgz /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/target/grafana/grafana.tgz &&\
mv /usr/lib/repository/myjars/hadoop.tar.gz /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/target/embedded/hadoop.tar.gz
ADD . /container/

RUN mv /usr/local/ambari/ambari-funtest/pom.xml /usr/local/ambari/ambari-funtest/pom.xml_bk &&\
cp /container/funtest_pom.xml /usr/local/ambari/ambari-funtest/pom.xml &&\
mv /usr/local/ambari/ambari-logsearch/pom.xml /usr/local/ambari/ambari-logsearch/pom.xml_bk &&\
cp /container/logsearch_pom.xml /usr/local/ambari/ambari-logsearch/pom.xml &&\
mv /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml_bk &&\
cp /container/metric_assembly_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-assembly/pom.xml &&\
mv /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml_bk &&\
cp /container/metric_grafana_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-grafana/pom.xml &&\
mv /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml_bk &&\
cp /container/metric_storm_sink_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-storm-sink/pom.xml &&\
mv /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml_bk &&\
cp /container/metric_timeline_services_pom.xml /usr/local/ambari/ambari-metrics/ambari-metrics-timelineservice/pom.xml &&\
mv /usr/local/ambari/utility/pom.xml /usr/local/ambari/utility/pom.xml_bk &&\
cp /container/utility_pom.xml /usr/local/ambari/utility/pom.xml



ENV JAVA_HOME /usr/local/jdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV MVN_HOME /usr/local/maven
ENV PATH $PATH:$MVN_HOME/bin
ENV MAVEN_OPTS -Xms256m -Xmx512m

RUN /bin/bash -c "echo 'export JAVA_HOME=/usr/local/jdk' >> /root/.bashrc; echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /root/.bashrc; echo 'export MVN_HOME=/usr/local/maven' >> /root/.bashrc; echo 'export PATH=$PATH:$MVN_HOME/bin' >> /root/.bashrc; echo 'export MAVEN_OPTS=\"-Xms256m -Xmx512m\"' >> /root/.bashrc;"


WORKDIR /usr/local/ambari/

#RUN /bin/bash -c "/container/setup.sh"
 
EXPOSE 8080
CMD /usr/sbin/sshd -D
