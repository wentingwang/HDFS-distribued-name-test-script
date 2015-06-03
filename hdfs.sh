#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=2
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_config_file> <type_of_start> "
echo "Type of command: start-all [-s soft or -h hard],
                       stop-all [-s soft or -h hard],
			  deploy-all,
			  deploy-jar,
			  deploy-config,
			  compile"
exit 1
fi

CONFIG_FILE=$1
source $CONFIG_FILE

if [ "$2" == "start-all" ]
then
	if [ "$3" == "-h" ]
	then
		echo "$3"
	fi
	
	if [ "$3" == "-h" -o "$3" == "-s" ]
	then
		./start.sh namenode $1
		./start.sh datanode $1
	else
		echo "Unrecongized start type: -s or -h"
		exit 1
	fi

elif [ "$2" == "stop-all" ]
then
	if [ "$3" == "-h"]
	then
		echo "$3"
	fi
	
	if [ "$3" == "-h" -o "$3" == "-s" ]
	then
		./stop.sh namenode $1
		./stop.sh datanode $1
	else
		echo "Unrecongized start type: -s or -h"
		exit 1
	fi

elif [ "$2" == "deploy-all" ]
then
	./deploy.sh -s $1
elif [ "$2" == "deploy-jar" ]
then
	./deploy.sh -j $1
elif [ "$2" == "deploy-config" ]
then
	./deploy.sh -c $1
elif [ "$2" == "compile" ]
then
	./compile.sh $1
else
	echo "Unrecongized command type: 
	                start-all [-s soft or -h hard],
                       stop-all [-s soft or -h hard],
			  deploy-all,
			  deploy-jar,
			  deploy-config,
			  compile"
	exit 1
fi

