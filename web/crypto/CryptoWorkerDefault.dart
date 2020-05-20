import 'package:flutter/foundation.dart';
import 'package:service_worker/window.dart' as sw;

import 'CryptoWorker.dart';



class CryptoWorkerDefault extends CryptoWorker{
  sw.ServiceWorkerRegistration _worker;
  Future<void> install()async{
    if(kIsWeb) {
      if (sw.isSupported) {
        print("reg___istering");
        _worker = await sw.register("CryptoWorker.js");

        _worker.active.onMessage.listen((event) {
          print("df");
          print(event.data);
        });
        _worker.addEventListener('message', (event) {
          print("pool");
        });
        _worker.active.onError.listen((event) {
          print("error");
        });
        _worker.active.addEventListener('message', (event) {
          print("pool");
        });
        //_worker.active.dispatchEvent(sw.Event("message"));
        print("dispatched");
        _worker.active.postMessage("heeei");
        print("registered");
      } else {
        print("Sw not supported");
      }
    }
  }
}