# Flask Server Example

Before running the app, run the following command to package the Python app into an asset.
Generate **app.zip** file

> ℹ️ **Important Reminder**: If you are using `serious_python: ^0.8.1`, ensure you use the command for macOS and not the iOS version, otherwise it will not work.

For Android:

```
export SERIOUS_PYTHON_SITE_PACKAGES=$(pwd)/build/site-packages
dart run serious_python:main package app/src -p Android --requirements -r,app/src/requirements.txt
```

For iOS, macOS testing: Use **-p Darwin**

```
dart run serious_python:main package app/src -p Darwin --requirements -r,app/src/requirements.txt
```

For Windows:

```
dart run serious_python:main package app/src -p Windows --requirements -r,app/src/requirements.txt
```

For Linux:

```
dart run serious_python:main package app/src -p Linux --requirements -r,app/src/requirements.txt
```

For Android:

In `android/app/build.gradle`:

```
android {
    ndkVersion "25.1.8937393"

    packagingOptions {
        jniLibs {
            useLegacyPackaging true
        }
    }

    packagingOptions {
        doNotStrip "*/arm64-v8a/libpython*.so"
        doNotStrip "*/armeabi-v7a/libpython*.so"
        doNotStrip "*/x86/libpython*.so"
        doNotStrip "*/x86_64/libpython*.so"
    }
}
```