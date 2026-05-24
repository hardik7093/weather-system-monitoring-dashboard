import requests
import mysql.connector

url = "https://api.open-meteo.com/v1/forecast?latitude=18.52&longitude=73.85&current_weather=true"

data = requests.get(url).json()

temp = data['current_weather']['temperature']
windspeed = data['current_weather']['windspeed']

db = mysql.connector.connect(
    host="localhost",
    user="weatheruser",
    password="Weather@123",
    database="weatherdb"
)

cursor = db.cursor()

query = """
INSERT INTO weather_data(city, temperature, humidity, weather_condition)
VALUES (%s, %s, %s, %s)
"""

values = ("Pune", temp, windspeed, "Clear")

cursor.execute(query, values)

db.commit()

print("Weather data inserted successfully")
