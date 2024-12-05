#!/bin/bash

remote_host=$1
remote_port=$2
agent_api_name=$3
agent_api_port=$4
agent_id=$5
agent_token=$6

echo "Installing agent..."
pip install -e /etc/mounted_agent > /dev/null
echo "The agent has been installed. Start running harness."

curl -s -X GET -H "Authorization: Bearer $agent_token" "$remote_host:$remote_port/registry/agent-manifest/$agent_id" > /tmp/agent-manifest.json
echo "Agent manifest has been obtained."

python -u agent_bench_automation/agent_harness/main.py \
        --host $agent_api_name \
        --port $agent_api_port \
        --agent_directory /etc/mounted_agent \
        -i /tmp/agent-manifest.json