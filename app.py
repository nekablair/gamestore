from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
import os
import psycopg2

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://neka:neka@localhost:5432/game_store'
# postgresql://username:password@localhost:5432/your_database

db = SQLAlchemy(app)

class Games(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50))
    price = db.Column(db.Float(precision=2))
    quantity = db.Column(db.Integer)
    # grade = db.Column(db.String(1))

# db.create_all()

@app.route('/data', methods=['GET'])
def get_games():
    games = Games.query.all()
    games_list = [
        {'id': game_id.id, 'title': game.title, 'price': game.price, 'quantity': game.quantity}
        for game in games
    ]
    return jsonify(games_list)

if __name__ == "__main__":
    app.run(debug=True)