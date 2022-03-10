---
title: VigenereDecrypto
date: 2020-03-17 14:19:49
categories: Python #Code
tags: [Crypt,python]
---
#-*-coding:utf-8-*-


'''
fileName : VigenereDecrypto.py
'''

def VigenereDecrypto (output , key) :
    ptLen = len (output)
    keyLen = len (key)

    quotien = ptLen // keyLen
    remainder = ptLen % keyLen

    inp = ""

    for i in range (0 , quotient) :
        for j in range (0 , keyLen) :
            c = int((ord(output[i*keyLen+j]) - ord('a') + 26 - (ord(key[j]) - ord('a')) % 26 + ord('a')))
            #global input
            inp += chr (c)

    for i in range (0 , remainder) :
        c = int((ord(output[quotient*keyLen + i]) - ord('a') + 26 - (ord(key[i]) - ord('a')) % 26 + ord('a')))
        #global input
        inp += chr (c)

    return inp
