<p align="center">
	<img width="256" height="256" src="../demo/assets/share-android.png">
</p>

---
# <img src="../addon/icon.png" width="24"> Share Plugin
Share Plugin allows sharing of text and images on Android platform.

## <img src="../addon/icon.png" width="20"> Prerequisites
Follow instructions on the following page to create a custom Android gradle build
- [Create custom Android gradle build](https://docs.godotengine.org/en/stable/tutorials/export/android_gradle_build.html)

## <img src="../addon/icon.png" width="20"> Package name
In your Godot project, make sure to...
- remove/replace the `$genname` token from the `package/unique_name` field of your project's Android export settings

## <img src="../addon/icon.png" width="20"> Troubleshooting

### ADB logcat
`adb logcat` is one of the best tools for troubleshooting unexpected behavior
- use `$> adb logcat | grep 'godot'` on Linux
	- `adb logcat *:W` to see warnings and errors
	- `adb logcat *:E` to see only errors
	- `adb logcat | grep 'godot|somethingElse'` to filter using more than one string at the same time
- use `#> adb.exe logcat | select-string "godot"` on powershell (Windows)


### Don't use `$genname` token for package name in Godot's project settings

Using the default setting of `com.example.$genname` for package name (`package/unique_name`) in your Godot project's Android Export settings will not work with this plugin as the `$genname` token is not replaced before an Android export. Removing the `$genname` token from the `package/unique_name` is necessary for this plugin to work.

Also check out:
https://docs.godotengine.org/en/stable/tutorials/platform/android/android_plugin.html#troubleshooting
