REPEAT_NUM=3
NODE=cdc-hpcblx033-01
THREAD_NUM="10 20 50 100"
name=16nn
randomNumber=8

for (( i=1; i<=$REPEAT_NUM; i++ ))
do
	for thread in $THREAD_NUM
	do
	    echo "thread: $thread exp:$i"
	    #sudo bin/hadoop org.apache.hadoop.hdfs.server.namenode.RealWorkloadGeneratorImpv hdfs://$NODE:9000 -op access -threads $thread -path /test -file bin/directory.log -random 100 -prefixNumber $randomNumber -printLatency &> access-$name-$thread-100-$i.log   
	    #sudo bin/hadoop org.apache.hadoop.hdfs.server.namenode.RealWorkloadGeneratorImpv hdfs://$NODE:9000 -op access -threads $thread -path /test -file bin/directory.log -random 1000 -prefixNumber $randomNumber -printLatency &> access-$name-$thread-1000-$i.log   
	    sudo bin/hadoop org.apache.hadoop.hdfs.server.namenode.RealWorkloadGeneratorImpv hdfs://$NODE:9000 -op create -threads $thread -path /data1/test -file bin/directory.log -random 100 -prefixNumber $randomNumber -subDir /test3 -printLatency &> create-$name-$thread-100-$i.log  
	    sleep 5
	done
done
