CONF_FILE=../../conf/setup-micro.conf
MKDIR_NUM="10000"
REPEAT_NUM=3
NODE_FROM=cdc-hpcblx033-17.bfd.walmart.com
NODE_TO=cdc-hpcblx033-18.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE

for exp in $MKDIR_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    echo "$exp-$c.log"
	    ../../start.sh namenode "$CONF_FILE" -h
	    sleep 10
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE_FROM "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://$NODE_FROM:9000/ -op mkdirs -threads 50 -dirs $exp -dirsPerDir $exp -keepResults" >& Exp1-$exp-$c-ops.log
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE_FROM "sudo $HADOOP_HOME/bin/hadoop fs -ls /data1/nnThroughputBenchmark/mkdirs/ThroughputBenchDir0" >& Exp1-$exp-$c-mkdir-result.log
	    wget -O "$exp-$c.log" "http://$NODE_FROM:50070/movens.jsp?path=/nnThroughputBenchmark/mkdirs/ThroughputBenchDir0&server=$NODE_TO"  
	    ../../stop.sh namenode "$CONF_FILE"
    done
done 