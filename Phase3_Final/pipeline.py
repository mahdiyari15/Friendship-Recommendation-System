import subprocess
import papermill as pm

subprocess.run(["python3", "scripts/load_data.py"])
pm.execute_notebook(
    'scripts/preprocess.ipynb',
    'output_notebook.ipynb',
)
pm.execute_notebook(
    'scripts/feature_engineering.ipynb',
    'output_notebook.ipynb',
)
pm.execute_notebook(
    'scripts/training.ipynb',
    'output_notebook.ipynb',
)