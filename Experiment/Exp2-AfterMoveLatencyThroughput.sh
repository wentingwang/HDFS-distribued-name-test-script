CONF_FILE=../conf/setup-test.conf
OPERATION="mkdir"
THREAD_NUM="10 20 50"
ITEM_NUM=10000
ITEM_PER_DIR=100
REPEAT_NUM=1

echo "$CONF_FILE"

for exp in $THREAD_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    ../command.sh "$CONF_FILE" "sudo rm -rf /data1/dfs/name"
	    ../command.sh "$CONF_FILE" "sudo /home/wwang27/test/hadoop-2.6.0/bin/hdfs namenode -format -clusterid nn -force"
	    ../start.sh namenode "$CONF_FILE"
	    sleep 10
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/test/hadoop-2.6.0/bin/hadoop fs -mkdir /data1/nnThroughputBenchmark"
	    wget -O "after-$exp-$c.log" "http://cdc-hpcblx033-13.bfd.walmart.com:50070/movens.jsp?path=/nnThroughputBenchmark&server=cdc-hpcblx033-14.bfd.walmart.com"
	    sleep 5
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/test/hadoop-2.6.0/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://cdc-hpcblx033-13.bfd.walmart.com:9000/ -op mkdirs -threads $exp -dirs $ITEM_NUM -dirsPerDir $ITEM_PER_DIR -keepResults -printLatency" >& after-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    ../stop.sh namenode "$CONF_FILE"
    done
done
