#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=2
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_config_file> <type_of_start> "
echo "Type of command: start-all [-s soft or -h hard],
                       stop-all,
			  deploy-all,
			  deploy-jar,
			  deploy-test-jar,
			  deploy-hdfs-jar,
			  deploy-config,
			  compile"
exit 1
fi

CONFIG_FILE=$1
source $CONFIG_FILE

if [ "$2" == "start-all" ]
then	
	if [ "$3" == "-h" -o "$3" == "-s" ]
	then
		./start.sh namenode $1 $3
		./start.sh datanode $1 $3
	else
		echo "Unrecongized start type: -s or -h"
		exit 1
	fi

elif [ "$2" == "stop-all" ]
then

	./stop.sh namenode $1
	./stop.sh datanode $1

elif [ "$2" == "deploy-all" ]
then
	# deploy from scratch
	./deploy.sh -s $1
elif [ "$2" == "deploy-jar" ]
then
	# deploy all jars
	./deploy.sh -j $1
elif [ "$2" == "deploy-test-jar" ]
then
	#deploy test-hdfs-2.6.0.jar
	./deploy.sh -t $1
elif [ "$2" == "deploy-hdfs-jar" ]
then
	#deploy hdfs-2.6.0.jar
	./deploy.sh -h $1
elif [ "$2" == "deploy-config" ]
then
	#deploy all config files
	./deploy.sh -c $1
elif [ "$2" == "compile" ]
then
	./compile.sh $1
else
	echo "Unrecongized command type: 
	                start-all [-s soft or -h hard],
                       stop-all [-s soft or -h hard],
			  deploy-all,
			  deploy-test-jar,
			  deploy-hdfs-jar,
			  deploy-jar,
			  deploy-config,
			  compile"
	exit 1
fi

