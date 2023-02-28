import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sutamochi_prototype/communication.dart';

class Index extends StatefulWidget {
  @override

  _Index createState() => _Index();
}

class _Index extends State<Index> {
  @override

  Widget build(BuildContext context) {
    Communication communication = Communication();
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: const Text("GET"),
              onPressed: () async {
                dynamic res = await communication.get('/sample/index');
                debugPrint(res.toString());
              },
            ),
            CupertinoButton(
              child: const Text("POST"),
              onPressed: () async {
                dynamic res = await communication.post('/sample/create', { 'test': 'text' });
                debugPrint(res.toString());
              },
            ),
            CupertinoButton(
              child: const Text("PUT"),
              onPressed: () async {
                dynamic res = await communication.put('/sample/update', { 'test': 'text2' });
                debugPrint(res.toString());
              },
            ),
            CupertinoButton(
              child: const Text("DELETE"),
              onPressed: () async {
                dynamic res = await communication.delete('/sample/delete');
                debugPrint(res.toString());
              },
            ),
          ],
        ),
      )
    );
  }
}
