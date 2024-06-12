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

vocab_choice = input('Please enter the number corresponding to the vocab file you wish to study followed by enter: ')
while vocab_choice not in vocab_choices_dict:
    print('Please enter a valid response.')
    vocab_choice = input('Please enter the number corresponding to the vocab file you wish to study followed by enter: ') 
selected_lesson = vocab_choices_dict[vocab_choice]


vocabulary = {}
french_words = []
english_words = []
try:
  with open(f'vocab/{selected_lesson}', 'r', encoding='utf-8') as f:
    for x in f:
      unpacked = x.split(',')
      french_translation = unpacked[0].strip()
      french_words.append(french_translation)
      english_translation = unpacked[1].strip() 
      vocabulary[french_translation] = english_translation
      english_words.append(english_translation)
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
for x in range(0,len(french_words)):
  multiple_choice_letters_list = ['a','b','c','d']
  current_word_french = french_words[x]
  print(f'\n {str(x+1)} . {current_word_french} \n')
  choices_dict = question_generator(current_word_french)
  for x in range(0,len(multiple_choice_letters_list)):
    print(f'{multiple_choice_letters_list[x]}. {choices_dict[multiple_choice_letters_list[x]]}')
  response = input('\n Enter your response: ').strip()
  while response not in multiple_choice_letters_list:
    print('please enter a valid response (a, b, c or d) followed by enter/return')
    response = input('\n Enter your response: ').strip()
  if choices_dict[response] == vocabulary[current_word_french]:
    print('correct')
    correct += 1
  else:
    print('false')
    incorrect += 1
    missed_words.append(current_word_french)
    print(f'\n the correct answer is: {vocabulary[current_word_french]} \n')

print(f'score: {correct} / {len(french_words)}')
print(f'your missed words are:')
for x in missed_words:
  print(x)