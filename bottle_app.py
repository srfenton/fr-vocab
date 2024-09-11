from quiz import generate_vocab_choices_list, generate_vocab_choices_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, run, template


@route('/')
def index():
    return template('index.tpl')


@route('/lessons')
def get_lessons():
    vocab_choices_list = generate_vocab_choices_list()
    return template('lessons.tpl', lessons=vocab_choices_list)

@post('/select/<lesson>')
def post_selected_lesson(lesson):
    redirect(f'/quiz/{lesson}')


@route('quiz/<lesson>')




run(host='localhost', port=8080)