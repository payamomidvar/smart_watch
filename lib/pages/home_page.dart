import '../dummy_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int piece = 0;
  final bandController = PageController();
  final watchController = PageController();
  late Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          shadowColor: Colors.transparent,
          title: const Text('Smart Watch'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: size.width * 0.6,
                      child: PageView.builder(
                        itemBuilder: (context, index) =>
                            Image.asset(bandList[index]),
                        itemCount: bandList.length,
                        controller: bandController,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: size.height * 0.265,
                      child: PageView.builder(
                        itemBuilder: (context, index) => Image.asset(
                          watchList[index],
                        ),
                        itemCount: watchList.length,
                        physics: const BouncingScrollPhysics(),
                        controller: watchController,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 35,
                      height: 300,
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            bandController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 7),
                            width: 30,
                            height: 35,
                            decoration: BoxDecoration(
                              color: bandChangerColorList[index],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: bandChangerColorList.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                primary: false,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 120,
                  mainAxisExtent: 120,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: watchList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    watchController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Image.asset(watchList[index]),
                ),
              ),
            ),
            price(),
          ],
        ),
      ),
    );
  }

  Widget price() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.grey.shade900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (piece != 0) {
                          piece--;
                        }
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      color: const Color.fromRGBO(23, 23, 23, 1),
                      child: const Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      piece.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (piece != 9) {
                          piece++;
                        }
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      color: const Color.fromRGBO(23, 23, 23, 1),
                      child: const Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                '\$${piece * 350}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(188, 188, 188, 1)
                ),
              )
            ],
          ),
        ),
      );
}
