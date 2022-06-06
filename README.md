# App Requirements
This is a simple app which connects to an existing RDS instance. To run this app, you must first export the following credentials: 
```bash
export MYSQL_HOST=<your-rds-endpoint>
export MYSQL_USER=<your-rds-master-user>
export MYSQL_PASSWORD=<your-rds-password>
```
and install the requirements by running `pip install -r requirements.txt`. 

If you run into errors with Flask-MySQLdb due to `mysqlclient` dependency, this can be resolved by first installing `mysql` using brew, if on mac, then `pip install mysqlclient` and finally `pip install flask_mysqldb`. For more OSs please refer to [this guide](https://pypi.org/project/mysqlclient/). 

Please refer to the README file in the `app` directory for more details on what the app does, how it was tested locally, and the notes / initial plan regarding deployment. 