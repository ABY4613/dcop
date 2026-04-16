import '../models/product.dart';

class AppConstants {
  static const String appName = 'DCOP';
  static const String heroTitle = 'DCOP';
  static const String heroSubtitle = 'SELVING';

  static final List<Product> dummyProducts = [
    Product(
      id: '1',
      name: 'Essential Oversized Black',
      description: 'Premium heavyweight cotton oversized t-shirt with classic logo.',
      price: 45.00,
      imageUrl: 'https://picsum.photos/id/1/800/1000',
      isFeatured: true,
      isTrending: true,
    ),
    Product(
      id: '2',
      name: 'Crimson Red Graphic Tee',
      description: 'Bold red graphic t-shirt featuring modern typography.',
      price: 55.00,
      imageUrl: 'https://picsum.photos/id/20/800/1000',
      isFeatured: true,
      isNewArrival: true,
    ),
    Product(
      id: '3',
      name: 'Urban Core White Box Fit',
      description: 'The ultimate box fit white tee with a glossy print on the back.',
      price: 50.00,
      imageUrl: 'https://picsum.photos/id/26/800/1000',
      isTrending: true,
    ),
    Product(
      id: '4',
      name: 'Midnight Edition Hoodie',
      description: 'Streetwear staple black hoodie with reflective accents.',
      price: 85.00,
      imageUrl: 'https://picsum.photos/id/64/800/1000',
      isFeatured: true,
    ),
    Product(
      id: '5',
      name: 'Neon Cyber Punk Tee',
      description: 'Futuristic design on premium pitch-black cotton.',
      price: 60.00,
      imageUrl: 'https://picsum.photos/id/96/800/1000',
      isNewArrival: true,
    ),
    Product(
      id: '6',
      name: 'Vintage Wash Grey',
      description: 'Acid washed grey t-shirt giving a retro 90s aesthetic.',
      price: 48.00,
      imageUrl: 'https://picsum.photos/id/119/800/1000',
      isTrending: true,
    ),
  ];
}
