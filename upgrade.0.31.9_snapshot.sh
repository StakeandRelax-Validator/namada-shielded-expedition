NAMADA_TAG="v0.31.9"

sudo systemctl stop namadad

cd namada
git checkout $NAMADA_TAG
make build-release
sudo mv target/release/namada /usr/local/bin/
sudo mv target/release/namada[c,n,w] /usr/local/bin/

cd $HOME
wget https://namada-se-rpc.citadel.one/snap/namada-se-90000-tx_index.tar.lz4
mkdir temp
lz4 -d namada-se-90000.tar.lz4 -c | tar xvf - -C ./temp/

rm -rf .local/share/namada/shielded-expedition.88f17d1d14/db
mv temp/db .local/share/namada/shielded-expedition.88f17d1d14/

mv .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/priv_validator_state.json .local/share/namada/shielded-expedition.88f17d1d14/cometbft/
rm -rf .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/
mv temp/data/ .local/share/namada/shielded-expedition.88f17d1d14/cometbft/
mv .local/share/namada/shielded-expedition.88f17d1d14/cometbft/priv_validator_state.json .local/share/namada/shielded-expedition.88f17d1d14/cometbft/data/

sudo systemctl start namadad
