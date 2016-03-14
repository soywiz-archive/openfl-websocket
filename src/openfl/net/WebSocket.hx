package openfl.net;
import openfl.utils.ByteArray;
import openfl.utils.Timer;
import haxe.io.Bytes;
import openfl.events.TimerEvent;

@:allow(Slot)
class WebSocket {
    private var ws:haxe.net.WebSocket;
    private var timer:Timer;

    public function new(uri:String, origin:String = "http://127.0.0.1/", key:String = "wskey", debug:Bool = true, protocols:Array<String> = null) {
        this.ws = haxe.net.WebSocket.create(uri, protocols, origin, debug);

        var timer = new Timer(20);
        timer.addEventListener(TimerEvent.TIMER, function(e) {
            ws.process();
        });
        timer.start();

        this.ws.onopen = function() {
            this.onOpen.dispatch(null);
        };

        this.ws.onclose = function() {
            this.onClose.dispatch(null);
        };

        this.ws.onerror = function(message:String) {
            this.onError.dispatch(message);
        };

        this.ws.onmessageString = function(message:String) {
            this.onTextPacket.dispatch(message);
        };

        this.ws.onmessageBytes = function(message:Bytes) {
            var data:ByteArray = message;
            this.onBinaryPacket.dispatch(data);
        };
    }

    public function dispose() {
        if (this.timer == null) return;
        this.timer.stop();
        this.timer = null;
    }

    public var onTextPacket = new Signal<String>();
    public var onBinaryPacket = new Signal<ByteArray>();
    public var onPing = new Signal<Dynamic>();
    public var onPong = new Signal<Dynamic>();
    public var onSocketOpen = new Signal<Dynamic>();
    public var onClose = new Signal<Dynamic>();
    public var onError = new Signal<String>();
    public var onOpen = new Signal<Dynamic>();

    public function sendText(data:String) {
        this.ws.sendString(data);
    }

    public function sendBinary(data:ByteArray) {
        this.ws.sendBytes(data);
    }

    public function close() {
        //this.ws.close();
    }
}

class Signal<T> {
    private var callbacks = new Array<T -> Void>();

    public function new() {
    }

    public function dispatch(?value:T) {
        for (cb in callbacks) {
            cb(value);
        }
    }

    public function add(callback:T -> Void):T -> Void {
        callbacks.push(callback);
        return callback;
    }

    public function remove(callback:T -> Void):Void {
        callbacks.remove(callback);
    }
}
