from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():  # put appldsdsdfsdication's code here
    return 'Hola Digital Ocean!!!!!'


if __name__ == '__main__':
    app.run()
