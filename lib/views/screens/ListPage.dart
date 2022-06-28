import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductCategory.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  final String title;
  bool IsCategory;
  int categoryID;
  ListPage(
      {Key? key,
      required this.title,
      this.IsCategory = true,
      this.categoryID = -1})
      : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController seearchController = TextEditingController();

  bool isfirst = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Provider.of<ProductState>(context, listen: false).AllFiltersForCategories.length == 0){
      Provider.of<ProductState>(context, listen: false)
          .fetchFilterCategories();
    }
    if (widget.categoryID != -1) {
      Provider.of<ProductState>(context, listen: false)
          .getProductsByCategory(widget.categoryID);
      Provider.of<ProductState>(context, listen: false)
          .selectedCategoryId = widget.categoryID;
      Provider.of<ProductState>(context, listen: false)
          .mainParentCategory = widget.categoryID;
    } else {
      Provider.of<ProductState>(context, listen: false)
          .mainParentCategory = -1;
          Provider.of<ProductState>(context, listen: false)
          .selectedCategoryId = -1;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<ProductState>(context, listen: false).clearListOfProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, state, child) {
      if (isfirst) {
        state.clearListOfProducts();
        state.page = 1;
        state.getListOfProducts(state.selectedCategoryId);
        isfirst = false;
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              state.Paginate(state.selectedCategoryId);
            }
            return true;
          },
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    widget.IsCategory
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  finish(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 32.0,
                                )),
                          )
                        : Container(),
                    Align(
                        alignment: Alignment.center,
                        child: TitleText(title: widget.title)),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: NotificationBell())
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: textSizeMedium, fontFamily: PoppinsFamily),
                  obscureText: false,
                  cursorColor: black,
                  controller: seearchController,
                  onChanged: state.fillListOfProductsToShow,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                    hintText: lbl_Search,
                    hintStyle: primaryTextStyle(color: textFieldHintColor),
                    filled: true,
                    fillColor: lightBorderColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isDense: true,
                            elevation: 0,
                            icon: Icon(Icons.sort, color: black),
                            items: [
                              DropdownMenuItem(
                                child: Text('Sort By Price Low to High'),
                                value: 'price_low_to_high',
                              ),
                              DropdownMenuItem(
                                child: Text('Sort By Price High to Low'),
                                value: 'price_high_to_low',
                              ),
                              DropdownMenuItem(
                                child: Text('A to Z'),
                                value: 'a_to_z',
                              ),
                              DropdownMenuItem(
                                child: Text('Z to A'),
                                value: 'z_to_a',
                              ),
                            ],
                            onChanged: (value) {
                              switch (value) {
                                case 'price_low_to_high':
                                  state.sortByPriceLowToHigh();
                                  break;
                                case 'price_high_to_low':
                                  state.sortByPriceHighToLow();
                                  break;
                                case 'a_to_z':
                                  state.sortByPriceAToZ();
                                  break;
                                case 'z_to_a':
                                  state.sortByPriceZToA();
                                  break;
                              }
                            }),
                      ),
                    ),
                    IconButton(onPressed: (){
                      showModalBottomSheet(context: context, 
                      builder: (context){      
                           return Consumer<ProductState>(
                            builder: (context, value, child) => Container(
                              child: ListView(
                                children: List.generate(
                                  value.selectedCategoryId!=-1?
                                  value.allCategories
                                                  .where((element) => element.parentCategoryId == value.selectedCategoryId)
                                                  .length
                                                  :value.mainCategories.length
                                                  , (index) { 
                                                    ProductCategory obj = value.selectedCategoryId!=-1?
                                                  value.allCategories.where((element) => element.parentCategoryId == value.selectedCategoryId).elementAt(index):
                                                  value.mainCategories.elementAt(index);
                                                  return ListTile(
                                                    trailing: Icon(Icons.arrow_forward_ios),
                                                    onTap: () {
                                                                                                            value.setselectedCategoryId(obj.id.toString().toInt());
                                                      if(value.allCategories
                                                                      .where((element) => element.parentCategoryId == value.selectedCategoryId)
                                                                      .length == 0){
                                                                        value.setselectedCategoryId(value.mainParentCategory);
                                                                        Navigator.pop(context);
                                                                      }
                                                      value.ListOfProducts.clear();
                                                      value.getListOfProducts(obj.id.toString().toInt());
                                                    },
                                                    title: value.selectedCategoryId!=-1?
                                                  Text(obj.name.toString())
                                                  :Text(obj.name.toString()),
                                                  );
    }),
                              ),
                            ),
                          );

                      });
                    }, icon: Icon(Icons.filter, color: Colors.black)),                        
                    IconButton(onPressed: (){
                      state.setselectedCategoryId(state.mainParentCategory);
                      state.ListOfProducts.clear();
                      state.getListOfProducts(state.mainParentCategory);
                        }, icon: Icon(Icons.restore))
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: seearchController.text.length != 0
                        ? state.ListOfProductsToShow.length
                        : state.ListOfProducts.length,
                    itemBuilder: (context, index) {
                      if ((seearchController.text.length != 0
                              ? state.ListOfProductsToShow.length
                              : state.ListOfProducts.length) !=
                          0) {
                        return ItemElement(
                          product: (seearchController.text.length != 0
                              ? state.ListOfProductsToShow
                              : state.ListOfProducts)[index],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
