# App Requirements
This is a simple app which connects to an existing RDS instance. To run this app locally, you must first export the following credentials: 
```bash
export MYSQL_HOST=<your-rds-endpoint>
export MYSQL_USER=<your-rds-master-user>
export MYSQL_PASSWORD=<your-rds-password>
```
and install the requirements by running `pip install -r requirements.txt`. 

If you run into errors with Flask-MySQLdb due to `mysqlclient` dependency, this can be resolved by first installing `mysql` using brew, if on mac, then `pip install mysqlclient` and finally `pip install flask_mysqldb`. For more OSs please refer to [this guide](https://pypi.org/project/mysqlclient/). 

Please refer to the README file in the `app` directory for more details on what the app does, how it was tested locally, and the notes / initial plan regarding deployment. 

# Terraform 
Run the following to set your AWS credentials for the account you would like to build in:
```bash
export AWS_ACCESS_KEY_ID=<your-access-key>
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
export AWS_DEFAULT_REGION=<your-desired-region>
```
Alternatively, if you already have an `aws/config` file set up with credentials, you can set an AWS profile in the provider definition. (This is also helpful if you have many different acconuts configured locally, as sometimes terraform defaults to the `default` profile). 

### 1. Building the wider infrastructure
VPC, Subnets, NACLs, IGW, and route tables built. 

### 2. Building the DB 
To avoid having credentials in plaintext, create your DB credentials by running the following commands before TF apply:
**Note:** this is not the safest (or even a safe) way to store credentials, Ideally we'd set up a secrets vault or certificate, but it's better than having them in plaintext

```bash
export TF_VAR_db_username=<your-master-username>
export TF_VAR_db_password=<your-password>
```
These will be exported by the module as outputs, but not shown in plaintext, so they can be transferred to the app instances to access the DB:
```terraform
output db_host {
    value = aws_db_instance.mood_db.address
}

output db_username {
    value = sensitive(aws_db_instance.mood_db.username)
}

output db_password {
    value = sensitive(aws_db_instance.mood_db.password)
}
```
- Later I had to resort to outputting those, so that running `terraform output -json` would enable me to feed the credentials into the app instance. Ideally this would have been done using terraform provisioner, but it wasn't working. 
- SG constantly forces recreation of instance too. 