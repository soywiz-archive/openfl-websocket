package ;
import openfl.net.WebSocket;
import openfl.Lib;
import openfl.display.Sprite;
import haxe.Timer;

class ClientExample extends Sprite {
    public function new() {
        super();
        Timer.delay(main, 10);
    }

    private function main() {
        trace('started');
        var ws = new WebSocket("ws://127.0.0.1:8080/");
        ws.onSocketOpen.add(function(v) {
            trace('socket opened!');
        });
        ws.onOpen.add(function(v) {
            trace('opened!');
            ws.sendText('hello');
        });
        ws.onClose.add(function(v) {
            trace('closed!');
        });
        ws.onError.add(function(e) {
            trace('error!' + e);
        });
        ws.onTextPacket.add(function(t) {
            trace('text packet! : ' + t);
        });
        ws.onBinaryPacket.add(function(t) {
            trace('binary packet! : ' + t);
        });
    }
}
