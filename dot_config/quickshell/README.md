# Quickshell

[Documentation](https://quickshell.org/docs/v0.3.0/types/)
[Top bar tutorial](https://www.tonybtw.com/tutorial/quickshell/)

Seeing details about Hyprland workspaces

```zsh
hyprctl workspaces -j
```

Insert this into components to read values (launch Quickshell via terminal)

```qml
Component.onCompleted: {
    for (const key in modelData)
        console.log(key, "=", modelData[key]);
    console.log(JSON.stringify(modelData.lastIpcObject, null, 2));
}
```
