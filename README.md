openfl-websocket
================

http://lib.haxe.org/p/openfl-websocket

```haxelib install openfl-websocket```

```haxe
var ws = new WebSocket("ws://127.0.0.1:8080/test");
ws.onTextPacket(function(text) {
	trace(text);
});
ws.sendText("Hello World!");
//ws.close();
```
