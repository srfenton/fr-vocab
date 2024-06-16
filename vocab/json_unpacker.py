import os
import sys
import json
import random
import tkinter

vocabulary = {}
french_words = []
english_words = []

with open(f'vocab/le_membre_de_famille.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    vocabulary = data['translations']
    french_words = list(vocabulary.keys())
    for x in french_words:
        english_words.append(vocabulary[x])
    
