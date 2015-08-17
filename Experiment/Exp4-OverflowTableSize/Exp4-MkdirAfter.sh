CONF_FILE=../../conf/setup-automation.conf
OPERATION="mkdir"
THREAD_NUM="10"
ITEM_NUM=1000000
DIR_NUM="1000 100"
REPEAT_NUM=3
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-13.bfd.walmart.com
NODE_TO=cdc-hpcblx033-14.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE

#iterate on # of sub-dir
for exp in $DIR_NUM
do
    ITEM_PER_DIR=$((ITEM_NUM / exp))
    echo "Items per dir: $ITEM_PER_DIR ; Total Dir: $exp"
    
    #Repeat experiment for $REPEAT_NUM times
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    $SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
	    sleep 10
	    #mkdir and move $exp number of sub-dir from one node to another
	    for (( i=0; i<$exp; i++ ))
	    do
		    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop fs -mkdir -p /data1/nnThroughputBenchmark/mkdirs/ThroughputBenchDir$i"
		    wget -O "movens-$exp-$c-$i.log" "http://$NODE:50070/movens.jsp?path=/nnThroughputBenchmark/mkdirs/ThroughputBenchDir$i&server=$NODE_TO"
	    done
	    #after moving, benchmark performance
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op mkdirs -threads $THREAD_NUM -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -keepResults -printLatency" >& overflow-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    sleep 10
	    $SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
    done
done
