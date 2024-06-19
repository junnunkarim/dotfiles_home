from subprocess import check_output, run
from .functions import fail_exit


class Menu:
    _main_prompt = []

    def __init__(self, main_prompt: list) -> None:
        self._main_prompt = main_prompt

    # ----------------
    # helper functions
    # ----------------
    def _get_screen_resolution(self):
        command = ["xrandr"]
        output = check_output(command).decode()

        for line in output.splitlines():
            if "current" in line:
                resolution = (
                    line.split("current ")[1].split(",")[0].strip().split(" x ")
                )
                break
        else:
            resolution = None

        return resolution

    # execution functions
    # -------------------
    def get_confirmation(
        self,
        question: str = "Are you sure?",
        positive=" Yes",
        negative=" No",
        extra_prompts: list = [],
        *args,
        **kargs,
    ) -> bool:
        prompt_question = ["-p", question]

        output = run(
            self._main_prompt + prompt_question + extra_prompts,
            input=f"{positive}\n{negative}",
            text=True,
            capture_output=True,
            check=True,
        )

        if output.returncode:
            fail_exit(exit_code=output.returncode)

        if output.stdout.strip() == positive:
            return True
        else:
            return False

    def get_selection(
        self,
        entries: str,
        prompt_name: str = "",
        extra_args: list = [],
        *args,
        **kargs,
    ) -> str:
        output = run(
            self._main_prompt + ["-p", prompt_name] + extra_args,
            input=entries,
            capture_output=True,
            encoding="utf-8",
        )

        if output.returncode:
            fail_exit(exit_code=output.returncode)

        return output.stdout.strip()

    def show(
        self,
        entries: str,
        prompt_name: str = "",
        extra_prompt: list = [],
        *args,
        **kargs,
    ) -> None:
        output = run(
            self._main_prompt + ["-p", prompt_name] + extra_prompt,
            input=entries,
            encoding="utf-8",
        )

        if output.returncode:
            fail_exit(exit_code=output.returncode)
