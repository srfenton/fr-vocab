from quiz import generate_vocab_choices_list, generate_quiz_questions, generate_vocab_choices_dict, generate_combined_vocabulary_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, post, request, run, template, redirect, response
from session_manager import random_id

index = {} #until session management

@route('/')
def index():
    session_id = request.get_cookie("session_id")
    if not session_id:
        session_id = random_id()
        response.set_cookie("session_id", session_id)
    index[session_id] = 0
    return template('index.tpl', session_id = session_id)


@route('/lessons')
def get_lessons():
    vocab_choices_list = generate_vocab_choices_list()
    session_id = request.get_cookie("session_id")
    return template('lessons.tpl', session_id = session_id, lessons=vocab_choices_list)

@post('/select')
def post_selected_lesson():
    selected_lesson = request.forms.get('selected_lesson')
    session_id = request.forms.get('session_id')
    redirect(f'/quiz/{selected_lesson}')


@route('/quiz/<selected_lesson>')
def get_selected_lesson(selected_lesson):
    session_id = request.get_cookie("session_id")
    question_count = len(quiz_questions)
    question_number = index[session_id] 
    vocab_dict = generate_combined_vocabulary_dict(selected_lesson)
    quiz_questions = generate_quiz_questions(vocab_dict)
    current_question = quiz_questions[index[session_id]]
    
    return template('quiz.tpl', question_number = question_number, question_count = question_count, session_id = session_id, current_question = current_question)




run(host='localhost', port=8080)