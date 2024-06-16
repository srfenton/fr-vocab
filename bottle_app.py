from quiz import generate_vocab_choices_list, generate_vocab_choices_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, run, template


@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

run(host='localhost', port=8080)