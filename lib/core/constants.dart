import '../models/product.dart';

class AppConstants {
  static const String appName = 'DCOP';
  static const String heroTitle = 'STREETWEAR\nEVOLVED';
  static const String heroSubtitle =
      'The latest collection of premium printed T-shirts. Level up your street style.';

  static final List<Product> dummyProducts = [
    Product(
      id: '1',
      name: 'Essential Oversized Black',
      description:
          'Premium heavyweight cotton oversized t-shirt with classic DCOP logo.',
      price: 45.00,
      imageUrl:
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      isTrending: true,
    ),
    Product(
      id: '2',
      name: 'Crimson Red Graphic Tee',
      description: 'Bold red graphic t-shirt featuring modern typography.',
      price: 55.00,
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
      isNewArrival: true,
    ),
    Product(
      id: '3',
      name: 'Urban Core White Box Fit',
      description:
          'The ultimate box fit white tee with a glossy print on the back.',
      price: 50.00,
      imageUrl:
          'https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isTrending: true,
    ),
    Product(
      id: '4',
      name: 'Midnight Edition Hoodie',
      description: 'Streetwear staple black hoodie with reflective accents.',
      price: 85.00,
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isFeatured: true,
    ),
    Product(
      id: '5',
      name: 'Neon Cyber Punk Tee',
      description: 'Futuristic design on premium pitch-black cotton.',
      price: 60.00,
      imageUrl:
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isNewArrival: true,
    ),
    Product(
      id: '6',
      name: 'Vintage Wash Grey',
      description: 'Acid washed grey t-shirt giving a retro 90s aesthetic.',
      price: 48.00,
      imageUrl:
          'https://images.unsplash.com/photo-1562157873-818bc0726f68?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isTrending: true,
    ),
  ];
}
