import buku
import pathlib
import os
import subprocess

from .class_menu import Menu, fail_exit


class BukuDmenu:
    def __init__(
        self,
        menu: Menu,
        database_path: pathlib.Path | None = None,
        attr_to_show: list[str] = ["id", "title", "tags"],
        max_str_len: int = 150,
        mode_of_operation: str = "online",
        return_str: str = " Return",
        icon_menu: str = "󰍜",
        icon_tips: str = "󰔨",
        icon_enter: str = "",
    ):
        if database_path:
            self._buku = buku.BukuDb(dbfile=str(database_path))
        else:
            self._buku = buku.BukuDb()

        self._menu = menu
        self._attr_to_show = attr_to_show
        self._max_str_len = max_str_len
        self._return_str = return_str
        self._mode_of_operation = mode_of_operation

        self._icon_menu = icon_menu
        self._icon_tips = icon_tips
        self._icon_enter = icon_enter

    def _copy_to_clipboard(self, text: str):
        wayland = os.environ.get("WAYLAND_DISPLAY", None)

        if wayland:
            print(wayland)
            command = ["wl-copy"]
        else:
            command = ["xclip", "-selection", "'clipboard'"]

        subprocess.run(
            command,
            input=text,
            encoding="utf-8",
            start_new_session=True,
        )

    def _truncate_str(
        self,
        string: str,
        max_limit: int,
    ):
        if len(string) > max_limit:
            return string[: max_limit - 3] + "..."

        return string

    def _format_output(
        self,
        id: str,
        url: str | None = None,
        title: str | None = None,
        description: str | None = None,
        tags: str | None = None,
        sep_space_count: int = 4,
    ) -> str:
        if not id:
            fail_exit(error="Bookmark ID was not given!")

        formatted_str = ""
        separator = ""
        for _ in range(sep_space_count):
            separator += " "

        if id in self._attr_to_show:
            attr_count = len(self._attr_to_show) - 1
        else:
            attr_count = len(self._attr_to_show)

        max_id_len = len(str(self._buku.get_max_id()))
        formatted_str += id.ljust(max_id_len, " ")

        max_attr_str_len = (
            self._max_str_len - max_id_len - (attr_count * sep_space_count)
        ) // attr_count

        # TODO: dynamically check if attr is the last element of the
        # given list and if it is then don't use 'ljust' on it
        if url and ("url" in self._attr_to_show):
            url = self._truncate_str(url, max_attr_str_len)
            formatted_str += separator + url.ljust(max_attr_str_len, " ")

        if title and ("title" in self._attr_to_show):
            title = self._truncate_str(title, max_attr_str_len + 20)
            formatted_str += separator + title.ljust(max_attr_str_len + 20, " ")

        if description and ("description" in self._attr_to_show):
            description = self._truncate_str(description, max_attr_str_len)
            formatted_str += separator + description.ljust(max_attr_str_len, " ")

        if tags and ("tags" in self._attr_to_show):
            formatted_str += separator + tags

        return formatted_str

    def get_bookmarks(
        self,
        tags: str | None = None,
    ) -> str:
        if tags:
            bookmark_list = self._buku.search_by_tag(tags=tags)
        else:
            bookmark_list = self._buku.get_rec_all()

        formatted_bookmarks = ""

        for row in bookmark_list:
            formatted_bookmarks += (
                self._format_output(
                    id=str(row.id),
                    url=row.url,
                    title=row.title,
                    description=row.desc,
                    tags=row.tags_raw.strip(","),
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

    def open_bookmark(self, id) -> None:
        command = ["buku", "--nostdin", "--nc", "--np", "--tacit", "-o", str(id)]

        subprocess.run(command, start_new_session=True)

    def get_selection(self, menu_entries: list, prompt_name: str) -> str:
        bookmarks = self.get_bookmarks()
        menu_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

        return self._menu.get_selection(
            entries=menu_entries_str,
            prompt_name=prompt_name,
        )

    def add_edit_bookmark(
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
            entry_add_title = "Add Title 󰏪"
            entry_add_tags = "Add Tags (optional) 󰏪"
            entry_add_desc = "Add Description (optional) 󰏪"
        else:
            entry_add_url = f"Url: {url} 󰏪"

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

        entry_editor = self._icon_menu + " Add using editor " + self._icon_enter
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
                prompt_name = "Add Bookmark:"
            else:
                prompt_name = "Edit Bookmark:"

            selection = self._menu.get_selection(
                entries=menu_entries_str,
                prompt_name=prompt_name,
            )

            if selection == self._return_str:  # return
                return
            elif selection == entry_editor:  # editor
                if mode == "add":
                    editor = os.environ.get("EDITOR", "vim")
                    shell_cmd = f"kitty -e buku -w '{editor}'"

                    status = subprocess.run(shell_cmd, shell=True)
                else:
                    shell_cmd = f"kitty -e buku -w {id}"

                    subprocess.run(shell_cmd, shell=True)

                return
            elif selection == entry_add_url:  # url
                if url:
                    self._copy_to_clipboard(url)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Url:",
                )

                if input and (input != self._return_str):
                    url = input
                    entry_add_url = f"Added url: '{url}' 󰄬"
            elif selection == entry_add_title:  # title
                if title:
                    self._copy_to_clipboard(title)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Title:",
                )

                if input and (input != self._return_str):
                    title = input
                    entry_add_title = f"Added title: '{title}' 󰄬"
            elif selection == entry_add_tags:  # tags
                if tags:
                    self._copy_to_clipboard(tags.strip(","))

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
            elif selection == entry_add_desc:  # description
                if description:
                    self._copy_to_clipboard(description)

                input = self._menu.get_selection(
                    entries=f"{self._return_str}\n",
                    prompt_name="Description:",
                )

                if input and (input != self._return_str):
                    description = input
                    entry_add_desc = f"Added tags: '{description}' 󰄬"
            elif selection == entry_save:  # save
                if not (url and title):
                    self._menu.show_message("Input of 'Url' and 'Title' are mandatory!")
                    continue

                if self._mode_of_operation == "online":
                    mode_of_op_status = True
                else:
                    mode_of_op_status = False

                if mode == "add":
                    status = self._buku.add_rec(
                        url,
                        title,
                        tags,
                        description,
                        immutable=mode_of_op_status,
                        fetch=mode_of_op_status,
                    )

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
                        immutable=mode_of_op_status,
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
                prompt_name="Edit Bookmarks:",
            )

            if selected_bookmark == menu_entries[0]:
                return
            elif not (selected_bookmark in menu_entries):
                bookmark_id = int(selected_bookmark.split(" ")[0])

                bookmark_info = self._buku.get_rec_by_id(index=bookmark_id)

                if bookmark_info:
                    self.add_edit_bookmark(
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
                prompt_name="Delete Bookmarks:",
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
                prompt_name="Tags:",
            )

            if selected_tag == menu_entries[0]:
                return False
            elif not (selected_tag in menu_entries):
                tag = selected_tag.split("(")[0].strip()
                bookmarks = self.get_bookmarks(tags=tag)
                new_entries_str = "\n".join(menu_entries) + "\n" + bookmarks

                selected_bookmark = self._menu.get_selection(
                    entries=new_entries_str,
                    prompt_name=f"Bookmarks Tagged with '{tag}'",
                )

                if not (selected_bookmark in menu_entries):
                    bookmark_id = int(selected_bookmark.split(" ")[0])

                    self.open_bookmark(id=bookmark_id)
                    return True
