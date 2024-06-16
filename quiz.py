import os
import sys
import json
import random

#generate list of vocab lessons from the vocab directory
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

vocab_choices_list = generate_vocab_choices_list() 

def generate_vocab_choices_dict(vocab_choices_list):
  vocab_choices_dict = {}
  vocab_index_number= 1
  for x in vocab_choices_list:
      print(f'{vocab_index_number}. {x}')
      vocab_choices_dict[str(vocab_index_number)] = x
      vocab_index_number += 1

  return vocab_choices_dict

vocab_choices_dict = generate_vocab_choices_dict(vocab_choices_list) #move me for module mode

def get_valid_user_selection(choices):
   response = input('\n')
   while response not in choices:
      if response.strip().lower() == 'exit':
        print('thanks for studying!')
        sys.exit()
      print('\nplease enter a valid selection')
      return get_valid_user_selection(choices)
    
   return response

vocab_choice = get_valid_user_selection(vocab_choices_dict) #this will need a new method for the web version
selected_lesson = vocab_choices_dict[vocab_choice] 

def generate_combined_vocabulary_dict(selected_lesson):
  vocabulary = {}
  french_words = []
  english_words = []
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

  return {'vocabulary' : vocabulary, 'french_words' : french_words, 'english_words' : english_words}

print(f'you have selected {selected_lesson} \n')
print('type exit anytime to end your session \n')

#########################################################################################################
#this will be deleted once generate combined vocab dict is fully tested
# vocabulary = {}
# french_words = []
# english_words = []

# try:
#   with open(f'vocab/{selected_lesson}', 'r', encoding='utf-8') as f:
#     data = json.load(f)
#     vocabulary = data['translations']
#     french_words = list(vocabulary.keys())
#     for x in french_words:
#         english_words.append(vocabulary[x])
#     f.close()

# except:
#   print('invalid vocabulary file.')
#   sys.exit()


# random.shuffle(french_words)
#########################################################################################################


def question_generator(current_word_french,combined_vocabulary_dict):
  english_words = combined_vocabulary_dict['english_words']
  vocabulary = combined_vocabulary_dict['vocabulary']
  answers = []
  choices = {}
  english_words_copy = english_words.copy()
  english_words_copy.remove(vocabulary[current_word_french])
  random.shuffle(english_words_copy)
  for x in range(0,3):
    answers.append(english_words_copy[x])
  correct_answer = vocabulary[current_word_french]
  answers.append(correct_answer)
  random.shuffle(answers)
  choices['a'] = answers[0]
  choices['b'] = answers[1]
  choices['c'] = answers[2]
  choices['d'] = answers[3]

  return choices

#these definitions are being moved inside the quiz function for portability
# correct = 0
# incorrect = 0
# missed_words = []

def print_missed_words(missed_words,vocabulary):
  print(f'your missed words are:')
  for x in missed_words:
    print(f'{x} ({vocabulary[x]})')
    
combined_vocabulary_dict = generate_combined_vocabulary_dict(selected_lesson) 

test_length_choices = [('short', 5),('full length', len(combined_vocabulary_dict['french_words'])),('infinite', 99999999999999999999999999999999)] 

for i, (name, length) in enumerate(test_length_choices): 
    print(f'{i}. {name}') 

print('\nselect your test length: ') 

#the definition below will need its own method in the web version
test_length_preference = get_valid_user_selection([str(i) for i in range(len(test_length_choices))]) #this list comprehension unpacks the test length choices to ensure the input we get is valid 
test_length = test_length_choices[int(test_length_preference)][1] 



#########################################################################################################
#this is the core functionality of the program. It may need broken up into more functions to function in a web app.
#for example, generating the next quesion, checking the result, and printing results might be able to broken up into 3 difference functions
def quiz(test_length, test_length_choices, combined_vocabulary_dict):
  correct = 0
  incorrect = 0
  missed_words = []
  french_words = combined_vocabulary_dict['french_words']
  vocabulary = combined_vocabulary_dict['vocabulary']

  for x in range(0,test_length):
    multiple_choice_letters_list = ['a','b','c','d']
    if test_length_choices[int(test_length_preference)][0] != 'infinite':
      current_word_french = french_words[x] 
    else:
      current_word_french = random.choice(french_words)
    print(f'\n {str(x+1)} . {current_word_french} \n')
    choices_dict = question_generator(current_word_french,combined_vocabulary_dict)
    for x in range(0,len(multiple_choice_letters_list)):
      print(f'{multiple_choice_letters_list[x]}. {choices_dict[multiple_choice_letters_list[x]]}')
    
    response = get_valid_user_selection(multiple_choice_letters_list) #this definition will needs its own method in the web version

    if choices_dict[response] == vocabulary[current_word_french]:
      print('correct')
      correct += 1
    else:
      print('false')
      incorrect += 1
      missed_words.append(current_word_french)
      print(f'\n the correct answer is: {vocabulary[current_word_french]} \n')
  print(f'{test_length_choices[int(test_length_preference)][0]} is the conditional value')
  if test_length_choices[int(test_length_preference)][0] in ['short', 'full length']:
    print(f'score: {correct} / {test_length}')
    print_missed_words(missed_words, vocabulary)

#########################################################################################################


quiz(test_length, test_length_choices, combined_vocabulary_dict)


#########################################################################################################



#the below code should be sufficient to run after a modular condition:
# if __name__ == "__main__":
#   vocab_choices_list = generate_vocab_choices_list()
#   vocab_choices_dict = generate_vocab_choices_dict(vocab_choices_list)
#   selected_lesson = get_valid_user_selection(vocab_choices_dict)
#   combined_vocabulary_dict = generate_combined_vocabulary_dict(selected_lesson)
#   quiz(test_length, test_length_choices, combined_vocabulary_dict)