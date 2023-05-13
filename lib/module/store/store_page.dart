import 'package:exopets/routes/app_routes.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Saya'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.ADD_PRODUCT);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: const NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'johndoe@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(
                        Icons.storefront,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Surabaya, Indonesia',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Produk',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Transaksi',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Penghasilan',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            thickness: 1,
            color: Colors.grey[400],
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Image.network(
                  'https://cdn.pixabay.com/photo/2015/11/16/14/43/cat-1045782__340.jpg',
                  fit: BoxFit.cover,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
