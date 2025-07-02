import os
import sys
import subprocess
import json

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__base.menu.base import Menu

from helpers.misc import copy_to_clipboard
from helpers.strings import adjust_str


class BkmrMenu:
    def __init__(
        self,
        menu: Menu,
        attr_to_show: list[str] = ["metadata", "tags"],
        max_str_len: int = 150,
        return_str: str = " Return",
        icon_menu: str = "󰍜",
        icon_tips: str = "󰔨",
        icon_enter: str = "",
        online_status: str = "online",
        terminal_cmd: str = "konsole -e",
    ):
        self._menu = menu
        self._attr_to_show = attr_to_show
        self._max_str_len = max_str_len
        self._return_str = return_str

        self._icon_menu = icon_menu
        self._icon_tips = icon_tips
        self._icon_enter = icon_enter

        self._online_status = online_status
        self._terminal_cmd = terminal_cmd

    def _format_output(
        self,
        id: str,
        max_id: int,
        url: str | None = None,
        metadata: str | None = None,
        description: str | None = None,
        tags: str | None = None,
        sep_space_count: int = 4,
    ) -> str:
        # TODO: can't handle unicode character length correctly

        if not id:
            sys.exit("Bookmark ID was not given!")

        separator = " " * sep_space_count

        attr_count = len(self._attr_to_show)
        max_id_len = len(str(max_id))
        len_available = self._max_str_len - max_id_len - (len(separator) * attr_count)
        max_attr_len = len_available // attr_count

        str_parts = [id.ljust(max_id_len, " ")]

        for attr in self._attr_to_show:
            if attr == "metadata" and metadata:
                attr_str = metadata
            elif attr == "url" and url:
                attr_str = url
            elif attr == "description" and description:
                attr_str = description
            elif attr == "tags" and tags:
                attr_str = tags
            else:
                attr_str = " "

            if attr is not self._attr_to_show[-1]:
                adjusted_str = adjust_str(attr_str, max_attr_len)
            else:
                adjusted_str = attr_str

            str_parts.append(separator + adjusted_str)

        return "".join(str_parts)

    def get_bookmarks(
        self,
        tags: str | None = None,
    ) -> str:
        if tags:
            result = subprocess.run(
                ["bkmr", "search", "-t", tags, "--json", "--np"],
                capture_output=True,
                text=True,
            )
        else:
            result = subprocess.run(
                ["bkmr", "search", "--json", "--np"],
                capture_output=True,
                text=True,
            )

        bookmarks = json.loads(result.stdout)
        bookmarks = sorted(bookmarks, key=lambda item: item["id"])

        max_id = max(bookmark["id"] for bookmark in bookmarks)

        formatted_bookmarks = [
            self._format_output(
                id=str(bookmark["id"]),
                max_id=max_id,
                url=bookmark["url"],
                metadata=bookmark["title"].replace("\n", ""),
                description=bookmark["description"],
                tags=",".join(bookmark["tags"]),
            )
            for bookmark in bookmarks
        ]

        return "\n".join(formatted_bookmarks)

    def get_selection(self, menu_entries: list, prompt_name: str) -> str:
        bookmarks = self.get_bookmarks()
        menu_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

        return self._menu.get_selection(
            entries=menu_entries_str,
            prompt_name=prompt_name,
        )

    def get_all_tags(
        self,
        with_count: bool = True,
    ) -> str:
        result = subprocess.run(
            ["bkmr", "tags"],
            capture_output=True,
            text=True,
        )

        output = result.stdout.strip()

        if with_count:
            tags = "\n".join(
                f"{tag_info.split('(')[0].strip()} [{tag_info.split('(')[-1].rstrip(')')}]"
                for tag_info in output.splitlines()
            )
        else:
            tags = "\n".join(
                f"{tag_info.split('(')[0].strip()}"
                for tag_info in output.splitlines()
            )

        return tags

    def open_bookmark(self, selection: str) -> None:
        # get the id from the selected bookmark string
        id = int(selection.split(" ")[0])

        command = ["bkmr", "open", str(id)]

        subprocess.run(command)

    def add_bookmark(
        self,
        url: str | None = "",
        tags: str | None = "",
        title: str | None = "",
        description: str | None = "",
    ) -> str | None:
        url = self._menu.get_selection(
            entries="",
            prompt_name="URL: ",
        )

        if not url:
            self._menu.show_message("Input of 'URL' is mandatory!")

            return
        else:
            copy_to_clipboard(url)

        all_tags = self.get_all_tags(with_count=False)

        tags = self._menu.get_selection(
            entries=all_tags,
            prompt_name="Tags (comma separated): ",
        ).replace(" ", "")

        # add ',' at the start and the end
        # bkmr needs this
        tags = tags.strip(",")
        tags = "," + tags + ","

        result = subprocess.run(
            ["bkmr", "add", url, tags],
            input="y\n",
            capture_output=True,
            text=True,
        )

        if result.returncode:
            self._menu.show_message(
                entries=f"{result.stdout}\n{result.stderr}",
                prompt_name="Error: ",
            )
        else:
            self._menu.show_message(
                entries="Successfully added bookmark!",
                prompt_name="Success: ",
            )

    def edit_bookmark(self):
        menu_entries = [
            self._return_str,
            "",
        ]

        while True:
            selected_bookmark = self.get_selection(
                menu_entries=menu_entries,
                prompt_name="Edit Bookmarks: ",
            )

            if selected_bookmark == self._return_str:
                return
            elif not (selected_bookmark in menu_entries):
                bookmark_id = int(selected_bookmark.split(" ")[0])

                result = subprocess.run(
                    self._terminal_cmd.split() + ["bkmr", "edit", str(bookmark_id)],
                    capture_output=True,
                    text=True,
                )

                if result.returncode:
                    self._menu.show_message(
                        entries=f"{result.stdout}\n{result.stderr}",
                        prompt_name="Error: ",
                    )
                else:
                    self._menu.show_message(
                        entries="Successfully added bookmark!",
                        prompt_name="Success: ",
                    )

                break

    def delete_bookmark(self):
        menu_entries = [
            self._return_str,
            "",
        ]

        while True:
            selected_bookmark = self.get_selection(
                menu_entries=menu_entries,
                prompt_name="Delete Bookmarks: ",
            )

            if selected_bookmark == self._return_str:
                return
            elif not (selected_bookmark in menu_entries):
                confirmation = self._menu.get_confirmation()

                if confirmation:
                    bookmark_id = selected_bookmark.split(" ", maxsplit=1)[0]

                    result = subprocess.run(
                        ["bkmr", "delete", bookmark_id], capture_output=True, text=True
                    )

                    if result.returncode:
                        self._menu.show_message(
                            entries="Something went wrong!\nCouldn't delete bookmark!",
                            prompt_name="Error: ",
                        )
                    else:
                        self._menu.show_message(
                            entries="Bookmark deleted!",
                            prompt_name="Success: ",
                        )

    def show_tags(self) -> bool | None:
        menu_entries = [
            self._return_str,
            "",
        ]
        tags = self.get_all_tags()
        menu_entries_str = "\n".join(menu_entries) + "\n" + tags

        while True:
            selected_tag = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name=f"Tags ({len(tags)}): ",
            )

            if selected_tag == self._return_str:
                return
            elif not (selected_tag in menu_entries):
                tag = selected_tag.split("[")[0].strip()
                bookmarks = self.get_bookmarks(tags=tag)
                new_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

                selected_bookmark = self._menu.get_selection(
                    entries=new_entries_str,
                    prompt_name=f"Bookmarks Tagged with '{tag}': ",
                )

                if not (selected_bookmark in menu_entries):
                    self.open_bookmark(selection=selected_bookmark)

                    return True

    def run(self):
        entry_new_bookmark = self._icon_menu + " add new bookmark "
        entry_edit_bookmark = self._icon_menu + " edit bookmark "
        entry_delete_bookmark = self._icon_menu + " delete bookmark "
        entry_all_tags = self._icon_menu + " show all tags "

        menu_entries = [
            entry_new_bookmark,
            entry_edit_bookmark,
            entry_delete_bookmark,
            entry_all_tags,
            "",  # for adding an empty line
        ]

        while True:
            selection = self.get_selection(
                menu_entries=menu_entries,
                prompt_name="Bookmarks: ",
            )

            if selection in menu_entries:
                if selection == entry_new_bookmark:
                    self.add_bookmark()
                elif selection == entry_edit_bookmark:
                    self.edit_bookmark()
                elif selection == entry_delete_bookmark:
                    self.delete_bookmark()
                elif selection == entry_all_tags:
                    status = self.show_tags()

                    if status:
                        break
            elif not (selection in menu_entries):
                self.open_bookmark(selection=selection)

                break
