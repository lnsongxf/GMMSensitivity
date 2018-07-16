#! /usr/bin/env python
#****************************************************
# GET LIBRARY
#****************************************************
import subprocess, shutil, os
gslab_make_path = os.getenv('gslab_make_path')
subprocess.call('svn export --force -r 33368 ' + gslab_make_path + ' gslab_make', shell = True)
from gslab_make.py.get_externals import *
from gslab_make.py.make_log import *
from gslab_make.py.run_program import *
from gslab_make.py.dir_mod import *


#****************************************************
# MAKE.PY STARTS
#****************************************************
clear_dirs('../output/', '../external/', '../temp/')
start_make_logging()

# GET_EXTERNALS
get_externals('externals.txt')

# ANALYSIS
run_matlab(program = 'sensitivity_to_moments')
run_matlab(program = 'misspecification')
run_matlab(program = 'figures')
run_stata(program = 'figures')
run_python(program = 'parse_tables')

end_make_logging()

raw_input('\n Press <Enter> to exit.')
