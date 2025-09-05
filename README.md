# The Initial D street stage headers  
The core headers that do all the heavy lifting to extract and repack VFS files (Virtual FileSystem files)  
This project can be extended to other forms of software/UI, by itself it isn't usable  
You can't and shouldn't use this library locally (even so you're free to do) unless you know exactly what you're doing  

# Installation  
This project only works on debian based distros, install it by adding the custom repo below and installing the package `libidssvfs`  
```sh
wget -O- https://nekomimi.tilde.team/nekomimiofficial.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nekomimiofficial-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nekomimiofficial-archive-keyring.gpg] https://nekomimi.tilde.team/ stable main" | sudo tee /etc/apt/sources.list.d/nekomimiofficial.list
sudo apt update
sudo apt install libidssvfs
```

# Building  
Make sure you have the following prerequisits:  
- cmake  
- gcc/g++  
- gnucobol  
- python3  
- lua  
- jdk  

You can now run `./build.sh` and find the deb package at `./build/`  

# To connect, To Neko :3  
contacts are found at [here](https://github.com/NekoMimiOfficial/NekoMimiOfficial)   
