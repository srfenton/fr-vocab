import os
import sys
import json
import random

# Generate list of vocab lessons from the vocab directory
def generate_vocab_choices_list():
    directory = 'vocab'
    vocab_choices_list = []
    try:
        with os.scandir(directory) as entries:
            for entry in entries:
                if '.json' in entry.name:
                    vocab_choices_list.append(entry.name)
    except FileNotFoundError:
        print(f"The directory {directory} does not exist.")
    except PermissionError:
        print(f"Permission denied to access {directory}.")
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit()

    return vocab_choices_list

def generate_vocab_choices_dict(vocab_choices_list):
    vocab_choices_dict = {}
    vocab_index_number = 1
    for x in vocab_choices_list:
        print(f'{vocab_index_number}. {x}')
        vocab_choices_dict[str(vocab_index_number)] = x
        vocab_index_number += 1

    return vocab_choices_dict

def get_valid_user_selection(choices):
    response = input('\n')
    while response not in choices:
        if response.strip().lower() == 'exit':
            print('Thanks for studying!')
            sys.exit()
        print('\nPlease enter a valid selection')
        return get_valid_user_selection(choices)
    return response

def generate_combined_vocabulary_dict(selected_lesson):
    vocabulary = {}
    french_words = []
    english_words = []
    vocab_path = os.path.join('vocab', selected_lesson)

    try:
        with open(vocab_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            vocabulary = data['translations']
            french_words = list(vocabulary.keys())
            for x in french_words:
                english_words.append(vocabulary[x])
            f.close()
    except FileNotFoundError:
        print(f"File not found: {vocab_path}. Please check the filename and directory.")
        sys.exit()
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit()

    random.shuffle(french_words)
    return {'vocabulary': vocabulary, 'french_words': french_words, 'english_words': english_words}

#i do not need the multple choice letters to be called out. remove them from a dictionary and put them in a list or tuple.
def question_generator(current_word_french, combined_vocabulary_dict):
    english_words = combined_vocabulary_dict['english_words']
    vocabulary = combined_vocabulary_dict['vocabulary']
    answers = []
    choices = []
    english_words_copy = english_words.copy()
    english_words_copy.remove(vocabulary[current_word_french])
    random.shuffle(english_words_copy)
    for x in range(0, 3):
        answers.append(english_words_copy[x])
    correct_answer = vocabulary[current_word_french]
    answers.append(correct_answer)
    random.shuffle(answers)

    return (current_word_french, correct_answer, answers)

def print_missed_words(missed_words, vocabulary):
    print('Your missed words are:')
    for x in missed_words:
        print(f'{x} ({vocabulary[x]})')

def generate_quiz_questions(combined_vocabulary_dict):
    french_words = combined_vocabulary_dict['french_words']
    quiz_questions = []
    for x in french_words:
        quiz_questions.append(question_generator(x,combined_vocabulary_dict))

    return quiz_questions
        

def quiz(test_length, test_length_choices, combined_vocabulary_dict):
    correct = 0
    incorrect = 0
    missed_words = []
    french_words = combined_vocabulary_dict['french_words']
    vocabulary = combined_vocabulary_dict['vocabulary']

    for x in range(0, test_length):
        multiple_choice_letters_list = ['a', 'b', 'c', 'd']
        if test_length_choices[int(test_length_preference)][0] != 'infinite':
            current_word_french = french_words[x]
        else:
            current_word_french = random.choice(french_words)
        print(f'\n {str(x+1)} . {current_word_french} \n')
        choices_dict = question_generator(current_word_french, combined_vocabulary_dict)
        for i in range(0, len(multiple_choice_letters_list)):
            print(f'{multiple_choice_letters_list[i]}. {choices_dict[multiple_choice_letters_list[i]]}')

        response = get_valid_user_selection(multiple_choice_letters_list)

        if choices_dict[response] == vocabulary[current_word_french]:
            print('Correct')
            correct += 1
        else:
            print('False')
            incorrect += 1
            missed_words.append(current_word_french)
            print(f'\nThe correct answer is: {vocabulary[current_word_french]}\n')

    if test_length_choices[int(test_length_preference)][0] in ['short', 'full length']:
        print(f'Score: {correct} / {test_length}')
        print_missed_words(missed_words, vocabulary)

if __name__ == "__main__":
    vocab_dict = generate_combined_vocabulary_dict('les_animaux.json')
    quiz_questions = generate_quiz_questions(vocab_dict)
    print(quiz_questions[0])






#######################################################################################################################################################################################
    #below are outdated testing function calls from before this was a web app. To be cleaned soon.
    # vocab_choices_list = generate_vocab_choices_list()
    # vocab_choices_dict = generate_vocab_choices_dict(vocab_choices_list)
    # vocab_choice = get_valid_user_selection(vocab_choices_dict)
    # selected_lesson = vocab_choices_dict[vocab_choice]

    # combined_vocabulary_dict = generate_combined_vocabulary_dict(selected_lesson)

    # test_length_choices = [('short', 5), ('full length', len(combined_vocabulary_dict['french_words'])), ('infinite', 99999999999999999999999999999999)]

    # for i, (name, length) in enumerate(test_length_choices):
    #     print(f'{i}. {name}')

    # print('\nSelect your test length: ')
    # test_length_preference = get_valid_user_selection([str(i) for i in range(len(test_length_choices))])
    # test_length = test_length_choices[int(test_length_preference)][1]

    # quiz(test_length, test_length_choices, combined_vocabulary_dict)
