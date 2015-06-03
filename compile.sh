#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=1
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_config_file>"
exit 1
fi

CONFIG_FILE=$1

echo "Config file is $CONFIG_FILE"
echo ""
source $CONFIG_FILE

#####Compile Hadoop Code and copy jar and web.xml to specified location #######

echo "Compile HDFS project in $LOCAL_HADOOP_HOME/hadoop-hdfs-project"
cd $LOCAL_HADOOP_HOME
export MAVEN_OPTS=-Xmx3000m
mvn clean package -DskipTests

sleep 2

echo "Copy $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.6.0.jar to $JAR_DIR"
cp $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.6.0.jar $JAR_DIR

echo "Copy $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.6.0-tests.jar to $JAR_DIR"
cp $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/hadoop-hdfs-2.6.0-tests.jar $JAR_DIR

echo "Copy $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/webapps/hdfs/WEB-INF/web.xml to ß$JAR_DIR"
cp $LOCAL_HADOOP_HOME/hadoop-hdfs-project/hadoop-hdfs/target/webapps/hdfs/WEB-INF/web.xml $JAR_DIR