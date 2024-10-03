from quiz import generate_vocab_choices_list, generate_quiz_questions, generate_vocab_choices_dict, generate_combined_vocabulary_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, post, request, run, template, redirect, response
from session_manager import random_id

index = {} 
correct = 0
incorrect = 0
missed_words = {}
quiz_questions_dict = {}


@route('/')
def home():
    session_id = request.get_cookie("session_id")
    if not session_id:
        session_id = random_id()
        response.set_cookie("session_id", session_id)
    index[session_id] = 0
    print(f'{session_id} assignedatindex')
    return template('index.tpl')


@route('/lessons')
def get_lessons():
    vocab_choices_list = generate_vocab_choices_list()
    session_id = request.get_cookie("session_id")
    print(f'{session_id} functionin at lesson select')
    return template('lessons.tpl', lessons=vocab_choices_list)

@post('/select')
def post_selected_lesson():
    selected_lesson = request.forms.get('selected_lesson')
    session_id = request.get_cookie("session_id")
    question_index = index[session_id]
    vocab_dict = generate_combined_vocabulary_dict(selected_lesson)
    quiz_questions = generate_quiz_questions(vocab_dict)
    quiz_questions_dict[session_id] = quiz_questions
    missed_words[session_id] = []
    print(f'{session_id} functionin at question generation')
    redirect(f'/quiz')


@route('/quiz')
def get_quiz_question():
    session_id = request.get_cookie("session_id")
    if session_id not in quiz_questions_dict:
        redirect('/')
    session_id = request.get_cookie("session_id")
    question_count = len(quiz_questions_dict[session_id]) 
    question_index = index[session_id]
    if question_index <= question_count:
        current_question = quiz_questions_dict[session_id][question_index]
        print(f'current quesiton: {current_question}')
        print(f'{index[session_id]} quiz worked')
        return template('quiz.tpl', question_index = question_index, question_count = question_count, current_question = current_question)
    
    else:   
        print(f'{index[session_id]} no qiestions') 
        return template('summary', summary = ['helo', 'darlin'])

@post('/next')
def get_next():
    session_id = request.get_cookie("session_id")
    missed_word = request.forms.get('missed_word')
    if missed_word:
        missed_words[session_id].append(missed_word)
    if session_id in index:
        index[session_id] += 1
    question_index = index[session_id]

    redirect(f'/quiz/')
    


run(host='localhost', port=8080)