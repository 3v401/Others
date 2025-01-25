Telephone database made with Node.js

### Node.js installation on Ubuntu

1. Download Nodejs from [here](https://nodejs.org/en)
2. Go where the compressed file is located and do: `tar -xf node-v%(version)s-%(arch)s.tar.xz`
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
6. For git CLI access run: `sudo apt-get install git`

### Development of a CRU database with Node.js

1. Initialize a new Node.js project: `npm init -y`
2. Install MongoDB: `npm install mongodb`
3. The following packages are needed: `node i express nodemon -D`
4. To connect a MongoDB database to our Node.js backend an account is required.
