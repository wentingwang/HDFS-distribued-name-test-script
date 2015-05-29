#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=2
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_config_file> <type_of_start> "
echo "Type of start: namenode or datanode "
exit 1
fi

CONFIG_FILE=$2

echo "Config file is $CONFIG_FILE"
echo ""
source $CONFIG_FILE

##############################START NAME/DATA NODE##############################

if [ "$1" == "namenode" ]
then
COMMAND="sudo $HADOOP_HOME/sbin/start-dfs.sh"
for node in ${NAME_NODE//,/ }
do
echo "Start name node in $node in $COMMAND"
ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "
$COMMAND"
break
done

elif [ "$1" == "datanode" ]
then
COMMAND="sudo HADOOP_SECURE_DN_USER=$USER $HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs start datanode"
for node in ${DATA_NODE//,/ }
do
echo "Start name node in $node in sudo $COMMAND"
ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "
$COMMAND"
SLEEP 5
done
else
echo "Unrecongized start type: namenode or datanode"
exit 1
fi



