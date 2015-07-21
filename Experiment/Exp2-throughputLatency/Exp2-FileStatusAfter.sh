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
#create files and move to another node
ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op fileStatus -threads 10 -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -keepResults -printLatency" >& after-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c-create.txt    
wget -O "after-fileStatus-$exp-$c.log" "http://$NODE:50070/movens.jsp?path=/nnThroughputBenchmark&server=$NODE_TO" 
sleep 5
	    
for exp in $THREAD_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do	    
        ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE:9000/ -op fileStatus -threads $exp -files $ITEM_NUM -filesPerDir $ITEM_PER_DIR -useExisting -useFederation -keepResults -printLatency" >& after-$OPERATION-$exp-$ITEM_NUM-$ITEM_PER_DIR-$c.txt    
        sleep 2   
    done
done
$SCRIPT_PATH/stop.sh namenode "$CONF_FILE"
$SCRIPT_PATH/stop.sh datanode "$CONF_FILE"
