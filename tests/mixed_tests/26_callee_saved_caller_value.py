def g(x):
    y = x + 1
    print(0)
    return y

def f(a):
    b = g(a)
    return a + b

print(f(10))
