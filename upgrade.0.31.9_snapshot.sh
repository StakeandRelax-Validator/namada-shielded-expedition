#!/bin/bash
NAMADA_TAG="v0.31.9"

sudo systemctl stop namadad

cd namada
git fetch
git checkout $NAMADA_TAG
make build-release
sudo mv target/release/namada /usr/local/bin/
sudo mv target/release/namada[c,n,w] /usr/local/bin/
cp /usr/local/bin/namada* /home/stakeval/.cargo/bin/

cd $HOME
wget https://namada-se-rpc.citadel.one/snap/namada-se-90000-tx_index.tar.lz4
mkdir temp
lz4 -d namada-se-90000-tx_index.tar.lz4 -c | tar xvf - -C ./temp/

rm -rf .local/share/namada/shielded-expedition.88f17d1d14/db
mv temp/db .local/share/namada/shielded-expedition.88f17d1d14/

mv .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/priv_validator_state.json .local/share/namada/shielded-expedition.88f17d1d14/cometbft/
rm -rf .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/
mv temp/data/ .local/share/namada/shielded-expedition.88f17d1d14/cometbft/
mv .local/share/namada/shielded-expedition.88f17d1d14/cometbft/priv_validator_state.json .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/

sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "0s"/g' $HOME/.local/share/namada/shielded-expedition.88f17d1d14/config.toml
sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "0s"/g' $HOME/.local/share/namada/shielded-expedition.88f17d1d14/config.toml
sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "0s"/g' $HOME/.local/share/namada/shielded-expedition.88f17d1d14/config.toml

rm namada-se-90000-tx_index.tar.lz4

sudo systemctl start namadad
