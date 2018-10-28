# Terraform
Terraform is used to create and provision AWS EC2 instances across the different regions.
The folder 'terraform' contains the terraform scripts to be executed.

**Steps**:
1. run `terraform init` to initialise terraform
2. run `terraform apply` to apply the changes on AWS


# Database
Database configuration for different environments is specified on file knexfile.js

Dev database runs on Docker container, see *Docker* section for more details about how to create the Dev database.
Production database runs on AWS RDS with MySQL flavour and has been created manually on AWS console.

Note: database name is different on Dev and Prod as AWS does not allow the use of hyphens in the database name.

## Migration
Database structure management is done with the library knex and its concept of *Migrations*.

**Steps**:
1. run `knex init` to initialise knex
2. run `knex migrate:make create_schema` to have knex create the create schema file and populate said file with the code to generate the schema
3. run `knex migrate:latest --env development` to execute the script

*Notes*:
1. steps (1) and (2) are common for all the environments. Step (3) is to be run separately for each environment.
2. the environment name must be as defined in *'knexfile.js'*, (*'development'* or *'production'*)
3. the commands must be run in the folder 'app' that is the one with the local installation of 'knex'; apparently, 'knex' also needs to be installed globally (`npm install knex -g`).

# Docker
The folder 'docker' contains the files to generate the Docker container with the database for local development. 
To get the container up and running, run `docker-compose up`.
The database listens on port 3406.

# App

## Environment configuration
Environment configuration must be done manually for each EC2 instance.

Env variables to be created:
- *THIS_LOCATION* name of the region where the EC2 instance runs, for local environment it can take any value, default value = localhost
- *NODE_ENV* identifies the environment as defined in *'knexfile.js'*, (*'development'* or *'production'*), default value = development
- *IRELAND_IP* IP of Ireland's server (elastic ip), default value = localhost
- *SYDNEY_IP* IP of Sydney's server (elastic ip), default value = localhost
- *SAOPAULO_IP* IP of Sao Paulo's server (elastic ip), default value = localhost
- *OREGON_IP* IP of Oregon's server (elastic ip), default value = localhost
- *INTERVAL_IN_MILLS* frequency of the ping operation in milliseconds,
- *DB_HOST* Database hostname (not needed when running in development)
- *DB_USER* Database user (not needed when running in development)
- *DB_PWD* Database password (not needed when running in development)


## Application start
Run the application in each EC2 instance with the command `node index.js`
