CONF_FILE=../../conf/setup-micro.conf
OPERATION="mkdir"
THREAD_NUM="10 20 50"
ITEM_NUM=1000
ITEM_PER_DIR=100
REPEAT_NUM=3
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-01.bfd.walmart.com
NODE_TO=cdc-hpcblx033-02.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE

#iterate on the number of threads
for exp in $THREAD_NUM
do
    #repeat $REPEAT_NUM times
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    #start cluster
	    $SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
	    sleep 10
	    #create parent dir and move
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop fs -mkdir /data1/nnThroughputBenchmark"
	    wget -O "after-$exp-$c.log" "http://$NODE:50070/movens.jsp?path=/nnThroughputBenchmark&server=$NODE_TO"
	    sleep 5
	    #benchmark performance
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op mkdirs -threads $exp -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -keepResults -printLatency" >& after-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    $SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
    done
done
