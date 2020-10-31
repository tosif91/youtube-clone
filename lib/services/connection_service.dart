import 'dart:io'; 
import 'dart:async'; 
import 'package:connectivity/connectivity.dart';

class ConnectionService {
   //This tracks the current connection status
    bool hasConnection = false;

    StreamController connectionChangeController = new StreamController.broadcast();
   //using flutter connectivity package
    final Connectivity _connectivity = Connectivity();
   StreamSubscription _connectionSubscription;
    //Hook into flutter_connectivity's Stream to listen for changes
    //And check the connection status out of the gate
    void initialize() async{
        _connectivity.onConnectivityChanged.listen(_connectionChange);
        await checkConnection();
    }

    Stream get connectionChange => connectionChangeController.stream;

    //A clean up method to close our StreamController
    //   Because this is meant to exist through the entire application life cycle this isn't
    //   really an issue
    void dispose() {
        connectionChangeController.close();
    }

    //flutter_connectivity's listener
    void _connectionChange(ConnectivityResult result) {
        checkConnection();
    }

    //The test to actually see if there is a connection
    Future<bool> checkConnection() async {
        bool previousConnection = hasConnection;

        try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                hasConnection = true;
            } else {
                hasConnection = false;
            }
            print('service connecting $hasConnection');
        } on SocketException catch(_) {
            hasConnection = false;
        }

        //The connection status changed send out an update to all listeners
        if (previousConnection != hasConnection) {
            connectionChangeController.add(hasConnection);
        }

        return hasConnection;
    }
}