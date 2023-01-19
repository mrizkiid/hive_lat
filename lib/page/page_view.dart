import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lat/model/monster.dart';

class Tampilan extends StatelessWidget {
  const Tampilan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Pak Ercio'),
      ),
      body: FutureBuilder(
          future: Hive.openBox('monster'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('error');
              } else {
                var m = Hive.box('monster');
                if (m.length == 0) {
                  m.add(Monster('Garp', 1));
                  m.add(Monster('Luffy', 2));
                }
                return ValueListenableBuilder(
                  valueListenable: Hive.box('monster').listenable(),
                  builder: (context, value, _) => Container(
                    margin: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: m.length,
                      itemBuilder: (context, index) {
                        Monster monsters = m.getAt(index);
                        monsters.name;
                        return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(3.3, 6),
                                      blurRadius: 6),
                                ]),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('${monsters.name}[${monsters.age}]'),
                                  IconButton(
                                      onPressed: () {
                                        monsters.age = monsters.age + 1;
                                        value.putAt(
                                            index,
                                            Monster(
                                                monsters.name, monsters.age));
                                      },
                                      icon: const Icon(
                                        Icons.trending_up,
                                        color: Colors.green,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        m.add(Monster(
                                            monsters.name, monsters.age));
                                      },
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.amber,
                                      )),
                                  IconButton(
                                    onPressed: () {
                                      value.deleteAt(index);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ]));
                      },
                    ),
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
