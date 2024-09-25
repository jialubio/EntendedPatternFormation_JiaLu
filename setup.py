# in terminal, run: python setup.py install

from setuptools import setup, find_packages

setup(
    name='ML',  # Name of your project
    description='This code uses ML surrogate to accelerate PDE simulation. The overall workflow includes 1. training a ML surrogate on PDE nuemrical simulation data; 2. Computational validatio by using ML inference results against PDE simulation; 3. Constructing a validate dataset and inferring patterning rules.',
    author='Jia Lu',
    # url='https://doi.org/10.1101/2024.09.02.610872', # url to the pre-print
    packages=find_packages(),  
    install_requires=['numpy', 'pandas', 'sklearn', 'torch', 'tqdm', 'matplotlib'],
    python_requires='>=3.8',
)
