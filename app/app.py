import os
import yaml
from datetime import datetime

from flask import Flask, render_template, redirect, request
from flask_mysqldb import MySQL
from flask_wtf import FlaskForm
from wtforms import TextField, SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)

db = yaml.load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db[os.environ['MYSQL_USER']]
app.config['MYSQL_PASSWORD'] = db[os.environ['MYSQL_PASSWORD']]
app.config['MYSQL_DB'] = db['mysql_db']