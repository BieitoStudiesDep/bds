import subprocess

entrada_reducers = open("entrada_reducer.txt","w")

subprocess.run(["sort", "salida_mapper.txt"], stdout=entrada_reducers, check=True)

