import random


class Generators:
    @staticmethod
    def generate_todos():
        num = random.randint(1, 10)
        n = 1
        todos_list = []
        while n <= num:
            todos_list.append(f'To-do num.{n}')
            n += 1
        return todos_list
