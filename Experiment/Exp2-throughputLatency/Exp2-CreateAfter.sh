CONF_FILE=../../conf/setup-test.conf
OPERATION="create"
THREAD_NUM="10 20 50"
ITEM_NUM=1000
ITEM_PER_DIR=100
REPEAT_NUM=3
SCRIPT_PATH=../..

echo "$CONF_FILE"

for exp in $THREAD_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    $SCRIPT_PATH/command.sh "$CONF_FILE" "sudo rm -rf /data1/dfs/name"
	    $SCRIPT_PATH/command.sh "$CONF_FILE" "sudo /home/wwang27/hadoop-2.6.0/bin/hdfs namenode -format -clusterid nn -force"
	    $SCRIPT_PATH/start.sh namenode "$CONF_FILE"
	    $SCRIPT_PATH/start.sh datanode "$CONF_FILE"
	    sleep 5
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/hadoop-2.6.0/bin/hadoop fs -mkdir /data1/nnThroughputBenchmark"
	    wget -O "after-create-$exp-$c.log" "http://cdc-hpcblx033-13.bfd.walmart.com:50070/movens.jsp?path=/nnThroughputBenchmark&server=cdc-hpcblx033-14.bfd.walmart.com"
	    #sleep 5
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/hadoop-2.6.0/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://cdc-hpcblx033-13.bfd.walmart.com:9000/ -op create -threads $exp -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -keepResults -printLatency" >& after-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    $SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
	    $SCRIPT_PATH/stop.sh datanode "$CONF_FILE"
    done
done
