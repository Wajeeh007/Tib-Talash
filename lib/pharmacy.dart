import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/constants.dart';
import 'checkout.dart';

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
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Buttons('View Cart', () {
                if (cart_sel.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => cart(cart_sel)
                  )
                  );
                }else{
                  null;
                }
               },
                  Colors.deepOrange),
            ),
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
                icon: Icon(
                  Icons.arrow_back,
                  size: 35.0,
                  color: Colors.white,
                )
            ),
            centerTitle: true,
            title: Text('Order Medicines'),
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
      padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 6.0),
      child: Container(
        height: height/3.0,
        width: width/2.2,
        child: Column(
          children: <Widget>[
            Image.network(
              '${widget.url}',
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
            SizedBox(
              height: 7.0,
            ),
            Text('${widget.medicinename}', style: TextStyle(
              fontSize: 17.5,
              color: Colors.black,
            ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text('Price:  RS ${widget.medicineprice}', style: TextStyle(
              fontSize: 15.5,
              color: Colors.grey,
            ),
            ),
            SizedBox(
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
                    child: Icon(Icons.remove, color: Colors.black,),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text('${widget.quantity}'),
                SizedBox(
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
                    child: Icon(Icons.add, color: Colors.black,),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.check? Colors.grey:Colors.deepOrange,
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
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                  ),
                )
            ),
            SizedBox(
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
            return Padding(
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