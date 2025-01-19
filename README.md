```bash
curl -O https://raw.githubusercontent.com/eadanila/coreos-config/refs/heads/main/coreos-from-archiso.sh
chmod +x ./coreos-from-archiso.sh

# Copy in butane.env or set BUTANE_PASSWORD_HASH and BUTANE_TS_AUTH_KEY

./coreos-from-archiso.sh $INITIAL_BLOCK_DEVICE
```
