from subprocess import check_output, run
from .functions import fail_exit


class Menu:
    _main_prompt = []

    def __init__(
        self,
        main_prompt: list,
        prompt_flag: str = "-p",
        *args,
        **kargs,
    ) -> None:
        self._main_prompt = main_prompt
        self._prompt_flag = prompt_flag

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
        question: str = "Are you sure? ",
        positive=" Yes",
        negative=" No",
        extra_prompts: list = [],
        *args,
        **kargs,
    ) -> bool:
        prompt_question = [self._prompt_flag, question]

        output = run(
            self._main_prompt + prompt_question + extra_prompts,
            input=f"{positive}\n{negative}",
            text=True,
            capture_output=True,
            check=True,
        )

        if output.returncode or (output.stdout.strip() not in [positive, negative]):
            fail_exit(
                exit_code=output.returncode,
                stderr=output.stderr,
                error="Couldn't get user confirmation!",
            )

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
            self._main_prompt + [self._prompt_flag, prompt_name] + extra_args,
            input=entries,
            capture_output=True,
            encoding="utf-8",
        )

        if output.returncode:
            fail_exit(
                exit_code=output.returncode,
                stderr=output.stderr,
                error="Couldn't get user selection!",
            )

        return output.stdout.strip()

    def show_message(
        self,
        entries: str,
        prompt_name: str = "Error:",
    ) -> None:
        output = run(
            self._main_prompt + [self._prompt_flag, prompt_name],
            input=entries,
            encoding="utf-8",
        )

        if output.returncode:
            fail_exit(
                exit_code=output.returncode,
                stderr=output.stderr,
                error="Couldn't display message!",
            )

    def show_app_launcher(
        self,
        prompt_name: str = "",
        extra_prompt: list = [],
        *args,
        **kargs,
    ) -> None:
        output = run(
            self._main_prompt + [self._prompt_flag, prompt_name] + extra_prompt,
        )

        if output.returncode:
            fail_exit(
                exit_code=output.returncode,
                stderr=output.stderr,
                error="Couldn't display app launcher!",
            )

    def show(
        self,
        entries: str,
        prompt_name: str = "",
        extra_prompt: list = [],
        *args,
        **kargs,
    ) -> None:
        output = run(
            self._main_prompt + [self._prompt_flag, prompt_name] + extra_prompt,
            input=entries,
            encoding="utf-8",
        )

        if output.returncode:
            fail_exit(
                exit_code=output.returncode,
                stderr=output.stderr,
                error="Couldn't display entries",
            )
