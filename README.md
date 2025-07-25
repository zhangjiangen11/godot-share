<p align="center">
	<img width="256" height="256" src="demo/assets/share-android.png">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<img width="256" height="256" src="demo/assets/share-ios.png">
</p>

---

# <img src="addon/icon.png" width="24"> Godot Share Plugin

Share Plugin allows sharing of text and images on Android and iOS platforms.

_This plugin has been moved under the umbrella of [Godot SDK Integrations](https://github.com/godot-sdk-integrations) organization in Github. Previously, the plugin was placed under three separate repositories: [Android](https://github.com/cengiz-pz/godot-android-share-plugin), [iOS](https://github.com/cengiz-pz/godot-ios-share-plugin), and [addon interface](https://github.com/cengiz-pz/godot-share-addon)._

<br/>

## <img src="addon/icon.png" width="20"> Installation
_Before installing this plugin, make sure to uninstall any previous versions of the same plugin._

_If installing both Android and iOS versions of the plugin in the same project, then make sure that both versions use the same addon interface version._

There are 2 ways to install this plugin into your project:
- Through the Godot Editor's AssetLib
- Manually by downloading archives from Github

### <img src="addon/icon.png" width="18"> Installing via AssetLib
Steps:
- search for and select the `Share` plugin in Godot Editor
- click `Download` button
- on the installation dialog...
	- keep `Change Install Folder` setting pointing to your project's root directory
	- keep `Ignore asset root` checkbox checked
	- click `Install` button
- enable the plugin via the `Plugins` tab of `Project->Project Settings...` menu, in the Godot Editor

#### <img src="addon/icon.png" width="16"> Installing both Android and iOS versions of the plugin in the same project
When installing via AssetLib, the installer may display a warning that states "_[x number of]_ files conflict with your project and won't be installed." You can ignore this warning since both versions use the same addon code.

### <img src="addon/icon.png" width="18"> Installing manually
Steps:
- download release archive from Github
- unzip the release archive
- copy to your Godot project's root directory
- enable the plugin via the `Plugins` tab of `Project->Project Settings...` menu, in the Godot Editor

<br/>

## <img src="addon/icon.png" width="20"> Usage
Add a `Share` node to your scene and follow the following steps:
- use one of the following methods of the `Share` node to share text or images:
		- `share_text(title, subject, content)`
		- `share_image(full_path_for_saved_image_file, title, subject, content)`
				- Note that the image you want to share must be saved under the `user://` virtual directory in order to be accessible. The `OS.get_user_data_dir()` method can be used to get the absolute path for the `user://` directory. See the implementation of `share_viewport()` method for sample code.
		- `share_viewport(viewport, title, subject, content)`

<br/>

## <img src="addon/icon.png" width="20"> Demo
Install and enable `SharePlugin` before running demo.

<br/><br/>

---

# <img src="addon/icon.png" width="24"> Android Share Plugin

<p align="center">
	<img width="256" height="256" src="demo/assets/share-android.png">
</p>


## [Android-specific Documentation](android/README.md)
## [AssetLib Entry](https://godotengine.org/asset-library/asset/2542)

<br/><br/>

---

# <img src="addon/icon.png" width="24"> iOS Share Plugin

<p align="center">
	<img width="256" height="256" src="demo/assets/share-ios.png">
</p>

## [iOS-specific Documentation](ios/README.md)
## [AssetLib Entry](https://godotengine.org/asset-library/asset/2907)

<br/><br/>

---
# <img src="addon/icon.png" width="24"> All Plugins

| Plugin | Android | iOS |
| :---: | :--- | :--- |
| [Admob](https://github.com/godot-sdk-integrations/godot-admob) | ✅ | ✅ |
| [Deeplink](https://github.com/godot-sdk-integrations/godot-deeplink) | ✅ | ✅ |
| [In-App Review](https://github.com/godot-sdk-integrations/godot-inapp-review) | ✅ | ✅ |
| [Notification Scheduler](https://github.com/godot-sdk-integrations/godot-notification-scheduler) | ✅ | ✅ |
| [Share](https://github.com/godot-sdk-integrations/godot-share) | ✅ | ✅ |

<br/><br/>

---
# <img src="addon/icon.png" width="24"> Credits

Developed by [Cengiz](https://github.com/cengiz-pz)

Android part is based on [Shin-NiL](https://github.com/Shin-NiL)'s [Godot Share plugin](https://github.com/Shin-NiL/Godot-Android-Share-Plugin)

iOS part is based on on: [Godot iOS Plugin Template](https://github.com/cengiz-pz/godot-ios-plugin-template)

Original repository: [Godot Share Plugin](https://github.com/godot-sdk-integrations/godot-share)
