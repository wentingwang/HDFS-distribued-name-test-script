#! /bin/bash

############################## PRE PROCESSING ################################
#check and process arguments
REQUIRED_NUMBER_OF_ARGUMENTS=2
if [ $# -lt $REQUIRED_NUMBER_OF_ARGUMENTS ]
then
echo "Usage: $0 <path_to_config_file> <command>"
echo "command that run on all name and data nodes "
exit 1
fi

CONFIG_FILE=$1

echo "Config file is $CONFIG_FILE"
echo ""
source $CONFIG_FILE

COMMAND=$2
echo "Command is '$COMMAND'"
for node in ${NAME_NODE//,/ }
do
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "$COMMAND"
done

for node in ${DATA_NODE//,/ }
do
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $node "$COMMAND"
done