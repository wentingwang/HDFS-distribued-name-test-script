#! /bin/bash

#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=3
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_raw_files> [-c command or -o output] [command or output file]"
exit 1
fi

FOLDER=$1

if [ "$2" == "-c" ]
then
	TYPE_OF_OUTPUT=1
	COMMAND=$3
elif [ "$2" == "-o" ]
then
	TYPE_OF_OUTPUT=0
	OUTPUT_FILE=$3
fi

for file in $FOLDER/*.txt
do
	awk '{print $1,$10}' $file | while read permission path;       
	do
	#echo "$path"  
	if [[ $permission == d* ]]
	then
	   if [ $TYPE_OF_OUTPUT -eq 1 ]
	   then
		   echo "$path"
	   else
	   #output to a file
              echo "$path" >> $OUTPUT_FILE
          fi
	   
       fi           
	done
done