#!/bin/bash

# 从文件中读取 JSON 数据
json=$(cat /root/Tucana/potv/deployed-addresses.json)

# 提取变量并赋值到局部变量中
Config=$(echo $json | jq -r '.Config')
PriceFeed=$(echo $json | jq -r '.PriceFeed')
ChainContract=$(echo $json | jq -r '.ChainContract')
Lend=$(echo $json | jq -r '.Lend')
Pool=$(echo $json | jq -r '.Pool')
Collateral_1=$(echo $json | jq -r '.Collateral_1')
Collateral_2=$(echo $json | jq -r '.Collateral_2')

# 输出变量的值
echo "Config: $Config"
echo "PriceFeed: $PriceFeed"
echo "ChainContract: $ChainContract"
echo "Lend: $Lend"
echo "Pool: $Pool"
echo "Collateral_1: $Collateral_1"
echo "Collateral_2: $Collateral_2"


cast call $PriceFeed "owner()(address)"

### cast query
cast call $Pool "getUserTokenSupply(address user, address tokenType)(uint256)" \
0x0ceEC05D21fAd69e1CA3FC2fD0dc948576B549C2 $Collateral_1

cast call $Pool "getUserTotalBorrow(address user)(uint256)" \
0x0ceEC05D21fAd69e1CA3FC2fD0dc948576B549C2


cast call $Pool "getSystemTokenTotalSupply(address tokenType)(uint256)" \
0x0ceEC05D21fAd69e1CA3FC2fD0dc948576B549C2



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
