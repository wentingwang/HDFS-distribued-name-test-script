#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=2
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <type_of_start> <path_to_config_file>"
echo "Type of start: -j for all jars, -c for config files + all jars, -s for scratch(hadoop file+config files+alljars) "
exit 1
fi

CONFIG_FILE=$2

echo "Config file is $CONFIG_FILE"
echo ""
source $CONFIG_FILE

##############################Copy files##############################

if [ "$1" == "-s" ]
then
	
	TAR_FILE_NAME=$(basename $LOCAL_HADOOP_FILE)
	echo "Step1: Copy hadoop binary file $TAR_FILE_NAME and extract here"
	for node in ${NAME_NODE//,/ }
	do
	    echo "Scp $LOCAL_HADOOP_FILE to $node:$HADOOP_DIR"
	    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "mkdir -p $HADOOP_DIR"
	    scp $LOCAL_HADOOP_FILE $node:$HADOOP_DIR/
	    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "tar -xzvf $HADOOP_DIR/$TAR_FILE_NAME -C $HADOOP_DIR"
	    #TO-DO chech if HADOOP_NAME == directory after tar
	done
	
	for node in ${DATA_NODE//,/ }
	do
   	    echo "Scp $LOCAL_HADOOP_FILE to $node:$HADOOP_DIR"
	    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "mkdir -p $HADOOP_DIR"
   	    scp $LOCAL_HADOOP_FILE $node:$HADOOP_DIR/
   	    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "tar -xzvf $HADOOP_DIR/$TAR_FILE_NAME -C $HADOOP_DIR"
   	    #TO-DO chech if HADOOP_NAME == directory after tar
	done
fi

if [ "$1" == "-s" -o  "$1" == "-c" ]
then
	echo "Step2: Copy all config files to name nodes and data ndoes"
	for node in ${NAME_NODE//,/ }
	do
	    echo "$node:
	    scp $NAME_NODE_CONF --> $HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/core-site.xml --> $HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/hadoop-env.sh --> $HADOOP_HOME/etc/hadoop/
	    scp $JAR_DIR/web.xml --> $HADOOP_HOME/share/hadoop/hdfs/webapps/hdfs/WEB-INF/"
	    #TO-DO check if HADOOP_HOME exists
	    scp $NAME_NODE_CONF $node:$HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/core-site.xml $node:$HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/hadoop-env.sh $node:$HADOOP_HOME/etc/hadoop/
	    scp $JAR_DIR/web.xml $node:$HADOOP_HOME/share/hadoop/hdfs/webapps/hdfs/WEB-INF/
	    
	done
	
	for node in ${DATA_NODE//,/ }
	do
   	    echo "$node:
	    scp $DATA_NODE_CONF --> $HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/core-site.xml --> $HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/hadoop-env.sh --> $HADOOP_HOME/etc/hadoop/"
	    #TO-DO check if HADOOP_HOME exists
	    scp $DATA_NODE_CONF $node:$HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/core-site.xml $node:$HADOOP_HOME/etc/hadoop/
	    scp $OTHER_CONF_DIR/hadoop-env.sh $node:$HADOOP_HOME/etc/hadoop/
	    
	done
fi

if [ "$1" == "-s"  -o "$1" == "-j" ]
then
       echo "Copy hdfs jar to hadoop home"
	for node in ${NAME_NODE//,/ }
	do
	    echo "$node:
	    scp $JAR_DIR/*.jar --> $HADOOP_HOME/share/hadoop/hdfs"
	    #TO-DO check if HADOOP_HOME exists
	    scp $JAR_DIR/*.jar $node:$HADOOP_HOME/share/hadoop/hdfs   
	done
	
	for node in ${DATA_NODE//,/ }
	do
   	    echo "$node:
	    scp $JAR_DIR/*.jar --> $HADOOP_HOME/share/hadoop/hdfs"
	    #TO-DO check if HADOOP_HOME exists
	    scp $JAR_DIR/*.jar $node:$HADOOP_HOME/share/hadoop/hdfs
	    
	done
	
else
	echo "Unrecongized start type: -h, -c, or -s"
	exit 1	
fi
