openfl-websocket
================

http://lib.haxe.org/p/openfl-websocket

```haxelib install openfl-websocket```

```haxe
var ws = new WebSocket("ws://127.0.0.1:8080/test", "http://127.0.0.1/origin");
ws.onTextPacket.add(function(text:String) {
	trace(text);
});
var slot = ws.onBinaryPacket.add(function(data:ByteArray) {
	trace(data);
	slot.dispose();
});
ws.sendText("Hello World!");
ws.sendBinary(new ByteArray());
//ws.close();
```
