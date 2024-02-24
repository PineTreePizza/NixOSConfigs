# NixOSConfigs

My configs from /etc/nixos
To use you can run the following on NixOS.

**NOTE**: Be sure to change *"home-manager.users.pong"* to **"home-manager.users.yourUsername"

```
nix-shell -p git
git clone https://github.com/PineTreePizza/NixOSConfigs
cd NixOSConfigs
sudo install -m 755 ./*.nix /etc/nixos/
sudo nixos-rebuild switch
```

Unfortunately I have yet to learn how to make my own iso with an installer.
