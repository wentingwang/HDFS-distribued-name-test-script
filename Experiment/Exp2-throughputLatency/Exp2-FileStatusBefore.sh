CONF_FILE=../../conf/setup-micro.conf
OPERATION="fileStatus"
THREAD_NUM="10 20 50"
ITEM_NUM=10000
ITEM_PER_DIR=100
REPEAT_NUM=3
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-01.bfd.walmart.com
NODE_TO=cdc-hpcblx033-02.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE

#start namenode and datanode
$SCRIPT_PATH/start.sh namenode "$CONF_FILE" -h
$SCRIPT_PATH/start.sh datanode "$CONF_FILE" -h
#create files
ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op fileStatus -threads 50 -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -keepResults -printLatency" >& before-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c-create.txt    
sleep 2
	    
for exp in $THREAD_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do	    
	    #ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/test/hadoop-2.6.0/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://cdc-hpcblx033-13.bfd.walmart.com:9000/ -op fileStatus -threads $exp -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -useExisting -keepResults -printLatency" >& before-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op fileStatus -threads $exp -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -useExisting -useFederation -keepResults -printLatency" >& before-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt
           sleep 2
    done
done
$SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
$SCRIPT_PATH/stop.sh datanode "$CONF_FILE"