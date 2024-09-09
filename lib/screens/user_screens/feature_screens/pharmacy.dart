import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/helpers/constants.dart';
import '../../dr_screens/feature_screens/checkout.dart';

final _firestore = FirebaseFirestore.instance;
List<MedicineBubble> medicineBubble = [];
List<MedicineBubble> cart_sel = [];

class pharmacy extends StatelessWidget {
  static const pharmacyID = "pharmacy_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            elevation: 4.0,
            child: Buttons('View Cart', () {
              if (cart_sel.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CartView(cart_sel)
                )
                );
              }else{
                null;
              }
             },
                Colors.deepOrange),
          ),
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            leading: IconButton(
                onPressed: (){
                  cart_sel.clear();
                  medicineBubble.forEach((element) {
                    element.check = false;
                    element.quantity = 1;
                  });
                  Navigator.pop(context);
                  },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25.0,
                  color: Colors.white,
                )
            ),
            centerTitle: true,
            title: const Text('Order Medicines', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
            elevation: 4.0,
            shadowColor: Colors.grey.shade600,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                child: medicineStream()
            ),
          ),
        );
  }
}

class MedicineBubble extends StatefulWidget {
  MedicineBubble(
      this.medicineprice,
      this.medicinename,
      this.url
      );

  final String medicinename;
  final int medicineprice;
  final String url;

  int quantity = 1;
  bool check = false;

  void update(){
    check = !check;
  }

  @override
  State<MedicineBubble> createState() => _MedicineBubbleState();
}

class _MedicineBubbleState extends State<MedicineBubble> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 6.0),
      child: Container(
        height: height/3.0,
        width: width/2.2,
        child: Column(
          children: <Widget>[
            Image.network(
              widget.url,
              width: 75.0,
              height: 75.0,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                return child;
              },
              loadingBuilder: (context, child, loadingProgress){
                if(loadingProgress == null){
                  return child;
                }
                else{
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 7.0,
            ),
            Text(widget.medicinename, style: const TextStyle(
              fontSize: 17.5,
              color: Colors.black,
            ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text('Price:  RS ${widget.medicineprice}', style: const TextStyle(
              fontSize: 15.5,
              color: Colors.grey,
            ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if(widget.quantity == 1){
                        return ;
                      }
                      else{
                        setState(() {
                          widget.quantity--;
                        });
                      }
                    },
                    child: const Icon(Icons.remove, color: Colors.black,),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text('${widget.quantity}'),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.orange
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if(widget.quantity == 6){
                        return ;
                      }
                      else{
                        setState(() {
                          widget.quantity++;
                        });
                      }
                    },
                    child: const Icon(Icons.add, color: Colors.black,),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: (){
                  setState(() {
                    widget.check = true;
                  });
                  cart_sel.add(widget);
                },
                child: Text(
                  widget.check? 'Added to Cart' : 'Add to Cart',
                  style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),
                )
            ),
            const SizedBox(
              height: 5.0,
            )
          ],
        ),
      ),
    );
  }
}

class medicineStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('medicines_data').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ),
              ),
            );
          }
          final medicines = snapshot.data!.docs;
          for(var medicine in medicines) {
            final medicinename = medicine.get('Name');
            final medicineURL = medicine.get('URL');
            final medicinePrice = medicine.get('Price');
            final medicinebubble = MedicineBubble(medicinePrice, medicinename, medicineURL);
            medicineBubble.add(medicinebubble);
        }
                return Center(
                  child: Wrap(
                    children: medicineBubble
                  ),
                );
          }
        );
  }
}