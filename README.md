# namada-shielded-expedition


cd $HOME

wget https://github.com/StakeandRelax-Validator/namada-shielded-expedition/blob/main/install_node.sh

chmod +x install_node.sh

./install_node.sh

# per poi attivare le porte RPC (se volete fare un RPC e non un validatore) eseguite

sed -i 's/127.0.0.1:26657/0.0.0.0:26657/g' .local/share/namada/shielded-expedition.88f17d1d14/config.toml

# riavviate il nodo
sudo systemctl restart namadad

# per poi importare il vostro wallet, dovete eseguire questo comando (cambiate "wallet" con quello che volete)
namadaw derive --alias "wallet"
# vi verrà chiesta la password, che DEVE essere la stessa messa sull'estensione del browser dove avete creato la chiave, e poi la seed phrase, sempre ottenibile dall'estensione del browser

# verificate che la chiave sia la stessa con la public key del wallet web
namadaw list

# controllate che il balance sia corretto, sostituite il tpknam1xxxxxxxxxxx con la vostra public key
cat .local/share/namada/shielded-expedition.88f17d1d14/balances.toml | grep tpknam1xxxxxxxxxxx
