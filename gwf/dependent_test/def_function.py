def my_function(fname):
    print(fname + " saying: Hello from a function!")

my_function("Linus")

def my_function(*kids):
  print("The youngest child is " + kids[2])

my_function("Emil", "Tobias", "Linus") 

## keyword arguments
def my_function(**kid):
    print("His last name is " + kid["lname"])

my_function(fname="tobias",lname="linus")