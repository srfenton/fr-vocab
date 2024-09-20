from quiz import generate_vocab_choices_list, generate_vocab_choices_dict, generate_combined_vocabulary_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, post, request, run, template, redirect


@route('/')
def index():
    return template('index.tpl')


@route('/lessons')
def get_lessons():
    vocab_choices_list = generate_vocab_choices_list()
    return template('lessons.tpl', lessons=vocab_choices_list)

@post('/select')
def post_selected_lesson():
    selected_lesson = request.forms.get('selected_lesson')
    redirect(f'/quiz/{selected_lesson}')


@route('/quiz/<selected_lesson>')
def get_selected_lesson(selected_lesson):
    vocab_dict = generate_combined_vocabulary_dict(selected_lesson)
    return template('quiz.tpl', vocab_dict=vocab_dict.get('vocabulary'))




run(host='localhost', port=8080)