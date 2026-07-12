// Insert this into components to read values (launch Quickshell via terminal)
Component.onCompleted: {
    for (const key in modelData)
        console.log(key, "=", modelData[key]);
    console.log(JSON.stringify(modelData.lastIpcObject, null, 2));
}
