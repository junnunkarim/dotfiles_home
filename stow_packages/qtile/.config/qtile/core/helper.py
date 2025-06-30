import importlib


# dynamically load module
def load_module(module_path: str) -> object:
    try:
        module = importlib.import_module(module_path)
        return module
    except ImportError:
        print("Error: Could not import module")
        return None
