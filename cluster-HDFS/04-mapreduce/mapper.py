#!/usr/bin/python3

entrada = open("datos.txt")
salida = open("salida_mapper.txt","w")

for line in entrada:

   words = line.split()

   for word in words:
       print (word, "\t", 1)
       salida.write(word + "\t" + "1\n")
       
salida.close()
