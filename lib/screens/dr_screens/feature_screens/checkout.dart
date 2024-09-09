import 'package:flutter/material.dart';

class CartView extends StatefulWidget {

  final List cart_data;

  const CartView(this.cart_data, {super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  bool uiCheck = true;
  int total = 0;
  @override
  void initState() {
    widget.cart_data.forEach((element) {
      int u = element.quantity * element.medicineprice;
      setState(() {
        total += u;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Your Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
          centerTitle: true,
          leading: TextButton(onPressed: () {
            setState(() {
              total = 0;
            });
            Navigator.pop(context);
          },
              child: const Icon(Icons.arrow_back, size: 35.0, color: Colors.white,)),
        ),
        body: SafeArea(
            child: uiCheck ? SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Total:',
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              fontFamily: 'Ubuntu'
                          ),
                        ),
                        Text(
                          'Rs $total',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.cart_data.length,
                      itemBuilder: (context, index) {
                        var item = widget.cart_data[index];
                        int current_total = item.medicineprice * item.quantity;
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Card(
                              elevation: 2.0,
                              color: const Color(0xfff2efef),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              '${item.url}',
                                              width: 85.0,
                                              height: 85.0,
                                              frameBuilder: (context, child,
                                                  frame,
                                                  wasSynchronouslyLoaded) {
                                                return child;
                                              },
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                else {
                                                  return Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 20.0),
                                                      child: CircularProgressIndicator(
                                                        value: loadingProgress
                                                            .expectedTotalBytes !=
                                                            null
                                                            ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                            : null,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text('${item.medicinename}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight
                                                      .bold),),
                                            const SizedBox(height: 7.0,),
                                            Text('${item.medicineprice}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight
                                                      .w700),),
                                            const SizedBox(height: 7.0,),
                                            Text('${item.quantity}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.5,
                                                  fontWeight: FontWeight
                                                      .w700),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(25.0)
                                            ),
                                            padding: const EdgeInsets.all(5.0)
                                        ),
                                        onPressed: () {
                                          setState(() {

                                            total = total - current_total;
                                            widget.cart_data.remove(item);
                                            if (widget.cart_data.isEmpty) {
                                              uiCheck = false;
                                            }
                                          });
                                        },
                                        child: const Text(
                                          'Remove Item',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                              ),
                            )
                        );
                      }
                  ),
                ],
              ),
            ) : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_shopping_cart,
                    color: Colors.grey,
                    size: 90,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Cart is now Empty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0,
                        fontFamily: 'Ubuntu',
                        color: Colors.grey.shade600
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    'Return to previous screen',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        fontFamily: 'Ubuntu',
                        color: Colors.grey.shade500
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
