import datetime
import mysql.connector

__cnx = None

def get_sql_connection():
  print("Opening mysql connection")
  global __cnx

  if __cnx is None:
    #__cnx = mysql.connector.connect(user='root', password='', database='database_name')
    __cnx = mysql.connector.connect(host='database_endpoint_here', user='admin_username_here', port=3306, password='your_password', database='database_name')
  return __cnx

