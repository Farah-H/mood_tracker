import os

from datetime import datetime
from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = os.environ['mysql_host']
app.config['MYSQL_USER'] = os.environ['MYSQL_USER']
app.config['MYSQL_PASSWORD'] = os.environ['MYSQL_PASSWORD']
app.config['MYSQL_DB'] = 'mysql'

mysql = MySQL(app)

@app.route('/',methods=['GET','POST'])
def index():
        if request.method == 'POST':
                userdetails = request.form
                name = userdetails['name']
                mood = userdetails['mood']
                date = datetime.utcnow()
                
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO users(name, mood, date) VALUES(%s, %s, %s)", (name, mood, date.strftime("%B %d %Y %H:%M")))
                mysql.connection.commit()
                cur.close()
                return render_template('success.html')
        return render_template('index.html')

@app.route('/moodchart')
def users():
        cur = mysql.connection.cursor()
        resutlValue = cur.execute("SELECT * FROM users")
        if resutlValue > 0:
                userdetails = cur.fetchall()
                return render_template('moodchart.html', userdetails=userdetails)

if __name__ == '__main__':
      app.run(debug=True)