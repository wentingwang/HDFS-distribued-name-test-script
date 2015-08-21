CONF_FILE=../../conf/setup-micro.conf
START_NUM=$1
REPEAT_NUM=$2
SCRIPT_PATH=../..
NODE=cdc-hpcblx033-17.bfd.walmart.com
SPLIT_FILE_NUM=10


echo "$CONF_FILE"
source $CONF_FILE


#for (( c=1; c<=$SPLIT_FILE_NUM; c++ ))
#do
#    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.RealWorkloadGeneratorImpv hdfs://$NODE:9000 -op mkdir -threads 20 -path /data1/test1/ -file $HADOOP_HOME/bin/directory.log.$c"   
#done

for (( i=$START_NUM; i<=$REPEAT_NUM; i++ ))
do
	for (( c=1; c<=$SPLIT_FILE_NUM; c++ ))
	do
	    ssh -t -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $NODE "sudo $HADOOP_HOME/bin/hadoop org.apache.hadoop.hdfs.server.namenode.RealWorkloadGeneratorImpv hdfs://$NODE:9000 -op mkdir -threads 20 -path /data1/test$i/ -file $HADOOP_HOME/bin/directory.log.$c"   
	    sleep 10
	done
done
	