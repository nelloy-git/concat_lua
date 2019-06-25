import os
import lua
from luaparser import ast

def compiletime_module(path):
    with open(path, 'r') as file:
        module = file.read()
    tree = ast.parse(module)
