import os
import sys
import pathlib
import subprocess

import buku

# enables importing from parent directories
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))

from class__base.menu.base import Menu

from helpers.misc import copy_to_clipboard
from helpers.strings import adjust_str


class BukuMenu:
    def __init__(
        self,
        menu: Menu,
        database_path: pathlib.Path | None = None,
        editor_cmd: str = "emacs",
        attr_to_show: list[str] = ["title", "tags"],
        max_str_len: int = 150,
        online_status: str = "online",
        return_str: str = " Return",
        icon_menu: str = "󰍜",
        icon_tips: str = "󰔨",
        icon_enter: str = "",
    ):
        if database_path:
            self._buku = buku.BukuDb(dbfile=str(database_path), colorize=False)
        else:
            self._buku = buku.BukuDb()

        self._menu = menu
        self._editor_cmd = editor_cmd
        self._attr_to_show = attr_to_show
        self._max_str_len = max_str_len
        self._return_str = return_str
        self._online_status = online_status

        self._icon_menu = icon_menu
        self._icon_tips = icon_tips
        self._icon_enter = icon_enter

    def _format_output(
        self,
        id: str,
        max_id: int,
        url: str | None = None,
        title: str | None = None,
        description: str | None = None,
        tags: str | None = None,
        sep_space_count: int = 4,
    ) -> str:
        if not id:
            sys.exit("Bookmark ID was not given!")

        separator = " " * sep_space_count

        attr_count = len(self._attr_to_show)
        max_id_len = len(str(max_id))

        len_available = self._max_str_len - max_id_len - (len(separator) * attr_count)
        max_attr_len = len_available // attr_count

        str_parts = [id.ljust(max_id_len, " ")]

        for attr in self._attr_to_show:
            if attr == "title" and title:
                attr_str = title
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
            bookmarks = self._buku.search_by_tag(tags=tags)
        else:
            bookmarks = self._buku.get_rec_all()

        max_id = max(bookmark.id for bookmark in bookmarks)
        formatted_bookmarks = ""

        for bookmark in bookmarks:
            formatted_bookmarks += (
                self._format_output(
                    id=str(bookmark.id),
                    max_id=max_id,
                    url=bookmark.url,
                    title=bookmark.title,
                    description=bookmark.desc,
                    tags=bookmark.tags_raw.strip(","),
                )
                + "\n"
            )

        return formatted_bookmarks

    def get_all_tags(
        self,
        with_item_count: bool = True,
    ) -> str:
        # index 0 of 'get_tag_all' is a list and
        # index 1 is a dictionary with the key being
        # the tag name and the value being the count
        if not with_item_count:
            buku_tags = self._buku.get_tag_all()[0]
            return "\n".join(buku_tags)
        else:
            buku_tags = self._buku.get_tag_all()[1]
            return "\n".join(f"{tag} ({count})" for tag, count in buku_tags.items())

    def open_bookmark(self, selection: str) -> None:
        # get the id from the selected bookmark string
        id = int(selection.split(" ")[0])

        command = ["buku", "--nostdin", "--nc", "--np", "--tacit", "-o", str(id)]

        subprocess.run(command, start_new_session=True)

    def get_selection(self, menu_entries: list, prompt_name: str) -> str:
        bookmarks = self.get_bookmarks()
        menu_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

        return self._menu.get_selection(
            entries=menu_entries_str,
            prompt_name=prompt_name,
        )

    def add_bookmark(
        self,
        mode: str = "add",
        id: int | None = None,
        url: str | None = "",
        title: str | None = "",
        tags: str | None = "",
        description: str | None = "",
    ) -> str | int | None:
        if (mode != "add") and (mode != "edit"):
            return

        if (mode == "edit") and (not id):
            return

        if (mode == "edit") and (not url):
            return

        if mode == "add":
            entry_add_url = "Add Url 󰏪"
            entry_editor = self._icon_menu + " Add using editor " + self._icon_enter
            entry_add_title = "Add Title 󰏪"
            entry_add_tags = "Add Tags (optional) 󰏪"
            entry_add_desc = "Add Description (optional) 󰏪"
        else:
            entry_add_url = f"Url: {url} 󰏪"
            entry_editor = self._icon_menu + " Edit using editor " + self._icon_enter

            if title:
                entry_add_title = f"Title: {title} 󰏪"
            else:
                entry_add_title = f"Title: 󰏪"

            if tags:
                entry_add_tags = f"Tags (optional): {tags.strip(',')} 󰏪"
            else:
                entry_add_tags = f"Tags (optional): 󰏪"

            if description:
                entry_add_desc = f"Description (optional): {description} 󰏪"
            else:
                entry_add_desc = f"Description (optional): 󰏪"

        entry_save = "Save? 󰆓"

        while True:
            menu_entries = [
                self._return_str,
                entry_editor,
                "",
                entry_add_url,
                entry_add_title,
                entry_add_tags,
                entry_add_desc,
                "",
                entry_save,
            ]

            menu_entries_str = "\n".join(menu_entries)

            if mode == "add":
                prompt_name = "Add Bookmark: "
            else:
                prompt_name = "Edit Bookmark: "

            selection = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name=prompt_name,
            )

            # if return was chosen
            if selection == self._return_str:
                return
            # editor
            elif selection == entry_editor:
                if mode == "add":
                    if self._online_status == "online":
                        shell_cmd = f"kitty -e buku -w '{self._editor_cmd}'"
                    else:
                        shell_cmd = f"kitty -e buku --offline -w '{self._editor_cmd}'"

                    status = subprocess.run(shell_cmd, shell=True)
                else:
                    shell_cmd = f"kitty -e buku -w {id}"

                    status = subprocess.run(shell_cmd, shell=True)

                return
            # url
            elif selection == entry_add_url:
                if url:
                    copy_to_clipboard(url)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Url:",
                )

                if input and (input != self._return_str):
                    url = input
                    entry_add_url = f"Added url: '{url}' 󰄬"
            # title
            elif selection == entry_add_title:
                if title:
                    copy_to_clipboard(title)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Title:",
                )

                if input and (input != self._return_str):
                    title = input
                    entry_add_title = f"Added title: '{title}' 󰄬"
            # tags
            elif selection == entry_add_tags:
                if tags:
                    copy_to_clipboard(tags.strip(","))

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Tags (comma separated):",
                )

                if input and (input != self._return_str):
                    tags = input
                    entry_add_tags = f"Added tags: '{tags}' 󰄬"
                    # add ',' at the start and the end
                    # buku needs this
                    tags = tags.strip(",")
                    tags = "," + tags + ","
            # description
            elif selection == entry_add_desc:
                if description:
                    copy_to_clipboard(description)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Description:",
                )

                if input and (input != self._return_str):
                    description = input
                    entry_add_desc = f"Added tags: '{description}' 󰄬"
            # save
            elif selection == entry_save:
                if not (url and title):
                    self._menu.show_message("Input of 'Url' and 'Title' are mandatory!")
                    continue

                if self._online_status == "online":
                    online_status = True
                else:
                    online_status = False

                if mode == "add":
                    status = self._buku.add_rec(
                        url,
                        title,
                        tags,
                        description,
                        immutable=online_status,
                        fetch=online_status,
                    )

                    # if not online_status:
                    #     shell_cmd = f"buku --nostdin --nc --np --offline -a {url} --title '{title}' --tag '{tags}' --comment '{description}'"
                    # else:
                    #     shell_cmd = (
                    #         f"buku --nostdin --nc --np -a {url} --title '{title}' --tag '{tags}' --comment "
                    #         + f"{description}"
                    #     )
                    #
                    # status = subprocess.run(shell_cmd, shell=True)

                    if not status:
                        self._menu.show_message(
                            entries="Something went wrong!\nCouldn't add bookmark!"
                        )
                    else:
                        self._menu.show_message(
                            entries="Successfully added bookmark!",
                            prompt_name="Success:",
                        )
                else:  # mode == "edit"
                    status = self._buku.update_rec(
                        id,
                        url,
                        title,
                        tags,
                        description,
                        immutable=online_status,
                    )

                    if not status:
                        self._menu.show_message(
                            entries="Something went wrong!\nCouldn't edit bookmark!"
                        )
                    else:
                        self._menu.show_message(
                            entries="Successfully edited bookmark!",
                            prompt_name="Success:",
                        )

                return status

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

            if selected_bookmark == menu_entries[0]:
                return
            elif not (selected_bookmark in menu_entries):
                bookmark_id = int(selected_bookmark.split(" ")[0])

                bookmark_info = self._buku.get_rec_by_id(index=bookmark_id)

                if bookmark_info:
                    self.add_bookmark(
                        mode="edit",
                        id=bookmark_id,
                        url=str(bookmark_info.url),
                        title=str(bookmark_info.title),
                        description=str(bookmark_info.desc),
                        tags=str(bookmark_info.tags_raw),
                    )

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

            if selected_bookmark == menu_entries[0]:
                return
            elif not (selected_bookmark in menu_entries):
                confirmation = self._menu.get_confirmation()
                if confirmation:
                    bookmark_id = int(selected_bookmark.split(" ")[0])

                    status = self._buku.delete_rec(bookmark_id)

                    if not status:
                        self._menu.show_message(
                            entries="Something went wrong!\nCouldn't delete bookmark!"
                        )
                    else:
                        self._menu.show_message(
                            entries="Bookmark deleted!",
                            prompt_name="Success:",
                        )

    def show_tags(self) -> bool:
        menu_entries = [
            self._return_str,
            "",
        ]
        tags = self.get_all_tags()
        menu_entries_str = "\n".join(menu_entries) + "\n" + tags

        while True:
            selected_tag = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name="Tags: ",
            )

            if selected_tag == menu_entries[0]:
                return False
            elif not (selected_tag in menu_entries):
                tag = selected_tag.split("(")[0].strip()
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
