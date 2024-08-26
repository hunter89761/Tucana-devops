deploy USER=init14cfsu664xrm3wd82jen4h4jsjnd2y6qcmzdl05

../../../initia/minitiad move deploy --path ./ --from $USER --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1 --gas-prices 0.15utuc --gas-adjustment 1.5 --gas auto --upgrade-policy COMPATIBLE

Set Oracle COLLATERAL=0xeb85af3fac00260b3f802aa1b8443da571ab28a823ba4d3c982553b9727625df DECIMAL=6

../../../initia/minitiad tx move execute $USER pricefeed set_non_native_token_config --args "address:$COLLATERAL u64:$DECIMAL" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

../../../initia/minitiad tx move execute $USER pricefeed update_non_native_token_price --args "address:$COLLATERAL u256:1000000" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1 Add collateral

../../../initia/minitiad tx move execute $USER config add_collateral --args "address:$COLLATERAL u256:$DECIMAL" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Set validator

vector in cli ../../../initia/minitiad tx move execute $USER chain set_validators --args 'vector

:[init14cfsu664xrm3wd82jen4h4jsjnd2y6qcmzdl05,init1rzuckk5hhrt8hy5xpl7ezk7nhcf9mced0q0rc9]' --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1
Supply AMOUNT=1000000 VALIDATOR=init14cfsu664xrm3wd82jen4h4jsjnd2y6qcmzdl05 ../../../initia/minitiad tx move execute $USER lend supply --args "address:$COLLATERAL u256:$AMOUNT address:$VALIDATOR" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Borrow BORROW_AMOUNT=100000 ../../../initia/minitiad tx move execute $USER lend borrow --args "u256:$BORROW_AMOUNT" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Repay REPAY_AMOUNT=1000 ../../../initia/minitiad tx move execute $USER lend repay --args "u256:$REPAY_AMOUNT" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Withdraw WITHDRAW_AMOUNT=44444 ../../../initia/minitiad tx move execute $USER lend withdraw --args "address:$COLLATERAL u256:$WITHDRAW_AMOUNT address:$VALIDATOR" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Migrate DELETED_VALIDATOR=init14cfsu664xrm3wd82jen4h4jsjnd2y6qcmzdl05 NEW_VALIDATOR=init1rzuckk5hhrt8hy5xpl7ezk7nhcf9mced0q0rc9 ../../../initia/minitiad tx move execute $USER chain migrate_stakes --args "address:$DELETED_VALIDATOR address:$NEW_VALIDATOR" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1 Get Total Supply ../../../initia/minitiad query move view $USER pool get_user_token_supply --node https://rpc.birdee-1.tucana.zone:443 --args "address:$USER address:$COLLATERAL"

GET Vlidator Stake

VALIDATOR=init1rzuckk5hhrt8hy5xpl7ezk7nhcf9mced0q0rc9 ../../../initia/minitiad query move view $USER chain get_user_validator_token_stake --node https://rpc.birdee-1.tucana.zone:443 --args "address:$USER address:$VALIDATOR address:$COLLATERAL"

Get Staked users number VALIDATOR=init1rzuckk5hhrt8hy5xpl7ezk7nhcf9mced0q0rc9 ../../../initia/minitiad query move view $USER chain get_staked_users --node https://rpc.birdee-1.tucana.zone:443 --args "address:$VALIDATOR" Get Total Borrow ../../../initia/minitiad query move view $USER pool get_user_total_borrow --node https://rpc.birdee-1.tucana.zone:443 --args "address:$USER" Set Liquidation Rate LIQUIDATE_RATE=10000000

../../../initia/minitiad tx move execute $USER config set_liquidate_rate --args "u256:$LIQUIDATE_RATE" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1

Get user Collateral rate ../../../initia/minitiad query move view $USER reader get_user_collateral_ratio --node https://rpc.birdee-1.tucana.zone:443 --args "address:$USER"

Liquidate

../../../initia/minitiad tx move execute $USER lend liquidate --args "address:$USER" --from $USER --gas auto --gas-adjustment 1.5 --gas-prices 0.15utuc --node https://rpc.birdee-1.tucana.zone:443 --chain-id birdee-1