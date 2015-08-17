#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=3
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <type_of_start> <path_to_config_file> <-h for hard or -s for soft>"
echo "Type of start: namenode or datanode "
echo "mode of start: -h hard for delete and format"
echo "               -s soft for start process only "
exit 1
fi

CONFIG_FILE=$2

echo "Config file is $CONFIG_FILE"
echo ""
source $CONFIG_FILE

if [ "$3" == "-h" ]
then
	MODE=0
elif [ "$3" == "-s" ]
then
	MODE=1
else
		echo "Unrecongized start type: -s or -h"
		exit 1
fi

##############################START NAME/DATA NODE##############################

if [ "$1" == "namenode" ]
then
COMMAND_START="sudo $HADOOP_HOME/sbin/start-dfs.sh"
if [ "$3" == "-h" ]
then
    for node in ${NAME_NODE//,/ }
    do
    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "sudo rm -rf /data1/dfs/name;sudo $HADOOP_HOME/bin/hdfs namenode -format -clusterid nn -force"
    done
fi

for node in ${NAME_NODE//,/ }
do
    echo "Start name node in $node in $COMMAND_START"
    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "$COMMAND_START"
    break
done

elif [ "$1" == "datanode" ]
then
    COMMAND="sudo HADOOP_SECURE_DN_USER=$USER $HADOOP_HOME/sbin/hadoop-daemon.sh --config $HADOOP_HOME/etc/hadoop --script hdfs start datanode"
    for node in ${DATA_NODE//,/ }
    do
        echo "Start name node in $node in sudo $COMMAND"
        ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "$COMMAND"
        SLEEP 20
    done
else
    echo "Unrecongized start type: namenode or datanode"
    exit 1
fi



