from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello_world():  # put appldsdsdfsdication's code here
    return 'Hola aws!!!!!'


if __name__ == '__main__':
    app.run()
