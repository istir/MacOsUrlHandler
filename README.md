# MacOS URL scheme handler

## [Original project](https://github.com/jwbargsten/ZettelURLHandler)

### Usage:

1. Create a config file `~/.config/uri-schemes.json`
2. Specify uri schemes that should open the app

```json
{
  "appuri": {
    "appScheme": "com.example.app"
  }
}
```

3. Visit `urihandler://appuri?whatever=you&want`
4. `com.example.app` will open following argument passed to it `appuri://appuri?whatever=you&want`

### Why?

The problem with macOS support for uri schemes is that it doesn't let you easily pass said scheme to the app you're writing outside of Swift ecosystem.

`some-scheme://app?foo=bar&foo=baz` would open registered app, but not pass the uri scheme itself, nor any arguments.
