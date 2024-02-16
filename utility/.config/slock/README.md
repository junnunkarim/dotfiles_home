Similar to [dwm-flexipatch](https://github.com/bakkeby/dwm-flexipatch) this slock 1.5 (4f04554,
2022-10-04) project has a different take on patching. It uses preprocessor directives to decide
whether or not to include a patch during build time. Essentially this means that this build, for
better or worse, contains both the patched _and_ the original code. The aim being that you can
select which patches to include and the build will contain that code and nothing more.

For example to include the `capscolor` patch then you would only need to flip this setting from 0
to 1 in [patches.h](https://github.com/bakkeby/slock-flexipatch/blob/master/patches.h):
```c
#define CAPSCOLOR_PATCH 1
```

Once you have found out what works for you and what doesn't then you should be in a better position
to choose patches should you want to start patching from scratch.

Alternatively if you have found the patches you want, but don't want the rest of the flexipatch
entanglement on your plate then you may want to have a look at
[flexipatch-finalizer](https://github.com/bakkeby/flexipatch-finalizer); a custom pre-processor
tool that removes all the unused flexipatch code leaving you with a build that contains the patches
you selected.

Refer to [https://tools.suckless.org/slock/](https://tools.suckless.org/slock/) for details on the
slock tool, how to install it and how it works.

---

### Changelog:

2022-03-28 - Added the background image patch

2021-09-13 - Added the dwm logo patch

2021-09-09 - Added the auto-timeout, failure-command and secret-password patches

2021-06-08 - Added the color message patch

2020-08-03 - Added alpha, keypress_feedback and blur_pixelated_screen patches

2019-11-27 - Added xresources patch

2019-10-17 - Added capscolor, control clear, dpms, mediakeys, message, pam auth, quickcancel patches

2019-10-16 - Introduced [flexipatch-finalizer](https://github.com/bakkeby/flexipatch-finalizer)

### Patches included:

   - [alpha](https://github.com/khuedoan/slock)
      - enables transparency for slock
      - intended to be combined with a compositor that can blur the transparent background

   - [auto-timeout](https://tools.suckless.org/slock/patches/auto-timeout/)
      - allows for a command to be executed after a specified time of inactivity

   - [background_image](https://tools.suckless.org/slock/patches/background-image/)
      - sets the lockscreen picture to a background image

   - [blur_pixelated_screen](https://tools.suckless.org/slock/patches/blur-pixelated-screen/)
      - sets the lockscreen picture to a blured or pixelated screenshot

   - [capscolor](https://tools.suckless.org/slock/patches/capscolor/)
      - adds an additional color to indicate the state of Caps Lock

   - [color-message](https://tools.suckless.org/slock/patches/colormessage/)
      - based on the message patch this patch lets you add a message to your lock screen using
        24-bit color ANSI escape codes

   - [control-clear](https://tools.suckless.org/slock/patches/control-clear/)
      - with this patch slock will no longer change to the failure color if a control key is pressed
        while the buffer is empty
      - this may be useful if, for example, you wake your monitor up by pressing a control key and
        don't want to spoil the detection of failed unlocking attempts

   - [dpms](https://tools.suckless.org/slock/patches/dpms/)
      - interacts with the Display Power Signaling and automatically shuts down the monitor after a
        configurable amount of seconds
      - the monitor will automatically be activated by pressing a key or moving the mouse and the
        password can be entered then

   - [dwmlogo](https://tools.suckless.org/slock/patches/dwmlogo/)
      - draws the dwm logo which changes color based on the state

   - [failure-command](https://tools.suckless.org/slock/patches/failure-command/)
      - allows for a command to be run after a specified number of incorrect attempts

   - [keypress_feedback](https://tools.suckless.org/slock/patches/keypress-feedback/)
      - draws random blocks on the screen to display keypress feedback

   - [mediakeys](https://tools.suckless.org/slock/patches/mediakeys/)
      - allows media keys to be used while the screen is locked, e.g. adjust volume or skip to the
        next song without having to unlock the screen first

   - [message](https://tools.suckless.org/slock/patches/message/)
      - this patch lets you add a custom message to your lock screen

   - [pam-auth](https://tools.suckless.org/slock/patches/pam_auth/)
      - replaces shadow support with PAM authentication support

   - [quickcancel](https://tools.suckless.org/slock/patches/quickcancel/)
      - cancel slock by moving the mouse within a certain time-period after slock started
      - the time-period can be defined in seconds with the setting timetocancel in the config.h
      - this can be useful if you forgot to disable xautolock during an activity that requires no
        input (e.g. reading text, watching video, etc.)

   - [secret-password](https://tools.suckless.org/slock/patches/secret-password/)
      - allows for commands to be executed when the user enters special passwords

   - [terminalkeys](https://tools.suckless.org/slock/patches/terminalkeys/)
      - adds key commands that are commonly used in terminal applications (in particular the login
        prompt)

   - [unlockscreen](https://tools.suckless.org/slock/patches/unlock_screen/)
      - this patch keeps the screen unlocked, but keeps the input locked
      - that is, the screen is not affected by slock, but users will not be able to interact with
        the X session unless they enter the correct password

   - [xresources](https://tools.suckless.org/slock/patches/xresources/)
      - this patch adds the ability to get colors via Xresources
