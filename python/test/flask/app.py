from flask import Flask, jsonify, abort, make_response

app = Flask(__name__)

tasks = [
    {
        'id': 1,
        'title': u'Buy groceries',
        'description': u'Milk, Cheese, Pizza, Fruit, Tylenol',
        'done': False
    },
    {
        'id': 2,
        'title': u'Learn Python',
        'description': u'Need to find a good Python tutorial on the web',
        'done': False
    }
]


@app.errorhandler(404)
def not_found(error):
    '''
    404
    :param error: 错误对象
    :return: 404 JSON信息
    '''
    return make_response(jsonify({'error': str(error)}), 404)


@app.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    if task_id == 0:
        abort(404)
    return jsonify({task_id: tasks})



if __name__ == '__main__':
    app.run(debug=True)