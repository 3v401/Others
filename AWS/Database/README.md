## This post is under development

### Database made with Node.js in AWS.

Note: This post is for people who doesn't have knowledge of Node.js so I explained every possible concept. Future posts won't have explanation of concepts already explained here.

### Explanation structure of the project

1. `Index.js`: Main entry point of the Node.js application. It sets up the server and initializes middleware, routes, and database connections.
2. `models/product.models.js`: Defines the product structure (schema) of the data (name, price, etc).
3. `routes/product.route.js`: Defines the API endpoints (routes). `Routes` define the URLs/endpoints that your application responds to and what happens when a user visits them. 
4. `controllers/roduct.controller.js`: Handles the business logic for each route, such as fetching products, creating a new product, or deleting a product. `Controllers` separate the application logic reducing clutter in the routes.

### Node.js installation on Ubuntu

Node.js is a JavasScript rntime environment that allows to run JavaScript code outside of browsers. It is often used to build backend servers and APIs because it is fast, lightweight and event driven. It is also well-suited for applications that require handling multiple simultaneous requests like web servers.
In software development, separating code into different files and folders is a best practice known as modularization. It facilitates code organization (separating logic into different files like routes, controllers and models), reusability (each model can be used accross the project without duplicating code), team collaboration (different team members can work on specific parts of the project without conflict) and scalability (well structured projects are easier to extend).

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
2. Install mongoose, mongodb, express and nodemon: `npm install mongoose mongodb express nodemon -D`.
3. To connect a MongoDB database to our Node.js backend an account is required.
4. To connect to the MongoDB database run:
```
mongodb+srv://<username>:<db_password>@cluster0.emyfy.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
```


## AWS

1. After downloading the key pair, find it: `ls -la | grep pem`
2. Grab the name and move it to: `mv CRU-Database-Nodejs.pem ~/.ssh`
3. Move to: `cd ~/.ssh`
4. Activate permissions: `chmod 400 "CRU-Database-Nodejs.pem"`
5. Connect to the AWS instance by: `ssh -i "./CRU-Database-Nodejs.pem" ubuntu@ec2-13-49-66-254.eu-north-1.compute.amazonaws.com`
