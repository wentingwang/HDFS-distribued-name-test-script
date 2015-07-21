CONF_FILE=../../conf/setup-micro.conf
OPERATION="mkdir"
THREAD_NUM="10"
ITEM_NUM=1000000
DIR_NUM="10 100 1000"
REPEAT_NUM=3
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-01.bfd.walmart.com
NODE_TO=cdc-hpcblx033-02.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE
$SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
sleep 10

for exp in $DIR_NUM
do
    ITEM_PER_DIR=$((ITEM_NUM / exp))
    echo "Items per dir: $ITEM_PER_DIR"
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op mkdirs -threads $THREAD_NUM -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -printLatency" >& overflow-nomoving-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    	    
    done
done
$SCRIPT_PATH/stop.sh namenode "$CONF_FILE"