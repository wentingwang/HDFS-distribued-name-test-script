CONF_FILE=../../conf/setup-micro.conf
OPERATION="mkdir"
THREAD_NUM="10 20 50"
ITEM_NUM=10000
ITEM_PER_DIR=100
REPEAT_NUM=3
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-01.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE
#start clsuter
$SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
sleep 15
#iterate on the number of threads    
for exp in $THREAD_NUM
do
	#repeat $REPEAT_NUM times
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do	    
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op mkdirs -threads $exp -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -keepResults -printLatency" >& before-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op clean"
	    
    done
done
#shutdown cluster
$SCRIPT_PATH/stop.sh namenode "$CONF_FILE"