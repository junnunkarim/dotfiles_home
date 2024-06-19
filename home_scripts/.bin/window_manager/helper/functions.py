def fail_exit(**kargs):
    for name, value in kargs.items():
        print(f"{name}: {value}")

    exit(1)


def safe_exit(**kargs):
    for name, value in kargs.items():
        print(f"{name}: {value}")
    exit()
