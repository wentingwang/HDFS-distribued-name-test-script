CONF_FILE=../conf/setup-test.conf
MKDIR_NUM="1000000"
REPEAT_NUM=1

echo "$CONF_FILE"

for exp in $MKDIR_NUM
do
    
    for (( c=1; c<=$REPEAT_NUM; c++ ))
    do
	    echo "$exp-$c.log"
	    ../command.sh "$CONF_FILE" "sudo rm -rf /data1/dfs/name"
	    ../command.sh "$CONF_FILE" "sudo /home/wwang27/test/hadoop-2.6.0/bin/hdfs namenode -format -clusterid nn -force"
	    ../start.sh namenode "$CONF_FILE"
	    sleep 10
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/test/hadoop-2.6.0/bin/hadoop org.apache.hadoop.hdfs.server.namenode.NNThroughputBenchmarkWenting hdfs://cdc-hpcblx033-13.bfd.walmart.com:9000/ -op mkdirs -threads 50 -dirs $exp -dirsPerDir $exp -keepResults" >& Exp1-$exp-$c-ops.log
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cdc-hpcblx033-13.bfd.walmart.com "sudo /home/wwang27/test/hadoop-2.6.0/bin/hadoop fs -ls /data1/nnThroughputBenchmark/mkdirs/ThroughputBenchDir0" >& Exp1-$exp-$c-mkdir-result.log
	    wget -O "$exp-$c.log" "http://cdc-hpcblx033-13.bfd.walmart.com:50070/movens.jsp?path=/nnThroughputBenchmark/mkdirs/ThroughputBenchDir0&server=cdc-hpcblx033-14.bfd.walmart.com"  
	    #../stop.sh namenode "$CONF_FILE"
    done
done





#./command.sh ./conf/setup-test.conf "sudo rm -rf /data1/dfs/name"
#./command.sh ./conf/setup-test.conf "sudo /home/wwang27/test/hadoop-2.6.0/bin/hdfs namenode -format -clusterid nn -force"
#./start.sh namenode ./conf/setup-test.conf 
#wget -O 100_2.log "http://cdc-hpcblx033-13.bfd.walmart.com:50070/movens.jsp?path=/nnThroughputBenchmark/mkdirs/ThroughputBenchDir0&server=cdc-hpcblx033-14.bfd.walmart.com"  