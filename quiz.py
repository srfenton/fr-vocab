import os
import sys
import json
import random
import tkinter

directory='vocab'
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

vocab_choices_dict = {}
vocab_index_number= 1
for x in vocab_choices_list:
    print(f'{vocab_index_number}. {x}')
    vocab_choices_dict[str(vocab_index_number)] = x
    vocab_index_number += 1

def get_valid_user_selection(choices, expected_type=str):
    while True:
        response = input().strip()
        if response.lower() == 'exit':
            sys.exit()

        try:
            # Try to convert the response to the expected type
            converted_response = expected_type(response)
        except ValueError:
            print(f'\nPlease enter a valid selection.')
            continue
        if converted_response in choices:
            return converted_response
        else:
            print('\nPlease enter a valid selection.')

def get_valid_user_selection(choices):
   response = input('\n')
   while response not in choices:
      if response.strip().lower() == 'exit':
        print('thanks for studying!')
        sys.exit()
      print('\nplease enter a valid selection \n')
      return get_valid_user_selection(choices)
    
   return response


vocab_choice = get_valid_user_selection(vocab_choices_dict)
selected_lesson = vocab_choices_dict[vocab_choice]


vocabulary = {}
french_words = []
english_words = []
print(f'you have selected {selected_lesson} \n')
print('type exit anytime to end your session \n')

try:
  with open(f'vocab/{selected_lesson}', 'r', encoding='utf-8') as f:
    data = json.load(f)
    vocabulary = data['translations']
    french_words = list(vocabulary.keys())
    for x in french_words:
        english_words.append(vocabulary[x])
    f.close()
    
except:
  print('invalid vocabulary file.')
  sys.exit()


random.shuffle(french_words)

def question_generator(french_word):
  answers = []
  choices = {}
  english_words_copy = english_words.copy()
  english_words_copy.remove(vocabulary[french_word])
  random.shuffle(english_words_copy)
  for x in range(0,3):
    answers.append(english_words_copy[x])
  correct_answer = vocabulary[french_word]
  answers.append(correct_answer)
  random.shuffle(answers)
  choices['a'] = answers[0]
  choices['b'] = answers[1]
  choices['c'] = answers[2]
  choices['d'] = answers[3]

  return choices

correct = 0
incorrect = 0
missed_words = []

def print_missed_words():
  print(f'your missed words are:')
  for x in missed_words:
    print(f'{x} ({vocabulary[x]})')
test_length_choices = [('short', 5),('full length', len(french_words)),('infinite', 99999999999999999999999999999999)]

for i, (name, length) in enumerate(test_length_choices):
    print(f'{i}. {name}')

print('\nselect your test length: ')

test_length_preference = get_valid_user_selection([str(i) for i in range(len(test_length_choices))]) #this list comprehension unpacks the test length choices to ensure the input we get is valid
test_length = test_length_choices[int(test_length_preference)][1]

for x in range(0,test_length):
  multiple_choice_letters_list = ['a','b','c','d']
  if test_length_choices[int(test_length_preference)][0] != 'infinite':
    current_word_french = french_words[x] 
  else:
    current_word_french = random.choice(french_words)
  print(f'\n {str(x+1)} . {current_word_french} \n')
  choices_dict = question_generator(current_word_french)
  for x in range(0,len(multiple_choice_letters_list)):
    print(f'{multiple_choice_letters_list[x]}. {choices_dict[multiple_choice_letters_list[x]]}')
  
  response = get_valid_user_selection(multiple_choice_letters_list)

  if choices_dict[response] == vocabulary[current_word_french]:
    print('correct')
    correct += 1
  else:
    print('false')
    incorrect += 1
    missed_words.append(current_word_french)
    print(f'\n the correct answer is: {vocabulary[current_word_french]} \n')

if test_length_choices[int(test_length_preference)][0] in ['short', 'full']:
  print(f'score: {correct} / {test_length}')
  print_missed_words()