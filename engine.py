#!/usr/bin/env python

import pickle

#all objects are stored in here
brain = []

#index of items by common names
labels = {}

def persist():
    pass

def getByLabel(label):
    return labels[label]

def fact(subj, verb, objs, opts):
    actor = None
    if len(subj)>1:
        raise AmbiguousSubjectError
    elif len(subj)<1:
        actor = Object()
    else:
        actor = subj[0]


    #here's the process where we make sure that the truth of this fact is known
