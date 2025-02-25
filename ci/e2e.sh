#!/bin/sh

set -e

RELAYER_CMD=/usr/bin/hermes

echo "================================================================================================================="
echo "                                              INITIALIZE                                                         "
echo "================================================================================================================="
echo "-----------------------------------------------------------------------------------------------------------------"
echo "Show relayer version"
echo "-----------------------------------------------------------------------------------------------------------------"
$RELAYER_CMD version
echo "-----------------------------------------------------------------------------------------------------------------"
echo "Setting up chains"
echo "-----------------------------------------------------------------------------------------------------------------"
# Configuration file
CONFIG_PATH="$RELAYER_DIR"/"$CONFIG"
echo Config: "$CONFIG_PATH"
echo "  Chain:" "$CHAIN_A"
echo "    creating chain store folder: "["$CHAIN_A_HOME"]
mkdir -p "$CHAIN_A_HOME"
echo "  Chain:" "$CHAIN_B" ["$CHAIN_B_HOME"]
echo "    creating chain store folder: "["$CHAIN_B_HOME"]
mkdir -p "$CHAIN_B_HOME"
echo Waiting 20 seconds for chains to generate blocks...
sleep 20
echo "================================================================================================================="
echo "                                            CONFIGURATION                                                        "
echo "================================================================================================================="
echo "-----------------------------------------------------------------------------------------------------------------"
echo "Add keys for chains"
echo "-----------------------------------------------------------------------------------------------------------------"
hermes -c "$CONFIG_PATH" keys add "$CHAIN_A" -f key_seed_"$CHAIN_A".json
hermes -c "$CONFIG_PATH" keys add "$CHAIN_B" -f key_seed_"$CHAIN_B".json
# hermes -c "$CONFIG_PATH" keys add "$CHAIN_A" -f user2_seed_"$CHAIN_A".json
# hermes -c "$CONFIG_PATH" keys add "$CHAIN_B" -f user2_seed_"$CHAIN_B".json

echo "================================================================================================================="
echo "                                             END-TO-END TESTS                                                    "
echo "================================================================================================================="

python3 /relayer/e2e/run.py -c "$CONFIG_PATH" --cmd "$RELAYER_CMD"

