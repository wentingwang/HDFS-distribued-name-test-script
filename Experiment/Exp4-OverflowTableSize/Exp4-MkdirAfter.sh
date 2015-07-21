CONF_FILE=../../conf/setup-micro.conf
OPERATION="mkdir"
THREAD_NUM="10"
ITEM_NUM=1000000
DIR_NUM="1000 10"
REPEAT_NUM=2
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-01.bfd.walmart.com
NODE_TO=cdc-hpcblx033-02.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE

for exp in $DIR_NUM
do
    ITEM_PER_DIR=$((ITEM_NUM / exp))
    echo "Items per dir: $ITEM_PER_DIR ; Total Dir: $exp"
    
    for (( c=2; c<=$REPEAT_NUM; c++ ))
    do
	    $SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
	    sleep 10
	    for (( i=0; i<$exp; i++ ))
	    do
		    echo $i
		    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop fs -mkdir -p /data1/nnThroughputBenchmark/mkdirs/ThroughputBenchDir$i"
		    wget -O "movens-$exp-$c-$i.log" "http://$NODE:50070/movens.jsp?path=/nnThroughputBenchmark/mkdirs/ThroughputBenchDir$i&server=$NODE_TO"
	    done
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op mkdirs -threads $THREAD_NUM -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -keepResults -printLatency" >& overflow-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    $SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
    done
done
