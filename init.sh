KEY1="key1"
KEY2="key2"
KEY3="key3"
KEY4="key4"
WALLET1="WALLET1"
WALLET2="WALLET2"
WALLET3="WALLET3"
WALLET4="WALLET4"
WALLET5="WALLET5"
WALLET6="WALLET6"
WALLET7="WALLET7"
WALLET8="WALLET8"
WALLET9="WALLET9"
WALLET10="WALLET10"
CHAINID="tucana_712-1"
MONIKER1="validator1"
MONIKER2="validator2"
MONIKER3="validator3"
MONIKER4="validator4"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
HOME=$PWD

rm -rf .tucd .tucd2 .tucd3 .tucd4

# if $KEY exists it should be deleted
tucd keys add $KEY1 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $KEY2 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $KEY3 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $KEY4 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET1 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET2 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET3 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET4 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET5 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET6 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET7 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET8 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET9 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10
tucd keys add $WALLET10 --keyring-backend $KEYRING --algo $KEYALGO
echo "generate key"
sleep 10

# Set moniker and chain-id for Canto (Moniker can be anything, chain-id must be an integer)
tucd init $MONIKER1 --chain-id $CHAINID

# Change parameter token denominations to utuc
cat $HOME/.tucd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["staking"]["params"]["max_validators"]=7' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["gov"]["params"]["min_deposit"][0]["denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["gov"]["params"]["expedited_min_deposit"][0]["denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["coinswap"]["params"]["pool_creation_fee"]["denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json
cat $HOME/.tucd/config/genesis.json | jq '.app_state["coinswap"]["standard_denom"]="utuc"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json

# change downtime slash to longer
cat $HOME/.tucd/config/genesis.json | jq '.app_state["slashing"]["params"]["signed_blocks_window"]=30000' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json

# change max gas
cat $HOME/.tucd/config/genesis.json | jq '.consensus["params"]["block"]["max_gas"]="30000000"' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json



#sed -i '/\[json-rpc\]/a enable-websocket = true' $HOME/.tucd/config/app.toml
sed -i 's/laddr = "tcp:\/\/127.0.0.1:26657"/laddr = "tcp:\/\/0.0.0.0:26657"/' $HOME/.tucd/config/config.toml
sed -i 's/prometheus = false/prometheus = true/' $HOME/.tucd/config/config.toml
sed -i 's/minimum-gas-prices = "0utuc"/minimum-gas-prices = "0.0001utuc"/' $HOME/.tucd/config/app.toml
sed -i 's/api = "eth,net,web3"/api = "eth,txpool,personal,net,debug,web3"/' $HOME/.tucd/config/app.toml
sed -i "s/chain-id = \"ethermint_9000-1\"/chain-id = \"$CHAINID\"/" $HOME/.tucd/config/client.toml

# Allocate genesis accounts (cosmos formatted addresses)
tucd add-genesis-account $KEY1 5000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $KEY2 5000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $KEY3 5000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $KEY4 5000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET1 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET2 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET3 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET4 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET5 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET6 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET7 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET8 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET9 98000000000000000000000000utuc --keyring-backend $KEYRING
tucd add-genesis-account $WALLET10 98000000000000000000000000utuc --keyring-backend $KEYRING

# Update total supply with claim values
total_supply=1000000000000000000000000000
cat $HOME/.tucd/config/genesis.json | jq -r --arg total_supply "$total_supply" '.app_state["bank"]["supply"][0]["amount"]=$total_supply' > $HOME/.tucd/config/tmp_genesis.json && mv $HOME/.tucd/config/tmp_genesis.json $HOME/.tucd/config/genesis.json


tucd init $MONIKER2 --chain-id $CHAINID --home ~/.tucd2
cp -r ~/.tucd/keyring-test $HOME/.tucd2
cp $HOME/.tucd/config/genesis.json $HOME/.tucd2/config/genesis.json

tucd init $MONIKER3 --chain-id $CHAINID --home ~/.tucd3
cp -r ~/.tucd/keyring-test $HOME/.tucd3
cp $HOME/.tucd/config/genesis.json $HOME/.tucd3/config/genesis.json

tucd init $MONIKER4 --chain-id $CHAINID --home ~/.tucd4
cp -r ~/.tucd/keyring-test $HOME/.tucd4
cp $HOME/.tucd/config/genesis.json $HOME/.tucd4/config/genesis.json


echo $KEYRING
echo $KEY1
# Sign genesis transaction
mkdir $HOME/.tucd/config/gentx
tucd gentx $KEY1 4000000000000000000000000utuc --commission-rate 0.1 --commission-max-rate 1.0 --commission-max-change-rate 1.0 --keyring-backend $KEYRING --chain-id $CHAINID --output-document $HOME/.tucd/config/gentx/gentx-1.json
tucd gentx $KEY2 4000000000000000000000000utuc --commission-rate 0.1 --commission-max-rate 1.0 --commission-max-change-rate 1.0 --keyring-backend $KEYRING --chain-id $CHAINID --output-document $HOME/.tucd/config/gentx/gentx-2.json --home ~/.tucd2
tucd gentx $KEY3 4000000000000000000000000utuc --commission-rate 0.1 --commission-max-rate 1.0 --commission-max-change-rate 1.0 --keyring-backend $KEYRING --chain-id $CHAINID --output-document $HOME/.tucd/config/gentx/gentx-3.json --home ~/.tucd3
tucd gentx $KEY4 4000000000000000000000000utuc --commission-rate 0.1 --commission-max-rate 1.0 --commission-max-change-rate 1.0 --keyring-backend $KEYRING --chain-id $CHAINID --output-document $HOME/.tucd/config/gentx/gentx-4.json --home ~/.tucd4


# Collect genesis tx
tucd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
tucd validate-genesis

cp $HOME/.tucd/config/genesis.json $HOME/.tucd2/config/genesis.json
cp $HOME/.tucd/config/genesis.json $HOME/.tucd3/config/genesis.json
cp $HOME/.tucd/config/genesis.json $HOME/.tucd4/config/genesis.json

cp -r $HOME/.tucd ./tucd

# edit each config.toml and app.toml to change ports, moniker and add peers, if run 4 node under the same ip, set `allow_duplicate_ip = true` in config.toml, then start 4 nodes
# tucd start --chain-id canto_7900-1
# tucd start --chain-id canto_7900-1 --home ~/.tucd2
# tucd start --chain-id canto_7900-1 --home ~/.tucd3
# tucd start --chain-id canto_7900-1 --home ~/.tucd4

