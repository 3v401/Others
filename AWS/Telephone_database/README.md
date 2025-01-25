Telephone database made with Node.js

### Node.js installation on Ubuntu

1. Download Nodejs from [here](https://nodejs.org/en)
2. Go to the file path and do: `tar -xf node-v%(version)s-%(arch)s.tar.xz`
3. Move the content of the uncompressed file to: `sudo mv node-v%(version)s-%(arch)s /usr/local/node`
4. Add Node.js to your $PATH:
```
echo 'export PATH=/usr/local/node/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```
5. Verify your installation:
```
node -v
npm -v
```

### Development of a CRU database with Node.js

