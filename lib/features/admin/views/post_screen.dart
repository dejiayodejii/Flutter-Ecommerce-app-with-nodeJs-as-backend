import 'package:flutter/material.dart';
import 'package:pushit/features/account/widget/single_product.dart';
import 'package:pushit/features/admin/controller/admin_controller.dart';
import 'package:pushit/features/admin/views/add_product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final AdminController _controller = AdminController();

  @override
  void initState() {
    super.initState();
    _controller.getAllProduct(context, _onSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.productList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _controller.productList!.isEmpty
              ? const Center(child: Text('No Products'))
              : GridView.builder(
                  itemCount: _controller.productList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: _controller.productList![index].images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                _controller.productList![index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _controller.deleteProduct(
                                    context: context,
                                    product: _controller.productList![index],
                                    index: index,
                                    onSuccess: _onSuccess);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onSuccess() {
    setState(() {});
  }
}
