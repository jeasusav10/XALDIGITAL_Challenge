# -*- coding: utf-8 -*-
"""
Created on Tue Dec 14 17:06:32 2021

XALDIGITAL_Challenge
Excercise 1. Programming

@author: Jesus Anaya
"""

#1. Link connection

#HTTP library for Python
import requests
#Datetime library 
from datetime import datetime

url="https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow"

#Convert url data to python dictionary (json format)
json_url = requests.get(url).json()

#Save responses data
responses = json_url['items']



#Function for answer questions 3,4 and 5 as they were similar
def respose_ans(parameter:str, min_max:str, parameter_2=False, responses=responses):
  '''Returns the response's title from the corresponding parameter with the respective min/max value'''

  #Get the value of the parameter for all responses 
  parameters  = [resp.get(parameter) for resp in responses]

  #Get the value of the parameter for all responses when main parameter is dict
  if parameter_2: parameters = [param.get(parameter_2,0) for param in parameters]

  #Extract the min/max value of the parameter
  if min_max == 'max': value = max(parameters)
  else: value = min(parameters)

  #Get the response that matches the min/max value
  if parameter_2: resp = [resp.get('title') for resp in responses if resp.get(parameter).get(parameter_2) == value][0]
  else: resp = [resp.get('title') for resp in responses if resp.get(parameter) == value][0]

  return resp, value



#2. Find the number of answered and unaswered responses

#Initialize counters for (un)answered reponses
ans = 0 
unans = 0

#Iterate to count (un)answered reponses
for resp in responses:  
  if resp['is_answered']: ans +=1
  else: unans +=1

print(f"2. Answered responses: {ans}, Unswered responses: {unans}")



#3. Find the response with the minimum number of views

#Get the response with min views
resp, value = respose_ans('view_count', 'min')
print(f"3. Reponse with min views: '{resp}', with: {value} views")



#4. Find the oldest and latest responses

#Get the oldest response
resp, value = respose_ans('creation_date', 'min')
print(f"4. Oldest response: '{resp}', created on: {datetime.fromtimestamp(value)}")

#Get the latest response
resp, value = respose_ans('creation_date', 'max')
print(f"4. Latest response: '{resp}', created on: {datetime.fromtimestamp(value)}")



#5. Find the owner's with best reputation response

#Get the response with the best reputation owner
resp, value = respose_ans('owner', 'max', 'reputation')
print(f"5. Response with the best reputation owner: '{resp}', with an owner reputation of: {value} ")
