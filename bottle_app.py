from quiz import generate_vocab_choices_list, generate_quiz_questions, generate_vocab_choices_dict, generate_combined_vocabulary_dict, get_valid_user_selection, generate_combined_vocabulary_dict, question_generator, print_missed_words, quiz
from bottle import route, post, request, run, template, redirect, response
from session_manager import random_id

index = {} 
missed_words = {}
quiz_questions_dict = {}
question_count = {}


@route('/')
def home():
    session_id = request.get_cookie("session_id")
    if not session_id:
        session_id = random_id()
        response.set_cookie("session_id", session_id)
    index[session_id] = 0

    return template('index.tpl')


@route('/lessons')
def get_lessons():
    vocab_choices_list = generate_vocab_choices_list()
    session_id = request.get_cookie("session_id")
    return template('lessons.tpl', lessons=vocab_choices_list)

@post('/select')
def post_selected_lesson():
    selected_lesson = request.forms.get('selected_lesson')
    session_id = request.get_cookie("session_id")
    # question_index = index[session_id]
    vocab_dict = generate_combined_vocabulary_dict(selected_lesson)
    quiz_questions = generate_quiz_questions(vocab_dict)
    quiz_questions_dict[session_id] = quiz_questions
    missed_words[session_id] = []
    redirect(f'/quiz')


@route('/quiz')
def get_quiz_question():
    session_id = request.get_cookie("session_id")
    if session_id not in quiz_questions_dict:
        redirect('/')
    session_id = request.get_cookie("session_id")
    question_count[session_id] = len(quiz_questions_dict[session_id]) 
    question_index = index[session_id]
    if question_index < question_count[session_id]:
        current_question = quiz_questions_dict[session_id][question_index]
        return template('quiz.tpl', question_index = question_index, question_count = question_count[session_id], current_question = current_question)
    
    else:   
        incorrect = len(missed_words[session_id])
        score = question_count[session_id] - incorrect
        return template('summary', question_count = question_count[session_id], score = score, missed_words = missed_words[session_id])

@post('/next')
def get_next():
    session_id = request.get_cookie("session_id")
    missed_word = request.forms.get('missed_word')
    if missed_word:
        # missed_words[session_id].append(missed_word)
        missed_word_french = quiz_questions_dict[session_id][index[session_id]][0]
        missed_word_english = quiz_questions_dict[session_id][index[session_id]][1]
        missed_words[session_id].append(f'{missed_word_french} in english is {missed_word_english}.')
    if session_id in index:
        index[session_id] += 1
    

    redirect(f'/quiz')
    
@post('/reset')
def get_reset():
    session_id = request.get_cookie("session_id")
    index.pop(session_id)
    missed_words.pop(session_id)
    quiz_questions_dict.pop(session_id)
    question_count.pop(session_id)
    response.delete_cookie('session_id')
    redirect('/')

run(host='localhost', port=8080)