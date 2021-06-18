import numpy as np


def writeFile(data):
    vFile = open(f'salida1.txt', 'a')

    vFile.write(data)

    vFile.close()


f1 = open("P1.txt", "r")
f2 = open("P2.txt", "r")


vFile = open(f'salida1.txt', 'a')
vFile.truncate()
vFile.close()


z1 = []
z2 = []

for i in f1:
    z1 += [i.split(" ")[3]]


for i in f2:
    z2 += [i.split(" ")[3]]


# for i in z1:
#     if i != " ":
#         writeFile(i+"\n")
