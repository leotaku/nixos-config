from setuptools import setup

setup(
    name='nixos',
    version='0.1',
    py_modules=[
        'nixos'
    ],
    packages=[
        'lib'
    ],
    install_requires=[
        'Click',
        'pyyaml',
        'GitPython'
    ],
    entry_points='''
        [console_scripts]
        nixos=nixos:cli
    ''',
)
