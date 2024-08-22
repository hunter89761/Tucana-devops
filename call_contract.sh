#!/bin/bash

# 从文件中读取 JSON 数据
json=$(cat ~/workspace/initia-2/Tucana/potv/deployed-addresses.json)

# 提取变量并赋值到局部变量中
Config=$(echo $json | jq -r '.Config')
PriceFeed=$(echo $json | jq -r '.PriceFeed')
ChainContract=$(echo $json | jq -r '.ChainContract')
Lend=$(echo $json | jq -r '.Lend')

# 输出变量的值
echo "Config: $Config"
echo "PriceFeed: $PriceFeed"
echo "ChainContract: $ChainContract"
echo "Lend: $Lend"

### cast demo: query contract
cast call 0x1234567890abcdef1234567890abcdef12345678 "getValue()"

### cast demo: call contract
cast send 0x1234567890abcdef1234567890abcdef12345678 "setValue(uint256)" \
42 --private-key f08a80d51fd9f9fa6cdbe450af4d2aa98a5d2632ab4847cfeac77233c911f832

### cast demo: query
cast call 0x1234567890abcdef1234567890abcdef12345678 \
"getBalance(address)" 0xAbCdef1234567890abcdef1234567890AbCdEf01

### cast demo: call contract
cast send 0x1234567890abcdef1234567890abcdef12345678 \
"transfer(address,uint256)" 0xAbCdef1234567890abcdef1234567890AbCdEf01 1000000000000000000 \
--private-key f08a80d51fd9f9fa6cdbe450af4d2aa98a5d2632ab4847cfeac77233c911f832
