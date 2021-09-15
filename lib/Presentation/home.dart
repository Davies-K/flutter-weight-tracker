import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plendify/Databases/firestore_db.dart';
import 'package:plendify/Models/weight.dart';
import 'package:plendify/Providers/auth_provider.dart';
import 'package:plendify/values/values.dart';
import 'package:plendify/widgets/primary_block_button.dart';
import 'package:plendify/widgets/weight_item.dart';
import 'package:provider/provider.dart';

final TextEditingController _weightController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _key = GlobalKey<ScaffoldState>();

class HomePage extends StatelessWidget {
  final User firebaseUser;
  const HomePage({Key? key, required this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addNewWeight(context, null);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: Text("Home",
              style: AppTextStyles.titleStyle
                  .copyWith(color: AppColors.whiteColor)),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: PrimaryBlockButton(
                    color: AppColors.black,
                    width: 100,
                    onButtonTap: () {
                      context.read<AuthenticationProvider>().signOut();
                    },
                    title: 'Sign Out',
                  )),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireStoreDB()
                      .weightDB
                      .collection(FireStoreDB().dbName)
                      .where('user', isEqualTo: firebaseUser.uid)
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      );
                    }
                    final weightdoc = snapshot.data!.docs;
                    var weights = [];
                    for (var weight in weightdoc) {
                      var ideavar = weight.data();
                      weights.add(ideavar!);
                    }

                    var listItems =
                        List<WeightItem>.generate(weights.length, (i) {
                      Weight objectWeight = Weight(
                        value: weights[i]['value'],
                        reference: weights[i]['createdAt'],
                      );
                      return WeightItem(
                        weight: objectWeight,
                        onTapEdit: () {
                          _addNewWeight(context, objectWeight);
                        },
                        onTapDelete: () {
                          _deleteWeight(context, objectWeight);
                        },
                      );
                    });

                    return ListView(children: [...listItems]);
                  },
                ),
              )
            ],
          ),
        ));
  }

  _addNewWeight(context, Weight? weight) {
    if (weight != null) _weightController.text = weight.value;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bc) {
          return Container(
              padding: const EdgeInsets.all(20.0),
              height: Utils.screenHeight * 0.5,
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Text((weight) != null ? 'Edit Weight' : 'Add new weight',
                      style: AppTextStyles.paragraph),
                  const SizedBox(height: Sizes.SIZE_16),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        (value!.isEmpty) ? "Please Enter Weight" : null,
                    style: AppTextStyles.paragraph,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.confirmation_number),
                        labelText: "Weight",
                        border: OutlineInputBorder()),
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryBlockButton(
                          width: Utils.screenWidth * 0.3,
                          color: Colors.red,
                          onButtonTap: () {
                            Navigator.pop(context);
                          },
                          title: 'Cancel',
                        ),
                        PrimaryBlockButton(
                          width: Utils.screenWidth * 0.3,
                          color: AppColors.primaryColor,
                          onButtonTap: () {
                            if (_formKey.currentState!.validate()) {
                              weight != null
                                  ? _updateWeight(context, weight)
                                  : _createWeight(context);
                            }
                          },
                          title: 'Continue',
                        )
                      ])
                ]),
              ));
        });
  }

  Future _updateWeight(context, Weight w) {
    Weight weight = Weight(value: _weightController.text);
    return FireStoreDB()
        .updateWeight(weight.value, w.reference!, firebaseUser.uid)
        .then((value) {
      Navigator.pop(context);
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("Updated Successfully"),
      ));
      _weightController.text = "";
    });
  }

  Future _createWeight(context) {
    Weight weight = Weight(value: _weightController.text);
    return FireStoreDB().postWeight(weight, firebaseUser.uid).then((value) {
      Navigator.pop(context);
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("Added Successfully"),
      ));
      _weightController.text = "";
    });
  }

  Future _deleteWeight(context, Weight w) {
    return FireStoreDB().deleteWeight(w, firebaseUser.uid).then((value) {
      // Navigator.pop(context);
      _key.currentState!.showSnackBar(const SnackBar(
        content: Text("Deleted Successfully"),
      ));
    });
  }
}
